#!/usr/bin/env perl
use v5.36;
use autodie;

sub get_current_brightness {
	my ($backlight_dir) = @_;
	open my $fd, "<", "$backlight_dir/brightness";
	my $brightness = <$fd>;
	chomp $brightness;
	close $fd;
	return $brightness;
}
sub get_max_brightness {
	my ($backlight_dir) = @_;
	open my $fd, "<", "$backlight_dir/max_brightness";
	my $max_brightness = <$fd>;
	chomp $max_brightness;
	close $fd;
	return $max_brightness;
}

my $backlight_id = $ARGV[0];
unless (defined $backlight_id) {
	die "please supply a backlight argument";
}

my $backlight_dir = "/sys/class/backlight/$backlight_id";
if (! -d $backlight_dir) {
	die "$backlight_dir does not exist"
}

my $brightness = get_current_brightness($backlight_dir);
my $max_brightness = get_max_brightness($backlight_dir);

if (defined $ARGV[1] and length $ARGV[1] > 0) {
	my $comm = $ARGV[1];
	chomp $comm;

	if ($comm =~ m/^\+/){
		$brightness = $brightness + substr $comm, 1;
	}
	elsif ($comm =~ m/^-/){
		$brightness = $brightness - substr $comm, 1;
	} else {
		$brightness = $comm;
	}

	$brightness = $brightness > $max_brightness ? $max_brightness : $brightness;
	$brightness = $brightness < 0 ? 0 : $brightness;

	open my $fd, ">", "$backlight_dir/brightness";
	print $fd $brightness;
	close $fd;
} 

say $brightness;

