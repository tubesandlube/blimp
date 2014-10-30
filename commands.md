Blimp
=====

```
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
  
  Usage: blimp move [OPTIONS] CONTAINER DOCKER_HOST
  
  Move a running container from one Docker host to another, 
  by default will use the same options the original container,
  was started with, but options can be overridden during move.
  
    -a, --attach=[]            Attach to STDIN, STDOUT or STDERR.
    --add-host=[]              Add a custom host-to-IP mapping (host:ip)
    -c, --cpu-shares=0         CPU shares (relative weight)
    --cap-add=[]               Add Linux capabilities
    --cap-drop=[]              Drop Linux capabilities
    --cidfile=""               Write the container ID to the file
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
  
  Usage: blimp replicate [OPTIONS] CONTAINER [HOST:n...] [n]
  
  Replicate a running container onto connected Docker hosts.
  Either n number of hosts with n number of containers must be specified,
  or n number of containers to replicate must be specified, or both.
  If only n number of containers is specified, it will replicate across
  all connected hosts evenly if it can.  If both are specified, it will
  use the bare minimum to meet n number per host specified, and replicate
  any remaining containers above that specified in n to start evenly across
  connected hosts.
  
  Examples:
  
  blimp replicate crazy_nomad do:2 rax:3
    (spins up 2 replicas of crazy_nomad on the do host and 3 on the rax host)
  
  blimp replicate crazy_nomad do:1 5
    (spins up 1 replica of crazy_nomad on the do host and 4 more evenly across connected hosts)
    
  blimp replicate crazy_nomad 7
    (spins up 7 replicas of crazy_nomad evenly across connected hosts)
    
  blimp replicate crazy_nomad do:2 rax:3 4
    (4 in this case is ignore since it is less than what is required by each specified host)


    -a, --attach=[]            Attach to STDIN, STDOUT or STDERR.
    --add-host=[]              Add a custom host-to-IP mapping (host:ip)
    -c, --cpu-shares=0         CPU shares (relative weight)
    --cap-add=[]               Add Linux capabilities
    --cap-drop=[]              Drop Linux capabilities
    --cidfile=""               Write the container ID to the file
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
  ...
```

```
  stop
  ...
```
