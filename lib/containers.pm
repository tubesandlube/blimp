package containers;

use Term::ANSIColor qw(:constants);

sub enumerate {

  my @args;
  my $argsref;
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
  my $me;
  my @options;
  my $optionsref;
  my $out;
  my $out1;
  my @parts;
  my $realtime;

  $argsref     = shift;
  $optionsref  = shift;
  $realtime    = shift || 0;

  $me      = "blimp::containers::enumerate";

  @args    = @{$argsref};
  @options = @{$optionsref};

  $hosts    = hosts::enumerate();
  $header   = 0;

  if($args[1] && $args[1] !~ /^\s*$/) {
    $extra = join(" ", @args[1..$#args]);
  } else {
    $extra = "";
  }

  $out = "";
  for($i = 0; $i <= $#{$hosts}; $i++) {
    #print "attaching to $hosts->[$i]\n";
    logger::log($me, "running ps across hosts");
    docker::drun("machines active $hosts->[$i]");
    $out1 = docker::drun("ps $extra");

    if($out1 && $out1 !~ /^\s*$/) {
      @lines = split(/\n/, $out1);
      for($j = 0; $j <= $#lines; $j++) {
        if($lines[$j] =~ /^CONTAINER/) {
          if(0 == $header && $realtime) {
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
          if($realtime) {
            print "$h $g $lines[$j]\n";
          } else {
            $out .= "$h $g $lines[$j]\n";
          }
        } else {
          print STDERR RED, "ERROR: $lines[$j]\n", RESET;
        }
      }
    }
  }

  return($out);

}

sub getgroupbyname {

  my @cenv;
  my $container;
  my $group;
  my $host;
  my $i;

  $host      = shift;
  $container = shift;

  docker::drun("machines active $host");

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
