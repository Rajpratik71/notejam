#!/bin/bash

response=$(curl --write-out %{http_code} --silent --output /dev/null http://localhost:8000/status)

if [[ "$response" == "200" ]]; then
    echo "Sanity Test OK"
    exit 0
else
    echo "Sanity Test FAILED"
    exit 1
fi
