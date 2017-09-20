use v6;

# These tests are meant to run against
# live development system. Do not run
# this against a production system.

# To run the `mine` tests working set the password for the customer
# then run these scripts with the P6MAGENTOCUSPASS enviornment 
# variable set:
# 
# P6MAGENTOCUSPASS=password prove -ve 'perl6 -Ilib' xt/02-quote.t

use Test;
use lib 'lib', 'xt'.IO.child('lib');

use Magento::Checkout;
use Magento::Config;
use Magento::Customer;
use Magento::Quote;
use Quote;
use Setup;

my %config      = Magento::Config::from-file config_file => $*HOME.child('.6mag-testing').child('config.yml');
my $customer_id = Setup::customer-id();
my $customer_email = 'p6magento@fakeemail.com';
my $cart_id;
my $cart_item_id;

subtest {

    # POST   /V1/carts/
    my $t1_results = carts(%config);
    is $t1_results.^name, 'Int', 'carts new';
    $cart_id = $t1_results;

    # GET    /V1/carts/:cartId
    %config
    ==> carts(
        cart_id => $cart_id
    )
    ==> my %t2_results;
    is %t2_results<customer_is_guest>, False, 'carts by id';

    # PUT    /V1/carts/:cartId
    my %t3_data = customerId => $customer_id,
                  storeId    => 1;
    my $t3_results = (
        %config
        ==> carts(
            cart_id => $cart_id,
            data   => %t3_data));

    given $t3_results {
        when Bool {
            is $t3_results, True, 'carts update';
        }
        default {
            like $t3_results<message>, /'Cannot assign customer to the given cart'/, 'carts update';
        }
    }

}, 'Carts';

if %*ENV<P6MAGENTOCUSPASS> {

    subtest {

        use Magento::Auth;
        my $customer_access_token = 
        request-access-token(
            host      => %config<host>,
            username  => $customer_email,
            password  => 'p6magento',
            user_type => 'customer');


        # POST   /V1/carts/mine
        %( |%config, accress_token => $customer_access_token )
        ==> carts-mine()
        ==> my $t1_results;
        is $t1_results.^name, 'Int', 'carts mine new';
        my $customer_cart_id = $t1_results;

        # GET    /V1/carts/mine
        %( |%config, accress_token => $customer_access_token )
        ==> carts-mine(:$customer_id)
        ==> my %t2_results;
        is %t2_results<customer_is_guest>, False, 'carts mine by id';

        # PUT    /V1/carts/mine
        my %t3_data = customerId => $customer_id,
                      storeId    => 1;

        %( |%config, accress_token => $customer_access_token )
        ==> carts-mine(
            data => %t3_data
        )
        ==> my $t3_results;
        given $t3_results {
            when Bool {
                is $t3_results, True, 'carts mine update';
            }
            default {
                like $t3_results<message>, /'Cannot assign customer to the given cart'/, 'carts mine update';
            }
        }

    }, 'Carts mine';
}

subtest {

    # POST   /V1/carts/:cartId/billing-address
    my %t2_data = Quote::carts-billing-address();

    my $t2_results = (
        %config
        ==> carts-billing-address(
            cart_id => $cart_id,
            data   => %t2_data));
    is $t2_results.^name, 'Int', 'carts billing-address new';
    my $cart_address_id = $t2_results;

    # GET    /V1/carts/:cartId/billing-address
    %config
    ==> carts-billing-address(:$cart_id)
    ==> my %t1_results;
    is %t1_results<postcode>, 90210, 'carts billing-address by id';

}, 'Carts billing-address';

subtest {

    my $sku = Setup::product-sku();

    # POST   /V1/carts/:quoteId/items
    my %t1_data = Quote::carts-items(quote_id => "$cart_id");

    %config
    ==> carts-items(
        quote_id => $cart_id,
        data     => %t1_data
    )
    ==> my %t1_results;
    is %t1_results<sku>, 'P6-TEST-DELETE', 'carts items new';
    $cart_item_id = %t1_results<item_id>;

    # PUT    /V1/carts/:cartId/items/:itemId
    my %t2_data = Quote::carts-items-update(quote_id => "$cart_id");

    %config
    ==> carts-items(
        cart_id => $cart_id,
        item_id => $cart_item_id,
        data    => %t2_data
    )
    ==> my %t2_results;
    is %t2_results<qty>, 5, 'carts items update';

    # GET    /V1/carts/:cartId/items
    %config
    ==> carts-items(:$cart_id)
    ==> my @t3_results;
    is @t3_results.head<product_type>, 'simple', 'carts items by cart_id';

}, 'Carts items';

#subtest {
#
#    use Magento::SalesRule;
#    # PUT    /V1/carts/:cartId/coupons/:couponCode
#    my $coupon_id = Setup::coupon-id();
#
#    # No way to assign 'specific' coupon_code
#    # to sales rule using the API yet, revisit.
#    %config
#    ==> carts-coupons(
#        cart_id     => $cart_id,
#        coupon_code => 'DeleteMeCoupon'
#    )
#    ==> my $t2_results;
#    is True, True, 'carts coupons update';
#
#    # GET    /V1/carts/:cartId/coupons
#    %config
#    ==> carts-coupons(:$cart_id)
#    ==> my @t2_results;
#    is @t2_results, [], 'carts coupons by cart_id';
#
#    # DELETE /V1/carts/:cartId/coupons
#    %config
#    ==> carts-coupons-delete(:$cart_id)
#    ==> my $t3_results;
#    is $t3_results, True, 'carts coupons delete';
#
#}, 'Carts coupons';

subtest {

    # POST   /V1/carts/:cartId/estimate-shipping-methods
    my %t1_data = Quote::carts-estimate-shipping-methods();

    %config
    ==> carts-estimate-shipping-methods(
        cart_id => $cart_id,
        data    => %t1_data
    )
    ==> my @t1_results;
    is @t1_results.head<carrier_code>, 'flatrate', 'carts estimate-shipping-methods';

}, 'Carts estimate-shipping-methods';

subtest {

    # POST   /V1/carts/:cartId/estimate-shipping-methods-by-address-id
    %config ==> customers-addresses-shipping(id => $customer_id) ==> my %t1_address;
    my %t1_data = %{ addressId => %t1_address<id> }

    %config
    ==> carts-estimate-shipping-methods-by-address-id(
        cart_id => $cart_id,
        data    => %t1_data
    )
    ==> my @t1_results;
    is @t1_results.head<carrier_code>, 'flatrate', 'carts estimate-shipping-methods-by-address-id';

}, 'Carts estimate-shipping-methods-by-address-id';

#subtest {
#
#    # GET    /V1/carts/mine/billing-address
#    %config
#    ==> carts-mine-billing-address(    )
#    ==> my $t1_results;
#    is True, True, 'carts mine-billing-address all';
#
#    # POST   /V1/carts/mine/billing-address
#    my %t2_data = Quote::carts-mine-billing-address();
#
#    %config
#    ==> carts-mine-billing-address(
#            data => %t2_data
#    )
#    ==> my $t2_results;
#    is True, True, 'carts mine-billing-address new';
#
#}, 'Carts mine-billing-address';
#
#subtest {
#
#    # PUT    /V1/carts/mine/collect-totals
#    my %t1_data = Quote::carts-mine-collect-totals();
#
#    %config
#    ==> carts-mine-collect-totals(
#            data => %t1_data
#    )
#    ==> my $t1_results;
#    is True, True, 'carts mine-collect-totals update';
#
#}, 'Carts mine-collect-totals';
#
#subtest {
#
#    # GET    /V1/carts/mine/coupons
#    %config
#    ==> carts-mine-coupons(    )
#    ==> my $t1_results;
#    is True, True, 'carts mine-coupons all';
#
#    # PUT    /V1/carts/mine/coupons/:couponCode
#    my %t2_data = Quote::carts-mine-coupons();
#
#    %config
#    ==> carts-mine-coupons(
#        coupon_code => '',
#        data       => %t2_data
#    )
#    ==> my $t2_results;
#    is True, True, 'carts mine-coupons update';
#
#    # DELETE /V1/carts/mine/coupons
#    %config
#    ==> carts-mine-coupons(    )
#    ==> my $t3_results;
#    is True, True, 'carts mine-coupons delete';
#
#}, 'Carts mine-coupons';
#
#subtest {
#
#    # POST   /V1/carts/mine/estimate-shipping-methods
#    my %t1_data = Quote::carts-mine-estimate-shipping-methods();
#
#    %config
#    ==> carts-mine-estimate-shipping-methods(
#            data => %t1_data
#    )
#    ==> my $t1_results;
#    is True, True, 'carts mine-estimate-shipping-methods new';
#
#}, 'Carts mine-estimate-shipping-methods';
#
#subtest {
#
#    # POST   /V1/carts/mine/estimate-shipping-methods-by-address-id
#    my %t1_data = Quote::carts-mine-estimate-shipping-methods-by-address-id();
#
#    %config
#    ==> carts-mine-estimate-shipping-methods-by-address-id(
#            data => %t1_data
#    )
#    ==> my $t1_results;
#    is True, True, 'carts mine-estimate-shipping-methods-by-address-id new';
#
#}, 'Carts mine-estimate-shipping-methods-by-address-id';
#
#subtest {
#
#    # GET    /V1/carts/mine/items
#    %config
#    ==> carts-mine-items(    )
#    ==> my $t1_results;
#    is True, True, 'carts mine-items all';
#
#    # POST   /V1/carts/mine/items
#    my %t2_data = Quote::carts-mine-items();
#
#    %config
#    ==> carts-mine-items(
#            data => %t2_data
#    )
#    ==> my $t2_results;
#    is True, True, 'carts mine-items new';
#
#    # PUT    /V1/carts/mine/items/:itemId
#    my %t3_data = Quote::carts-mine-items();
#
#    %config
#    ==> carts-mine-items(
#        item_id => '',
#        data   => %t3_data
#    )
#    ==> my $t3_results;
#    is True, True, 'carts mine-items update';
#
#    # DELETE /V1/carts/mine/items/:itemId
#    %config
#    ==> carts-mine-items(
#        item_id => ''
#    )
#    ==> my $t4_results;
#    is True, True, 'carts mine-items delete';
#
#}, 'Carts mine-items';
#
#subtest {
#
#    # PUT    /V1/carts/mine/order
#    my %t1_data = Quote::carts-mine-order();
#
#    %config
#    ==> carts-mine-order(
#            data => %t1_data
#    )
#    ==> my $t1_results;
#    is True, True, 'carts mine-order update';
#
#}, 'Carts mine-order';
#
#subtest {
#
#    # GET    /V1/carts/mine/payment-methods
#    %config
#    ==> carts-mine-payment-methods(    )
#    ==> my $t1_results;
#    is True, True, 'carts mine-payment-methods all';
#
#}, 'Carts mine-payment-methods';
#
#subtest {
#
#    # GET    /V1/carts/mine/selected-payment-method
#    %config
#    ==> carts-mine-selected-payment-method(    )
#    ==> my $t1_results;
#    is True, True, 'carts mine-selected-payment-method all';
#
#    # PUT    /V1/carts/mine/selected-payment-method
#    my %t2_data = Quote::carts-mine-selected-payment-method();
#
#    %config
#    ==> carts-mine-selected-payment-method(
#            data => %t2_data
#    )
#    ==> my $t2_results;
#    is True, True, 'carts mine-selected-payment-method update';
#
#}, 'Carts mine-selected-payment-method';
#
#subtest {
#
#    # GET    /V1/carts/mine/shipping-methods
#    %config
#    ==> carts-mine-shipping-methods(    )
#    ==> my $t1_results;
#    is True, True, 'carts mine-shipping-methods all';
#
#}, 'Carts mine-shipping-methods';
#
#subtest {
#
#    # GET    /V1/carts/mine/totals
#    %config
#    ==> carts-mine-totals(    )
#    ==> my $t1_results;
#    is True, True, 'carts mine-totals all';
#
#}, 'Carts mine-totals';

subtest {

    # GET    /V1/carts/:cartId/payment-methods
    %config
    ==> carts-payment-methods(:$cart_id)
    ==> my @t1_results;
    is so @t1_results.any.grep({ $_<code> ~~ 'banktransfer' }), True, 'carts payment-methods by cart_id';

}, 'Carts payment-methods';

subtest {

    # GET    /V1/carts/search
    my %t1_search_criteria = %{
        searchCriteria => %{ 
            filterGroups => [
                {
                    filters => [
                        {
                            field => 'is_active',
                            value => 'true',
                            condition_type => 'eq'
                        },
                    ]
                },
            ],
        }
    }

    %config
    ==> carts-search(
        search_criteria => %t1_search_criteria
    )
    ==> my %t1_results;
    is so %t1_results<items>.any.grep({ $_<billing_address><email> ~~ $customer_email }),
    True, 'carts search all';

}, 'Carts search';

subtest {

    # Cannot complete order without shipping address
    # assigned to cart. Confirm endpoint returns 
    # expected shipping address message.
 
    # PUT    /V1/carts/:cartId/shipping-address
    my %t1_address = %{
        address => %{
            customerId    => $customer_id,
            firstname     => 'Camelia',
            lastname      => 'Butterfly',
            postcode      => '90210',
            city          => 'Beverly Hills',
            street        => ['Zoe Ave'],
            regionId      => 12,
            countryId     => 'US',
            telephone     => '555-555-5555',
            email         => $customer_email,
            useForShipping => 'true'

        }
    }

    # Need to save shipping address for cart before 
    # setting the payment method. Cannot set the cart
    # shipping address via the API. Looks like it is being
    # workied on in beta, revisit:
    # https://github.com/magento/magento2/issues/2517

    # Assign shipping address to cart
    %config
    ==> carts-billing-address(
        cart_id => $cart_id,
        data    => %t1_address
    );

    # PUT    /V1/carts/:cartId/selected-payment-method
    my %t1_data = method => %{
        method => 'banktransfer'
    }

    %config
    ==> carts-selected-payment-method(
        cart_id => $cart_id,
        data    => %t1_data
    )
    ==> my %t1_results;
    is %t1_results<message>, 'Shipping address is not set', 'carts selected-payment-method update';

    # GET    /V1/carts/:cartId/selected-payment-method
    %config
    ==> carts-selected-payment-method(:$cart_id)
    ==> my @t2_results;
    is @t2_results, [], 'carts selected-payment-method by id';


}, 'Carts selected-payment-method';

subtest {

    # GET    /V1/carts/:cartId/shipping-methods
    %config
    ==> carts-shipping-methods(:$cart_id)
    ==> my %t1_results;
    is %t1_results<message>, 'Shipping address not set.', 'carts shipping-methods by cart_id';

}, 'Carts shipping-methods';

subtest {

    # GET    /V1/carts/:cartId/totals
    %config
    ==> carts-totals(:$cart_id)
    ==> my %t1_results;
    is %t1_results<grand_total>, '99.75', 'carts totals by cart_id';

}, 'Carts totals';

subtest {

    # POST   /V1/customers/:customerId/carts
    my $t1_results = customers-carts(%config, :$customer_id);
    is $t1_results ~~ Int, True, 'customers carts new';

}, 'Customers carts';

subtest {

    # Cannot complete order without shipping address
    # assigned to cart. Confirm endpoint returns 
    # expected shipping address message.

    # PUT    /V1/carts/:cartId/order
    my %t1_data = paymentMethod => %{
        method => 'banktransfer'
    }

    %config
    ==> carts-order(
        cart_id => $cart_id,
        data    => %t1_data
    )
    ==> my %t1_results;
    like %t1_results<message>, / 'Please check the shipping address information' /, 'carts order update';

}, 'Carts order';


subtest {

    # POST   /V1/guest-carts
    my $t1_results = guest-carts(%config);
    is $t1_results.chars, 32, 'guest carts new';
    my $t1_cart_id = $t1_results;

    # revisit, need to add customer to guest cart?

    # PUT    /V1/guest-carts/:cartId
    #my %t2_data = %{
    #    customerId => $customer_id,
    #    storeId    => 1
    #}

    #%config
    #==> guest-carts(
    #    cart_id => $t1_cart_id,
    #    data    => %t2_data
    #)
    #==> my $t2_results;
    #is True, True, 'guest carts update';

    # POST   /V1/guest-carts/:cartId/billing-address
    my %t3_data = %{
        address => %{
            firstname     => 'Camelia',
            lastname      => 'Butterfly',
            postcode      => '90210',
            city          => 'Beverly Hills',
            street        => ['Zoe Ave'],
            regionId      => 12,
            countryId     => 'US',
            telephone     => '555-555-5555',
            email         => $customer_email

        }
    }

    my $t3_results = guest-carts-billing-address
        %config,
        cart_id => $t1_cart_id,
        data    => %t3_data;
    is $t3_results ~~ Int, True, 'guest carts-billing-address new';


    # GET    /V1/guest-carts/:cartId/billing-address
    %config
    ==> guest-carts-billing-address(
        cart_id => $t1_cart_id
    )
    ==> my %t4_results;
    is %t4_results<country_id>, 'US', 'guest carts-billing-address by cart_id';

    
    # GET    /V1/guest-carts/:cartId
    %config
    ==> guest-carts(
        cart_id => $t1_cart_id
    )
    ==> my %t5_results;
    is %t5_results<currency><quote_currency_code>, 'USD', 'guest carts by cart_id';

    # POST   /V1/guest-carts/:cartId/items
    my %t6_data = Quote::guest-carts-items(cart_id => $t1_cart_id);

    %config
    ==> guest-carts-items(
        cart_id => $t1_cart_id,
        data    => %t6_data
    )
    ==> my %t6_results;
    is %t6_results<product_type>, 'simple', 'guest carts-items new';

    # PUT    /V1/guest-carts/:cartId/items/:itemId
    my %t7_data = Quote::guest-carts-items-update(cart_id => $t1_cart_id);

    %config
    ==> guest-carts-items(
        cart_id => $t1_cart_id,
        item_id => %t6_results<item_id>,
        data    => %t7_data
    )
    ==> my %t7_results;
    is %t7_results<qty>, 7, 'guest carts-items update';

    # GET    /V1/guest-carts/:cartId/items
    %config
    ==> guest-carts-items(
        cart_id => $t1_cart_id
    )
    ==> my @t8_results;
    is @t8_results.elems, 1, 'guest carts-items by cart_id';

    my %t9_data = addressInformation => %{
        shippingAddress => %{
            firstname     => 'Camelia',
            lastname      => 'Butterfly',
            postcode      => '90210',
            city          => 'Beverly Hills',
            street        => ['Zoe Ave'],
            regionId      => 12,
            countryId     => 'US',
            telephone     => '555-555-5555',
            email         => $customer_email
        },
        billingAddress => %{
            firstname     => 'Camelia',
            lastname      => 'Butterfly',
            postcode      => '90210',
            city          => 'Beverly Hills',
            street        => ['Zoe Ave'],
            regionId      => 12,
            countryId     => 'US',
            telephone     => '555-555-5555',
            email         => $customer_email
        },
        shippingCarrierCode => 'flatrate', 
        shippingMethodCode  => 'flatrate'
    }

    %config
    ==> guest-carts-shipping-information(
        cart_id => $t1_cart_id,
        data    => %t9_data)
    ==> my %t9_results;
    is %t9_results<totals><base_currency_code>, 'USD', 'guest carts set shipping / billing address'; 

    my %t10_data = %{
        email         => $customer_email,
        paymentMethod => %{
            method => 'banktransfer'
        },
        billingAddress => %{
            firstname     => 'Camelia',
            lastname      => 'Butterfly',
            postcode      => '90210',
            city          => 'Beverly Hills',
            street        => ['Zoe Ave'],
            regionId      => 12,
            countryId     => 'US',
            telephone     => '555-555-5555',
            sameAsBilling => 1
        }
    }

    %config
    ==> guest-carts-set-payment-information(
        cart_id => $t1_cart_id,
        data    => %t10_data)
    ==> my $t10_results;
    is $t10_results, True, 'guest carts set payment method'; 

    # PUT    /V1/guest-carts/:cartId/collect-totals
    my %t11_data = paymentMethod => %{
        method => 'banktransfer'
    }
    %config
    ==> guest-carts-collect-totals(
        cart_id => $t1_cart_id,
        data    => %t11_data
    )
    ==> my %t11_results;
    is %t11_results<quote_currency_code>, 'USD', 'guest carts-collect-totals update';

    # GET    /V1/guest-carts/:cartId/selected-payment-method
    %config
    ==> guest-carts-selected-payment-method(
        cart_id => $t1_cart_id
    )
    ==> my %t12_results;
    is %t12_results<method>, 'banktransfer', 'guest carts-selected-payment-method by cart_id';

    # PUT    /V1/guest-carts/:cartId/selected-payment-method
    my %t13_data = method => %{
        method => 'banktransfer'
    }

    my $t13_results = guest-carts-selected-payment-method(
        %config,
        cart_id => $t1_cart_id,
        data    => %t13_data
    );
    is $t13_results ~~ Int, True, 'guest carts-selected-payment-method update';

    # GET    /V1/guest-carts/:cartId/payment-methods
    %config
    ==> guest-carts-payment-methods(
        cart_id => $t1_cart_id
    )
    ==> my @t14_results;
    is so @t14_results.any.grep({ $_<code> ~~ 'checkmo' }), True, 'guest carts-payment-methods by cart_id';

    # GET    /V1/guest-carts/:cartId/shipping-methods
    %config
    ==> guest-carts-shipping-methods(
        cart_id => $t1_cart_id
    )
    ==> my @t15_results;
    is so @t15_results.any.grep({ $_<carrier_code> ~~ 'flatrate' }), True, 'guest carts-shipping-methods by cart_id';

    # GET    /V1/guest-carts/:cartId/totals
    %config
    ==> guest-carts-totals(
        cart_id => $t1_cart_id
    )
    ==> my %t16_results;
    is %t16_results<base_currency_code>, 'USD', 'guest carts-totals by cart_id';


#subtest {
#
#    # GET    /V1/guest-carts/:cartId/coupons
#    %config
#    ==> guest-carts-coupons(
#        cart_id => ''
#    )
#    ==> my $t1_results;
#    is True, True, 'guest carts-coupons by id';
#
#    # PUT    /V1/guest-carts/:cartId/coupons/:couponCode
#    my %t2_data = Quote::guest-carts-coupons();
#
#    %config
#    ==> guest-carts-coupons(
#        cart_id    => '',
#    coupon_code => '',
#        data       => %t2_data
#    )
#    ==> my $t2_results;
#    is True, True, 'guest carts-coupons update';
#
#    # DELETE /V1/guest-carts/:cartId/coupons
#    %config
#    ==> guest-carts-coupons(
#        cart_id => ''
#    )
#    ==> my $t3_results;
#    is True, True, 'guest carts-coupons delete';
#
#}, 'Guest carts-coupons';
#
#subtest {
#
#    # POST   /V1/guest-carts/:cartId/estimate-shipping-methods
#    my %t1_data = Quote::guest-carts-estimate-shipping-methods();
#
#    %config
#    ==> guest-carts-estimate-shipping-methods(
#        cart_id => '',
#        data   => %t1_data
#    )
#    ==> my $t1_results;
#    is True, True, 'guest carts-estimate-shipping-methods new';
#
#}, 'Guest carts-estimate-shipping-methods';
#
#subtest {
#
#    # DELETE /V1/guest-carts/:cartId/items/:itemId
#    %config
#    ==> guest-carts-items(
#        cart_id => '',
#    item_id => ''
#    )
#    ==> my $t4_results;
#    is True, True, 'guest carts-items delete';
#
#}, 'Guest carts-items';
#
#subtest {
#
#    # PUT    /V1/guest-carts/:cartId/order
#    my %t1_data = Quote::guest-carts-order();
#
#    %config
#    ==> guest-carts-order(
#        cart_id => '',
#        data   => %t1_data
#    )
#    ==> my $t1_results;
#    is True, True, 'guest carts-order update';
#
#}, 'Guest carts-order';

}, 'Guest carts';

subtest {
    
    # DELETE /V1/carts/:cartId/items/:itemId
    %config
    ==> carts-items-delete(
        cart_id => $cart_id,
        item_id => $cart_item_id
    )
    ==> my $cart_results;
    is $cart_results, True, 'carts items delete';

}, 'Cleanup';

done-testing;
