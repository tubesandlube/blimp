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
                        Flags: []cli.Flag{
				cli.BoolFlag{
					Name:  "all, a",
					Usage: "Show all containers. Only running containers are shown by default.",
				},
				cli.StringFlag{
					Name:  "before",
					Usage: "Show only container created before Id or Name, include non-running ones.",
				},
				cli.BoolFlag{
					Name:  "latest, l",
					Usage: "Show only the latest created container, include non-running ones.",
				},
				cli.IntFlag{
					Name:  "n",
					Usage: "Show n last created containers, include non-running ones.",
				},
				cli.BoolFlag{
					Name:  "no-trunc",
					Usage: "Don't truncate output",
				},
				cli.BoolFlag{
					Name:  "quiet, q",
					Usage: "Only display numeric IDs",
				},
				cli.BoolFlag{
					Name:  "size, s",
					Usage: "Display sizes",
				},
				cli.StringFlag{
					Name:  "since",
					Usage: "Show only containers created since Id or Name, include non-running ones.",
				},
			},
		},
		{
			Name:   "move",
			Usage:  "Move a running container from one Docker host to another",
			Action: moveContainer,
                        Flags: []cli.Flag{
				cli.StringFlag{
					Name:  "group",
					Usage: "Specify a container group to belong to",
				},
			},
		},
		{
			Name:   "replicate",
			Usage:  "Start n number of containers on n number of Docker hosts " +
                                "that mimic an already running container",
			Action: replicateContainer,
                        Flags: []cli.Flag{
				cli.StringFlag{
					Name:  "group",
					Usage: "Specify a container group to belong to",
				},
			},
		},
		{
			Name:   "start",
			Usage:  "Start n number of containers on n number of Docker hosts",
			Action: startContainer,
                        Flags: []cli.Flag{
				cli.StringFlag{
					Name:  "group",
					Usage: "Specify a container group to belong to",
				},
			},
		},
		{
			Name:   "stop",
			Usage:  "Stop n number of containers on n number of Docker hosts",
			Action: stopContainer,
                        Flags: []cli.Flag{
				cli.StringFlag{
					Name:  "group",
					Usage: "Specify a container group to belong to",
				},
			},
		},
	}
	app.Run(os.Args)
}
