#!/bin/bash

pids=`ps -ef | grep redis-sentinel | grep -v grep | awk '{print $2}'`

for pid in $pids
do
    echo "stop redis-sentinel ["$pid"]..."
    kill $pid
done
