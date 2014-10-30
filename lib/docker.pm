package docker;

sub drun {

  my $cmd;
  my $out;
  my $arg;
  my $docker;

  $arg = shift;
  $docker = "docker";

  $cmd = "$docker $arg";
  $out = `$cmd`;

  return($out);

}

1;
