ORIG_IFS=${IFS}
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
	for luser in $LUSER; do
		KEY_NUM=`grep  -i $luser Key_store.txt | wc -l`
        	if [ $KEY_NUM -ne 1 ]; then
                	echo "ERROR: Too few or too many keys found for user $luser."
                	echo "Only one entry in keystore is allowed."
			echo "Trying next user..."
                	continue
        	fi
                        for ruser in $RUSER; do
                                for saddr in $SADDR; do
        ssh $ruser@$saddr "ls -la" 2> /dev/null 1>/dev/null
        if [ $? -ne 0 ]; then
                echo "ERROR: $ruser or `whoami` does NOT have access to $saddr."
                echo "Can not continue with $ruser/`whoami` on $saddr."
                break
        else
		echo "Adding $luser to $saddr as $ruser"
                KEY=`grep -i $luser Key_store.txt`
                ssh $ruser@$saddr "echo $KEY >> .ssh/authorized_keys" 2> /dev/null 1>/dev/null
	fi
                                done
                        done
                done

fi
IFS=$ORIG_IFS
