use strict;
use warnings;
use 5.010;

use Text::CSV_XS;
use File::Basename;
use Term::ANSIColor;

# column index in CSV
use constant {
    LENGTH => 0,
    WIDTH => 1,
    MULTIPLIER => 2
};

sub print_report_info {
    my ( $section, $unit, $data_file, $show_filename_only ) = @_;
    
    say colored(["bright_cyan"], "Section: $section");
    say colored(["bright_cyan"], "Unit: $unit");
    
    if ( $show_filename_only ) {
        $data_file = basename( $data_file );
    }
    
    say colored(["bright_cyan"], "Source: $data_file");
}


sub calculate_coverage {
    my ($csv, $fh, $verbose, $conversion) = @_;
    
    my $partial_area = 0;
    my $total_area = 0;

    $csv->getline ($fh); # throw away headers
    while ( my $row = $csv->getline ($fh) ) {

        # just overwrite,if not the nested statement will be very complicated
        if ( $conversion eq "ft_to_m" ) {
            # divide by 3.281 (Google) -not so accurate
            # divide by 3.28084 (https://www.magicbricks.com/meter-to-feet-pppfa)
            $row->[ LENGTH ] = sprintf("%.5f", ($row->[LENGTH] / 3.28084) );
            $row->[ WIDTH ] = sprintf("%.5f", ($row->[WIDTH] / 3.28084) );
        }

        $partial_area = sprintf("%.4f", 
                                ($row->[LENGTH] * $row->[WIDTH] * $row->[MULTIPLIER]) );
        $total_area += $partial_area;
        
        if ( $verbose ) {
            if ( $row->[ MULTIPLIER ] < 0 ) {
            
                print colored( ["bright_red"], 
                    "L=$row->[LENGTH] W=$row->[WIDTH] M=$row->[MULTIPLIER], " );
                
                say colored( ["bright_red"], "P(A)=$partial_area, C(A)=$total_area" );
                
            } else {
            
                print "L=$row->[LENGTH] W=$row->[WIDTH] M=$row->[MULTIPLIER], ";
                say "P(A)=$partial_area, C(A)=$total_area";
                
            }
            
        }
    }

    return $total_area;
}

sub generate_coverage_report {
    my ( $data_file, $verbose, $unit, $conversion ) = @_;
    
    my $csv = Text::CSV_XS->new ({ binary => 1, auto_diag => 1 });

    open my $fh, "<:encoding(utf8)", $data_file or 
        die "$!";

    my $coverage = calculate_coverage( $csv, $fh, $verbose, $conversion );
    
    if ( $conversion eq "ft_to_m" ) {
        $unit = "m";
    }
    
    say colored(["bright_cyan"], "Area = $coverage $unit\^2");    

    close $fh;
    
    return $coverage;
}

1; # besiyata d'shmaya
