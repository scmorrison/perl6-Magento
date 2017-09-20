use v6;

use Magento::HTTP;
use Magento::Utils;
use JSON::Fast;

unit module Magento::Downloadable;

proto sub products-downloadable-links(|) is export {*}
# GET    /V1/products/:sku/downloadable-links
our multi products-downloadable-links(
    Hash $config,
    Str  :$sku!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/$sku/downloadable-links";
}

proto sub products-downloadable-links-samples(|) is export {*}
# GET    /V1/products/:sku/downloadable-links/samples
our multi products-downloadable-links-samples(
    Hash $config,
    Str  :$sku!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/$sku/downloadable-links/samples";
}

# POST   /V1/products/:sku/downloadable-links
our multi products-downloadable-links(
    Hash $config,
    Str  :$sku!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/products/$sku/downloadable-links",
        content => to-json $data;
}

# PUT    /V1/products/:sku/downloadable-links/:id
our multi products-downloadable-links(
    Hash $config,
    Str  :$sku!,
    Str  :$id!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/products/$sku/downloadable-links/$id",
        content => to-json $data;
}

# DELETE /V1/products/downloadable-links/:id
our sub products-downloadable-links-delete(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/products/downloadable-links/$id";
}

# POST   /V1/products/:sku/downloadable-links/samples
our multi products-downloadable-links-samples(
    Hash $config,
    Str  :$sku!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/products/$sku/downloadable-links/samples",
        content => to-json $data;
}

# PUT    /V1/products/:sku/downloadable-links/samples/:id
our multi products-downloadable-links-samples(
    Hash $config,
    Str  :$sku!,
    Str  :$id!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/products/$sku/downloadable-links/samples/$id",
        content => to-json $data;
}

# DELETE /V1/products/downloadable-links/samples/:id
our sub products-downloadable-links-samples-delete(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/products/downloadable-links/samples/$id";
}
