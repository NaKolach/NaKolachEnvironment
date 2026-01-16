#!/bin/bash

DOMAIN="nakolach.com"
CONFIG_FILE="csr.conf"
DAYS=3650

openssl genrsa -out ca.key 4096
openssl req -x509 -new -nodes -key ca.key -sha256 -days $DAYS -out ca.crt \
    -subj "/C=PL/ST=Mazowieckie/L=Warszawa/O=NaKolach/CN=nakolach.com"

openssl genrsa -out tls.key 2048

openssl req -new -key tls.key -out tls.csr -config $CONFIG_FILE

openssl x509 -req -in tls.csr -CA ca.crt -CAkey ca.key \
    -CAcreateserial -out tls.crt -days $DAYS \
    -extensions v3_ext -extfile $CONFIG_FILE -sha256

cat tls.crt tls.key > ${DOMAIN}.pem