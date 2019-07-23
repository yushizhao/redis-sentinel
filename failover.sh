#!/bin/bash

MASTER_IP=${6}
OLD_IP=${4}
MY_IP='172.16.212.121'   # 各サーバ自身のIP
VIP='172.16.212.124'     # VIP
SLAVEVIP=
NETMASK='24'          # Netmask
INTERFACE='ens160'      # インターフェイス

if [ ${MASTER_IP} = ${MY_IP} ]; then
  sudo /sbin/ip addr add ${VIP}/${NETMASK} dev ${INTERFACE}
  sudo /sbin/arping -q -c 3 -A ${VIP} -I ${INTERFACE}
  sudo /sbin/ip addr del ${SLAVEVIP}/${NETMASK} dev ${INTERFACE}
else
  sudo /sbin/ip addr del ${VIP}/${NETMASK} dev ${INTERFACE}
  sudo /sbin/ip addr add ${SLAVEVIP}/${NETMASK} dev ${INTERFACE}
  if [ ${OLD_IP} != ${MY_IP} ]; then
    sudo /sbin/arping -q -c 3 -A ${SLAVEVIP} -I ${INTERFACE}
  fi
fi
