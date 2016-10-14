#!/bin/bash


getPrimary() {

	host=`sed -n "$1 p" host_mapper.txt`
	echo $host

}


getSecondary() {

	OLD_IFS=$IFS
	IFS=","
	for host_num in $1; do
		host_array="$host_array `sed -n "$host_num p" host_mapper.txt`"
	done
	IFS=$OLD_IFS
	echo $host_array

}


echo "Here is a list of available nodes..."
cat -n host_mapper.txt

echo "Please enter a number for primary host"
read -r pHost
echo "Please enter comma separated list for secondary hosts"
read -r sHosts

echo "Primary host is "; getPrimary $pHost
echo "Secondary hosts are "; getSecondary $sHosts
