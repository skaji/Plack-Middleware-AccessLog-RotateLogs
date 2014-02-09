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
        logfile => "$tempdir/%Y%m%d_%H%M%S.log",
        rotationtime => 1;
    sub { [200, [], ['hello']] };
};

my $test = Plack::Test->create($app);
for (0..1) {
    $test->request(POST "/request$_");
    last if $_ == 1;
    sleep 2;
}
my @log = glob "$tempdir/*.log";
is @log, 2;
like slurp($log[0]), qr/request0/;
like slurp($log[1]), qr/request1/;

done_testing;

