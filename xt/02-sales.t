use v6;

# These tests are meant to run against
# live development system. Do not run
# this against a production system.

use Test;
use lib 'lib', 'xt'.IO.child('lib');

use Magento::Config;
use Magento::Sales;
use Sales;

my %config = Magento::Config::from-file config_file => $*HOME.child('.6mag-testing').child('config.yml');


subtest {

    # GET    /V1/creditmemo/:id
    %config
    ==> creditmemo(
        id => ''
    )
    ==> my $t1_results;
    is True, True, 'creditmemo by id';

    # PUT    /V1/creditmemo/:id
    my %t2_data = Sales::creditmemo();

    %config
    ==> creditmemo(
        id   => '',
        data => %t2_data
    )
    ==> my $t2_results;
    is True, True, 'creditmemo modified';

    # POST   /V1/creditmemo
    my %t3_data = Sales::creditmemo();

    %config
    ==> creditmemo(
            data => %t3_data
    )
    ==> my $t3_results;
    is True, True, 'creditmemo new';

}, 'Creditmemo';

subtest {

    # GET    /V1/creditmemo/:id/comments
    %config
    ==> creditmemo-comments(
        id => ''
    )
    ==> my $t1_results;
    is True, True, 'creditmemo comments by id';

    # POST   /V1/creditmemo/:id/comments
    my %t2_data = Sales::creditmemo-comments();

    %config
    ==> creditmemo-comments(
        id   => '',
        data => %t2_data
    )
    ==> my $t2_results;
    is True, True, 'creditmemo comments new';

}, 'Creditmemo comments';

subtest {

    # POST   /V1/creditmemo/:id/emails
    my %t1_data = Sales::creditmemo-emails();

    %config
    ==> creditmemo-emails(
        id   => '',
        data => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'creditmemo emails new';

}, 'Creditmemo emails';

subtest {

    # GET    /V1/creditmemos
    %config
    ==> creditmemos(    )
    ==> my $t1_results;
    is True, True, 'creditmemos all';

}, 'Creditmemos';

subtest {

    # POST /V1/invoice/:invoiceId/refund
    my %t1_data = Sales::invoice-refund();

    %config
    ==> invoice-refund(
        invoice_id => '',
        data      => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'invoice refund new';

}, 'Invoice refund';

subtest {

    # GET    /V1/invoices/:id
    %config
    ==> invoices(
        id => ''
    )
    ==> my $t1_results;
    is True, True, 'invoices by id';

    # GET    /V1/invoices
    %config
    ==> invoices(    )
    ==> my $t2_results;
    is True, True, 'invoices all';

    # POST   /V1/invoices/
    my %t3_data = Sales::invoices();

    %config
    ==> invoices(
            data => %t3_data
    )
    ==> my $t3_results;
    is True, True, 'invoices new';

}, 'Invoices';

subtest {

    # POST   /V1/invoices/:id/capture
    my %t1_data = Sales::invoices-capture();

    %config
    ==> invoices-capture(
        id   => '',
        data => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'invoices capture new';

}, 'Invoices capture';

subtest {

    # GET    /V1/invoices/:id/comments
    %config
    ==> invoices-comments(
        id => ''
    )
    ==> my $t1_results;
    is True, True, 'invoices comments by id';

    # POST   /V1/invoices/comments
    my %t2_data = Sales::invoices-comments();

    %config
    ==> invoices-comments(
            data => %t2_data
    )
    ==> my $t2_results;
    is True, True, 'invoices comments new';

}, 'Invoices comments';

subtest {

    # POST   /V1/invoices/:id/emails
    my %t1_data = Sales::invoices-emails();

    %config
    ==> invoices-emails(
        id   => '',
        data => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'invoices emails new';

}, 'Invoices emails';

subtest {

    # POST   /V1/invoices/:id/void
    my %t1_data = Sales::invoices-void();

    %config
    ==> invoices-void(
        id   => '',
        data => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'invoices void new';

}, 'Invoices void';

subtest {

    # POST /V1/order/:orderId/invoice
    my %t1_data = Sales::order-invoice();

    %config
    ==> order-invoice(
        order_id => '',
        data    => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'order invoice new';

}, 'Order invoice';

subtest {

    # POST /V1/order/:orderId/refund
    my %t1_data = Sales::order-refund();

    %config
    ==> order-refund(
        order_id => '',
        data    => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'order refund new';

}, 'Order refund';

subtest {

    # GET    /V1/orders/:id
    %config
    ==> orders(
        id => ''
    )
    ==> my $t1_results;
    is True, True, 'orders by id';

    # GET    /V1/orders
    %config
    ==> orders(    )
    ==> my $t2_results;
    is True, True, 'orders all';

    # PUT    /V1/orders/:parent_id
    my %t3_data = Sales::orders();

    %config
    ==> orders(
        parent_id => '',
        data      => %t3_data
    )
    ==> my $t3_results;
    is True, True, 'orders modified';

    # POST   /V1/orders/
    my %t4_data = Sales::orders();

    %config
    ==> orders(
            data => %t4_data
    )
    ==> my $t4_results;
    is True, True, 'orders new';

}, 'Orders';

subtest {

    # POST   /V1/orders/:id/cancel
    my %t1_data = Sales::orders-cancel();

    %config
    ==> orders-cancel(
        id   => '',
        data => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'orders cancel new';

}, 'Orders cancel';

subtest {

    # POST   /V1/orders/:id/comments
    my %t1_data = Sales::orders-comments();

    %config
    ==> orders-comments(
        id   => '',
        data => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'orders comments new';

    # GET    /V1/orders/:id/comments
    %config
    ==> orders-comments(
        id => ''
    )
    ==> my $t2_results;
    is True, True, 'orders comments by id';

}, 'Orders comments';

subtest {

    # PUT    /V1/orders/create
    my %t1_data = Sales::orders-create();

    %config
    ==> orders-create(
            data => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'orders create modified';

}, 'Orders create';

subtest {

    # POST   /V1/orders/:id/emails
    my %t1_data = Sales::orders-emails();

    %config
    ==> orders-emails(
        id   => '',
        data => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'orders emails new';

}, 'Orders emails';

subtest {

    # POST /V1/order/:orderId/ship
    my %t1_data = Sales::order-ship();

    %config
    ==> order-ship(
        order_id => '',
        data    => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'order ship new';

}, 'Order ship';

subtest {

    # POST   /V1/orders/:id/hold
    my %t1_data = Sales::orders-hold();

    %config
    ==> orders-hold(
        id   => '',
        data => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'orders hold new';

}, 'Orders hold';

subtest {

    # GET    /V1/orders/items/:id
    %config
    ==> orders-items(
        id => ''
    )
    ==> my $t1_results;
    is True, True, 'orders items by id';

    # GET    /V1/orders/items
    %config
    ==> orders-items(    )
    ==> my $t2_results;
    is True, True, 'orders items all';

}, 'Orders items';

subtest {

    # GET    /V1/orders/:id/statuses
    %config
    ==> orders-statuses(
        id => ''
    )
    ==> my $t1_results;
    is True, True, 'orders statuses by id';

}, 'Orders statuses';

subtest {

    # POST   /V1/orders/:id/unhold
    my %t1_data = Sales::orders-unhold();

    %config
    ==> orders-unhold(
        id   => '',
        data => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'orders unhold new';

}, 'Orders unhold';

subtest {

    # GET    /V1/shipment/:id
    %config
    ==> shipment(
        id => ''
    )
    ==> my $t1_results;
    is True, True, 'shipment by id';

    # POST   /V1/shipment/
    my %t2_data = Sales::shipment();

    %config
    ==> shipment(
            data => %t2_data
    )
    ==> my $t2_results;
    is True, True, 'shipment new';

}, 'Shipment';

subtest {

    # GET    /V1/shipment/:id/comments
    %config
    ==> shipment-comments(
        id => ''
    )
    ==> my $t1_results;
    is True, True, 'shipment comments by id';

    # POST   /V1/shipment/:id/comments
    my %t2_data = Sales::shipment-comments();

    %config
    ==> shipment-comments(
        id   => '',
        data => %t2_data
    )
    ==> my $t2_results;
    is True, True, 'shipment comments new';

}, 'Shipment comments';

subtest {

    # POST   /V1/shipment/:id/emails
    my %t1_data = Sales::shipment-emails();

    %config
    ==> shipment-emails(
        id   => '',
        data => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'shipment emails new';

}, 'Shipment emails';

subtest {

    # GET    /V1/shipment/:id/label
    %config
    ==> shipment-label(
        id => ''
    )
    ==> my $t1_results;
    is True, True, 'shipment label by id';

}, 'Shipment label';

subtest {

    # GET    /V1/shipments
    %config
    ==> shipments(    )
    ==> my $t1_results;
    is True, True, 'shipments all';

}, 'Shipments';

subtest {

    # POST   /V1/shipment/track
    my %t1_data = Sales::shipment-track();

    %config
    ==> shipment-track(
            data => %t1_data
    )
    ==> my $t1_results;
    is True, True, 'shipment track new';

    # DELETE /V1/shipment/track/:id
    %config
    ==> shipment-track(
        id => ''
    )
    ==> my $t2_results;
    is True, True, 'shipment track delete';

}, 'Shipment track';

subtest {

    # GET    /V1/transactions/:id
    %config
    ==> transactions(
        id => ''
    )
    ==> my $t1_results;
    is True, True, 'transactions by id';

    # GET    /V1/transactions
    %config
    ==> transactions(    )
    ==> my $t2_results;
    is True, True, 'transactions all';

}, 'Transactions';

done-testing;
