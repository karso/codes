#!/bin/bash

CUR_IFS=${IFS}
IFS=","

echo "Local user name:" 
read -r LUSER
echo "Remote user name:"
read -r RUSER
echo "Server IP/FQDN:"
read -r SADDR

if [ -z "$LUSER" ] || [ -z "$RUSER" ] || [ -z "$SADDR" ]; then
	echo "One of the inputs are not valid. Please enter proper input and try again."
	echo "Bye! Bye!"
	exit
else 
	KEY_NUM=`grep  -i $LUSER Key_store.txt | wc -l`
	if [ $KEY_NUM -ne 1 ]; then
		echo "Too few or too many keys found."
		echo "Only one entry in keystore is allowed. Quiting..."
		exit
	fi	
	ssh $RUSER@$SADDR "ls -la" 2> /dev/null 1>/dev/null
	if [ $? -ne 0 ]; then
		echo "$RUSER or `whoami` does NOT have access to $SADDR."
		echo "Can not continue."
		exit
	else
		for luser in $LUSER; do
			for ruser in $RUSER; do 
				for saddr in $SADDR; do
					echo "Adding $luser to $saddr as $ruser"
#		KEY=`grep -i $LUSER Key_store.txt`
#		ssh $RUSER@$SADDR "echo $KEY >> .ssh/authorized_keys" 2> /dev/null 1>/dev/null
				done
			done
		done	
	fi
	
fi
		 
		
		
