#!/bin/bash
MY_IP=  

VIP='10.118.11.201'     
SLAVE_VIP='10.118.11.202'
NETMASK='24'          
INTERFACE='ens160'     

MASTER_IP=${6}
OLD_IP=${4}

if [ ${OLD_IP} == ${MY_IP} ]; then
  sudo /sbin/ip addr del ${VIP}/${NETMASK} dev ${INTERFACE}
fi

if [ ${MASTER_IP} == ${MY_IP} ]; then
  sudo /sbin/ip addr del ${SLAVE_VIP}/${NETMASK} dev ${INTERFACE}
  sudo /sbin/ip addr add ${VIP}/${NETMASK} dev ${INTERFACE}
  sudo /sbin/arping -q -c 3 -A ${VIP} -I ${INTERFACE}
fi

if [ ${OLD_IP} != ${MY_IP} ] && [ ${MASTER_IP} != ${MY_IP} ]; then
  sudo /sbin/ip addr add ${SLAVE_VIP}/${NETMASK} dev ${INTERFACE}
  sudo /sbin/arping -q -c 3 -A ${SLAVE_VIP} -I ${INTERFACE}
fi
