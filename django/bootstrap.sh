#!/bin/bash

set -e

echo -e "\nLooking around..."
SCRIPT=$(realpath $0)
SCRIPTPATH=`dirname $SCRIPT`
ACTION=${1:-up} # pass "down" as the first argument to destroy the environment

echo -e "\nSourcing required environment variables..."
source $SCRIPTPATH/bootstrapenv

echo -e "\nMoving to Sceptre's root..."
cd $SCRIPTPATH/sceptre

if [ "$ACTION" == "up" ]; then
    echo -e "\nLaunching environment..."

    echo -e "\nChecking to see if this is the first run..."
    sceptre describe-stack-outputs default ci >/dev/null || export FIRST_RUN=true

    echo -e "\nLaunching Base stack..."
    sceptre launch-stack default base

    echo -e "\nLaunching Aurora stack..."
    sceptre launch-stack default aurora

    echo -e "\nLaunching ES stack..."
    sceptre launch-stack default es
    eval $(sceptre describe-stack-outputs default es --export=envvar)

    echo -e "\nLaunching Prom/Grafana stack..."
    sceptre launch-stack default prom
    eval $(sceptre describe-stack-outputs default prom --export=envvar)

    echo -e "\nLaunching CI stack..."
    sceptre launch-stack default ci
    eval $(sceptre describe-stack-outputs default ci --export=envvar)

    if [ -n "$SCEPTRE_APP_SERVER_AMI_ID" ]; then
        echo -e "\nLaunching App Stack with AMI: $SCEPTRE_APP_SERVER_AMI_ID"
        sceptre launch-stack default app
        eval $(sceptre describe-stack-outputs default app --export=envvar)
    fi

    test -n "$FIRST_RUN" \
        && echo -e "\nWaiting for SSh to be available before tailing the CI instance log..." \
        && timeout 60 sh -c "until  nc -z ${SCEPTRE_CIPublicIp} 22; do sleep 1; done" \
        && ssh ${SCEPTRE_CIPublicIp} tail -n 100 -F /var/log/cloud-init-output.log

    echo -e "\nCI enpoint: ${SCEPTRE_CIRoute53RecordSet}:8080"
    echo "ES enpoint: ${SCEPTRE_ESRoute53RecordSet}:80/_plugin/kibana/app/kibana"
    echo "Grafana enpoint: ${SCEPTRE_PROMRoute53RecordSet}:3000"
    test -n "$SCEPTRE_APP_SERVER_AMI_ID" \
        && echo "App enpoint: ${SCEPTRE_APPRoute53RecordSet}:80"

elif [ "$ACTION" == "down" ]; then 
    echo -e "\nDestroying environment..."
    sceptre delete-env default
else
    echo "Unrecognized value for \$1: $1"
    exit 1
fi
