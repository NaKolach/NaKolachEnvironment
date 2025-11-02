#!/bin/sh

echo "Waiting for the database server to become available..."

while ! nc -z postgres 5432; do
    echo "Database server is not available yet. Waiting..."
    sleep 2
done

echo "Database server is available"

echo "Running migrations for kreda server"
while ! migrate -source file:///server/NaKolachServer.Migrations -database postgresql://postgres:postgres@postgres:5432/nakolach_server?sslmode=disable up; do
    echo "NaKolach server database is not available yet. Waiting..."
    sleep 2
done

echo "Migrations completed."