package containers;

sub enumerate {

  my $extra;
  my $h;
  my $hosts;
  my $i;
  my $j;
  my $k;
  my @lines;
  my $out;
  my $out1;

  $hosts = hosts::enumerate();

  if($ARGV[1] && $ARGV[1] !~ /^\s*$/) {
    $extra = join(" ", @ARGV[1..$#ARGV]);
  } else {
    $extra = "";
  }

  $out = "";
  for($i = 0; $i <= $#{$hosts}; $i++) {
    #print "attaching to $hosts->[$i]\n";
    docker::drun("hosts active $hosts->[$i]");
    $out1 = docker::drun("ps $extra");

    if($out1 && $out1 !~ /^\s*$/) {
      @lines = split(/\n/, $out1);
      for($j = 0; $j <= $#lines; $j++) {
        if($lines[$j] =~ /^CONTAINER/) {
          if(0 == $i) {
            # XXX
            printf "HOST            $lines[$j]\n";
          }
        } elsif($lines[$j] =~ /^[0-9a-z]/) {
          # gross, fix
          for($k = 0; $k <= 15; $k++) {
            $hosts->[$i] .= " ";
          }
          $h = substr($hosts->[$i], 0, 15);
          $out .= "$h $lines[$j]\n";
        } else {
          print STDERR "ERROR: $lines[$j]\n";
        }
      }
    }
  }

  return($out);

}

1;
