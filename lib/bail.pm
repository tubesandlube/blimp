package bail;

sub bye {

  my $message;

  $message = shift || '';

  print STDERR "Error: $message\n";
  # XXX logger;
  exit(1);

}

1;
