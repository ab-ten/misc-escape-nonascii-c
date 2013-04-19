#!/usr/bin/perl -W

use strict;

while (my $f = shift) {
    my $bak = $f.".escbak";
    my $work = $f.".escwrk";
    my $infile = (-f $bak) ? $bak : $f;
    open my $in, "<", $infile	or die;
    open my $out, ">", $work	or die;
    my $changed = 0;
    while (<$in>) {
	if (s/[\x80-\xff]/sprintf('\x%02x',ord($&))/eg) {
	    $changed = 1;
	}
	print $out $_;
    }
    close $out;
    close $in;

    if (! $changed) {
	unlink($work);
	local $| = 1;
	print STDERR "-";
	next;
    }else {
	local $| = 1;
	print STDERR ".";
    }

    if (! -f $bak) {
	rename($f, $bak);
    }
    rename($work, $f);
}
