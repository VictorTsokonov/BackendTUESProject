package main

import (
	"database/sql"
	"fmt"
	"log"
	"os"

	"github.com/joho/godotenv"
	_ "github.com/lib/pq" // Import the PostgreSQL driver
)

func main() {
	// Load .env file
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	postgresURI := os.Getenv("DATABASE_URL")
	if postgresURI == "" {
		log.Fatal("DATABASE_URL is not set in the environment")
	}

	// Open the PostgreSQL database
	db, err := sql.Open("postgres", postgresURI)
	if err != nil {
		log.Panic(err)
	}
	defer db.Close()

	// Ping the database to verify the connection
	err = db.Ping()
	if err != nil {
		log.Panic(err)
	}

	fmt.Println("Connected to the database")

	// Keep the program running (optional, if needed for long-running tasks)
	select {}
}
