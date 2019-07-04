package main

import (
	"fmt"
	"time"

	"github.com/yushizhao/hubble/redis"
)

func main() {
	r := redis.NewClient("172.16.212.124:6379", "123", 3, 60)
	for {
		now := time.Now().Format(time.RFC3339)
		err := r.Pub("test", now)
		fmt.Println(now)
		if err != nil {
			fmt.Println(err)
		}
		time.Sleep(time.Second)
	}
}
