#!/bin/bash

SWITCH=$1
ACTION_NAME=$2 
# hostsallini=${WORKSPACE}/ansiblehosts/hosts/hosts_all.ini
hostsallini=/tmp/ops-artifacts/trial/hosts/group_vars/all.yml 
USER=`cat $hostsallini | grep ZabbixAPIUser | awk '{print $2}'`
PASS=`cat $hostsallini | grep ZabbixAPIPass | awk '{print $2}'`
ZABBIX_SERVER=`cat $hostsallini | grep ZabbixServer | awk '{print $2}'`
API='https://'$ZABBIX_SERVER'/zabbix/api_jsonrpc.php'

# Authenticate with Zabbix API

authenticate() {
	echo `curl -s -H  'Content-Type: application/json-rpc' -d "{\"jsonrpc\": \"2.0\",\"method\":\"user.login\",\"params\":{\"user\":\""${USER}"\",\"password\":\""${PASS}"\"},\"auth\": null,\"id\":0}" $API`
}

AUTH_TOKEN=`echo $(authenticate)| cut -d , -f 2 | cut -d : -f 2`

# Get This Host HostId:

getactionid() {
               echo `curl -s -H 'Content-Type: application/json-rpc' -d "{\"jsonrpc\":\"2.0\",\"method\":\"action.get\",\"params\":{\"output\":\"extend\",\"selectOperations\":\"extend\",\"selectRecoveryOperations\":\"extend\",\"selectFilter\":\"extend\",\"filter\":{\"name\":\"${ACTION_NAME}\"}},\"auth\":"${AUTH_TOKEN}",\"id\":1}" $API`
}

ACTION_ID=`echo $(getactionid) | cut -d , -f 2 | cut -d : -f 3`
# echo $ACTION_ID


if [ "$SWITCH" == "OFF" ]; then
	disableaction() {
		echo `curl -s -H  'Content-Type: application/json-rpc' -d "{\"jsonrpc\":\"2.0\",\"method\":\"action.update\",\"params\":{\"actionid\":"${ACTION_ID}",\"status\":\"1\"},\"auth\":"${AUTH_TOKEN}",\"id\":1}" $API`
	}
	ACTION_STATUS=`echo $(disableaction)`
	# echo $ACTION_STATUS
elif [ "$SWITCH" == "ON" ]; then
	enableaction() {
		echo `curl -s -H  'Content-Type: application/json-rpc' -d "{\"jsonrpc\":\"2.0\",\"method\":\"action.update\",\"params\":{\"actionid\":"${ACTION_ID}",\"status\":\"0\"},\"auth\":"${AUTH_TOKEN}",\"id\":1}" $API`
	}
	ACTION_STATUS=`echo $(enableaction)`
	# echo $ACTION_STATUS
else
	echo "Unknown Option $SWITCH"
	exit 1
fi

exit 0
