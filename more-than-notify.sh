#!/bin/bash
SELFIP=
VIP='172.16.212.124'
SLAVEVIP=
NETMASK='24'    
INTERFACE='ens160'

if [ ${1} == "+sdown" ]; then
  read -r -a array <<< "${2}"
  role=${array[0]}
  ip=${array[2]}
  masterip=${array[6]}

  if [ ${role} == "slave" ] && [ ${masterip} != ${SELFIP} ]; then
    if [ ${ip} == ${SELFIP} ]; then
      sudo /sbin/ip addr del ${SLAVEVIP}/${NETMASK} dev ${INTERFACE}
    else
      sudo /sbin/ip addr add ${SLAVEVIP}/${NETMASK} dev ${INTERFACE}
      sudo /sbin/arping -q -c 3 -A ${SLAVEVIP} -I ${INTERFACE}
    fi
  fi
fi

if [ ${1} == "-sdown" ]; then
  read -r -a array <<< "${2}"
  role=${array[0]}
  ip=${array[2]}
  masterip=${array[6]}

  if [ ${role} == "slave" ] && [ ${ip} == ${SELFIP} ]; then
    sudo /sbin/ip addr del ${VIP}/${NETMASK} dev ${INTERFACE}
    sudo /sbin/ip addr del ${SLAVEVIP}/${NETMASK} dev ${INTERFACE}
  fi
fi


# msg="{\"msgtype\": \"text\", 
#         \"text\": {
#              \"content\": \"${1} ${2}\"
#         }
#       }"

# echo ${msg}
# curl 'https://oapi.dingtalk.com/robot/send?access_token=0789c47ae457d7198adf27d03af3a44d3fb2dd8190a6320daa2fc978d1bcba11' \
#    -H 'Content-Type: application/json' \
#    -d "${msg}"