#!/usr/bin/perl -W

use strict;

while (my $f = shift) {
    my $bak = $f.".escbak";
    my $work = $f.".escwrk";
    my $infile = (-f $bak) ? $bak : $f;
    open my $in, "<", $infileor die;
    open my $out, ">", $workor die;
    my $changed = 0;
    while (<$in>) {
	if (s/[\x80-\xff]/sprintf('\x%02x',ord($&))/eg) {
	    $changed = 1;
	}
	print $out $_;
    }
    close $out;
    close $in;

    {
	local $| = 1;
	if (! $changed) {
	    unlink($work);
	    print STDERR "-";
	    next;
	}
	print STDERR ".";
    }

    if (! -f $bak) {
	rename($f, $bak);
    }
    rename($work, $f);
}
