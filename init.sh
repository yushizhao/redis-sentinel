BIND1=127.0.0.1
BIND2=127.0.0.1
BIND3=127.0.0.1

PORT1=6379
PORT2=6380
PORT3=6381

MONITOR="127.0.0.1 6379 2"

SVPASS="123"
STPASS="12345678"

rm -rf ../${PORT1}
rm -rf ../${PORT2}
rm -rf ../${PORT3}

mkdir ../${PORT1}
mkdir ../${PORT2}
mkdir ../${PORT3}

cp redis.conf.template ../${PORT1}/redis.conf
sed -i 's/BINDPLACEHOLDER/'"${BIND1}"'/g' ../${PORT1}/redis.conf
sed -i 's/SELFPORTPLACEHOLDER/'"${PORT1}"'/g' ../${PORT1}/redis.conf
sed -i 's/SVPASSPLACEHOLDER/'"${SVPASS}"'/g' ../${PORT1}/redis.conf
sed -i 's/MASTERPASSPLACEHOLDER/'"${SVPASS}"'/g' ../${PORT1}/redis.conf

cp redis.conf.template ../${PORT2}/redis.conf
sed -i 's/BINDPLACEHOLDER/'"${BIND2}"'/g' ../${PORT2}/redis.conf
sed -i 's/SELFPORTPLACEHOLDER/'"${PORT2}"'/g' ../${PORT2}/redis.conf
sed -i 's/SVPASSPLACEHOLDER/'"${SVPASS}"'/g' ../${PORT2}/redis.conf
sed -i 's/MASTERPASSPLACEHOLDER/'"${SVPASS}"'/g' ../${PORT2}/redis.conf
echo 'replicaof '"${BIND1}"' '"${PORT1}" >> ../${PORT2}/redis.conf

cp redis.conf.template ../${PORT3}/redis.conf
sed -i 's/BINDPLACEHOLDER/'"${BIND3}"'/g' ../${PORT3}/redis.conf
sed -i 's/SELFPORTPLACEHOLDER/'"${PORT3}"'/g' ../${PORT3}/redis.conf
sed -i 's/SVPASSPLACEHOLDER/'"${SVPASS}"'/g' ../${PORT3}/redis.conf
sed -i 's/MASTERPASSPLACEHOLDER/'"${SVPASS}"'/g' ../${PORT3}/redis.conf
echo 'replicaof '"${BIND1}"' '"${PORT1}" >> ../${PORT3}/redis.conf

cp sentinel.conf.template ../${PORT1}/sentinel.conf
sed -i 's/PORTPLACEHOLDER/2'"${PORT1}"'/g' ../${PORT1}/sentinel.conf
sed -i 's/MONITORPLACEHOLDER/'"${MONITOR}"'/g' ../${PORT1}/sentinel.conf
sed -i 's/MASTERPASSPLACEHOLDER/'"${SVPASS}"'/g' ../${PORT1}/sentinel.conf
echo 'requirepass '"${STPASS}"'' >> ../${PORT1}/sentinel.conf

cp sentinel.conf.template ../${PORT2}/sentinel.conf
sed -i 's/PORTPLACEHOLDER/2'"${PORT2}"'/g' ../${PORT2}/sentinel.conf
sed -i 's/MONITORPLACEHOLDER/'"${MONITOR}"'/g' ../${PORT2}/sentinel.conf
sed -i 's/MASTERPASSPLACEHOLDER/'"${SVPASS}"'/g' ../${PORT2}/sentinel.conf
echo 'requirepass '"${STPASS}"'' >> ../${PORT2}/sentinel.conf

cp sentinel.conf.template ../${PORT3}/sentinel.conf
sed -i 's/PORTPLACEHOLDER/2'"${PORT3}"'/g' ../${PORT3}/sentinel.conf
sed -i 's/MONITORPLACEHOLDER/'"${MONITOR}"'/g' ../${PORT3}/sentinel.conf
sed -i 's/MASTERPASSPLACEHOLDER/'"${SVPASS}"'/g' ../${PORT3}/sentinel.conf
echo 'requirepass '"${STPASS}"'' >> ../${PORT3}/sentinel.conf
