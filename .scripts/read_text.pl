#!/usr/bin/perl
use v5.34;
use autodie;
use File::Temp;

# check if grim and slurp are installed
`grim -h`;
`slurp -h`;

my $fh         = File::Temp->newdir();
my $temp_path  = $fh->dirname;
my $image_path = "$temp_path/image.png";
my $text_path  = "$temp_path/text.txt";

system(qq!grim -g "\$(slurp)" $image_path!);
`tesseract $image_path $temp_path/text 2>/dev/null`;

open( my $text_handle, "<", $text_path );
read $text_handle, my $text, -s $text_handle;
print( $text =~ s/\s*$//r =~ s/\n+/\n/gr );

