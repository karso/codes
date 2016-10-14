#!/bin/bash

NGINX_HTTP_PORT=80
NGINX_HTTPS_PORT=443
BOXER_PORT=3030
REPORTING_PORT=8083
PUSHER_PORT=8084
ANALYTICS_PORT=8082
KINDEX_PORT=8080
WOWZA_PORT=1935
RABBITMQ_PORT=15672
REDIS_PORT=6379
MONGO_PORT=27017
POLICY_PORT=14819

usage()
{
    echo "USAGE: ./${0##*/}  environment serverType"
    echo "environment: [test|staging|production]"
    echo "serverType: [fe|policy|analytics|reporting|boxer|pusher|kayindex]"
    exit 1
}

[[ $# -ne 2 ]] && usage

env=${1}
server_type=${2}

conn_status() {
	host_ip="$1"
	port="$2"
	state=`nmap -PN -p $port $host_ip | grep $port |  awk '{print $2}'`
	echo "Connection from this host to $host_ip on $port is $state" >> /tmp/conn_status.log
}

if [ ${env} = "test" ]; then
    mongo01="staging-mongo-01.mysite.com"
    mongo02="staging-mongo-02.mysite.com"
    mongo03="staging-mongo-03.mysite.com"
elif [ ${env} = "staging" ]; then
    mongo01="$staging-mongo-01.mysite.com"
    mongo02="$staging-mongo-02.mysite.com"
    mongo03="$staging-mongo-03.mysite.com"
elif [ ${env} = "production" ]; then
    mongo01="$prod-mongo-01.mysite.com"
    mongo02="$prod-mongo-02.mysite.com"
    mongo03="$prod-mongo-03.mysite.com"
else
    echo "I am not aware of environment $env"
    exit 1
fi

case $server_type in
    fe )
	rm -f /tmp/conn_status.log
	touch /tmp/conn_status.log
	conn_status localhost $NGINX_HTTP_PORT
	conn_status localhost $NGINX_HTTPS_PORT
	conn_status localhost $BOXER_PORT
	conn_status localhost $REPORTING_PORT
	conn_status pusher $PUSHER_PORT
	conn_status analytics $ANALYTICS_PORT
	conn_status reporting $REPORTING_PORT
	conn_status $env-kayindex.mysite.com $KINDEX_PORT
	conn_status wowza $WOWZA_PORT
	conn_status rabbit-master $RABBITMQ_PORT
	conn_status boxer $BOXER_PORT
	conn_status redis-master $REDIS_PORT
	conn_status $mongo01 $MONGO_PORT
	conn_status $mongo02 $MONGO_PORT
	conn_status $mongo03 $MONGO_PORT
	;;
    policy )
	rm -f /tmp/conn_status.log
        touch /tmp/conn_status.log
	conn_status localhost $POLICY_PORT
	conn_status rabbit-master $RABBITMQ_PORT
	conn_status redis-master $REDIS_PORT
        conn_status $mongo01 $MONGO_PORT
        conn_status $mongo02 $MONGO_PORT
        conn_status $mongo03 $MONGO_PORT
        ;;
    boxer )
	rm -f /tmp/conn_status.log
        touch /tmp/conn_status.log
	conn_status localhost $BOXER_PORT
	conn_status rabbit-master $RABBITMQ_PORT
        conn_status redis-master $REDIS_PORT
        conn_status $mongo01 $MONGO_PORT
        conn_status $mongo02 $MONGO_PORT
        conn_status $mongo03 $MONGO_PORT
        ;;
    analytics )
	rm -f /tmp/conn_status.log
        touch /tmp/conn_status.log
	conn_status localhost $ANALYTICS_PORT
	conn_status rabbit-master $RABBITMQ_PORT
        conn_status redis-master $REDIS_PORT
        conn_status $mongo01 $MONGO_PORT
        conn_status $mongo02 $MONGO_PORT
        conn_status $mongo03 $MONGO_PORT
        ;;
    reporting )
	rm -f /tmp/conn_status.log
        touch /tmp/conn_status.log
	conn_status localhost $REPORTING_PORT
	conn_status rabbit-master $RABBITMQ_PORT
        conn_status redis-master $REDIS_PORT
        conn_status $mongo01 $MONGO_PORT
        conn_status $mongo02 $MONGO_PORT
        conn_status $mongo03 $MONGO_PORT
        ;;
    pusher )
	rm -f /tmp/conn_status.log
        touch /tmp/conn_status.log
	conn_status localhost $PUSHER_PORT
	conn_status rabbit-master $RABBITMQ_PORT
        conn_status redis-master $REDIS_PORT
        conn_status $mongo01 $MONGO_PORT
        conn_status $mongo02 $MONGO_PORT
        conn_status $mongo03 $MONGO_PORT
        ;;
	kayindex )
	rm -f /tmp/conn_status.log
        touch /tmp/conn_status.log
	conn_status localhost $KINDEX_PORT
	conn_status rabbit-master $RABBITMQ_PORT
        conn_status redis-master $REDIS_PORT
        conn_status $mongo01 $MONGO_PORT
        conn_status $mongo02 $MONGO_PORT
        conn_status $mongo03 $MONGO_PORT
        ;;
    * )
	echo "I am not aware of this $server_type type of server"
	echo "Exiting..."
	exit 1
	;;
esac
echo "Running for host `hostname -i`"
cat /tmp/conn_status.log | grep -e closed -e filtered
