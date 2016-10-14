#!/bin/bash

IFS_OLD=$IFS
IFS=", "
for ip in $1; do 

	echo "Checking IP $ip"
	qSize=`ssh www@"$ip" "mailq | grep -v empty | wc -l"`
	echo "Mail Queue size for $ip = $qSize"
	logEntry=`ssh -t www@"$ip" "sudo grep 'predovicnitzsche.biz' /var/log/mail.log | wc -l"`
	expect "[sudo] password for www:"
	send "ab0uttime\r"
	echo "Mail log entry predovicnitzsche.biz for has $logEntry returns"
	
done
IFS=$IFS_OLD
