```
___.   .__  .__                         _..--=--..._ 
\_ |__ |  | |__| _____ ______        .-'            '-.  .-.
 | __ \|  | |  |/     \\____ \      /.'              '.\/  /
 | \_\ \  |_|  |  Y Y  \  |_> >    |=-                -=| (
 |___  /____/__|__|_|  /   __/      \'.              .'/\  \
     \/              \/|__|          '-.,_____ _____.-'  '-'
                                          [_____]=8

```
```
  help        Print out help message
  ls          List containers running across all connected Docker hosts
  move        Move a running container from one Docker host to another
  replicate   Start n number of containers on n number of Docker hosts that mimic an already running container
  start       Start n number of containers on n number of Docker hosts
  stop        Stop n number of containers on n number of Docker hosts
```

Details
=======

```
  ls
  
  Usage: blimp ls [OPTIONS]
  
  List containers on all Docker hosts.
  
    -a, --all=false            Show all containers. Only running containers are shown by default.
```

```
  move
  
  Usage: blimp move [OPTIONS] [CONTAINER_GROUP] CONTAINER[:HOST] DOCKER_HOST
  
  Move a running container from one Docker host to another, 
  by default will use the same options the original container,
  was started with, but options can be overridden during move.
  Optionally the host the container is currently being run on
  can be specified with the container, in case there are duplicate
  names across hosts.
  
    --group=""                 Specify a container group to belong to
  
    -a, --attach=[]            Attach to STDIN, STDOUT or STDERR.
    --add-host=[]              Add a custom host-to-IP mapping (host:ip)
    -c, --cpu-shares=0         CPU shares (relative weight)
    --cap-add=[]               Add Linux capabilities
    --cap-drop=[]              Drop Linux capabilities
    --cidfile=""               Write the container ID to the file
    --command=""               Overwrite the default COMMAND of the image
    --cpuset=""                CPUs in which to allow execution (0-3, 0,1)
    -d, --detach=false         Detached mode: run the container in the background and print the new container ID
    --device=[]                Add a host device to the container (e.g. --device=/dev/sdc:/dev/xvdc:rwm)
    --dns=[]                   Set custom DNS servers
    --dns-search=[]            Set custom DNS search domains
    -e, --env=[]               Set environment variables
    --entrypoint=""            Overwrite the default ENTRYPOINT of the image
    --env-file=[]              Read in a line delimited file of environment variables
    --expose=[]                Expose a port from the container without publishing it to your host
    -h, --hostname=""          Container host name
    -i, --interactive=false    Keep STDIN open even if not attached
    --link=[]                  Add link to another container in the form of name:alias
    --lxc-conf=[]              (lxc exec-driver only) Add custom lxc options --lxc-conf="lxc.cgroup.cpuset.cpus = 0,1"
    -m, --memory=""            Memory limit (format: <number><optional unit>, where unit = b, k, m or g)
    --name=""                  Assign a name to the container
    --net="bridge"             Set the Network mode for the container
                               'bridge': creates a new network stack for the container on the docker bridge
                               'none': no networking for this container
                               'container:<name|id>': reuses another container network stack
                               'host': use the host network stack inside the container.  Note: the host mode gives the container full access to local system services such as D-bus and is therefore considered insecure.
    -P, --publish-all=false    Publish all exposed ports to the host interfaces
    -p, --publish=[]           Publish a container's port to the host
                               format: ip:hostPort:containerPort | ip::containerPort | hostPort:containerPort | containerPort
                               (use 'docker port' to see the actual mapping)
    --privileged=false         Give extended privileges to this container
    --restart=""               Restart policy to apply when a container exits (no, on-failure[:max-retry], always)
    --rm=false                 Automatically remove the container when it exits (incompatible with -d)
    --security-opt=[]          Security Options
    --sig-proxy=true           Proxy received signals to the process (even in non-TTY mode). SIGCHLD, SIGSTOP, and SIGKILL are not proxied.
    -t, --tty=false            Allocate a pseudo-TTY
    -u, --user=""              Username or UID
    -v, --volume=[]            Bind mount a volume (e.g., from the host: -v /host:/container, from Docker: -v /container)
    --volumes-from=[]          Mount volumes from the specified container(s)
    -w, --workdir=""           Working directory inside the container
```

```
  replicate
  
  Usage: blimp replicate [OPTIONS] [CONTAINER_GROUP] CONTAINER [HOST:n...] [n]
  
  Replicate a running container onto connected Docker hosts.
  Either n number of hosts with n number of containers must be specified,
  or n number of containers to replicate must be specified, or both.
  If only n number of containers is specified, it will replicate across
  all connected hosts evenly if it can.  If both are specified, it will
  use the bare minimum to meet n number per host specified, and replicate
  any remaining containers above that specified in n to start evenly across
  connected hosts.
  
  Examples:
  
  blimp replicate --group="nomads" crazy_nomad do:2 rax:3
    (spins up 2 replicas of crazy_nomad on the do host and 3 on the rax host,
     also puts them all in the 'nomads' container group)
  
  blimp replicate crazy_nomad do:1 5
    (spins up 1 replica of crazy_nomad on the do host and 4 more evenly across connected hosts)
    
  blimp replicate crazy_nomad 7
    (spins up 7 replicas of crazy_nomad evenly across connected hosts)
    
  blimp replicate crazy_nomad do:2 rax:3 4
    (4 in this case is ignored since it is less than what is required by each specified host)

    --group=""                 Specify a container group to belong to

    -a, --attach=[]            Attach to STDIN, STDOUT or STDERR.
    --add-host=[]              Add a custom host-to-IP mapping (host:ip)
    -c, --cpu-shares=0         CPU shares (relative weight)
    --cap-add=[]               Add Linux capabilities
    --cap-drop=[]              Drop Linux capabilities
    --cidfile=""               Write the container ID to the file
    --command=""               Overwrite the default COMMAND of the image
    --cpuset=""                CPUs in which to allow execution (0-3, 0,1)
    -d, --detach=false         Detached mode: run the container in the background and print the new container ID
    --device=[]                Add a host device to the container (e.g. --device=/dev/sdc:/dev/xvdc:rwm)
    --dns=[]                   Set custom DNS servers
    --dns-search=[]            Set custom DNS search domains
    -e, --env=[]               Set environment variables
    --entrypoint=""            Overwrite the default ENTRYPOINT of the image
    --env-file=[]              Read in a line delimited file of environment variables
    --expose=[]                Expose a port from the container without publishing it to your host
    -h, --hostname=""          Container host name
    -i, --interactive=false    Keep STDIN open even if not attached
    --link=[]                  Add link to another container in the form of name:alias
    --lxc-conf=[]              (lxc exec-driver only) Add custom lxc options --lxc-conf="lxc.cgroup.cpuset.cpus = 0,1"
    -m, --memory=""            Memory limit (format: <number><optional unit>, where unit = b, k, m or g)
    --name=""                  Assign a name to the container
    --net="bridge"             Set the Network mode for the container
                               'bridge': creates a new network stack for the container on the docker bridge
                               'none': no networking for this container
                               'container:<name|id>': reuses another container network stack
                               'host': use the host network stack inside the container.  Note: the host mode gives the container full access to local system services such as D-bus and is therefore considered insecure.
    -P, --publish-all=false    Publish all exposed ports to the host interfaces
    -p, --publish=[]           Publish a container's port to the host
                               format: ip:hostPort:containerPort | ip::containerPort | hostPort:containerPort | containerPort
                               (use 'docker port' to see the actual mapping)
    --privileged=false         Give extended privileges to this container
    --restart=""               Restart policy to apply when a container exits (no, on-failure[:max-retry], always)
    --rm=false                 Automatically remove the container when it exits (incompatible with -d)
    --security-opt=[]          Security Options
    --sig-proxy=true           Proxy received signals to the process (even in non-TTY mode). SIGCHLD, SIGSTOP, and SIGKILL are not proxied.
    -t, --tty=false            Allocate a pseudo-TTY
    -u, --user=""              Username or UID
    -v, --volume=[]            Bind mount a volume (e.g., from the host: -v /host:/container, from Docker: -v /container)
    --volumes-from=[]          Mount volumes from the specified container(s)
    -w, --workdir=""           Working directory inside the container
```

```
  start
  
  Usage: blimp start [OPTIONS] [CONTAINER_GROUP] IMAGE [HOST:n...] [n]
  
  Start a container on connected Docker hosts. Either n number of hosts
  with n number of containers must be specified, or n number of containers
  to start must be specified, or both. If only n number of containers is
  specified, it will start across all connected hosts evenly if it can.
  If both are specified, it will use the bare minimum to meet n number per
  host specified, and start any remaining containers above that specified
  in n to start evenly across connected hosts.
  
  Examples:
  
  blimp start --group="redis" redis do:2 rax:3
    (spins up 2 containers of redis on the do host and 3 on the rax host,
     also puts them all in the 'redis' container group)
  
  blimp start redis do:1 5
    (spins up 1 conatiner of redis on the do host and 4 more evenly across connected hosts)
    
  blimp start redis 7
    (spins up 7 containers of redis evenly across connected hosts)
    
  blimp start redis do:2 rax:3 4
    (4 in this case is ignored since it is less than what is required by each specified host)

    --group=""                 Specify a container group to belong to

    -a, --attach=[]            Attach to STDIN, STDOUT or STDERR.
    --add-host=[]              Add a custom host-to-IP mapping (host:ip)
    -c, --cpu-shares=0         CPU shares (relative weight)
    --cap-add=[]               Add Linux capabilities
    --cap-drop=[]              Drop Linux capabilities
    --cidfile=""               Write the container ID to the file
    --command=""               Overwrite the default COMMAND of the image
    --cpuset=""                CPUs in which to allow execution (0-3, 0,1)
    -d, --detach=false         Detached mode: run the container in the background and print the new container ID
    --device=[]                Add a host device to the container (e.g. --device=/dev/sdc:/dev/xvdc:rwm)
    --dns=[]                   Set custom DNS servers
    --dns-search=[]            Set custom DNS search domains
    -e, --env=[]               Set environment variables
    --entrypoint=""            Overwrite the default ENTRYPOINT of the image
    --env-file=[]              Read in a line delimited file of environment variables
    --expose=[]                Expose a port from the container without publishing it to your host
    -h, --hostname=""          Container host name
    -i, --interactive=false    Keep STDIN open even if not attached
    --link=[]                  Add link to another container in the form of name:alias
    --lxc-conf=[]              (lxc exec-driver only) Add custom lxc options --lxc-conf="lxc.cgroup.cpuset.cpus = 0,1"
    -m, --memory=""            Memory limit (format: <number><optional unit>, where unit = b, k, m or g)
    --name=""                  Assign a name to the container
    --net="bridge"             Set the Network mode for the container
                               'bridge': creates a new network stack for the container on the docker bridge
                               'none': no networking for this container
                               'container:<name|id>': reuses another container network stack
                               'host': use the host network stack inside the container.  Note: the host mode gives the container full access to local system services such as D-bus and is therefore considered insecure.
    -P, --publish-all=false    Publish all exposed ports to the host interfaces
    -p, --publish=[]           Publish a container's port to the host
                               format: ip:hostPort:containerPort | ip::containerPort | hostPort:containerPort | containerPort
                               (use 'docker port' to see the actual mapping)
    --privileged=false         Give extended privileges to this container
    --restart=""               Restart policy to apply when a container exits (no, on-failure[:max-retry], always)
    --rm=false                 Automatically remove the container when it exits (incompatible with -d)
    --security-opt=[]          Security Options
    --sig-proxy=true           Proxy received signals to the process (even in non-TTY mode). SIGCHLD, SIGSTOP, and SIGKILL are not proxied.
    -t, --tty=false            Allocate a pseudo-TTY
    -u, --user=""              Username or UID
    -v, --volume=[]            Bind mount a volume (e.g., from the host: -v /host:/container, from Docker: -v /container)
    --volumes-from=[]          Mount volumes from the specified container(s)
    -w, --workdir=""           Working directory inside the container
```

```
  stop
  
  Usage: blimp stop CONTAINER_GROUP [HOST:n...] [n]
  
  Stop a container group on connected Docker hosts. Either n number of hosts
  with n number of containers must be specified, or n number of containers
  to stop must be specified, or both. If only n number of containers is
  specified, it will stop across all connected hosts evenly if it can.
  If both are specified, it will use the bare minimum to meet n number per
  host specified, and stop any remaining containers above that specified
  in n to stop evenly across connected hosts. Container groups can be 
  retrieved from using ls.
  
  Examples:
  
  blimp stop nomads do:2 rax:3
    (stops up to 2 containers of nomads on the do host and up to 3 on the rax host)
  
  blimp stop nomads do:1 5
    (stops up to 1 conatiner of nomads on the do host and up to 4 more evenly across connected hosts)
    
  blimp stop nomads 7
    (stops up to 7 containers of nomads evenly across connected hosts)
    
  blimp stop nomads do:2 rax:3 4
    (4 in this case is ignored since it is less than what is required by each specified host)
    
  blimp stop nomads -1
    (stops all containers of nomads)
```
