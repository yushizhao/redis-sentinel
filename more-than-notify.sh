#!/bin/bash
MY_IP=

VIP='10.118.11.201'
SLAVE_VIP='10.118.11.202'
NETMASK='24'    
INTERFACE='ens160'

if [ ${1} == "+sdown" ]; then
  read -r -a array <<< "${2}"
  role=${array[0]}
  ip=${array[2]}
  masterip=${array[6]}

  if [ ${role} == "slave" ] && [ ${masterip} != ${MY_IP} ]; then
    if [ ${ip} == ${MY_IP} ]; then
      sudo /sbin/ip addr del ${SLAVE_VIP}/${NETMASK} dev ${INTERFACE}
    else
      sudo /sbin/ip addr add ${SLAVE_VIP}/${NETMASK} dev ${INTERFACE}
      sudo /sbin/arping -q -c 3 -A ${SLAVE_VIP} -I ${INTERFACE}
    fi
  fi
fi

if [ ${1} == "-sdown" ]; then
  read -r -a array <<< "${2}"
  role=${array[0]}
  ip=${array[2]}
  masterip=${array[6]}

  if [ ${role} == "slave" ] && [ ${ip} == ${MY_IP} ]; then
    sudo /sbin/ip addr del ${VIP}/${NETMASK} dev ${INTERFACE}
    sudo /sbin/ip addr del ${SLAVE_VIP}/${NETMASK} dev ${INTERFACE}
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