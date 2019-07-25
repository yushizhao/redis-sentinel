#!/bin/bash

nohup redis-sentinel.sh sentinel.conf > nohup.out 2>&1 &