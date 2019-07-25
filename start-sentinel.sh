#!/bin/bash

nohup redis-sentinel sentinel.conf > nohup.out 2>&1 &