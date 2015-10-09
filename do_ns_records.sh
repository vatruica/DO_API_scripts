#!/bin/bash

# DO related vars
DROPLETID="7digitnumber" 
TOKEN="bigassstring"
BASEAPIURL="https://api.digitalocean.com/v2"
DROPLETIP="your VPS ip"

# domain and record vars
domainName="testing.co"

recordAIP=$DROPLETIP
recordAName="www"

recordMXServer="mail.server.com"
recordMXPriority="10"

zohoCNAME="zb14420523"
recordCNAME=$zohoCNAME
zohoCNAMEdata="zmverify.zoho.com."
recordCNAMEData=$zohoCNAMEdata

recordSPFName="@"
recordSPFData="v=spf1 mx a +all"

recordDKIMName="zoho._domainkey"
recordDKIMData="k=rsa; p=longassstring"


# creating domain name
echo " Sending request to create domain "
echo ""
createDomain=$(curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d "{\"name\":\"$domainName\",\"ip_address\":\"$DROPLETIP\"}" "$BASEAPIURL/domains")
echo ""
echo " DigitalOcean says :"
echo ""
echo $createDomain

# adding an A record
addARecord=$(curl -X POST -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" -d "{\"type\":\"A\",\"name\":\"$recordAName\",\"data\":\"$recordAIP\",\"priority\":null,\"port\":null,\"weight\":null}" "$BASEAPIURL/domains/$domainName/records")
echo "Adding an A record"
echo $addARecord
echo ""

# adding a MX record
addMXRecord=$(curl -X POST -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" -d "{\"type\":\"MX\",\"name\":\"\",\"data\":\"$recordMXServer\",\"priority\":\"$recordMXPriority\",\"port\":null,\"weight\":null}" "$BASEAPIURL/domains/$domainName/records")
echo "Adding an MX record"
echo $addMXRecord
echo ""

# adding a CNAME record
addCNAMERecord=$(curl -X POST -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" -d "{\"type\":\"CNAME\",\"name\":\"$recordCNAME\",\"data\":\"$recordCNAMEData\",\"priority\":null,\"port\":null,\"weight\":null}" "$BASEAPIURL/domains/$domainName/records")
echo "Adding a CNAME record"
echo $addCNAMERecord
echo ""

# adding a SPF record
addSPFRecord=$(curl -X POST -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" -d "{\"type\":\"TXT\",\"name\":\"$recordSPFName\",\"data\":\"$recordSPFData\",\"priority\":null,\"port\":null,\"weight\":null}" "$BASEAPIURL/domains/$domainName/records")
echo "Adding a SPF record"
echo $addSPFRecord
echo ""

# adding a DKIM record
addDKIMRecord=$(curl -X POST -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" -d "{\"type\":\"TXT\",\"name\":\"$recordDKIMName\",\"data\":\"$recordDKIMData\",\"priority\":null,\"port\":null,\"weight\":null}" "$BASEAPIURL/domains/$domainName/records")
echo "Adding a DKIM record"
echo $addDKIMRecord
echo ""

# listing the zone file
echo " Listing all records for domain $domainName : "
echo ""
listDomainRecords=$(curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" $BASEAPIURL/domains/$domainName/records)
echo $listDomainRecords

