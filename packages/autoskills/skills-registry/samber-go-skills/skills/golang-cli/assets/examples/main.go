// cmd/myapp/main.go
package main

import (
	"os"
)

func main() {
	if err := Execute(); err != nil {
		os.Exit(1)
	}
}
