#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

# Version 1.0

require "./coverage_functions.pl";

if ( @ARGV < 3 ) {
    die "Usage: coverage.pl <quarters_name> <unit> <data_files>\n", 
        "    quarters_name: quarters' / building block name\n",
        "    unit: unit measurement of your original data. 'ft' & 'm' are the only supported conversion \n",
        "    data_files: list of data files (CSV), good luck on Windows\n";
}

my $section = shift @ARGV;
my $unit = shift @ARGV;
my @data_files = @ARGV;

# customizable hard-coded data
my $verbose = 0;
my $conversion = "ft_to_m"; # "ft_to_m" and "none" only
my $show_filename_only = 1; # true of false values

my $total_area = 0;
# filename not exist: user's problem, won't cater for that

if ( ($conversion eq "ft_to_m") and ($unit eq "ft") ) {

    $unit = "m";
    
} elsif ( ($conversion eq "ft_to_m") and ($unit eq "m") ) {
    # this is only for supported conversion
    die ("Oi!! Conversion ft->m required, but file data is already in m.\n", 
            "What are you trying to do?\n");
    
} else {
    $conversion = "none";
}

for ( @data_files ) {
    print_report_info( $section, $unit, $_, $show_filename_only );
    
    $total_area += generate_coverage_report ($_, $verbose, $unit, $conversion);
    
    say "";
}

say colored(["bold bright_yellow"], "Total Area = $total_area $unit\^2");
say "";


# besiyata d'shmaya


