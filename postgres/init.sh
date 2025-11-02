#!/bin/bash
set -e
psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE nakolach_server;
    REVOKE ALL PRIVILEGES ON DATABASE nakolach_service FROM public;
    CREATE ROLE "nakolach_server_admin" WITH LOGIN PASSWORD 'qwerty1!';
    CREATE ROLE "nakolach_server_user" WITH LOGIN PASSWORD 'qwerty1!';
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "nakolach_server" <<-EOSQL
    GRANT ALL PRIVILEGES ON DATABASE nakolach_server TO "nakolach_server_admin";
    GRANT ALL PRIVILEGES ON SCHEMA public TO "nakolach_server_admin" WITH GRANT OPTION;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO "nakolach_server_admin";
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO "nakolach_server_admin";
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON FUNCTIONS TO "nakolach_server_admin";
    ALTER DEFAULT PRIVILEGES FOR ROLE "nakolach_server_admin" GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO "kreda_server";
    ALTER DEFAULT PRIVILEGES FOR ROLE "nakolach_server_admin" GRANT USAGE, SELECT, UPDATE ON SEQUENCES TO "kreda_server";

    GRANT CONNECT ON DATABASE kreda_server TO "nakolach_server_user";
    GRANT USAGE ON SCHEMA public to "nakolach_server_user";
EOSQL