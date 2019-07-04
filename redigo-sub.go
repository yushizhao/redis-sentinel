package main

import (
	"fmt"
	"time"

	"github.com/gomodule/redigo/redis"
	"github.com/yushizhao/hubble/rediswrapper"
)

func main() {
	r := rediswrapper.NewClient("172.16.212.124:6379", "123", 3, 60)

	psc, err := r.Sub("test")
	if err != nil {
		fmt.Println(err)
	}
	for {
		switch v := psc.Receive().(type) {
		case redis.Message:
			fmt.Println(string(v.Data))
		case redis.Subscription:
			// logger.Info("%s: %s %d\n", v.Channel, v.Kind, v.Count)
		case error:
			fmt.Println(v)
			time.Sleep(time.Second)
			psc, err = r.Sub("test")
			if err != nil {
				fmt.Println(err)
			}
		}
	}
}
