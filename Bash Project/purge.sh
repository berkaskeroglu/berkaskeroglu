#!/bin/bash

#--- This filed is created to work with a cronjob.

HASURA_API_URL="http://****/v1/graphql"
DB_USER="****"
DB_PASSWORD="****"
DB_HOST="****"
DB_PORT="****"
DB_NAME="****"


TABLE_NAME="titanic"

purge_table_postgresql() {
    export PGPASSWORD=$DB_PASSWORD
    psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "DELETE FROM $TABLE_NAME"
    unset PGPASSWORD
    echo "Deleted all records from $TABLE_NAME table using PostgreSQL."
}



purge_table_postgresql

