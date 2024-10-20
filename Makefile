include .env

# Variables
POSTGRES_URI="postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:${POSTGRES_PORT}/${POSTGRES_DB}?sslmode=disable"
MIGRATION_PATH=db/migrations

# Target: Create a new migration file
create_migration:
	migrate create -ext=sql -dir=${MIGRATION_PATH} -seq init

# Target: Apply the migration (up)
migrate_up:
	migrate -path=${MIGRATION_PATH} -database ${POSTGRES_URI} -verbose up

# Target: Rollback the migration (down)
migrate_down:
	migrate -path=${MIGRATION_PATH} -database ${POSTGRES_URI} -verbose down

# Target: Run validation, formatting, apply migration, and run the Go app
run: migrate_up validate fmt
	go run cmd/main.go

# Target: Validate the Go code
validate:
	go vet ./...

# Target: Format the Go code
fmt:
	go fmt ./...

.PHONY: create_migration migrate_up migrate_down run validate fmt
