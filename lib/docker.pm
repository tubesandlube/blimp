package docker;

sub drun {

  my $arg;
  my $cmd;
  my $docker;
  my $me;
  my $out;

  $arg    = shift;
  $me     = "blimp::docker::drun";

  # setup default TLS auth for all non-local/default hosts
  if($arg =~ /machines active/) {
    if($arg =~ /machines active default/) {
      delete $ENV{'DOCKER_AUTH'};
      delete $ENV{'DOCKER_AUTH_CA'};
      delete $ENV{'DOCKER_AUTH_CERT'};
      delete $ENV{'DOCKER_AUTH_KEY'};
    } else {
      $ENV{'DOCKER_AUTH'}      = $ENV{'DOCKER_AUTH'}      || "cert";
      $ENV{'DOCKER_AUTH_CA'}   = $ENV{'DOCKER_AUTH_CA'}   || "~/.docker/ca.pem";
      $ENV{'DOCKER_AUTH_CERT'} = $ENV{'DOCKER_AUTH_CERT'} || "~/.docker/cert.pem";
      $ENV{'DOCKER_AUTH_KEY'}  = $ENV{'DOCKER_AUTH_KEY'}  || "~/.docker/key.pem";
    }
  }

  if(%ENV && $ENV{'DOCKER_BINARY'}) {
    $docker = $ENV{'DOCKER_BINARY'};
    logger::log($me, "overwriting docker binary in path with supplied environment variable for DOCKER_BINARY");
  } else {
    $docker = "docker";
  }

  # XXX
  $docker .= " --tls"; 

  # XXX shell injection issue here - needs work
  logger::log($me, "running docker command: $arg");

  $cmd = "$docker $arg";
  $out = `$cmd 2>&1 | grep -v 'Warning:'`;

  return($out);

}

sub pass_options {

  # XXX pull out command and return it

  my $command;
  my $i;
  my $me;
  my $options;
  my $runtime;

  $me = "blimp::docker::pass_options";

  $options = shift;

  $command = "";
  $runtime = "";
  for($i = 0; $i <= $#{$options}; $i++) {
    if($options->[$i] && $options->[$i] =~ /^--command=(.*)/) {
      $command = $1;
      logger::log($me, "adding command option parameter of: $command");
    } else {
      logger::log($me, "passing through runtime option: $options->[$i]");
      $runtime .= "$options->[$i] ";
    }
  }

  return($runtime, $command);

}

sub gethostbyname {

  my $host;
  my $i;
  my @lines;
  my $name;
  my $out;

  $name = shift;

  $out  = drun("machines");
  $host = "";

  @lines = split(/\n/, $out);
  for($i = 0; $i <= $#lines; $i++) {
    my @parts = split(/\s+/, $lines[$i]);
    if($parts[0] eq $name) {
      $host = $parts[$#parts]; # XXX
      $host =~ s/.*\///;
      $host =~ s/:.*//;
    }
  }

  if(!($host && $host !~ /^\s*$/)) {
    bail::bye("Error, host named '$name' not found");
  }

  #print "turned $name into $host\n";

  return($host);

}

1;
