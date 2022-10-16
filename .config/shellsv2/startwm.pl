#!/usr/bin/perl
use File::Basename;

#early exit on error
use autodie;

#exec only on /dev/tty1
if ( `/bin/tty` =~ m"/dev/tty1" ) {
  print "starting wm\n";

  #get exec path
  my $exec = dirname $0;
  $exec .= "/startwm";

  #exec path if it exists
  exec $exec if -f $exec;
  print "'$exec' does not exist";
}
