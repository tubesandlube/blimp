package bail;

use Term::ANSIColor qw(:constants);

sub bye {

  my $message;

  $message = shift || '';

  print STDERR RED, "Error: $message\n", RESET;
  # XXX logger;
  exit(1);

}

1;
