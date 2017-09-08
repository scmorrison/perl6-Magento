#!/usr/bin/env perl6

use v6;

use Magento::HTTP;
use Magento::Utils;
use JSON::Fast;

unit module Magento::Customers;

proto sub customer-groups(|) is export {*}
#GET    /V1/customerGroups/:id
our multi customer-groups(
    Hash $config,
    Int  :$id
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/customerGroups/$id",
        access_token => $config<access_token>;
}

#PUT    /V1/customerGroups/:id
our multi customer-groups(
    Hash $config,
    Int  :$id,
    Hash :$data
) {
    Magento::HTTP::request
        method       => 'PUT',
        host         => $config<host>,
        uri          => "rest/V1/customerGroups/$id",
        access_token => $config<access_token>,
        content      => to-json $data;
}


proto sub customer-groups-default(|) is export {*}
#GET    /V1/customerGroups/default/:storeId
our multi customer-groups-default(
    Hash $config,
    Int  :$store_id
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/customerGroups/default/$store_id",
        access_token => $config<access_token>;
}

#GET    /V1/customerGroups/default
multi customer-groups-default(
    Hash $config
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/customerGroups/default",
        access_token => $config<access_token>;
}

proto sub customer-groups-permissions(|) is export {*}
#GET    /V1/customerGroups/:id/permissions
our multi customer-groups-permissions(
    Hash $config,
    Int  :$id
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/customerGroups/$id/permissions",
        access_token => $config<access_token>;
}

#GET    /V1/customerGroups/search
proto sub customer-groups-search(|) is export {*}
our multi customer-groups-search(
    Hash $config,
    Hash :$search_criteria
) {
    my $query_string = search-criteria-to-query-string $search_criteria;
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/customerGroups/search?$query_string",
        access_token => $config<access_token>;
}

#POST    /V1/customerGroups
proto sub customer-groups-new(|) is export {*}
our multi customer-groups-new(
    Hash $config,
    Hash :$data
) {
    Magento::HTTP::request
        method       => 'POST',
        host         => $config<host>,
        uri          => "rest/V1/customerGroups",
        access_token => $config<access_token>,
        content      => to-json $data;
}

#DELETE /V1/customerGroups/:id
proto sub customer-groups-delete(|) is export {*}
our multi customer-groups-delete(
    Hash $config,
    Int  :$id
) {
    Magento::HTTP::request
        method       => 'DELETE',
        host         => $config<host>,
        uri          => "rest/V1/customerGroups/$id",
        access_token => $config<access_token>;
}

#GET    /V1/attributeMetadata/customer/attribute/:attributeCode
proto sub customer-metadata-attribute(|) is export {*}
our multi customer-metadata-attribute(
    Hash $config,
    Str :$attribute_code
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/attributeMetadata/customer/attribute/$attribute_code",
        access_token => $config<access_token>;
}

#GET    /V1/attributeMetadata/customer/form/:formCode
proto sub customer-metadata-form(|) is export {*}
our multi customer-metadata-form(
    Hash $config,
    Str :$form_code
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/attributeMetadata/customer/form/$form_code",
        access_token => $config<access_token>;
}

#GET    /V1/attributeMetadata/customer
proto sub customer-metadata(|) is export {*}
our multi customer-metadata(
    Hash $config
    --> Array
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/attributeMetadata/customer",
        access_token => $config<access_token>;
}

#GET    /V1/attributeMetadata/customer/custom
proto sub customer-metadata-custom(|) is export {*}
our multi customer-metadata-custom(
    Hash $config
    --> Array
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/attributeMetadata/customer/custom",
        access_token => $config<access_token>;
}

#GET    /V1/attributeMetadata/customerAddress/attribute/:attributeCode
proto sub customer-address-attribute(|) is export {*}
our multi customer-address-attribute(
    Hash $config,
    Str :$attribute_code
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/attributeMetadata/customerAddress/attribute/$attribute_code",
        access_token => $config<access_token>;
}

#GET    /V1/attributeMetadata/customerAddress/form/:formCode
#GET    /V1/attributeMetadata/customerAddress
#GET    /V1/attributeMetadata/customerAddress/custom
#POST   /V1/customers
#PUT    /V1/customers/:id
#PUT    /V1/customers/me
#GET    /V1/customers/me
#PUT    /V1/customers/me/activate
#GET    /V1/customers/search
#PUT    /V1/customers/:email/activate
#PUT    /V1/customers/me/password
#GET    /V1/customers/:customerId/password/resetLinkToken/:resetPasswordLinkToken
#PUT    /V1/customers/password
#GET    /V1/customers/:customerId/confirm
#POST   /V1/customers/confirm
#PUT    /V1/customers/validate
#GET    /V1/customers/:customerId/permissions/readonly
#DELETE /V1/customers/:customerId
#POST   /V1/customers/isEmailAvailable
#GET    /V1/customers/addresses/:addressId
#GET    /V1/customers/me/billingAddress
#GET    /V1/customers/:customerId/billingAddress
#GET    /V1/customers/me/shippingAddress
#GET    /V1/customers/:customerId/shippingAddress
#DELETE /V1/addresses/:addressId

proto sub customers(|) is export {*}
#GET    /V1/customers
our multi customers(
    Hash $config
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/customers",
        access_token => $config<access_token>;
}

#GET    /V1/customers/:customerId
our multi customers(
    Hash $config,
    Int  :$id
) {
    Magento::HTTP::request
        method  => 'GET',
        host    => $config<host>,
        uri     => "rest/V1/customers/$id",
        access_token => $config<access_token>;
}

proto sub customers-me(|) is export {*}
#GET    /V1/customers/me/:customerId
our multi customers-me(
    Hash $config
) {
    Magento::HTTP::request
        method  => 'GET',
        host    => $config<host>,
        uri     => "rest/V1/customers/me",
        access_token => $config<access_token>;
}

#GET    /V1/customers/search
proto sub customers-search(|) is export {*}
our multi customers-search(
    Hash $config,
    Hash :$search_criteria
) {
    my $query_string = search-criteria-to-query-string $search_criteria;
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/customers/search?$query_string",
        access_token => $config<access_token>;
}
