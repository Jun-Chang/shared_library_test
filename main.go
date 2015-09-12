package main

import (
	"C"
	"fmt"
)

func init() {
	fmt.Println("laoded.")
}

//export helloGopher
func helloGopher() {
	fmt.Println("Hello Gopher!")
}

func main() {
}
