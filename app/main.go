package main

import (
	"net/http"

	"github.com/gin-gonic/gin"
)

func HelloWorld(c *gin.Context) {
	c.HTML(http.StatusOK, "index.html", gin.H{
		"title": "Hello world 2",
	})
}

func main() {
	r := gin.Default()
	r.LoadHTMLFiles("index.html")
	r.GET("/", HelloWorld)

	err := r.Run()
	if err != nil {
		panic(err)
	}
}
