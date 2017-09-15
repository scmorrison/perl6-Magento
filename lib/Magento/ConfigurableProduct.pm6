use v6;

use Magento::HTTP;
use Magento::Utils;
use JSON::Fast;

unit module Magento::ConfigurableProduct;

proto sub configurable-products-children(|) is export {*}
# GET    /V1/configurable-products/:sku/children
our multi configurable-products-children(
    Hash $config,
    Str  :$sku!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/configurable-products/$sku/children";
}

# DELETE /V1/configurable-products/:sku/children/:childSku
our sub configurable-products-children-delete(
    Hash $config,
    Str  :$sku!,
    Str  :$child_sku!
) {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/configurable-products/$sku/children/$child_sku";
}

# PUT    /V1/configurable-products/variation
our sub configurable-products-variation(
    Hash $config,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/configurable-products/variation",
        content => to-json $data;
}

# POST   /V1/configurable-products/:sku/child
our sub configurable-products-child(
    Hash $config,
    Str  :$sku!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/configurable-products/$sku/child",
        content => to-json $data;
}

proto sub configurable-products-options(|) is export {*}
# GET    /V1/configurable-products/:sku/options/:id
our multi configurable-products-options(
    Hash $config,
    Str  :$sku!,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/configurable-products/$sku/options/$id";
}

# GET    /V1/configurable-products/:sku/options/all
our sub configurable-products-options-all(
    Hash $config,
    Str  :$sku!
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/configurable-products/$sku/options/all";
}

# POST   /V1/configurable-products/:sku/options
our multi configurable-products-options(
    Hash $config,
    Str  :$sku!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/configurable-products/$sku/options",
        content => to-json $data;
}

# PUT    /V1/configurable-products/:sku/options/:id
our multi configurable-products-options(
    Hash $config,
    Str  :$sku!,
    Str  :$id!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/configurable-products/$sku/options/$id",
        content => to-json $data;
}

# DELETE /V1/configurable-products/:sku/options/:id
our sub configurable-products-options-delete(
    Hash $config,
    Str  :$sku!,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/configurable-products/$sku/options/$id";
}

