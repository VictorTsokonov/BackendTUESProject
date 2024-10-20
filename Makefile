include .env

# Define arg var for different targets
MIGRATION_NAME ?= # Leave black to force the user to specify name

# Target: Create a new migration file
create_migration:
	migrate create -ext=sql -dir=${MIGRATION_PATH} -seq ${MIGRATION_NAME}

# Target: Apply the migration (up)
migrate_up:
	migrate -path=${MIGRATION_PATH} -database ${POSTGRES_URL} -verbose up

# Target: Rollback the migration (down)
migrate_down:
	migrate -path=${MIGRATION_PATH} -database ${POSTGRES_URL} -verbose down

# Target: Run validation, formatting, apply migration, and run the Go app
#run: migrate_up validate fmt
#	go run cmd/main.go

# Target: Run Docker and apply migration, validation, and Go app
run: docker_up migrate_up validate fmt
	go run cmd/main.go

# Target: Start Docker Compose
docker_up:
	@echo "Starting Docker Compose..."
	docker-compose up -d
	@echo "Waiting for PostgreSQL to be ready..."
	@while ! docker exec -it $(DATABASE_CONTAINER_NAME) pg_isready > /dev/null 2>&1; do sleep 1; done
	@echo "PostgreSQL is ready!"

# Target: Validate the Go code
validate:
	go vet ./...

# Target: Format the Go code
fmt:
	go fmt ./...

.PHONY: create_migration migrate_up migrate_down run validate fmt
