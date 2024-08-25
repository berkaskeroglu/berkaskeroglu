#!/bin/bash

processed_records=0
inserted_records=0

CSV_FILE="/home/ubuntux/titanic.csv"
HASURA_API_URL="http://****/v1/graphql"

DB_HOST="****"
DB_PORT="****"
DB_USER="****"
DB_PASSWORD="****"
DB_NAME="****"

while IFS=',' read -r passengerid survived pclass name1 name2 sex age sibsp parch ticket fare cabin embarked; do

    survived=${survived:-null}
    pclass=${pclass:-null}
    name=$(echo $name1 $name2 | tr -d '"' | sed "s/'/''/g") #-------I've merged name1 and name2 bcs name contains ','
    sex=${sex:-null}
    age=${age:-null}
    sibsp=${sibsp:-null}
    parch=${parch:-null}
    ticket=${ticket:-null}
    fare=${fare:-null}
    cabin=${cabin:-null}
    embarked=${embarked:-null}
    
#-------CHECKING IDs via HASURA

    result=$(curl -s -X POST -H "Content-Type: application/json" -d "{\"query\":\"query { titanic(where: { passengerid: { _eq: $passengerid } }) { passengerid } }\"}" $HASURA_API_URL)
    
#-------CHECKING DATA then INSERT

    if [[ $result == *"$passengerid"* ]]; then
        
        echo "Record with passengerid $passengerid already exists. Skipping."
    else
        export PGPASSWORD=$DB_PASSWORD
        psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "INSERT INTO titanic (passengerid, survived, pclass, name, sex, age, sibsp, parch, ticket, fare, cabin, embarked) VALUES ($passengerid, $survived, $pclass, '$name', '$sex', $age, $sibsp, $parch, '$ticket', $fare, '$cabin', '$embarked')"
        unset PGPASSWORD
        
#-------CHECKING IF INSERTED DATA MATCH

        export PGPASSWORD=$DB_PASSWORD
        psql_output=$(psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -t -c "SELECT * FROM titanic WHERE passengerid = $passengerid")
        unset PGPASSWORD
        
        psql_output_nospaces=$(echo "$psql_output" | tr -d ' ')
        name_nospaces=$(echo "$name" | tr -d ' ')

        if [ -z "$psql_output_nospaces" ]; then
            echo "Error querying the database for passengerid $passengerid."
        else
            if [ "$psql_output_nospaces" == "$passengerid|$survived|$pclass|$name_nospaces|$sex|$age|$sibsp|$parch|$ticket|$fare|$cabin|$embarked" ]; then
                echo "Record with passengerid $passengerid matches the local record."
            else
                echo "Error: Inserted record with passengerid $passengerid does not match the local record."
            fi
        fi
        echo "Record with passengerid $passengerid inserted."
        ((inserted_records++))
    fi

    ((processed_records++))

done < <(tail -n +2 "$CSV_FILE")

#-------PRINTING RESULTS
echo "$processed_records records processed, $inserted_records records inserted."



