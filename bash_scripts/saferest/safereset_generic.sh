#!/bin/bash 

echo "Enter Pig Script name [EX: iknow.pig]"
read pig_script

if [ -z $pig_script ]; then 
	echo "Pig script name not provided. Exiting..."
	exit 1
fi

echo "Enter environment name [EX: development|staging|production]"
read environment

if [ -z $environment ]; then 
	echo "Environment name not provided. Exiting..."
	exit 1
fi

run_safereset () { 
	sudo sh /home/ubuntu/hadoop1/current/analytics/bin/safereset.sh $pig_script $1 $environment
}

run_safereset fbl
run_safereset examiner
run_safereset bdo
run_safereset amp
run_safereset examiner
run_safereset buci-rnd-india
run_safereset acclivus
run_safereset adidas-group
run_safereset know
run_safereset invensense
run_safereset 47brand
run_safereset ledengin
run_safereset artiman
run_safereset routers
run_safereset magconsulting
run_safereset harmonic
run_safereset comcast
run_safereset hitachi-solutions
run_safereset nelco
run_safereset zspace
run_safereset emerson
run_safereset corp
run_safereset tegile
run_safereset salmat
run_safereset plusone
run_safereset prysm
run_safereset cisco
run_safereset cradlepoint
run_safereset explore
run_safereset partners
run_safereset five9
run_safereset labs-comcast


