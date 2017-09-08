use v6;

use Magento::HTTP;
use Magento::Utils;
use JSON::Fast;

unit module Magento::Customer;

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

#POST    /V1/customerGroups
our multi customer-groups(
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
proto sub customer-address-form(|) is export {*}
our multi customer-address-form(
    Hash $config,
    Str :$form_code
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/attributeMetadata/customerAddress/form/$form_code",
        access_token => $config<access_token>;
}

#GET    /V1/attributeMetadata/customerAddress
proto sub customer-address(|) is export {*}
our multi customer-address(
    Hash $config
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/attributeMetadata/customerAddress",
        access_token => $config<access_token>;
}

#GET    /V1/attributeMetadata/customerAddress/custom
proto sub customer-address-custom(|) is export {*}
our multi customer-address-custom(
    Hash $config
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/attributeMetadata/customerAddress/custom",
        access_token => $config<access_token>;
}

#DELETE /V1/customers/:customerId
our sub customers-delete(
    Hash $config,
    Int  :$id
) is export {
    Magento::HTTP::request
        method       => 'DELETE',
        host         => $config<host>,
        uri          => "rest/V1/customers/$id",
        access_token => $config<access_token>;
}

#POST   /V1/customers
proto sub customers(|) is export {*}
our multi customers(
    Hash $config,
    Hash :$data
) {
    Magento::HTTP::request
        method       => 'POST',
        host         => $config<host>,
        uri          => "rest/V1/customers",
        access_token => $config<access_token>,
        content      => to-json $data;
}
#PUT    /V1/customers/:id
our multi customers(
    Hash $config,
    Int  :$id,
    Hash :$data
) {
    Magento::HTTP::request
        method       => 'PUT',
        host         => $config<host>,
        uri          => "rest/V1/customers/$id",
        access_token => $config<access_token>,
        content      => to-json $data;
}
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

#PUT    /V1/customers/me/activate
#GET    /V1/customers/me          - use GET customers/:customerId
#PUT    /V1/customers/me          - use PUT customers/:customerId
#PUT    /V1/customers/me/password - use customers/password
#GET    /V1/customers/me/billingAddress
#GET    /V1/customers/me/shippingAddress

#GET    /V1/customers/search
our sub customers-search(
    Hash $config,
    Hash :$search_criteria
) is export {
    my $query_string = search-criteria-to-query-string $search_criteria;
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/customers/search?$query_string",
        access_token => $config<access_token>;
}

#PUT    /V1/customers/:email/activate
our sub customers-email-activate(
    Hash $config,
    Str  :$email,
    Hash :$data
) is export {
    Magento::HTTP::request
        method       => 'PUT',
        host         => $config<host>,
        uri          => "rest/V1/customers/$email/activate",
        access_token => $config<access_token>,
        content      => to-json $data;
}

#GET    /V1/customers/:customerId/password/resetLinkToken/:resetPasswordLinkToken
our sub customers-reset-link-token(
    Hash $config,
    Int  :$id,
    Str  :$link_token
) is export {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/customers/$id/password/resetLinkToken/$link_token",
        access_token => $config<access_token>;
}

#PUT    /V1/customers/password
our sub customers-password(
    Hash $config,
    Hash :$data
) is export {
    Magento::HTTP::request
        method       => 'PUT',
        host         => $config<host>,
        uri          => "rest/V1/customers/password",
        access_token => $config<access_token>,
        content      => to-json $data;
}

proto sub customers-confirm(|) is export {*}
#GET    /V1/customers/:customerId/confirm
our multi customers-confirm(
    Hash $config,
    Int  :$id
) {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/customers/$id/confirm",
        access_token => $config<access_token>
}
#POST   /V1/customers/confirm
our multi customers-confirm(
    Hash $config,
    Hash :$data
) {
    Magento::HTTP::request
        method       => 'POST',
        host         => $config<host>,
        uri          => "rest/V1/customers/confirm",
        access_token => $config<access_token>,
        content      => to-json $data;
}

#PUT    /V1/customers/validate
our sub customers-validate(
    Hash $config,
    Hash :$data
) is export {
    Magento::HTTP::request
        method       => 'PUT',
        host         => $config<host>,
        uri          => "rest/V1/customers/validate",
        access_token => $config<access_token>,
        content      => to-json $data;
}

#GET    /V1/customers/:customerId/permissions/readonly
our sub customers-permissions(
    Hash $config,
    Int  :$id
) is export {
    Magento::HTTP::request
        method       => 'GET',
        host         => $config<host>,
        uri          => "rest/V1/customers/$id/permissions/readonly",
        access_token => $config<access_token>
}

#POST   /V1/customers/isEmailAvailable
#GET    /V1/customers/addresses/:addressId
#GET    /V1/customers/:customerId/billingAddress
#GET    /V1/customers/:customerId/shippingAddress
#DELETE /V1/addresses/:addressId

