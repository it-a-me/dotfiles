#!/usr/bin/perl -ng
use v5.14;
use autodie;
`wl-copy "$_"`;
`notify-send "$_"`;
