use v6;

use Magento::HTTP;

unit module Magento::Store;

#GET    /V1/store/storeConfigs
our sub store-configs(
    Hash $config
) is export {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/store/storeConfigs",
        access_token => $config<access_token>;
}
