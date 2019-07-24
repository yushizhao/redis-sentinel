SVPORT=6379
MASTERIP=10.118.11.11
STPORT=26379

SVPASS=123
STPASS=12345678

MONITOR='mymaster '"${MASTERIP}"' '"${SVPORT}"' 2'
AUTHPASS='mymaster '"${SVPASS}"

rm -rf ../master
rm -rf ../slave
rm -rf ../sentinel

mkdir ../master
mkdir ../slave
mkdir ../sentinel

cp redis-vip.conf.template ../master/redis.conf
sed -i 's/SVPORTPLACEHOLDER/'"${SVPORT}"'/g' ../master/redis.conf
sed -i 's/SVPASSPLACEHOLDER/'"${SVPASS}"'/g' ../master/redis.conf
sed -i 's/MASTERPASSPLACEHOLDER/'"${SVPASS}"'/g' ../master/redis.conf

cp redis-vip.conf.template ../slave/redis.conf
sed -i 's/SVPORTPLACEHOLDER/'"${SVPORT}"'/g' ../slave/redis.conf
sed -i 's/SVPASSPLACEHOLDER/'"${SVPASS}"'/g' ../slave/redis.conf
sed -i 's/MASTERPASSPLACEHOLDER/'"${SVPASS}"'/g' ../slave/redis.conf
echo 'replicaof '"${MASTERIP}"' '"${SVPORT}" >> ../slave/redis.conf

cp sentinel-vip.conf.template ../sentinel/sentinel.conf
sed -i 's/STPORTPLACEHOLDER/'"${STPORT}"'/g' ../sentinel/sentinel.conf
sed -i 's/STPASSPLACEHOLDER/'"${STPASS}"'/g' ../sentinel/sentinel.conf
sed -i 's/MONITORPLACEHOLDER/'"${MONITOR}"'/g' ../sentinel/sentinel.conf
sed -i 's/AUTHPASSPLACEHOLDER/'"${AUTHPASS}"'/g' ../sentinel/sentinel.conf

cp more-than-notify.sh ../sentinel/notify.sh
cp failover.sh ../sentinel/failover.sh