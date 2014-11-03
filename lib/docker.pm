package docker;

sub drun {

  my $arg;
  my $cmd;
  my $docker;
  my $me;
  my $out;

  $arg    = shift;
  $docker = "docker";
  $me     = "blimp::docker::drun";

  # XXX shell injection issue here - needs work
  logger::log($me, "running docker command: $arg");

  $cmd = "$docker $arg";
  $out = `$cmd`;

  return($out);

}

1;
