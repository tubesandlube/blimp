package capture;

=pod

=head1 capture.pm

 Functions for capturing state/parameters of a current container.

=cut

sub running {

  my @ccmd;
  my $ccmd2;
  my @cenv;
  my $cenv2;
  my $cid;
  my $cimage;
  my $cname;
  my %data;
  my $fullenv;
  my $groupset;
  my $host;
  my $i;
  my $inspect;
  my $name;
  my @options;
  my $optionsref;
  my $runtime;

  $cname      = shift;
  $host       = shift;
  $name       = shift;
  $optionsref = shift;
  @options    = @{$optionsref};

  docker::drun("hosts active $host");

  $inspect = JSON::decode_json(docker::drun("inspect $cname"));
  $cimage  = $inspect->[0]{'Config'}{'Image'};
  @ccmd    = $inspect->[0]{'Config'}{'Cmd'};
  @cenv    = $inspect->[0]{'Config'}{'Env'};

  # XXX add port exposure settings...
  # deal with -i -t -P , etc.
  $runtime = "run -d";

  # XXX dupes default path unnecessarily, but path could be altered
  for($i = 0; $i <= $#{$cenv[0]}; $i++) {
    if($cenv[0][$i] && $cenv[0][$i] !~ /^\s*$/
        && $cenv[0][$i] !~ /^CONTAINER_GROUP=/) {
      $runtime .= " -e $cenv[0][$i]";
    }
  }

  # add env for container group
  $groupset = 0;
  for($i = 0; $i <= $#options+1; $i++) {
    if($options[$i] =~ /^--group=/) {
      my @group = split(/=/, $options[$i]);
      $runtime .= " -e CONTAINER_GROUP=$group[1]";
      $groupset = 1;
    }
  }
  # XXX stick with prior group only if a new one wasn't set, at this point
  if(0 == $groupset) {
    $runtime .= " -e CONTAINER_GROUP=$name";
  }

  # image
  $runtime .= " $cimage";

  # XXX this seems to lose stuff after the first command, i.e. && 
  for($i = 0; $i <= $#{$ccmd[0]}; $i++) {
    if($ccmd[0][$i] && $ccmd[0][$i] !~ /^\s*$/) {
      $runtime .= " $ccmd[0][$i]";
    }
  }
 
  print "planning to re-run this container as: $runtime\n";

  return($runtime);
  
}

1;
