use strict;
use warnings;
use utf8;
use Test::More;
use Plack::Test;
use File::Temp 'tempdir';
use Plack::Builder;
use HTTP::Request::Common qw(GET POST);
use POSIX qw(strftime);
use t::Util;

my $tempdir = tempdir CLEANUP => 1;

my $app = builder {
    enable 'AccessLog::RotateLogs',
        logfile => "$tempdir/%Y%m%d.log", maxage => 10000;
    sub { [200, [], ['hello']] };
};

test_psgi $app, sub {
    my $cb = shift;
    my $res = $cb->(GET "/");
    my $expect_file = "$tempdir/" . strftime("%Y%m%d.log", localtime);
    ok -f $expect_file;
    my $content = slurp($expect_file);
    diag $content;
    like $content, qr/200/;
};


done_testing;

