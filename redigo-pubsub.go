package main

import (
	"flag"
	"fmt"
	"time"

	"github.com/gomodule/redigo/redis"
	"github.com/yushizhao/hubble/rediswrapper"
)

func main() {
	var mode = flag.String("m", "sub", "pub or sub")
	var url = flag.String("u", "10.118.11.202:6379", "host:port")
	var password = flag.String("p", "123", "password")
	var topic = flag.String("t", "test", "topic")

	flag.Parse()
	r := rediswrapper.NewClient(*url, *password, 3, 60)

	if *mode == "pub" {

		for {
			now := time.Now().Format(time.RFC3339)
			err := r.Pub(*topic, now)
			fmt.Println(now)
			if err != nil {
				fmt.Println(err)
			}
			time.Sleep(2 * time.Second)
		}

	}

	if *mode == "sub" {

		psc, err := r.Sub(*topic)
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
				psc, err = r.Sub(*topic)
				if err != nil {
					fmt.Println(err)
				}
			}
		}

	}
}
