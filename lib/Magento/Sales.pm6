use v6;

use Magento::HTTP;
use Magento::Utils;
use JSON::Fast;

unit module Magento::Sales;

proto sub orders(|) is export {*}
# GET    /V1/orders/:id
our multi orders(
    Hash $config,
    Int  :$id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/orders/$id";
}

# GET    /V1/orders
our multi orders(
    Hash $config,
    Hash :$search_criteria = %{}
) {
    my $query_string = search-criteria-to-query-string $search_criteria;
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/orders?$query_string";
}

# PUT    /V1/orders/:parent_id
our multi orders(
    Hash $config,
    Int  :$parent_id!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/orders/$parent_id",
        content => to-json $data;
}

# GET    /V1/orders/:id/statuses
our sub orders-statuses(
    Hash $config,
    Int  :$id!
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/orders/$id/statuses";
}

# POST   /V1/orders/:id/cancel
our sub orders-cancel(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/orders/$id/cancel",
        content => to-json $data;
}

# POST   /V1/orders/:id/emails
our sub orders-emails(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/orders/$id/emails",
        content => to-json $data;
}

# POST   /V1/orders/:id/hold
our sub orders-hold(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/orders/$id/hold",
        content => to-json $data;
}

# POST   /V1/orders/:id/unhold
our sub orders-unhold(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/orders/$id/unhold",
        content => to-json $data;
}

proto sub orders-comments(|) is export {*}
# POST   /V1/orders/:id/comments
our multi orders-comments(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/orders/$id/comments",
        content => to-json $data;
}

# GET    /V1/orders/:id/comments
our multi orders-comments(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/orders/$id/comments";
}

# PUT    /V1/orders/create
our sub orders-create(
    Hash $config,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/orders/create",
        content => to-json $data;
}

proto sub orders-items(|) is export {*}
# GET    /V1/orders/items/:id
our multi orders-items(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/orders/items/$id";
}

# GET    /V1/orders/items
our multi orders-items(
    Hash $config
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/orders/items";
}

proto sub invoices(|) is export {*}
# GET    /V1/invoices/:id
our multi invoices(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/invoices/$id";
}

# GET    /V1/invoices
our multi invoices(
    Hash $config
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/invoices";
}

proto sub invoices-comments(|) is export {*}
# GET    /V1/invoices/:id/comments
our multi invoices-comments(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/invoices/$id/comments";
}

# POST   /V1/invoices/:id/emails
our sub invoices-emails(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/invoices/$id/emails",
        content => to-json $data;
}

# POST   /V1/invoices/:id/void
our sub invoices-void(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/invoices/$id/void",
        content => to-json $data;
}

# POST   /V1/invoices/:id/capture
our sub invoices-capture(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/invoices/$id/capture",
        content => to-json $data;
}

# POST   /V1/invoices/comments
our multi invoices-comments(
    Hash $config,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/invoices/comments",
        content => to-json $data;
}

# POST   /V1/invoices/
our multi invoices(
    Hash $config,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/invoices/",
        content => to-json $data;
}

proto sub creditmemo-comments(|) is export {*}
# GET    /V1/creditmemo/:id/comments
our multi creditmemo-comments(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/creditmemo/$id/comments";
}

# GET    /V1/creditmemos
our sub creditmemos(
    Hash $config
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/creditmemos";
}

proto sub creditmemo(|) is export {*}
# GET    /V1/creditmemo/:id
our multi creditmemo(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/creditmemo/$id";
}

# PUT    /V1/creditmemo/:id
our multi creditmemo(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'PUT',
        config  => $config,
        uri     => "rest/V1/creditmemo/$id",
        content => to-json $data;
}

# POST   /V1/creditmemo/:id/emails
our sub creditmemo-emails(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/creditmemo/$id/emails",
        content => to-json $data;
}

# POST   /V1/creditmemo/:id/comments
our multi creditmemo-comments(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/creditmemo/$id/comments",
        content => to-json $data;
}

# POST   /V1/creditmemo
our multi creditmemo(
    Hash $config,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/creditmemo",
        content => to-json $data;
}

proto sub shipment(|) is export {*}
# GET    /V1/shipment/:id
our multi shipment(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/shipment/$id";
}

# GET    /V1/shipments
our sub shipments(
    Hash $config
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/shipments";
}

proto sub shipment-comments(|) is export {*}
# GET    /V1/shipment/:id/comments
our multi shipment-comments(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/shipment/$id/comments";
}

# POST   /V1/shipment/:id/comments
our multi shipment-comments(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/shipment/$id/comments",
        content => to-json $data;
}

# POST   /V1/shipment/:id/emails
our sub shipment-emails(
    Hash $config,
    Str  :$id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/shipment/$id/emails",
        content => to-json $data;
}

proto sub shipment-track(|) is export {*}
# POST   /V1/shipment/track
our multi shipment-track(
    Hash $config,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/shipment/track",
        content => to-json $data;
}

# DELETE /V1/shipment/track/:id
our sub shipment-track-delete(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'DELETE',
        config  => $config,
        uri     => "rest/V1/shipment/track/$id";
}

# POST   /V1/shipment/
our multi shipment(
    Hash $config,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/shipment/",
        content => to-json $data;
}

# GET    /V1/shipment/:id/label
our sub shipment-label(
    Hash $config,
    Str  :$id!
) is export {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/shipment/$id/label";
}

# POST   /V1/orders/
our multi orders(
    Hash $config,
    Hash :$data!
) {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/orders/",
        content => to-json $data;
}

proto sub transactions(|) is export {*}
# GET    /V1/transactions/:id
our multi transactions(
    Hash $config,
    Str  :$id!
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/transactions/$id";
}

# GET    /V1/transactions
our multi transactions(
    Hash $config
) {
    Magento::HTTP::request
        method  => 'GET',
        config  => $config,
        uri     => "rest/V1/transactions";
}

# POST /V1/order/:orderId/invoice
our sub order-invoice(
    Hash $config,
    Int  :$order_id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/order/$order_id/invoice",
        content => to-json $data;
}

# POST /V1/order/:orderId/ship
our sub order-ship(
    Hash $config,
    Int  :$order_id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/order/$order_id/ship",
        content => to-json $data;
}

# POST /V1/invoice/:invoiceId/refund
our sub invoice-refund(
    Hash $config,
    Int  :$invoice_id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/invoice/$invoice_id/refund",
        content => to-json $data;
}

# POST /V1/order/:orderId/refund
our sub order-refund(
    Hash $config,
    Int  :$order_id!,
    Hash :$data!
) is export {
    Magento::HTTP::request
        method  => 'POST',
        config  => $config,
        uri     => "rest/V1/order/$order_id/refund",
        content => to-json $data;
}

