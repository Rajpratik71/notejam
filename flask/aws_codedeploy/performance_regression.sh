#!/bin/sh

# Run load testing with JMETER
wget https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-3.1.tgz -O /tmp/apache-jmeter-3.1.tgz
tar xzfv /tmp/apache-jmeter-3.1.tgz -C /tmp/

# Run jmeter on localhost
/tmp/apache-jmeter-3.1/bin/jmeter -t notejam.jmx -n -Jusers=5000 -Jduration=60 -l /tmp/notejam-jmeter-test.log

if [[ $? == 0 ]]; then
    echo "OK - Load for load testing / performance regression tests."
    exit 0
else
    echo "FAILED - Load for load testing / performance regression tests."
    exit 1
fi
