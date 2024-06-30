#!/usr/bin/env perl
use v5.38;
use autodie;
use JSON::PP;

die "please supply a .env path" if scalar @ARGV < 1;

open(my $fh, "<", $ARGV[0]);
my %env;
while(<$fh>) {
	next if m/^\s*(#|$)/;
	s/^\s*(.*)\s*/$1/;
	my ($key, $val) = split /=/;
	$env{$key} = $val;
}
print encode_json(\%env);
