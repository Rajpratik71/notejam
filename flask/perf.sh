#!/bin/bash

curl -o /dev/null -s -w "%{time_total}\n" "$1" > response_time.txt
