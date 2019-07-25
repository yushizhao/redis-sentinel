#!/bin/bash

nohup redis-server redis.conf > nohup.out 2>&1 &
tail -f nohup.out