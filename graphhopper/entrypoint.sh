#!/bin/sh
PBF_FILE="/data/gdansk.osm.pbf"

while [ ! -f "$PBF_FILE" ]; do
    echo "Waiting for pbf file..."
    sleep 2
done

exec java -jar *.jar server /config.yml