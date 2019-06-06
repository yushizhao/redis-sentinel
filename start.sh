PORT1=6379
PORT2=6380
PORT3=6381

nohup redis-server ../${PORT1}/redis.conf > ../${PORT1}/redis.nohup.out 2>&1 &
nohup redis-server ../${PORT2}/redis.conf > ../${PORT2}/redis.nohup.out 2>&1 &
nohup redis-server ../${PORT3}/redis.conf > ../${PORT3}/redis.nohup.out 2>&1 &

nohup redis-sentinel ../${PORT1}/sentinel.conf > ../${PORT1}/sentinel.nohup.out 2>&1 &
nohup redis-sentinel ../${PORT2}/sentinel.conf > ../${PORT2}/sentinel.nohup.out 2>&1 &
nohup redis-sentinel ../${PORT3}/sentinel.conf > ../${PORT3}/sentinel.nohup.out 2>&1 &