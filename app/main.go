package main

import (
	"fmt"
	"net/http"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.GET("/", func(c *gin.Context) {
		c.String(http.StatusOK, "Hello world 2")
	})
	err := r.Run()
	if err != nil {
		fmt.Print("handle your error here")
	}
}
