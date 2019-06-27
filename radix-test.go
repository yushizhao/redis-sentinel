package main

import (
	"fmt"
	"log"

	"github.com/mediocregopher/radix"
)

func main() {
	address := []string{
		"redis://:12345678@127.0.0.1:26379",
		"redis://:12345678@127.0.0.1:26380",
		"redis://:12345678@127.0.0.1:26381",
	}

	customConnFunc := func(network, addr string) (radix.Conn, error) {
		return radix.Dial(network, addr,
			// radix.DialTimeout(1*time.Second),
			radix.DialAuthPass("12345678"),
		)
	}

	customClientFunc := func(network, addr string) (radix.Client, error) {

		customClientConnFunc := func(network, addr string) (radix.Conn, error) {
			return radix.Dial(network, addr,
				// radix.DialTimeout(1*time.Second),
				radix.DialAuthPass("123"),
			)
		}

		return radix.NewPool(network, addr, 100, radix.PoolConnFunc(customClientConnFunc))
	}

	sentinel, err := radix.NewSentinel("mymaster", address, radix.SentinelConnFunc(customConnFunc), radix.SentinelPoolFunc(customClientFunc))
	if err != nil {
		fmt.Println(err)
	}

	// fmt.Println(sentinel.SentinelAddrs())
	_, slaves := sentinel.Addrs()
	conn, err := radix.Dial("tcp", slaves[len(slaves)-1], radix.DialAuthPass("123"))
	ps := radix.PubSub(conn)
	if err != nil {
		fmt.Println(err)
	}
	msgCh := make(chan radix.PubSubMessage)
	if err := ps.PSubscribe(msgCh, "*"); err != nil {
		fmt.Println(err)
	}
	for msg := range msgCh {
		log.Printf("publish to channel %q received: %q", msg.Channel, msg.Message)
	}
	// client, err := sentinel.Client(slaves[0])
	// if err != nil {
	// 	fmt.Println(err)
	// }
	// var s string
	// err = client.Do(radix.Cmd(&s, "INFO"))
	// if err != nil {
	// 	fmt.Println(err)
	// }
	// fmt.Println(s)

}
