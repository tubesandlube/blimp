package containers;

sub enumerate {

  my $extra;
  my $g;
  my $group;
  my $h;
  my $header;
  my $hosts;
  my $i;
  my $j;
  my $k;
  my @lines;
  my $out1;
  my @parts;

  $hosts  = hosts::enumerate();
  $header = 0;

  if($ARGV[1] && $ARGV[1] !~ /^\s*$/) {
    $extra = join(" ", @ARGV[1..$#ARGV]);
  } else {
    $extra = "";
  }

  for($i = 0; $i <= $#{$hosts}; $i++) {
    #print "attaching to $hosts->[$i]\n";
    docker::drun("hosts active $hosts->[$i]");
    $out1 = docker::drun("ps $extra");

    if($out1 && $out1 !~ /^\s*$/) {
      @lines = split(/\n/, $out1);
      for($j = 0; $j <= $#lines; $j++) {
        if($lines[$j] =~ /^CONTAINER/) {
          if(0 == $header) {
            printf "HOST            GROUP           $lines[$j]\n";
            $header = 1;
          }
        } elsif($lines[$j] =~ /^[0-9a-z]/) {

          # hack
          @parts = split(/\s+/, $lines[$j]);
          $group = getgroupbyname($hosts->[$i], $parts[$#parts]);

          # gross, fix
          for($k = 0; $k <= 15; $k++) {
            $hosts->[$i] .= " ";
          }
          for($k = 0; $k <= 15; $k++) {
            $group .= " ";
          }
          $h = substr($hosts->[$i], 0, 15);
          $g = substr($group, 0, 15);
          print "$h $g $lines[$j]\n";
        } else {
          print STDERR "ERROR: $lines[$j]\n";
        }
      }
    }
  }

  return();

}

sub getgroupbyname {

  my @cenv;
  my $container;
  my $group;
  my $host;
  my $i;

  $host      = shift;
  $container = shift;

  docker::drun("hosts active $host");

  $inspect = JSON::decode_json(docker::drun("inspect $container"));
  @cenv    = $inspect->[0]{'Config'}{'Env'};

  for($i = 0; $i <= $#{$cenv[0]}; $i++) {
    if($cenv[0][$i] && $cenv[0][$i] !~ /^\s*$/
        && $cenv[0][$i] =~ /^CONTAINER_GROUP=(.*)/) {
      $group = $1;
    }
  }
  if(!($group && $group !~ /^\s*$/)) {
    $group = "-";
  }

  return($group);

}

1;
