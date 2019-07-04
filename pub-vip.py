import redis
import time

if __name__ == "__main__":
    r1 = redis.Redis(host='172.16.212.124', port=6379, db=0, password='123')
    # p1 = r1.pubsub()
    i=0
    while True:
        r1.publish("test", i)
        i = i+1
        time.sleep(1)