package docker;

sub drun {

  my $arg;
  my $cmd;
  my $docker;
  my $me;
  my $out;

  $arg    = shift;
  $docker = "docker --tls";
  $me     = "blimp::docker::drun";

  # XXX shell injection issue here - needs work
  logger::log($me, "running docker command: $arg");

  $cmd = "$docker $arg";
  $out = `$cmd`;

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
