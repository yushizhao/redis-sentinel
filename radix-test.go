package main

import (
	"fmt"

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

	sentinel, err := radix.NewSentinel("mymaster", address, radix.SentinelConnFunc(customConnFunc))
	if err != nil {
		fmt.Println(err)
	}

	m, s := sentinel.Addrs()
	fmt.Println(m)
	fmt.Println(s)
}
