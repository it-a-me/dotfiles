#!/usr/bin/perl
use v5.36;
use autodie;
use File::Path;

sub is_comment {
  return 1 if $_[0] =~ /^\s*#|^\s*$/;
  return 0;
}

#returns the shell config_dir
sub config_dir {

  #ensure $HOME has a final '/' and append .config
  my $xdg_config_dir = $ENV{HOME} =~ s%/?$%/%r;
  $xdg_config_dir .= ".config";

  #overwrite ~/.config if $XDG_CONFIG_HOME is defined
  $xdg_config_dir = $ENV{XDG_CONFIG_HOME} if defined $ENV{XDG_CONFIG_HOME};
  return "$xdg_config_dir/shellsv2";
}

#ask the user a yes or no question and return -- yes->1; no->0; error->-1;
sub prompt {
  my ($prompt) = @_;
  my $input;

  #try 3 times
  for ( 1 .. 3 ) {
    say STDERR "invalid input '$input'" unless !defined $input;
    say "$prompt (y/n)";
    $input = <STDIN>;
    chomp $input;
    return 1 if lc($input) =~ /^(y|yes)$/;
    return 0 if lc($input) =~ /^(n|no)$/;
  }
  return -1;
}

#return 1 if any of the @outputs is older than any of @sources
sub outdated {
  my ( $outputs, $sources ) = @_;

  #default to infinity so any mod time will be lower
  my $output_time = "inf";

  #set output_time to the lowest time
  for (@$outputs) {

    #if the file doesn't exist, return true
    my $last_modified = ( stat $_ )[9] or return 1;
    $output_time = $last_modified if $last_modified < $output_time;
  }

  #if any of the @sources is lower than $output_time, return true
  for (@$sources) {
    my $source_time = ( stat $_ )[9] or die "'$_' does not exist";
    if ( $source_time > $output_time ) {
      say "syncing with '$_'";
      return 1;
    }
  }

  #default to returning false
  return 0;
}

#create a file at $path if with $contents if $path is empty
sub opt_create {
  my ( $path, $contents ) = @_;
  if ( !-f $path ) {
    open my $handle, ">", $path;
    say STDERR "creating '$path'";
    say $handle $contents;
    close $handle;
  }
}

#add to %hash a pair for each line in the file stored at $path
#the key is the first word and the value is the rest of the line
sub space_hash {
  my ($path) = shift;
  my ($hash) = shift;

  #open path in readonly mode
  open my $handle, "<", $path;
  while ( my $line = <$handle> ) {
    chomp $line;
    unless ( is_comment $line) {
      my ( $key, $val ) = $line =~ /^(\S+)\s+(.*)/;
      if ( !defined $key or !defined $val ) {
        say STDERR "invalid line $. in '$path'. Skipping";
      }
      else {
        $hash->{$key} = $val;
      }
    }
  }
  close $handle;
}

sub append_path {
  my ( $list, $path ) = @_;
  open my $handle, "<", $path;
  for (<$handle>) {
    my $line = $_;
    chomp $line;
    $line =~ s/~|\$HOME/$ENV{HOME}/g;
    unless ( is_comment $line ) {
      if ( !-d $line ) {
        say STDERR
          "invalid line $. in '$path'. '$line' is not a directory.  Skipping";
      }
      else {
        push @{$list}, $line;
      }
    }
  }
  close $handle;
}

#locate the config_dir
my $config_dir = config_dir;

#prompt the user to create it if it doesn't exist.  Otherwise exit
if ( !-d $config_dir ) {
  if ( prompt "$config_dir does not exist. Create it?" ) {
    use File::Copy;
    my $update_path = "$config_dir/update.pl";
    use File::Path "make_path";
    make_path $config_dir;
    copy $0, $update_path;
    chmod 0777, $update_path;
    exec $update_path;
  }
  exit 0;
}

#ensure that the local and export dir exist
mkdir "$config_dir/local"  unless -d "$config_dir/local";
mkdir "$config_dir/export" unless -d "$config_dir/export";

#create any files that don't exist
opt_create "$config_dir/aliases",
  '#this is the git synced aliases file.  Example: "hx helix"';
opt_create "$config_dir/local/aliases",
  '#this is the local aliases file.  Example: "hx helix"';
opt_create "$config_dir/env",
  '#this is the git synced env file.  Example: "BROWSER librewolf"';
opt_create "$config_dir/local/env",
  '#this is the local env file.  Example: "BROWSER librewolf"';
opt_create "$config_dir/path",
  '#this is the git synced paths file.  Example: "~/.local/bin"';
opt_create "$config_dir/local/path",
  '#this is the local paths file.  Example: "~/.local/bin"';

opt_create "$config_dir/.gitignore", "/local\n/export\n/startwm";

opt_create "$config_dir/startwm.pl", q^#!/usr/bin/perl
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
}'^;
chmod 0777, "$config_dir/startwm.pl";

{
  my $sources = [ "$config_dir/aliases", "$config_dir/local/aliases" ];
  my $outputs = ["$config_dir/export/alias.sh"];

  #if $output is outdated, update it
  if ( outdated $outputs, $sources ) {

    #create an alias hash from both global and local aliases files
    my %aliases;
    space_hash $_, \%aliases for @$sources;

    #delete each $output if it exists
    for (@$outputs) {
      unlink $_ if -f $_;
    }

    #for alias in %aliases, write it to $output;
    open my $posix_h, ">>", "@$outputs[0]";
    while ( my ( $key, $val ) = each %aliases ) {
      say $posix_h qq{alias $key="$val"};
    }
    close $posix_h;
  }
}
{
  my $sources = [ "$config_dir/env", "$config_dir/local/env" ];
  my $outputs = ["$config_dir/export/env.sh"];

  #if $output is outdated, update it
  if ( outdated $outputs, $sources ) {

    #create an env hash from both global and local aliases files
    my %env_vars;

    space_hash $_, \%env_vars for @$sources;

    #delete each $output if it exists
    for (@$outputs) {
      unlink $_ if -f $_;
    }

    #for env in %env_vars, write it to $output;
    open my $posix_h, ">>", "@$outputs[0]";
    while ( my ( $key, $val ) = each %env_vars ) {
      say $posix_h qq{export $key="$val"};
    }
    close $posix_h;
  }
}

{
  my $sources = [ "$config_dir/path", "$config_dir/local/path" ];
  my $outputs =
    [ "$config_dir/export/path.sh", "$config_dir/export/path.fish" ];

  #if any $output is outdated, update it
  if ( outdated $outputs, $sources ) {

    #create an path array from all source files
    my $paths = [];
    append_path $paths, $_ for @$sources;

    #delete each $output if it exists
    for (@$outputs) {
      unlink $_ if -f $_;
    }

    open my $posix_h, ">>", "@$outputs[0]";
    open my $fish_h,  ">>", "@$outputs[1]";

    #ifndef statement for posix
    say $posix_h 'if test -z "$SHELLSV2"; then';
    for (@$paths) {
      my $path = $_;
      chomp $path;

      #write to path.fish and path.sh comamnds to edit the path's shells
      say $posix_h "   export PATH=\"\$PATH:$path\"";
      say $fish_h "fish_add_path $path";
    }
    say $posix_h 'fi; export SHELLSV2=1';
    close $posix_h;
    close $fish_h;
  }
}
