#!/bin/bash

set -e

NEXT_WAIT_TIME=0
TARGET=$1
RETRY_COUNT=${2:-6} #value taken from $2, default value is 6
RETRY_SLEEP=10

until [ $NEXT_WAIT_TIME -eq $RETRY_COUNT ]; do
    curl -m 10 -s --fail --location $TARGET >/dev/null && exit 0
    sleep $RETRY_SLEEP
    echo "$0 - Slept $(( (NEXT_WAIT_TIME++ + 1) * $RETRY_SLEEP )) seconds waiting for $TARGET..."
done
echo "$0 - Failed while waiting for $TARGET..."
exit 1
