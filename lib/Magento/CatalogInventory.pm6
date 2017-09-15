use v6;

use Magento::HTTP;
use Magento::Utils;
use JSON::Fast;

unit module Magento::CatalogInventory;

# GET    /V1/stockItems/:productSku
our sub stockItems(
    Hash $config,
    Str  :$product_sku!
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/stockItems/$product_sku";
}

# PUT    /V1/products/:productSku/stockItems/:itemId
our sub products-stockItems(
    Hash $config,
    Str  :$product_sku!,
    Int  :$item_id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/products/$product_sku/stockItems/$item_id",
        content => to-json $data;
}

# GET    /V1/stockItems/lowStock/
our sub stockItems-lowStock(
    Hash $config
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/stockItems/lowStock/";
}

# GET    /V1/stockStatuses/:productSku
our sub stockStatuses(
    Hash $config,
    Str  :$product_sku!
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/stockStatuses/$product_sku";
}

