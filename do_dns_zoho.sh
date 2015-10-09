#!/bin/bash
# script meant to interact with a DO VPS via DO APIv2 in order to create
# the dns records needed for a ZOHO mail account

# DO vars
DROPLETID="7digitnumber" # change to your droplet
TOKEN="bigassstring" # change to your token
BASEAPIURL="https://api.digitalocean.com/v2"
domainName="testing.co" # change to your domain

# zoho vars
zohoMX="mx.zoho.com."
zohoMX2="mx2.zoho.com."
zohoCNAME="zb14420523" # the verification code supplied by zoho
zohoCNAMEdata="zmverify.zoho.com."
zohoSPFName="@"
zohoSPFData="v=spf1 mx include:zoho.com ~all"

# add cname verification record
addCNAMERecord=$(curl -X POST -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" -d "{\"type\":\"CNAME\",\"name\":\"$zohoCNAME\",\"data\":\"$zohoCNAMEdata\",\"priority\":null,\"port\":null,\"weight\":null}" "$BASEAPIURL/domains/$domainName/records")
echo "Adding a CNAME record"
echo $addCNAMERecord
echo ""

# add both mx records
addMXRecord=$(curl -X POST -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" -d "{\"type\":\"MX\",\"name\":\"\",\"data\":\"$zohoMX\",\"priority\":\"10\",\"port\":null,\"weight\":null}" "$BASEAPIURL/domains/$domainName/records")
echo "Adding an MX record"
echo $addMXRecord
echo ""

addMXRecord2=$(curl -X POST -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" -d "{\"type\":\"MX\",\"name\":\"\",\"data\":\"$zohoMX2\",\"priority\":\"20\",\"port\":null,\"weight\":null}" "$BASEAPIURL/domains/$domainName/records")
echo "Adding an MX record"
echo $addMXRecord
echo ""

# add SPF record
addSPFRecord=$(curl -X POST -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" -d "{\"type\":\"TXT\",\"name\":\"$zohoSPFName\",\"data\":\"$zohoSPFData\",\"priority\":null,\"port\":null,\"weight\":null}" "$BASEAPIURL/domains/$domainName/records")
echo "Adding a SPF record"
echo $addSPFRecord
echo ""