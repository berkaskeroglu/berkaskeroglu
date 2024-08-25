package main

import (
	"context"
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"time"

	"github.com/bradfitz/gomemcache/memcache"
	_ "github.com/lib/pq"
	"google.golang.org/api/customsearch/v1"
	"google.golang.org/api/option"
)

const (
	dbUser        = "postgres"
	dbPassword    = "1234"
	dbName        = "postgres"
	memcachedAddr = "localhost:11211"
	gcsAPIKey     = "*******"
	gcsCx         = "*******"
)

type Client struct {
	ID             string    `json:"id"`
	Name           string    `json:"name"`
	PhoneNumber    string    `json:"phone_number"`
	Country        string    `json:"country"`
	Gender         string    `json:"gender"`
	Company        string    `json:"company"`
	CompanyRevenue float64   `json:"company_revenue"`
	CreditAmount   float64   `json:"credit_amount"`
	CreatedAt      time.Time `json:"created_at"`
}

var db *sql.DB
var mc *memcache.Client

func main() {
	var err error
	dbinfo := fmt.Sprintf("user=%s password=%s dbname=%s sslmode=disable", dbUser, dbPassword, dbName)
	db, err = sql.Open("postgres", dbinfo)
	if err != nil {
		log.Fatalf("Failed to connect to database: %v", err)
	}
	defer db.Close()

	mc = memcache.New(memcachedAddr)

	http.HandleFunc("/process-job", handleJobProcessing)
	log.Fatal(http.ListenAndServe(":8081", nil))
}

func handleJobProcessing(w http.ResponseWriter, r *http.Request) {
	log.Println("Processing job request")
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		log.Println("Invalid request method")
		return
	}

	var requestBody map[string]string
	if err := json.NewDecoder(r.Body).Decode(&requestBody); err != nil {
		http.Error(w, "Failed to decode request body", http.StatusBadRequest)
		log.Printf("Failed to decode request body: %v", err)
		return
	}

	jobID, exists := requestBody["jobID"]
	if !exists {
		http.Error(w, "Missing jobID", http.StatusBadRequest)
		log.Println("Missing jobID in request")
		return
	}

	codes, err := fetchAndCacheCallingCodes()
	if err != nil {
		http.Error(w, "Failed to fetch calling codes", http.StatusInternalServerError)
		log.Printf("Failed to fetch calling codes: %v", err)
		return
	}

	clients, err := fetchAndCacheClients(jobID)
	if err != nil {
		http.Error(w, "Failed to fetch clients", http.StatusInternalServerError)
		return
	}

	validClients := validateClients(clients, codes)
	if len(validClients) == 0 {
		log.Println("No valid clients found")
		http.Error(w, "No valid clients found", http.StatusInternalServerError)
		return
	}

	for _, client := range validClients {
		if client.CreditAmount > 2000000 {
			log.Printf("Processing client %s with high credit amount", client.ID)
			links, err := searchGoogle(client.Company, client.Country)
			if err != nil {
				http.Error(w, "Failed to search Google", http.StatusInternalServerError)
				log.Printf("Failed to search Google for client %s: %v", client.ID, err)
				return
			}

			if err := saveClientToDatabase(client); err != nil {
				http.Error(w, "Failed to save client to database", http.StatusInternalServerError)
				log.Printf("Failed to save client %s to database: %v", client.ID, err)
				return
			}

			if err := saveLinksToDatabase(client, links); err != nil {
				http.Error(w, "Failed to save links to database", http.StatusInternalServerError)
				log.Printf("Failed to save links for client %s: %v", client.ID, err)
				return
			}

		} else {
			log.Printf("Processing client %s with low credit amount - BELOW", client.ID)

			if err := saveClientToDatabase(client); err != nil {
				http.Error(w, "Failed to save client to database", http.StatusInternalServerError)
				log.Printf("Failed to save client %s to database: %v", client.ID, err)
				return
			}
		}
	}

	log.Println("Job processed successfully")
	w.WriteHeader(http.StatusOK)
	w.Write([]byte("Job processed successfully"))
}

func fetchAndCacheCallingCodes() (map[string]string, error) {
	rows, err := db.Query("SELECT country_name, phone_code FROM callingCodes")
	if err != nil {
		return nil, fmt.Errorf("database query error: %v", err)
	}
	defer rows.Close()

	codes := make(map[string]string)
	for rows.Next() {
		var country, code string
		if err := rows.Scan(&country, &code); err != nil {
			return nil, fmt.Errorf("row scan error: %v", err)
		}
		codes[country] = code
	}

	for country, code := range codes {
		log.Printf("Memcache key: %s", country)
		if err := mc.Set(&memcache.Item{Key: country, Value: []byte(code)}); err != nil {

			return nil, fmt.Errorf("memcache set error: %v", err, country)
		}
	}

	return codes, nil
}

func fetchAndCacheClients(jobID string) ([]Client, error) {
	rows, err := db.Query("SELECT id, name, phone_number, country, gender, company, company_revenue, credit_amount FROM clients WHERE id = $1", jobID)
	if err != nil {
		return nil, fmt.Errorf("database query error: %v", err)
	}
	defer rows.Close()

	var clients []Client
	for rows.Next() {
		var client Client
		if err := rows.Scan(&client.ID, &client.Name, &client.PhoneNumber, &client.Country, &client.Gender, &client.Company, &client.CompanyRevenue, &client.CreditAmount); err != nil {
			return nil, fmt.Errorf("row scan error: %v", err)
		}
		clients = append(clients, client)
	}

	clientData, err := json.Marshal(clients)
	if err != nil {
		return nil, fmt.Errorf("json marshal error: %v", err)
	}
	if err := mc.Set(&memcache.Item{Key: jobID, Value: clientData}); err != nil {
		return nil, fmt.Errorf("memcache set error2: %v", err)
	}

	return clients, nil
}

func validateClients(clients []Client, codes map[string]string) []Client {
	var validClients []Client

	for _, client := range clients {
		code, exists := codes[client.Country]
		if !exists {
			log.Printf("No matching phone code for country %s", client.Country)
			continue
		}

		if client.PhoneNumber == code {
			validClients = append(validClients, client)
		} else {
			log.Printf("Phone number %s does not match country code %s for client %s", client.PhoneNumber, code, client.ID)
		}
	}
	log.Printf("Number of valid clients: %d", len(validClients))
	return validClients
}

func searchGoogle(company, country string) ([]string, error) {
	query := company + " " + country
	ctx := context.Background()
	svc, err := customsearch.NewService(ctx, option.WithAPIKey(gcsAPIKey))
	if err != nil {
		log.Fatalf("Error creating customsearch service: %v", err)
	}

	resp, err := svc.Cse.List().Cx(gcsCx).Q(query).Do()
	if err != nil {
		log.Fatalf("Error making search request: %v", err)
	}

	var links []string
	for i, item := range resp.Items {
		fmt.Printf("#%d: %s\n", i+1, item.Title)
		fmt.Printf("\t%s\n", item.Snippet)
		links = append(links, item.Link)
	}

	return links, nil
}

func saveClientToDatabase(client Client) error {
	query := `
        INSERT INTO verifiedClients (id, name, phone_number, country, gender, company, company_revenue, credit_amount)
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
    `
	result, err := db.Exec(query, client.ID, client.Name, client.PhoneNumber, client.Country, client.Gender, client.Company, client.CompanyRevenue, client.CreditAmount)
	if err != nil {
		return fmt.Errorf("failed to insert client into database: %w", err)
	}

	rowsAffected, err := result.RowsAffected()
	if err != nil {
		return fmt.Errorf("could not get rows affected: %w", err)
	}

	log.Printf("Inserted client %s, rows affected: %d", client.ID, rowsAffected)
	return nil
}

func saveLinksToDatabase(client Client, links []string) error {
	query := `INSERT INTO links (name, url) VALUES ($1, $2)`

	for _, link := range links {
		_, err := db.Exec(query, client.Name, link)
		if err != nil {
			return fmt.Errorf("failed to insert link for client %s: %w", client.Name, err)
		}
	}
	return nil
}
