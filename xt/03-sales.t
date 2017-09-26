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
my $customer_email = 'p6magento@fakeemail.com';
my $customer_quote_id;

subtest {

    # GET    /V1/orders
    my %t1_search_criteria = %{
        searchCriteria => %{
            filterGroups => [
                {
                    filters => [
                        {
                            field => 'email',
                            value => $customer_email,
                            condition_type =>  'eq'
                        },
                    ]
                },
            ],
            current_page => 1,
            page_size    => 10
        }
    }
    my %t1_results = orders %config;
    $customer_quote_id = %t1_results<items>.head<quote_id>;
    my $quote_parent_id = %t1_results<items>.head<parent_id>;
    is %t1_results<items>.head<base_currency_code>, 'USD', 'orders all';

    # GET    /V1/orders/:id
    my %t2_results = orders %config, id => $customer_quote_id;
    is %t2_results<base_currency_code>, 'USD', 'orders by id';
    my $entity_id = %t2_results<billing_address><entity_id>.Int;
    my $parent_id = %t2_results<billing_address><parent_id>.Int;

    # PUT    /V1/orders/:parent_id
    #
    # revist, not saving correctly
    #
    my %t3_data = Sales::orders-address-update(:$entity_id, :$parent_id);

    my %t3_results = 
        orders 
            %config,
            parent_id => $parent_id,
            data      => %t3_data;
    is %t3_results<message>, 'Could not save order address', 'orders update';
#
#    # POST   /V1/orders/
#    my %t4_data = Sales::orders();
#
#    my $t4_results =
#        orders 
#            %config,
#            data => %t4_data;
#    is True, True, 'orders new';

}, 'Orders';

#subtest {
#
#    # POST   /V1/orders/:id/comments
#    my %t1_data = Sales::orders-comments();
#
#    my $t1_results =
#        orders-comments 
#            %config,
#            id   => '',
#        data => %t1_data;
#    is True, True, 'orders comments new';
#
#    # GET    /V1/orders/:id/comments
#    my $t2_results =
#        orders-comments 
#            %config,
#            id => '';
#    is True, True, 'orders comments by id';
#
#}, 'Orders comments';
#
#subtest {
#
#    # PUT    /V1/orders/create
#    my %t1_data = Sales::orders-create();
#
#    my $t1_results =
#        orders-create 
#            %config,
#            data => %t1_data;
#    is True, True, 'orders create update';
#
#}, 'Orders create';
#
#subtest {
#
#    # POST   /V1/orders/:id/emails
#    my %t1_data = Sales::orders-emails();
#
#    my $t1_results =
#        orders-emails 
#            %config,
#            id   => '',
#        data => %t1_data;
#    is True, True, 'orders emails new';
#
#}, 'Orders emails';
#
#subtest {
#
#    # POST /V1/order/:orderId/ship
#    my %t1_data = Sales::order-ship();
#
#    my $t1_results =
#        order-ship 
#            %config,
#            order_id => '',
#        data    => %t1_data;
#    is True, True, 'order ship new';
#
#}, 'Order ship';
#
#subtest {
#
#    # POST   /V1/orders/:id/hold
#    my %t1_data = Sales::orders-hold();
#
#    my $t1_results =
#        orders-hold 
#            %config,
#            id   => '',
#        data => %t1_data;
#    is True, True, 'orders hold new';
#
#}, 'Orders hold';
#
#subtest {
#
#    # GET    /V1/orders/items/:id
#    my $t1_results =
#        orders-items 
#            %config,
#            id => '';
#    is True, True, 'orders items by id';
#
#    # GET    /V1/orders/items
#    my $t2_results =
#        orders-items %config;
#    is True, True, 'orders items all';
#
#}, 'Orders items';
#
#subtest {
#
#    # GET    /V1/orders/:id/statuses
#    my $t1_results =
#        orders-statuses 
#            %config,
#            id => '';
#    is True, True, 'orders statuses by id';
#
#}, 'Orders statuses';
#
#subtest {
#
#    # POST   /V1/orders/:id/unhold
#    my %t1_data = Sales::orders-unhold();
#
#    my $t1_results =
#        orders-unhold 
#            %config,
#            id   => '',
#        data => %t1_data;
#    is True, True, 'orders unhold new';
#
#}, 'Orders unhold';
#
#subtest {
#
#    # POST /V1/order/:orderId/invoice
#    my %t1_data = Sales::order-invoice();
#
#    my $t1_results =
#        order-invoice 
#            %config,
#            order_id => '',
#        data    => %t1_data;
#    is True, True, 'order invoice new';
#
#}, 'Order invoice';
#
#subtest {
#
#    # GET    /V1/invoices/:id
#    my $t1_results =
#        invoices 
#            %config,
#            id => '';
#    is True, True, 'invoices by id';
#
#    # GET    /V1/invoices
#    my $t2_results =
#        invoices %config;
#    is True, True, 'invoices all';
#
#    # POST   /V1/invoices/
#    my %t3_data = Sales::invoices();
#
#    my $t3_results =
#        invoices 
#            %config,
#            data => %t3_data;
#    is True, True, 'invoices new';
#
#}, 'Invoices';
#
#subtest {
#
#    # POST   /V1/invoices/:id/capture
#    my %t1_data = Sales::invoices-capture();
#
#    my $t1_results =
#        invoices-capture 
#            %config,
#            id   => '',
#        data => %t1_data;
#    is True, True, 'invoices capture new';
#
#}, 'Invoices capture';
#
#subtest {
#
#    # GET    /V1/invoices/:id/comments
#    my $t1_results =
#        invoices-comments 
#            %config,
#            id => '';
#    is True, True, 'invoices comments by id';
#
#    # POST   /V1/invoices/comments
#    my %t2_data = Sales::invoices-comments();
#
#    my $t2_results =
#        invoices-comments 
#            %config,
#            data => %t2_data;
#    is True, True, 'invoices comments new';
#
#}, 'Invoices comments';
#
#subtest {
#
#    # POST   /V1/invoices/:id/emails
#    my %t1_data = Sales::invoices-emails();
#
#    my $t1_results =
#        invoices-emails 
#            %config,
#            id   => '',
#        data => %t1_data;
#    is True, True, 'invoices emails new';
#
#}, 'Invoices emails';
#
#subtest {
#
#    # GET    /V1/creditmemo/:id
#    my $t1_results =
#        creditmemo 
#            %config,
#            id => '';
#    is True, True, 'creditmemo by id';
#
#    # PUT    /V1/creditmemo/:id
#    my %t2_data = Sales::creditmemo();
#
#    my $t2_results =
#        creditmemo 
#            %config,
#            id   => '',
#            data => %t2_data;
#    is True, True, 'creditmemo update';
#
#    # POST   /V1/creditmemo
#    my %t3_data = Sales::creditmemo();
#
#    my $t3_results =
#        creditmemo 
#            %config,
#            data => %t3_data;
#    is True, True, 'creditmemo new';
#
#}, 'Creditmemo';
#
#subtest {
#
#    # GET    /V1/creditmemo/:id/comments
#    my $t1_results =
#        creditmemo-comments 
#            %config,
#            id => '';
#    is True, True, 'creditmemo comments by id';
#
#    # POST   /V1/creditmemo/:id/comments
#    my %t2_data = Sales::creditmemo-comments();
#
#    my $t2_results =
#        creditmemo-comments 
#            %config,
#            id   => '',
#            data => %t2_data;
#    is True, True, 'creditmemo comments new';
#
#}, 'Creditmemo comments';
#
#subtest {
#
#    # POST   /V1/creditmemo/:id/emails
#    my %t1_data = Sales::creditmemo-emails();
#
#    my $t1_results =
#        creditmemo-emails 
#            %config,
#            id   => '',
#        data => %t1_data;
#    is True, True, 'creditmemo emails new';
#
#}, 'Creditmemo emails';
#
#subtest {
#
#    # GET    /V1/creditmemos
#    my $t1_results =
#        creditmemos %config;
#    is True, True, 'creditmemos all';
#
#}, 'Creditmemos';
#
#subtest {
#
#    # GET    /V1/shipment/:id
#    my $t1_results =
#        shipment 
#            %config,
#            id => '';
#    is True, True, 'shipment by id';
#
#    # POST   /V1/shipment/
#    my %t2_data = Sales::shipment();
#
#    my $t2_results =
#        shipment 
#            %config,
#            data => %t2_data;
#    is True, True, 'shipment new';
#
#}, 'Shipment';
#
#subtest {
#
#    # GET    /V1/shipment/:id/comments
#    my $t1_results =
#        shipment-comments 
#            %config,
#            id => '';
#    is True, True, 'shipment comments by id';
#
#    # POST   /V1/shipment/:id/comments
#    my %t2_data = Sales::shipment-comments();
#
#    my $t2_results =
#        shipment-comments 
#            %config,
#            id   => '',
#        data => %t2_data;
#    is True, True, 'shipment comments new';
#
#}, 'Shipment comments';
#
#subtest {
#
#    # POST   /V1/shipment/:id/emails
#    my %t1_data = Sales::shipment-emails();
#
#    my $t1_results =
#        shipment-emails 
#            %config,
#            id   => '',
#        data => %t1_data;
#    is True, True, 'shipment emails new';
#
#}, 'Shipment emails';
#
#subtest {
#
#    # GET    /V1/shipment/:id/label
#    my $t1_results =
#        shipment-label 
#            %config,
#            id => '';
#    is True, True, 'shipment label by id';
#
#}, 'Shipment label';
#
#subtest {
#
#    # GET    /V1/shipments
#    my $t1_results =
#        shipments %config;
#    is True, True, 'shipments all';
#
#}, 'Shipments';
#
#subtest {
#
#    # POST   /V1/shipment/track
#    my %t1_data = Sales::shipment-track();
#
#    my $t1_results =
#        shipment-track 
#            %config,
#            data => %t1_data;
#    is True, True, 'shipment track new';
#
#    # DELETE /V1/shipment/track/:id
#    my $t2_results =
#        shipment-track-delete 
#            %config,
#            id => '';
#    is True, True, 'shipment track delete';
#
#}, 'Shipment track';
#
#subtest {
#
#    # GET    /V1/transactions/:id
#    my $t1_results =
#        transactions 
#            %config,
#            id => '';
#    is True, True, 'transactions by id';
#
#    # GET    /V1/transactions
#    my $t2_results =
#        transactions %config;
#    is True, True, 'transactions all';
#
#}, 'Transactions';
#
#subtest {
#
#    # POST /V1/invoice/:invoiceId/refund
#    my %t1_data = Sales::invoice-refund();
#
#    my $t1_results =
#        invoice-refund 
#            %config,
#            invoice_id => '',
#        data      => %t1_data;
#    is True, True, 'invoice refund new';
#
#}, 'Invoice refund';
#
#subtest {
#
#    # POST   /V1/invoices/:id/void
#    my %t1_data = Sales::invoices-void();
#
#    my $t1_results =
#        invoices-void 
#            %config,
#            id   => '',
#        data => %t1_data;
#    is True, True, 'invoices void new';
#
#}, 'Invoices void';
#
#subtest {
#
#    # POST /V1/order/:orderId/refund
#    my %t1_data = Sales::order-refund();
#
#    my $t1_results =
#        order-refund 
#            %config,
#            order_id => '',
#        data    => %t1_data;
#    is True, True, 'order refund new';
#
#}, 'Order refund';
#
#subtest {
#
#    # POST   /V1/orders/:id/cancel
#    my %t1_data = Sales::orders-cancel();
#
#    my $t1_results =
#        orders-cancel 
#            %config,
#            id   => '',
#        data => %t1_data;
#    is True, True, 'orders cancel new';
#
#}, 'Orders cancel';

done-testing;
