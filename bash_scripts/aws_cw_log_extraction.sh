#!/bin/bash 

while [ $# -ne 0 ]; do
	case "$1" in
		-h | --help)
			echo " " 
			echo "./$0 [options]"
			echo " "
			echo "Options:"
			echo " "
			echo -e "\t-r|--region : AWS region" 
			echo -e "\t-g|--lg-name : ASW CloudWatch LogGroup name"
			echo -e "\t-s|--ls-name-prefix : AWS CloudWatch LogStream Name prefix" 
			echo -e "\t-i|--max-items : Number of items to iterate through" 
			echo -e "\t-p|--profile : User AWS profile" 
			echo -e "\t-f|--file-name : File name where the log is saved" 
			exit
			;;
		-r | --region)
			REGION=$2
			;;
		-g | --lg-name)
			LGNAME=$2
			;;
		-s | --ls-name-prefix)
			LSNAME=$2
			;;
		-i | --max-items)
			MITEMS=$2
			;;
		-p | --profile)
			PROF=$2
			;;
		-f | --file-name)
			FILE=$2
			;;
		*)
			echo "Unknown option. Please use '-h|--help' for options"
			exit
			;;
	esac
	shift
done

# : '
echo $REGION
echo $LGNAME
echo $LSNAME
echo $MITEMS
echo $PROF
# '

for line in $(aws logs describe-log-streams \
					--log-group-name $LGNAME \
					--region $REGION \
					--output text \
					--log-stream-name-prefix $LSNAME \
					--max-items $MITEMS \
					--profile $PROF | \
					awk '{print $2":"$5":"$6}' | cut -d : -f 9 -f 10 -f 11 | sort -k 2); do 

	lsn=`echo $line | cut -d : -f 1`; start=`echo $line | cut -d : -f 2`; end=`echo $line | cut -d : -f 3`
	aws logs filter-log-events \
				--log-group-name $LGNAME \
				--log-stream-names $lsn \
				--start-time $start \
				--end-time $end \
				--profile $PROF \
				--region $REGION \
				--output text >> $FILE
done
