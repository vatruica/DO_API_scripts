#!/bin/bash
# script meant to interact with a DO VPS via DO APIv2 in order to take an automatic snapshot of the VPS
# get the latest version from truica-victor.com/resources/do_auto_snapshot.sh
# TO DO
#	- parse json responses - https://github.com/micha/jsawk
#	- use json responses to check the status of the snapshot

# DO vars
HOST="digitalocean" # your ssh host entry - check do_auto_snapshot_sshconfigexample for an example config
DROPLETID="7digitint" # your VPS ID
TOKEN="bigassstring" # change with your token
BASEAPIURL="https://api.digitalocean.com/v2"

# script vars
TODAY="$(date +%y-%m-%d)"
SNAPSHOTNAME="regular_$TODAY"

# power off droplet
echo ""
echo "Powering off droplet ..."
echo ""

ssh $HOST "poweroff"

# get info on droplet
#DROPLETINFO=$(curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" "$BASEAPIURL/droplets/$DROPLETID")
#echo $DROPLETINFO

# waiting after powering off to make sure its done
sleep 10
echo ""
echo "Droplet has been powered off!"
echo ""

# take snapshot
echo ""
echo "Initializing snapshot ... "
echo ""
TAKESNAPSHOT=$(curl -X POST -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" -d "{\"type\":\"snapshot\",\"name\":\"$SNAPSHOTNAME\"}" "$BASEAPIURL/droplets/$DROPLETID/actions")

# show response
echo " DigitalOcean says :"
echo ""
echo $TAKESNAPSHOT

echo ""
echo "It should take about ~17 minutes until its finished"
echo ""
echo "Check again with DO at around" $(date --date='17 minutes' +%R)


# wait and check snapshot status
#sleep 10
#STATUSSNAPSHOT=$(curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer $TOKEN" "$BASEAPIURL/actions/64459531")
#echo $STATUSSNAPSHOT

#####################
# useful outputs
##################### 

# if snapshot is succesful
# {"action":{"id":64459531,"status":"in-progress","type":"snapshot","started_at":"2015-09-18T10:49:29Z","completed_at":null,"resource_id":7500337,"resource_type":"drople
#t","region":{"name":"Amsterdam 3","slug":"ams3","sizes":["512mb","1gb","2gb","4gb","8gb","16gb","32gb","48gb","64gb"],"features":["private_networking","backups","ipv6"
#,"metadata"],"available":true},"region_slug":"ams3"}}

# if droplet is on and a snapshot is tried to be taken
# {"id":"unprocessable_entity","message":"Droplet is currently on. Please power it off to run this event."}

# if snapshot has been taken
#{"action":{"id":64459531,"status":"completed","type":"snapshot","started_at":"2015-09-18T10:49:29Z","completed_at":"2015-09-18T10:50:32Z","resource_id":7500337,"resour
#ce_type":"droplet","region":{"name":"Amsterdam 3","slug":"ams3","sizes":["512mb","1gb","2gb","4gb","8gb","16gb","32gb","48gb","64gb"],"features":["private_networking",
#"backups","ipv6","metadata"],"available":true},"region_slug":"ams3"}}

