#!/usr/bin/env bash
msg="{\"msgtype\": \"text\", 
        \"text\": {
             \"content\": \"${1} ${2}\"
        }
      }"
# echo ${msg}
curl 'https://oapi.dingtalk.com/robot/send?access_token=0789c47ae457d7198adf27d03af3a44d3fb2dd8190a6320daa2fc978d1bcba11' \
   -H 'Content-Type: application/json' \
   -d "${msg}"
