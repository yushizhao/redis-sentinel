#!/bin/bash

nohup redis-sentinel.sh sentinel.conf > nohup.out 2>&1 &
tail -f nohup.out