package hosts;

sub enumerate {

  my @hosts;
  my $i;
  my @lines;
  my @parts;
  my $out;

  $out = docker::drun("machines");
  @lines = split(/\n/, $out);
  # skip first; header
  for($i = 1; $i <= $#lines; $i++) {
    @parts = split(/\s+/, $lines[$i]);
    push @hosts, $parts[0];
    #print "$parts[0]\n";
  }

  return(\@hosts);

}

1;
