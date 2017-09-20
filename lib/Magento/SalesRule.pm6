use v6;

use Magento::HTTP;
use Magento::Utils;
use JSON::Fast;

unit module Magento::SalesRule;

proto sub coupons(|) is export {*}
# GET    /V1/coupons/:couponId
our multi coupons(
    Hash $config,
    Int  :$coupon_id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/coupons/$coupon_id";
}

# POST   /V1/coupons
our multi coupons(
    Hash $config,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/coupons",
        content => to-json $data;
}

# PUT    /V1/coupons/:couponId
our multi coupons(
    Hash $config,
    Int  :$coupon_id!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/coupons/$coupon_id",
        content => to-json $data;
}

# DELETE /V1/coupons/:couponId
our sub coupons-delete(
    Hash $config,
    Int  :$coupon_id!
) {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/coupons/$coupon_id";
}

# POST   /V1/coupons/deleteByCodes
our sub coupons-delete-by-codes(
    Hash $config,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/coupons/deleteByCodes",
        content => to-json $data;
}

# POST   /V1/coupons/deleteByIds
our sub coupons-delete-by-ids(
    Hash $config,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/coupons/deleteByIds",
        content => to-json $data;
}

# POST   /V1/coupons/generate
our sub coupons-generate(
    Hash $config,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/coupons/generate",
        content => to-json $data;
}

# GET    /V1/coupons/search
our sub coupons-search(
    Hash $config,
    Hash :$search_criteria = %()
) is export {
    my $query_string = search-criteria-to-query-string $search_criteria;
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/coupons/search?$query_string";
}

proto sub sales-rules(|) is export {*}
# GET    /V1/salesRules/:ruleId
our multi sales-rules(
    Hash $config,
    Int  :$rule_id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/salesRules/$rule_id";
}

# POST   /V1/salesRules
our multi sales-rules(
    Hash $config,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/salesRules",
        content => to-json $data;
}

# PUT    /V1/salesRules/:ruleId
our multi sales-rules(
    Hash $config,
    Int  :$rule_id!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/salesRules/$rule_id",
        content => to-json $data;
}

# DELETE /V1/salesRules/:ruleId
our sub sales-rules-delete(
    Hash $config,
    Int  :$rule_id!
) {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/salesRules/$rule_id";
}

# GET    /V1/salesRules/search
our sub sales-rules-search(
    Hash $config,
    Hash :$search_criteria = %()
) is export {
    my $query_string = search-criteria-to-query-string $search_criteria;
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/salesRules/search?$query_string";
}
