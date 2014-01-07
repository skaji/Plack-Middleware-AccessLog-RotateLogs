# NAME

Plack::Middleware::AccessLog::RotateLogs - AccessLog with File::RotateLogs

# SYNOPSIS

    use Plack::Builder;

    builder {
        enable 'AccessLog::RotateLogs',
            format  => 'combined',
            logfile => '/path/to/access_log.%Y%m%d',
            maxage  => 86400;
        $app;
    ;}

# DESCRIPTION

Plack::Middleware::AccessLog::RotateLogs is a subclass of
Plack::Middleware::AccessLog with File::RotateLogs.

# CONFIGURATION

For Plack::Middleware::AccessLog:

    format

For File::RotateLogs:

    logfile, linkname, rotationtime, maxage, sleep_before_remove, offset

Note that if the offset is omitted,
it is set to appropriate value for current timezone.

# SEE ALSO

[Plack::Middleware::AccessLog](https://metacpan.org/pod/Plack::Middleware::AccessLog)

[File::RotateLogs](https://metacpan.org/pod/File::RotateLogs)

# LICENSE

Copyright (C) Shoichi Kaji.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

Shoichi Kaji <skaji@outlook.com>
