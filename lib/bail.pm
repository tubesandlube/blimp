package bail;

use Term::ANSIColor qw(:constants);

sub bye {

  my $message;

  $message = shift || '';

  print STDERR RED, "Error: $message\n", RESET;
  logger::log('blimp', $message);

  exit(1);

}

1;
