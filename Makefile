# Load env vars from .env if it exists
ifneq (,$(wildcard .env))
    include .env
    export $(shell sed 's/=.*//' .env)
endif

# postgres:
# # 	docker run --name simple-bank -e POSTGRES_PASSWORD=secret -p 5432:5432 -d postgres

migrate-up:
	migrate -path db/migration -database "$(DATABASE_URL)?sslmode=disable" -verbose up

migrate-down:
	migrate -path db/migration -database "$(DATABASE_URL)?sslmode=disable" -verbose down	

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

test-profile:
	go test -v -coverprofile=coverage.out ./...
	go tool cover -html=coverage.out


.PHONY: migrate-up, migrate-down, sqlc, test, test-profile