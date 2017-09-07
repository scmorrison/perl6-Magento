use v6;

use Magento::HTTP;

unit module Magento::Auth;

subset UserType of Str where 'admin'|'customer';
our sub request-access-token(
    Str      :$username,
    Str      :$password,
    UserType :$user_type = 'admin',
    Str      :$host
    --> Str
) is export {
    my $uri     = "/rest/V1/integration/$user_type/token";
    my $content = qq:to/EOF/;
    \{
        "username":"{$username}",
        "password":"{$password}"
    \}
    EOF
    my $access_token = Magento::HTTP::request method => 'POST', :$host, :$uri, :$content;
    return S:g/<["]>// given $access_token;
}
