FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    osmium-tool \
    osm2pgsql \
    curl \
    ca-certificates \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /work
COPY ingest.sh /work/ingest.sh
RUN chmod +x /work/ingest.sh

CMD ["/work/ingest.sh"]
