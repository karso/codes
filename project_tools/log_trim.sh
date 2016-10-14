#!/bin/sh

###############################################################################
##### "This is a script to truncate logs depending on the free disk size" #####
#####									  #####
###############################################################################


DEF_LIMIT=90										#Threshhold value for the FS use.
DEF_RATE=50										#The LOG file will be % trimmed per iteration.
DEF_MIN_ENTRY=1000									#Minimum number of lines that will be kept in the LOG.

function Usage(){									#Function that shows how to use the script.
	echo "USAGE: /bin/sh $0 [Log File Absolute Path]"
	exit 1
}

if [[ $# -eq 1 && -e $1 ]]								#Expecting only one input ie absolute path of Log file
	then

        LOG_FILE=$1
        FILE_SYSTEM=`dirname $1`

	TOTAL_LINES=`wc -l $LOG_FILE | awk '{print $1}'`				#Currently number of lines present in the LOG file.
	FS_USED=`df -h $FILE_SYSTEM | grep "G" | awk '{print $4}' | sed 's,%,,g'`	#Currently the FS disk usage.

	while [[ $FS_USED -gt $DEF_LIMIT && $TOTAL_LINES -gt $DEF_MIN_ENTRY ]]
	        do
        	FS_USED=`df -h $FILE_SYSTEM | grep "G" | awk '{print $4}' | sed 's,%,,g'`
        	TOTAL_LINES=`wc -l $LOG_FILE | awk '{print $1}'`
        	del=$(($TOTAL_LINES * $DEF_RATE / 100 ))					#Calculating how mant lines to delete.
        	`sed -i 1,$del\d $LOG_FILE`;						#Deleting.

	done
	
else
	Usage
fi

