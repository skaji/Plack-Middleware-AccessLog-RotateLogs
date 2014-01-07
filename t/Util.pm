package t::Util;
use strict;
use warnings;
use Exporter 'import';
our @EXPORT = qw(slurp);

sub slurp {
    my $file = shift;
    open my $fh, "<", $file or die "$file: $!";
    local $/; scalar(<$fh>);
}




1;

