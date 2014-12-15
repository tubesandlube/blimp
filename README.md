This hack was written in 2014 as a participating entry in the Docker global hack day. Popular voting came to a close and many interesting projects came out of it. This particular project would require some cleanup and less hack-like code to really be useful, but it was an interesting experiment and certainly scratched an itch.  https://www.docker.com/community/globalhackday#24

blimp
=====

Mechanism to easily move a container from one Docker host to another, show containers running against all of your hosts, replicate a container across multiple hosts and more.

Presently relies on the `docker machines` feature proposed in docker#8681 and laid out in this branch: https://github.com/bfirsh/docker/tree/host-management, which has now become a real application called `machines` at https://github.com/docker/machines

See it in action: https://www.youtube.com/watch?v=L66f5kkN7W8

environment
=======

The environment variable `DOCKER_BINARY` can be set to a specific path for an alternate or path-specific docker binary. Often needed if you have built the branch for `docker machines` capability on a shared system.

install
=======

dependencies: curl, perl

build docker from the `host-management` branch of `@bfirsh`'s fork from here: https://github.com/bfirsh/docker/tree/host-management (note you can instead build docker machine from https://github.com/docker/machine, or use run it from a Docker container: defermat/machine)

add some hosts using `docker machines`

`git clone https://github.com/tubesandlube/blimp.git`

`cd blimp/bin`

`./blimp`

Note: for logging, setup syslog, and blimp will automatically send messages there.

usage
=====

see [``commands.md``](https://github.com/tubesandlube/blimp/blob/master/commands.md)

faq
===

What do I do if I see this error?

```
  Can't locate JSON.pm in @INC (you may need to install the JSON module) (@INC contains: ../lib ../lib /etc/perl
  /usr/local/lib/perl/5.18.2 /usr/local/share/perl/5.18.2 /usr/lib/perl5 /usr/share/perl5 /usr/lib/perl/5.18
  /usr/share/perl/5.18 /usr/local/lib/site_perl .) at ./blimp line 55.
  BEGIN failed--compilation aborted at ./blimp line 55.
```

Install the JSON library via the CPAN shell:
```
PERL_MM_USE_DEFAULT=1 sudo perl -MCPAN -e 'install JSON'
```
