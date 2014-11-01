blimp
=====

Mechanism to easily move a container from one Docker host to another, show containers running against all of your hosts, etc

Relies on the `docker hosts` feature proposed in docker#8681 and laid out in this branch: https://github.com/bfirsh/docker/tree/host-management

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
