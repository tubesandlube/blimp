Like our hack? Vote for us for the Docker globalhackday by giving us a +1 on Facebook, Twitter, and/or Google+.
<table class="soc_vote" data-id="24"><tbody><tr>                <td>                    <div class="fb-like" data-href="https://www.docker.com/community/globalhackday/24" data-width="80" data-layout="button_count" data-action="like" data-via="docker" data-show-faces="false" data-share="false"></div>                </td>                <td>                      <a href="https://twitter.com/share" class="twitter-share-button" data-url="https://www.docker.com/community/globalhackday/24/" data-text="I voted for Blimp by @schvin @defermat @docker" data-hashtags="dockerhackday"></a>                </td>                <td>                    <div class="g-plusone" data-size="medium" data-width="50px" data-href="https://www.docker.com/community/globalhackday/#24"></div>                </td>            </tr></tbody></table>

blimp
=====

Mechanism to easily move a container from one Docker host to another, show containers running against all of your hosts, replicate a container across multiple hosts and more.

Relies on the `docker hosts` feature proposed in docker#8681 and laid out in this branch: https://github.com/bfirsh/docker/tree/host-management

See it in action: https://www.youtube.com/watch?v=L66f5kkN7W8

install
=======

dependencies: perl

build docker from the `host-management` branch of `@bfirsh`'s fork from here: https://github.com/bfirsh/docker/tree/host-management

add some hosts using `docker hosts`

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

Invoke the CPAN shell:

```
# perl -MCPAN -e shell
```

If you run this for the first time it asks you some configuration questions. In most cases it works just fine if you tell it to "go figure it out yourself." Once configured you will see a cpan> shell prompt.

The first thing you should do is to upgrade your CPAN:

```
cpan> install Bundle::CPAN
```

Once ready, type:

```
cpan> reload cpan
```

Now it is time to install the additional modules you need. In this case the JSON module:

```
cpan> install JSON
```

If needed you will be prompted to install other modules this module depends on.
