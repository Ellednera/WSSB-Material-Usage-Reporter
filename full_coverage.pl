#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

open STDOUT, ">", "full_coverage_report";

my $line = "-" x 75;

say $line;

say "COVERAGE FOR CLINIC CLAY BRICK AND VARIOUS TILES (m^2)";

say $line;
say "CLAY BRICK";
print `perl coverage.pl "Clinic" "ft" clinic_clay-brick/*.csv`;

say $line;
say "TILE 600x600 POLISHED FLOOR";
print `perl coverage.pl "Clinic" "ft" clinic_tiles/600x600_floor-only/*.csv`;

say $line;
say "TILE 600x300 STAIRCASE FLOOR ONLY";
print `perl coverage.pl "Clinic" "ft" clinic_tiles/600x300_staircase/floor-only/*.csv`;

say $line;
say "TILE 300x300 FLOOR";
print `perl coverage.pl "Clinic" "ft" clinic_tiles/300x300_black-and-white/internal_clinic/floor/*.csv`;

say $line;
say "TILE 300x300 WALL";
print `perl coverage.pl "Clinic" "ft" clinic_tiles/300x300_black-and-white/internal_clinic/wall/*.csv`;

say $line;
say "TILE 300x300 FLOOR";
print `perl coverage.pl "External" "ft" clinic_tiles/300x300_black-and-white/external_block/floor/*.csv`;

say $line;
say "TILE 300x300 WALL";
print `perl coverage.pl "External" "ft" clinic_tiles/300x300_black-and-white/external_block/wall/*.csv`;

say $line;

close STDOUT;

# besiyata d'shmaya


