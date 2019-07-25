#!/bin/bash

pids=`ps -ef | grep redis-server | grep -v grep | awk '{print $2}'`

for pid in $pids
do
    echo "stop redis-server ["$pid"]..."
    kill $pid
done