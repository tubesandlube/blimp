package volumes;

use Term::ANSIColor qw(:constants);

sub move {

  my $cmd;
  my $dcmd;
  my $dhost;
  my $dvols;
  my $i;
  my @keys;
  my $me;
  my $out;
  my $scmd;
  my $shost;
  my $svols;

  $me   = "blimp::volumes::move";

  $svols = shift;
  $dvols = shift;
  $sname = shift;
  $dname = shift;

  $shost = docker::gethostbyname($sname);
  $dhost = docker::gethostbyname($dname);

  @keys = keys(%{$svols});
  for($i = 0; $i <= $#keys; $i++) {
    # XXX sanity check that items of svols == dvols
    logger::log($me, "moving volume $keys[$i] from $shost ($svols->{$keys[$i]}) to $dhost ($dvols->{$keys[$i]})");
    print CYAN, "going to move $keys[$i] from:\n\t$shost ($svols->{$keys[$i]}), to\n\t$dhost ($dvols->{$keys[$i]})\n", RESET;
    $scmd = "sudo tar cpv --file - --directory $svols->{$keys[$i]} .";
    $dcmd = "sudo tar xpv --file - --directory $dvols->{$keys[$i]}";
    $cmd = "ssh $shost \"$scmd\" | ssh $dhost \"$dcmd\"";
    $out = `$cmd`;
    logger::log($me, "volume copy completed");
    print CYAN, "volume copy completed\n", RESET;
  }

  return();

}

sub getvolumesbyuuid {

  my $container;
  my @cvol;
  my $dhost;
  my $i;
  my @keys;
  my $me;
  my %volumes;

  $me = "blimp::volumes::getvolumesbyuuid";

  $container = shift;
  $dhost     = shift;
 
  docker::drun("machines active $dhost");
  $inspect = JSON::decode_json(docker::drun("inspect $container"));
  @cvol    = $inspect->[0]{'Volumes'};

  @keys = keys(%{$cvol[0]});
  for($i = 0; $i <= $#keys; $i++) {
    logger::log($me, "found volume $keys[$i]");
    print CYAN, "identified volume $keys[$i] ($cvol[0]{$keys[$i]})...\n", RESET;
    $volumes{$keys[$i]} = $cvol[0]{$keys[$i]};
  }

  return(\%volumes);

}

1;
