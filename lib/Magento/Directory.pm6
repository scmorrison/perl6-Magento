use v6;

use Magento::HTTP;
use Magento::Utils;
use JSON::Fast;

unit module Magento::Directory;

# GET    /V1/directory/currency
our sub directory-currency(
    Hash $config
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/directory/currency";
}

proto sub directory-countries(|) is export {*}
# GET    /V1/directory/countries
our multi directory-countries(
    Hash $config
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/directory/countries";
}

# GET    /V1/directory/countries/:countryId
our multi directory-countries(
    Hash $config,
    Int  :$country_id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/directory/countries/$country_id";
}

