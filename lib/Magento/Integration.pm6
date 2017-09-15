use v6;

use Magento::HTTP;
use Magento::Utils;
use JSON::Fast;

unit module Magento::Integration;

# POST   /V1/integration/admin/token
our sub integration-admin-token(
    Hash $config,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/integration/admin/token",
        content => to-json $data;
}

# POST   /V1/integration/customer/token
our sub integration-customer-token(
    Hash $config,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/integration/customer/token",
        content => to-json $data;
}

