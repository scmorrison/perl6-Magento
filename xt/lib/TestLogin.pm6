use v6.c;

use Magento::Auth;

unit module TestLogin;

our sub admin_config {

    my $host       = %*ENV<P6MAGHOST>||'http://127.0.0.1';
    my $admin      = %*ENV<P6MAGADMIN>||'admin';
    my $admin_pass = %*ENV<P6MAGADMINPASS>||'fakeMagent0P6';

    %{
        host         => $host,
        access_token => request-access-token(
            username => $admin,
            password => $admin_pass,
            :$host),
        store        => 'default'
    }

}
