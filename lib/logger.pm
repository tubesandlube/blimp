package logger;

sub log {

  my $app;
  my $i;
  my @lines;
  my $log;
  my $logapp;
  my $pid;
  my $stdout;

  $app    = shift;
  $log    = shift;
  $stdout = shift || '0';

  $pid    = $$;
  $logapp = '/usr/bin/logger';

  @lines  = split(/\n+/, $log);

  open(LOG, "| $logapp") || die("$!: can not send to syslog.\n");
  for($i = 0; $i <= $#lines; $i++) {
    if($lines[$i] !~ /^\s*$/) {
      print LOG "$app\[$pid\]: $lines[$i]\n";
      print STDOUT "$lines[$i]\n" if $stdout;
    }
  }
  close LOG;

  return();

}

1;
