package main

import (
	"fmt"
	"os"

	"github.com/codegangsta/cli"
)

func main() {
	app := cli.NewApp()
	app.Action = func(c *cli.Context) {
		fmt.Println(`
___.   .__  .__                         _..--=--..._
\_ |__ |  | |__| _____ ______        .-'            '-.  .-.
 | __ \|  | |  |/     \\____ \      /.'              '.\/  /
 | \_\ \  |_|  |  Y Y  \  |_> >    |=-                -=| (
 |___  /____/__|__|_|  /   __/      \'.              .'/\  \
     \/              \/|__|          '-.,_____ _____.-'  '-'
                                          [_____]=8
		`)
	} 
	app.Name = "blimp"
	app.Usage = "Mechanism to easily move a container from one " +
                    "Docker host to another, show containers running " +
                    "against all of your hosts, replicate a container " +
                    "across multiple hosts and more."
	app.Version = "0.1.0"
	app.Author = "Charlie Lewis, George Lewis"
	app.Email = "defermat@defermat.net, schvin@schvin.net"
	app.Commands = []cli.Command{
		{
			Name:   "ls",
			Usage:  "List containers running across all connected Docker hosts",
			Action: containerList,
		},
		{
			Name:   "move",
			Usage:  "Move a running container from one Docker host to another",
			Action: moveContainer,
		},
		{
			Name:   "replicate",
			Usage:  "Start n number of containers on n number of Docker hosts " +
                                "that mimic an already running container",
			Action: replicateContainer,
		},
		{
			Name:   "start",
			Usage:  "Start n number of containers on n number of Docker hosts",
			Action: startContainer,
		},
		{
			Name:   "stop",
			Usage:  "Stop n number of containers on n number of Docker hosts",
			Action: stopContainer,
		},
	}
	app.Run(os.Args)
}
