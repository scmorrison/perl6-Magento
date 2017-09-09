use v6;

unit module Magento::Catalog;

proto sub products(|) is export {*}
#GET    /V1/products
our multi products(
    Hash $config
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products"
}

#POST   /V1/products
our multi products(
    Hash $config,
    Hash :$data
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
    Int  :$sku,
    Hash :$data
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
    Int  :$sku
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/products/$sku"
}

#DELETE /V1/products/:sku
our sub products-delete(
    Hash $config,
    Int  :$sku
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
#POST   /V1/products/attribute-sets/groups
#PUT    /V1/products/attribute-sets/:attributeSetId/groups
#DELETE /V1/products/attribute-sets/groups/:groupId
#GET    /V1/products/attributes/:attributeCode/options
#POST   /V1/products/attributes/:attributeCode/options
#DELETE /V1/products/attributes/:attributeCode/options/:optionId
#GET    /V1/products/media/types/:attributeSetName
#GET    /V1/products/:sku/media/:entryId
#POST   /V1/products/:sku/media
#PUT    /V1/products/:sku/media/:entryId
#DELETE /V1/products/:sku/media/:entryId
#GET    /V1/products/:sku/media
#GET    /V1/products/:sku/group-prices/:customerGroupId/tiers
#POST   /V1/products/:sku/group-prices/:customerGroupId/tiers/:qty/price/:price
#DELETE /V1/products/:sku/group-prices/:customerGroupId/tiers/:qty
#DELETE /V1/categories/:categoryId
#GET    /V1/categories/:categoryId
#POST   /V1/categories
#GET    /V1/categories
#PUT    /V1/categories/:id
#PUT    /V1/categories/:categoryId/move
#GET    /V1/products/options/types
#GET    /V1/products/:sku/options
#GET    /V1/products/:sku/options/:optionId
#POST   /V1/products/options
#PUT    /V1/products/options/:optionId
#DELETE /V1/products/:sku/options/:optionId
#GET    /V1/products/links/types
#GET    /V1/products/links/:type/attributes
#GET    /V1/products/:sku/links/:type
#POST   /V1/products/:sku/links
#DELETE /V1/products/:sku/links/:type/:linkedProductSku
#PUT    /V1/products/:sku/links
#GET    /V1/categories/:categoryId/products
#POST   /V1/categories/:categoryId/products
#PUT    /V1/categories/:categoryId/products
#DELETE /V1/categories/:categoryId/products/:sku
#* POST   /V1/products/:sku/websites
#* PUT    /V1/products/:sku/websites
#* DELETE /V1/products/:sku/websites/:websiteId
