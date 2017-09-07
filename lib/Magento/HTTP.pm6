use v6;

use HTTP::Tinyish;
use JSON::Fast;

unit module Magento::HTTP;

subset Response of Any where Hash|Str|Bool;

our sub request(
    Str  :$method = 'GET',
    Str  :$host,
    Str  :$uri,
    Str  :$access_token,
    Str  :$content,
    Hash :$headers
    --> Response
) {
    my %request_headers = %(
        'Content-Type'  => 'application/json',
        $access_token ?? ('Authorization' => "Bearer $access_token") !! %(),
        $headers ?? |$headers !! %()
    );

    my $url = "{$host}/$uri";

    my %res = do given $method {
        when 'POST' {
            HTTP::Tinyish.new.post:
                $url, headers => %request_headers, :$content;
        }
        when 'GET' {
            HTTP::Tinyish.new.get:
                $url, headers => %request_headers;
        }
    }
    return (%res<content> ?? from-json %res<content> !! False);
}
