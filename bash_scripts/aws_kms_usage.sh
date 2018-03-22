#!/bin/bash

REGION=$1
RESOURCE=$2
THRESHOLD=$3

usage(){
	echo $0 [REGION] [RESOURCE] [THRESHOLD]
}


case $REGION in
	us-east-1) 
		;;
	ca-central-1)
		;;
	eu-west-1)
		;;
	*)
		echo "Unsupported | Missing Region"
		usage
		exit 1
esac


case $RESOURCE in
	alias) 
		param='list-aliases'
		;;
	key)	
		param='list-keys'
		;;
	*)
		echo "Unsupported | Missing Resource"
		usage
		exit 1
		;;
esac

if [ "$THRESHOLD" == '' ] || [ $THRESHOLD -lt 1000 ]; then
	echo "Missing | Unrealistic Threshold"
	usage
	exit 1
fi
		
output=`aws kms $param --region $REGION | grep KeyId | wc -l`
available=$(( $THRESHOLD - $output ))
avail_per=$(( $available * 100 / $THRESHOLD ))
# echo $output
# echo $available
echo $avail_per
