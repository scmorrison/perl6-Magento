use v6;

use Magento::HTTP;
use Magento::Utils;
use JSON::Fast;

unit module Magento::Rma;

proto sub returns-tracking-numbers(|) is export {*}
# POST   /V1/returns/:id/tracking-numbers
our multi returns-tracking-numbers(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/returns/$id/tracking-numbers",
        content => to-json $data;
}

# DELETE /V1/returns/:id/tracking-numbers/:trackId
our sub returns-tracking-numbers-delete(
    Hash $config,
    Str  :$id!,
    Int  :$track_id!
) {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/returns/$id/tracking-numbers/$track_id";
}

proto sub returns(|) is export {*}
# GET    /V1/returns/:id
our multi returns(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/returns/$id";
}

# DELETE /V1/returns/:id
our sub returns-delete(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/returns/$id";
}

proto sub returns-comments(|) is export {*}
# POST   /V1/returns/:id/comments
our multi returns-comments(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/returns/$id/comments",
        content => to-json $data;
}

# POST   /V1/returns
our multi returns(
    Hash $config,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/returns",
        content => to-json $data;
}

# PUT    /V1/returns/:id
our multi returns(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/returns/$id",
        content => to-json $data;
}

# GET    /V1/returns/:id/comments
our multi returns-comments(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/returns/$id/comments";
}

# GET    /V1/returns
our multi returns(
    Hash $config
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/returns";
}

proto sub returnsAttributeMetadata(|) is export {*}
# GET    /V1/returnsAttributeMetadata/:attributeCode
our multi returnsAttributeMetadata(
    Hash $config,
    Str  :$attribute_code!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/returnsAttributeMetadata/$attribute_code";
}

# GET    /V1/returnsAttributeMetadata/form/:formCode
our sub returnsAttributeMetadata-form(
    Hash $config,
    Str  :$form_code!
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/returnsAttributeMetadata/form/$form_code";
}

# GET    /V1/returnsAttributeMetadata
our multi returnsAttributeMetadata(
    Hash $config
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/returnsAttributeMetadata";
}

# GET    /V1/returnsAttributeMetadata/custom
our sub returnsAttributeMetadata-custom(
    Hash $config
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/returnsAttributeMetadata/custom";
}

# GET    /V1/returns/:id/tracking-numbers
our multi returns-tracking-numbers(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/returns/$id/tracking-numbers";
}

# GET    /V1/returns/:id/labels
our sub returns-labels(
    Hash $config,
    Str  :$id!
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/returns/$id/labels";
}

