requires 'perl', '5.008001';

requires 'Plack::Middleware::AccessLog';
requires 'File::RotateLogs';

on 'test' => sub {
    requires 'Plack::Test';
    requires 'Plack::Builder';
    requires 'HTTP::Request::Common';
    requires 'Test::More', '0.98';
};

