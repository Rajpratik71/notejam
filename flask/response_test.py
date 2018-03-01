#!/usr/bin/env python

import subprocess

# We need to automate performance tests. One important metric is response times.

# This is just a placeholder so that we can work out a basic approach

# All we do is get a response time from a curl script and check if it lower than some value

# Obviously we need to parameterize the target URL and be more intelligent about interpreting the results.

# Still, this is enough to get the basic idea

subprocess.call(['sudo', 'sh', 'perf.sh', 'http://127.0.0.1:5000'])

with open('response_time.txt') as f:
    result = f.readline()
    f.close()

result = result.rstrip()

result = float(result)

if result > .500:
    print "RUH ROH!"
else:
    print "VERY NICE"
