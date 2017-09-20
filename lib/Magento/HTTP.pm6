use v6;

use HTTP::Tinyish;
use JSON::Fast;

unit module Magento::HTTP;

our sub request(
    Hash :$config,
    Str  :$method = 'GET',
    Str  :$uri,
    Str  :$content = '',
    Hash :$headers
    --> Any
) {
    # Config variables
    my $host         = $config<host>;
    my $format       = $config<format>||'default';
    my $access_token = $config<access_token>;

    # Header
    my $content_type = 'application/' ~ ($format ~~ 'default' ?? 'json' !! $format);
    my %request_headers = %{
        Content-Type => $content_type,
        Accept       => $content_type,
        $access_token ?? (Authorization => "Bearer $access_token") !! %(),
        $headers ?? |$headers !! %()
    }

    my $url = "{$host}/{$uri.trans: /'['/ => '\\[', /']'/ => '\\]'}";

    my %res = do given $method {
        when 'DELETE' {
            HTTP::Tinyish.new.delete:
                $url, headers => %request_headers;
        }
        when 'GET' {
            HTTP::Tinyish.new.get:
                $url, headers => %request_headers, :$content;
        }
        when 'POST' {
            HTTP::Tinyish.new.post:
                $url, headers => %request_headers, :$content;
        }
        when 'PUT' {
            HTTP::Tinyish.new.put:
                $url, headers => %request_headers, :$content;
        }
    }

    return do given $format {
        when 'json'|'xml' {
            %res<content>;
        }
        default {
            %res<content>.defined ?? from-json(%res<content>) !! False;
        }
    }
}
