#!/usr/bin/env perl
use v5.38;
use autodie;
use File::Basename;
use File::Path qw(make_path);
use Cwd;

my $log = 1;


my $script = $ARGV[0];

unless ( defined $script ) {
    die "please supply a script name";
}

unless ( -x $script ) {
    die "script is not executable";
}
my $name = basename $script;
say "found name: $name" if $log;
my $realpath = Cwd::realpath $script;
say "found realpath: $realpath" if $log;

my $desktop_path = "$ENV{'HOME'}/.local/share/applications/$name.desktop";
say "found desktop: $realpath" if $log;

my $desktop_file = 
qq{[Desktop Entry]
Type=Application
Name=$name
Exec=$realpath
Icon=$name
Terminal=false
};

unless (-d "$ENV{'HOME'}/.local/share/applications"){
    say "creating ~/.local/share/applications" if $log;
    make_path "~/.local/share/applications";
}

say "writing to $desktop_path";
open my $fh, ">", $desktop_path;
print $fh $desktop_file;
close $fh;
