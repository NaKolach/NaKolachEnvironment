#!/usr/bin/env bash
set -euo pipefail

DATA_DIR="data"
POLAND_PBF="$DATA_DIR/poland.osm.pbf"
GDANSK_PBF="$DATA_DIR/gdansk.osm.pbf"

# ===== wait for postgres =====
echo "Waiting for postgres..."
until psql -d postgres -c '\q' >/dev/null 2>&1; do
  sleep 2
done
echo "Postgres is up"

# ===== create database if not exists =====
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

# ===== download OSM data =====
mkdir -p "$DATA_DIR"

if [ ! -f "$POLAND_PBF" ]; then
  echo "Downloading Poland OSM extract"
  curl -L -o "$POLAND_PBF" \
  curl -L -f -o "${POLAND_PBF}.tmp" \
    https://download.geofabrik.de/europe/poland-latest.osm.pbf
  mv "${POLAND_PBF}.tmp" "$POLAND_PBF"
else
  echo "Poland extract already present"
fi

# ===== extract Gdańsk area =====
echo "Extracting Gdansk area"
osmium extract \
  -b 18.42,54.29,18.78,54.46 \
  "$POLAND_PBF" \
  -o "$GDANSK_PBF" \
  -O

# ===== import to PostGIS =====
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

