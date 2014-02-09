package Plack::Middleware::AccessLog::RotateLogs;
use 5.008005;
use strict;
use warnings;
use File::RotateLogs;
use Time::Local ();

use parent 'Plack::Middleware::AccessLog';

our $VERSION = "0.001";

sub prepare_app {
    my ($self, @arg) = @_;

    my $offset = $self->{offset} || do {
        my @t = localtime;
        Time::Local::timegm(@t) - Time::Local::timelocal(@t);
    };
    my $maxage = $self->{maxage} || 60 * 60 * 24 * 30;

    my %other = map { defined $self->{$_} ? ($_ => $self->{$_}) : () }
                qw(logfile linkname rotationtime sleep_before_remove);

    my $logs = File::RotateLogs->new(
        offset => $offset, maxage => $maxage, %other
    );
    $self->logger(sub { $logs->print(@_) });
    $self->SUPER::prepare_app(@arg);
}


1;
__END__

=encoding utf-8

=head1 NAME

Plack::Middleware::AccessLog::RotateLogs - AccessLog with File::RotateLogs

=head1 SYNOPSIS

    use Plack::Builder;

    builder {
        enable 'AccessLog::RotateLogs',
            format  => 'combined',
            logfile => '/path/to/access_log.%Y%m%d',
            maxage  => 86400;
        $app;
    ;}

=head1 DESCRIPTION

Plack::Middleware::AccessLog::RotateLogs is a subclass of
Plack::Middleware::AccessLog with File::RotateLogs.

=head1 CONFIGURATION

For Plack::Middleware::AccessLog:

    format

For File::RotateLogs:

    logfile, linkname, rotationtime, maxage, sleep_before_remove, offset

Note that if the offset is omitted,
it is set to appropriate value for current timezone.
In addtion, the maxage defaults to 60 * 60 * 24 * 30.

=head1 SEE ALSO

L<Plack::Middleware::AccessLog>

L<File::RotateLogs>

=head1 LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Shoichi Kaji E<lt>skaji@outlook.comE<gt>

=cut

