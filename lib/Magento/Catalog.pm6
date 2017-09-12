use v6;

use Magento::HTTP;
use Magento::Utils;
use JSON::Fast;

unit module Magento::Catalog;

proto sub products(|) is export {*}
#GET    /V1/products
our multi products(
    Hash $config,
    Hash :$search_criteria = %()
) {
    my $query_string = search-criteria-to-query-string $search_criteria;
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products?$query_string"
}
#POST   /V1/products
our multi products(
    Hash $config,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/products",
        content => to-json $data;
}
#PUT    /V1/products/:sku
our multi products(
    Hash $config,
    Str  :$sku!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/products/$sku",
        content => to-json $data;
}
#GET    /V1/products/:sku
our multi products(
    Hash $config,
    Str  :$sku!
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/$sku"
}

#DELETE /V1/products/:sku
our sub products-delete(
    Hash $config,
    Str  :$sku!
) is export {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/products/$sku";
}

#GET    /V1/products/attributes/types
our sub products-attributes-types(
    Hash $config
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/attributes/types";
}

proto sub products-attributes(|) is export {*}
#GET    /V1/products/attributes/:attributeCode
our multi products-attributes(
    Hash $config,
    Int  :$attributeCode
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/attributes/$attributeCode";
}
#GET    /V1/products/attributes
our multi products-attributes(
    Hash $config
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/attributes";
}
#POST   /V1/products/attributes
our multi products-attributes(
    Hash $config,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/products/attributes",
        content => to-json $data;
}
#PUT    /V1/products/attributes/:attributeCode
our multi products-attributes(
    Hash $config,
    Int  :$attributeCode,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/products/attributes/$attributeCode",
        content => to-json $data;
}

#DELETE /V1/products/attributes/:attributeCode
our sub products-attributes-delete(
    Hash $config,
    Int  :$attributeCode
) is export {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/products/attributes/$attributeCode";
}

proto sub categories-attributes(|) is export {*}
#GET    /V1/categories/attributes/:attributeCode
our multi categories-attributes(
    Hash $config,
    Int  :$attributeCode
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/categories/attributes/$attributeCode";
}
#GET    /V1/categories/attributes
our multi categories-attributes(
    Hash $config
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/categories/attributes";
}

#GET    /V1/categories/attributes/:attributeCode/options
our sub categories-attributes-options(
    Hash $config,
    Int  :$attributeCode
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/categories/attributes/$attributeCode/options";
}

#GET    /V1/products/types
our sub products-types(
    Hash $config
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/types";
}

proto sub products-attribute-sets(|) is export {*}
#GET    /V1/products/attribute-sets/sets/list
our multi products-attribute-sets(
    Hash $config
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/attribute-sets/sets/list";
}
#GET    /V1/products/attribute-sets/:attributeSetId
our multi products-attribute-sets(
    Hash $config,
    Int  :$attributeSetId
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/attribute-sets/$attributeSetId";
}
#POST   /V1/products/attribute-sets
our multi products-attribute-sets(
    Hash $config,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/products/attribute-sets",
        content => to-json $data;
}
#PUT    /V1/products/attribute-sets/:attributeSetId
our multi products-attribute-sets(
    Hash $config,
    Int  :$attributeSetId,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/products/attribute-sets/$attributeSetId",
        content => to-json $data;
}

#DELETE /V1/products/attribute-sets/:attributeSetId
our sub products-attribute-sets-delete(
    Hash $config,
    Int  :$attributeSetId
) is export {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/products/attribute-sets/$attributeSetId";
}

proto sub products-attribute-sets-attributes(|) is export {*}
#GET    /V1/products/attribute-sets/:attributeSetId/attributes
our multi products-attribute-sets-attributes(
    Hash $config,
    Int  :$attributeSetId
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/attribute-sets/$attributeSetId/attributes";
}
#POST   /V1/products/attribute-sets/attributes
our multi products-attribute-sets-attributes(
    Hash $config,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/products/attribute-sets/attributes",
        content => to-json $data;
}

#DELETE /V1/products/attribute-sets/:attributeSetId/attributes/:attributeCode
our sub products-attribute-sets-attributes-delete(
    Hash $config,
    Int  :$attributeSetId,
    Int  :$attributeCode
) is export {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/products/attribute-sets/$attributeSetId/attributes/attributeCode";
}

#GET    /V1/products/attribute-sets/groups/list
proto sub products-attribute-groups(|) is export {*}
our multi products-attribute-groups(
    Hash $config
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/attribute-sets/groups/list";
}
#POST   /V1/products/attribute-sets/groups
our multi products-attribute-groups(
    Hash $config,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/products/attribute-sets/groups",
        content => to-json $data;
}
#PUT    /V1/products/attribute-sets/:attributeSetId/groups
our multi products-attribute-groups(
    Hash $config,
    Int  :$attributeSetId,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/products/attribute-sets/$attributeSetId/groups",
        content => to-json $data;
}

#DELETE /V1/products/attribute-sets/groups/:groupId
our sub products-attribute-sets-groups-delete(
    Hash $config,
    Int  :$groupId
) is export {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/products/attribute-sets/groups/$groupId";
}

#GET    /V1/products/attributes/:attributeCode/options
proto sub products-attributes-options(|) is export {*}
our multi products-attributes-options(
    Hash $config,
    Int  :$attributeCode
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/attributes/$attributeCode/options";
}
#POST   /V1/products/attributes/:attributeCode/options
our multi products-attributes-options(
    Hash $config,
    Int  :$attributeCode,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/products/attributes/$attributeCode/options",
        content => to-json $data;
}

#DELETE /V1/products/attributes/:attributeCode/options/:optionId
our sub products-attributes-options-delete(
    Hash $config,
    Int  :$attributeCode,
    Int  :$optionId
) is export {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/products/attributes/$attributeCode/options/$optionId";
}

#GET    /V1/products/media/types/:attributeSetName
our sub products-media-types(
    Hash $config,
    Str  :$attributeSetName
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/media/types/$attributeSetName";
}

proto sub products-media(|) is export {*}
#GET    /V1/products/:sku/media
our multi products-media(
    Hash $config,
    Str  :$sku,
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/$sku/media";
}
#GET    /V1/products/:sku/media/:entryId
our multi products-media(
    Hash $config,
    Str  :$sku,
    Int  :$entryId
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/$sku/media/$entryId";
}
#POST   /V1/products/:sku/media
our multi products-media(
    Hash $config,
    Str  :$sku,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/products/$sku/media";
        content => to-json $data;
}
#PUT    /V1/products/:sku/media/:entryId
our multi products-media(
    Hash $config,
    Str  :$sku,
    Int  :$entryId,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/products/$sku/media/$entryId",
        content => to-json $data;
}

#DELETE /V1/products/:sku/media/:entryId
our sub products-media-delete(
    Hash $config,
    Str  :$sku,
    Int  :$entryId
) is export {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/products/$sku/media/$entryId";
}

proto sub products-group-prices(|) is export {*}
#GET    /V1/products/:sku/group-prices/:customerGroupId/tiers
our multi products-group-prices(
    Hash $config,
    Str  :$sku,
    Int  :$customerGroupId
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/$sku/group-prices/$customerGroupId/tiers";
}
#POST   /V1/products/:sku/group-prices/:customerGroupId/tiers/:qty/price/:price
our multi products-group-prices(
    Hash $config,
    Str  :$sku,
    Int  :$customerGroupId,
    Int  :$qty,
    Real :$price,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/products/$sku/group-prices/$customerGroupId/tiers/$qty/price/$price",
        content => to-json $data;
}

#DELETE /V1/products/:sku/group-prices/:customerGroupId/tiers/:qty
our sub products-group-prices-delete(
    Hash $config,
    Str  :$sku,
    Int  :$customerGroupId,
    Int  :$qty
) is export {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/products/$sku/group-prices/$customerGroupId/tiers/$qty";
}

proto sub categories(|) is export {*}
#GET    /V1/categories
our multi categories(
    Hash $config
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/categories";
}
#GET    /V1/categories/:categoryId
our multi categories(
    Hash $config,
    Int  :$categoryId
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/categories/$categoryId";
}
#POST   /V1/categories
our multi categories(
    Hash $config,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/categories",
        content => to-json $data;
}
#PUT    /V1/categories/:id
our multi categories(
    Hash $config,
    Int  :$categoryId,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/categories/$categoryId",
        content => to-json $data;
}

#DELETE /V1/categories/:categoryId
our sub categories-delete(
    Hash $config,
    Int  :$categoryId
) is export {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/categories/$categoryId";
}

#PUT    /V1/categories/:categoryId/move
our sub categories-move(
    Hash $config,
    Int  :$categoryId,
    Hash :$data
) is export {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/categories/$categoryId/move",
        content => to-json $data;
}

#GET    /V1/products/options/types
our sub products-options-types(
    Hash $config
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/options/types";
}

proto sub products-options(|) is export {*}
#GET    /V1/products/:sku/options
our multi products-options(
    Hash $config,
    Str  :$sku
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/$sku/options";
}
#GET    /V1/products/:sku/options/:optionId
our multi products-options(
    Hash $config,
    Str  :$sku,
    Int  :$optionId
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/$sku/options/$optionId";
}
#POST   /V1/products/options
our multi products-options(
    Hash $config,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/products/options",
        content => to-json $data;
}
#PUT    /V1/products/options/:optionId
our multi products-options(
    Hash $config,
    Int  :$optionId,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/products/options/$optionId",
        content => to-json $data;
}

#DELETE /V1/products/:sku/options/:optionId
our sub products-options-delete(
    Hash $config,
    Str  :$sku,
    Int  :$optionId
) is export {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/products/$sku/options/$optionId";
}

#GET    /V1/products/links/types
our sub products-links-types(
    Hash $config
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/links/types";
}

#GET    /V1/products/links/:type/attributes
our sub products-links-attributes(
    Hash $config,
    Str  :$type
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/links/$type/attributes";
}

proto sub products-links(|) is export {*}
#GET    /V1/products/:sku/links/:type
our multi products-links(
    Hash $config,
    Str  :$sku,
    Str  :$type
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/$sku/links/$type";
}
#POST   /V1/products/:sku/links
our multi products-links(
    Hash $config,
    Str  :$sku,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/products/$sku/links",
        content => to-json $data;
}
#PUT    /V1/products/:sku/links
our multi products-links(
    Hash $config,
    Str  :$sku,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/products/$sku/links",
        content => to-json $data;
}

#DELETE /V1/products/:sku/links/:type/:linkedProductSku
our sub products-links-delete(
    Hash $config,
    Str  :$sku,
    Str  :$type,
    Str  :$linkedProductSku
) is export {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/products/$sku/links/$type/$linkedProductSku";
}


proto sub categories-products(|) is export {*}
#GET    /V1/categories/:categoryId/products
our multi categories-products(
    Hash $config,
    Int  :$categoryId
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/categories/$categoryId/products";
}
#POST   /V1/categories/:categoryId/products
our multi categories-products(
    Hash $config,
    Int  :$categoryId,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/categories/$categoryId/products",
        content => to-json $data;
}
#PUT    /V1/categories/:categoryId/products
our multi categories-products(
    Hash $config,
    Int  :$categoryId,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/categories/$categoryId/products",
        content => to-json $data;
}

#DELETE /V1/categories/:categoryId/products/:sku
our sub categories-products-delete(
    Hash $config,
    Int  :$categoryId,
    Str  :$sku
) is export {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/categories/$categoryId/products/$sku";
}

#* POST   /V1/products/:sku/websites
our sub products-websites(
    Hash $config,
    Str  :$sku,
    Hash :$data
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/products/$sku/websites",
        content => to-json $data;
}

#* PUT   /V1/products/:sku/websites
our sub products-websites-update(
    Hash $config,
    Str  :$sku,
    Hash :$data
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/products/$sku/websites",
        content => to-json $data;
}

#* DELETE /V1/products/:sku/websites/:websiteId
our sub products-websites-delete(
    Hash $config,
    Str  :$sku,
    Int  :$websiteId
) is export {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/products/$sku/websites/$websiteId";
}
