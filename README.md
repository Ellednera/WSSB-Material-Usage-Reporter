# WSSB-Material-Usage-Reporter
Generates material usage / coverage report for clay bricks, tiles ect.

## Usage
```perl
perl full_coverage.pl
```

- *full_coverage.pl* will invoke *coverage.pl* with different parameters and the resulting report will be written into a file called "full_coverage_report" which contains ANSI color codes for Linux. This file is meant to be printed inside a console. An HTML version of the report might be supported in the future :)
- The subroutines in *coverage_functions.pl* will be packed into an actual CPAN module in the future
- 
