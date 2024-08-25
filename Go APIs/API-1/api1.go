package main

import (
	//	"crypto/md5"
	"encoding/csv"
	//"encoding/hex"
	"bytes"
	"database/sql"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"regexp"
	"strconv"

	//"strings"
	"github.com/google/uuid"
	_ "github.com/lib/pq"
)

const (
	dbUser      = "postgres"
	dbPassword  = "1234"
	dbName      = "postgres"
	apiEndpoint = "http://localhost:8081/process-job"
)

var db *sql.DB

func main() {
	var err error

	dbinfo := fmt.Sprintf("user=%s password=%s dbname=%s sslmode=disable", dbUser, dbPassword, dbName)
	db, err = sql.Open("postgres", dbinfo)
	if err != nil {
		log.Fatal(err)
	}
	//defer db.Close()
	http.HandleFunc("/upload-csv", handleCSVUpload)
	log.Fatal(http.ListenAndServe(":8080", nil))
}

func handleCSVUpload(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	file, _, err := r.FormFile("file")
	if err != nil {
		http.Error(w, "Failed to get file", http.StatusBadRequest)
		return
	}
	defer file.Close()

	reader := csv.NewReader(file)

	jobID := uuid.New().String()

	for {
		record, err := reader.Read()
		if err == io.EOF {
			break
		}
		if err != nil {
			http.Error(w, "Failed to read CSV record", http.StatusInternalServerError)
			return
		}
		companyRevenue, err := cleanAndConvertToNumeric(record[5])
		if err != nil {
			http.Error(w, "Invalid company revenue format", http.StatusInternalServerError)
			return
		}

		creditAmount, err := cleanAndConvertToNumeric(record[6])
		if err != nil {
			http.Error(w, "Invalid credit amount format", http.StatusInternalServerError)
			return
		}

		query := `INSERT INTO clients (id, name, phone_number, country, gender, company, company_revenue, credit_amount) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)`
		_, err = db.Exec(query, jobID, record[0], record[1], record[2], record[3], record[4], companyRevenue, creditAmount)
		if err != nil {
			log.Printf("Failed to insert into database: %v", err)
			http.Error(w, "Failed to insert into database", http.StatusInternalServerError)
			return
		}

	}

	jobData := map[string]interface{}{"jobID": jobID, "status": "success"}
	jobDataBytes, _ := json.Marshal(jobData)

	_, err = http.Post(apiEndpoint, "application/json", bytes.NewReader(jobDataBytes))
	if err != nil {
		http.Error(w, "Failed to notify second microservice", http.StatusInternalServerError)
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write([]byte("CSV processed successfully"))
}

func cleanAndConvertToNumeric(value string) (float64, error) {
	re := regexp.MustCompile(`[^\d.]`)
	cleaned := re.ReplaceAllString(value, "")

	numericValue, err := strconv.ParseFloat(cleaned, 64)
	if err != nil {
		return 0, err
	}

	return numericValue, nil
}
