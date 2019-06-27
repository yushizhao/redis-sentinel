package main

// import (
// 	"fmt"
// 	"time"

// 	"github.com/go-redis/redis"
// )

// func main() {
// 	redisdb := redis.NewFailoverClient(&redis.FailoverOptions{
// 		MasterName:       "mymaster",
// 		SentinelAddrs:    []string{":26379", ":26380", "26381"},
// 		SentinelPassword: "12345678",
// 		Password:         "123",
// 	})

// 	for {
// 		valInfo, err := redisdb.Do("ROLE").Result()
// 		if err != nil {
// 			fmt.Println(err)
// 		}
// 		fmt.Println(valInfo)
// 		time.Sleep(10 * time.Second)
// 	}
// }
