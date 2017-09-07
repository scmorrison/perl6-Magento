#!/usr/bin/env perl6

use v6;

use Magento::HTTP;
use Magento::Utils;

unit module Magento::Customers;

#GET    /V1/customerGroups/search
#POST   /V1/customerGroups
#PUT    /V1/customerGroups/:id
#DELETE /V1/customerGroups/:id
#GET    /V1/attributeMetadata/customer/attribute/:attributeCode
#GET    /V1/attributeMetadata/customer/form/:formCode
#GET    /V1/attributeMetadata/customer
#GET    /V1/attributeMetadata/customer/custom
#GET    /V1/attributeMetadata/customerAddress/attribute/:attributeCode
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

proto sub customer-groups-default(|) is export {*}
#GET    /V1/customerGroups/default
our multi customer-groups-default(
    Hash $config
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/customerGroups/default",
        access_token => $config<access_token>;
}
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
#PUT    /V1/customerGroups
our multi customer-groups(
    Hash $config
) {
    Magento::HTTP::request
        method       => 'PUT',
        host         => $config<host>,
        uri          => "rest/V1/customerGroups",
        access_token => $config<access_token>;
}

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
