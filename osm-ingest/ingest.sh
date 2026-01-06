#!/usr/bin/env bash
set -euo pipefail

# ===== konfiguracja =====
DB_HOST=postgres
DB_USER=postgres
DB_PASS=postgres
DB_NAME=osm_gdansk

export PGPASSWORD="$DB_PASS"
export PGHOST="$DB_HOST"
export PGUSER="$DB_USER"

DATA_DIR="data"
POLAND_PBF="$DATA_DIR/poland.osm.pbf"
GDANSK_PBF="$DATA_DIR/gdansk.osm.pbf"

# ===== czekaj na postgres =====
echo "Waiting for postgres..."
until psql -d postgres -c '\q' >/dev/null 2>&1; do
  sleep 2
done
echo "Postgres is up"

# ===== utwórz bazę jeśli nie istnieje =====
if ! psql -d postgres -tc "SELECT 1 FROM pg_database WHERE datname='${DB_NAME}'" | grep -q 1; then
  echo "Creating database ${DB_NAME}"
  psql -d postgres -c "CREATE DATABASE ${DB_NAME};"
else
  echo "Database ${DB_NAME} already exists"
fi

# ===== postgis =====
echo "Ensuring PostGIS extension"
psql -d "$DB_NAME" -c "CREATE EXTENSION IF NOT EXISTS postgis;"
# ===== hstore =====
echo "Ensuring hstore extension"
psql -d "$DB_NAME" -c "CREATE EXTENSION IF NOT EXISTS hstore;"

# ===== pobierz dane OSM =====
mkdir -p "$DATA_DIR"

if [ ! -f "$POLAND_PBF" ]; then
  echo "Downloading Poland OSM extract"
  curl -L -o "$POLAND_PBF" \
    https://download.geofabrik.de/europe/poland-latest.osm.pbf
else
  echo "Poland extract already present"
fi

# ===== wytnij Gdańsk =====
echo "Extracting Gdansk area"
osmium extract \
  -b 18.42,54.29,18.78,54.46 \
  "$POLAND_PBF" \
  -o "$GDANSK_PBF" \
  -O

# ===== import do PostGIS =====
echo "Importing OSM data into PostGIS"

osm2pgsql \
  --create \
  --slim \
  --hstore \
  --cache 2000 \
  --number-processes 2 \
  -d "$DB_NAME" \
  "$GDANSK_PBF"

echo "OSM ingestion finished successfully"

