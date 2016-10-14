#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]
then
	echo "correct call is deploy-build.sh <branch> <tenant> <set_manitainence yes/no> "
	exit 1
else	
	echo "Begin deployment for Tenant " $1 " For " $2  "," $3

	USER=`whoami`
	echo "Please enter user name. [Press enter to run as '$USER']" 
	read user
	if [ -z $user ]; then
		echo "Running as user $USER"
	else	
		USER=$user
		echo "Running as user $USER"
	fi

	PATH=/Users/$USER/mysite_code/mysite
	echo "Please enter path to DevOps folder. [Press enter to use /Users/$USER/mysite_code/mysite]"
	read path
	if [ -z $path ] && [ -d $PATH ]; then
		echo "Deploying DevOps Repository on $PATH"
		cd $PATH 
	elif [ -z $path ] && [ ! -e $PATH ]; then
		echo "Error: [$PATH] NOT found."
		exit
	elif [ ! -z $path ]; then
		PATH=$path
		echo "Deploying DevOps Repository on $PATH"
		cd $PATH 
	else
		echo "No path found. I am lost"
		exit
	fi 	
	sleep 2
	git checkout $1
	sleep 2
	git pull
	sleep 2
	cap -s branch=$1 HOSTS=$2 deploy
    	echo "DevOps Repository deployed for Tenant " $2 " for branch " $1 
    	sleep 5    
    	echo "Checking if Maintainence Page Is required for Tenant " $2     
    	if [ "$3" == "yes" ] 
    	then	
		echo $3       
		echo "setting maintainence page"
		cd /Users/dinardalvi/mysite_code/mysite
		ssh -t www@$2 sh /home/www/DevOps/current/scripts/config/set_maint.sh
		echo "Maintainence Page Set for Tenant" $2 
	fi	
	
fi
