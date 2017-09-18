use v6;

use Magento::HTTP;
use Magento::Utils;
use JSON::Fast;

unit module Magento::CatalogInventory;

# PUT    /V1/products/:productSku/stockItems/:itemId
our sub products-stock-items(
    Hash $config,
    Str  :$sku!,
    Int  :$item_id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/products/$sku/stockItems/$item_id",
        content => to-json $data;
}

# GET    /V1/stockItems/:productSku
our sub stock-items(
    Hash $config,
    Str  :$sku!
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/stockItems/$sku";
}

# GET    /V1/stockItems/lowStock/
our sub stock-items-low-stock(
    Hash $config
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/stockItems/lowStock/";
}

# GET    /V1/stockStatuses/:productSku
our sub stock-statuses(
    Hash $config,
    Str  :$sku!
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/stockStatuses/$sku";
}

