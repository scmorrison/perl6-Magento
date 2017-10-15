use v6;

# These tests are meant to run against
# live development system. Do not run
# this against a production system.

use Test;
use lib 'lib', 'xt'.IO.child('lib');

use Magento::Config;
use Magento::Checkout;
use Checkout;

my %config = Magento::Config::from-file config_file => $*HOME.child('.6mag-testing').child('config.yml');


subtest {

    # POST   /V1/carts/mine/payment-information
    my %t1_data = Checkout::carts-mine-payment-information();

    my $t1_results =
        carts-mine-payment-information 
            %config,
            data => %t1_data;
    is True, True, 'carts mine-payment-information new';

    # GET    /V1/carts/mine/payment-information
    my $t2_results =
        carts-mine-payment-information %config;
    is True, True, 'carts mine-payment-information all';

}, 'Carts mine-payment-information';

subtest {

    # POST   /V1/carts/mine/set-payment-information<Paste>
    my %t1_data = Checkout::carts-mine-set-payment-information();

    my $t1_results =
        carts-mine-set-payment-information
            %config,
            data => %t1_data;
    is True, True, 'carts mine-set-payment-information new';

}, 'Carts mine-set-payment-information<paste>';

subtest {

    # POST   /V1/carts/mine/shipping-information
    my %t1_data = Checkout::carts-mine-shipping-information();

    my $t1_results =
        carts-mine-shipping-information 
            %config,
            data => %t1_data;
    is True, True, 'carts mine-shipping-information new';

}, 'Carts mine-shipping-information';

subtest {

    # POST   /V1/carts/mine/totals-information
    my %t1_data = Checkout::carts-mine-totals-information();

    my $t1_results =
        carts-mine-totals-information 
            %config,
            data => %t1_data;
    is True, True, 'carts mine-totals-information new';

}, 'Carts mine-totals-information';

subtest {

    # POST   /V1/carts/:cartId/shipping-information
    my %t1_data = Checkout::carts-shipping-information();

    my $t1_results =
        carts-shipping-information 
            %config,
            cart_id => '',
        data   => %t1_data;
    is True, True, 'carts shipping-information new';

}, 'Carts shipping-information';

subtest {

    # POST   /V1/carts/:cartId/totals-information
    my %t1_data = Checkout::carts-totals-information();

    my $t1_results =
        carts-totals-information 
            %config,
            cart_id => '',
        data   => %t1_data;
    is True, True, 'carts totals-information new';

}, 'Carts totals-information';

subtest {

    # POST   /V1/guest-carts/:cartId/payment-information
    my %t1_data = Checkout::guest-carts-payment-information();

    my $t1_results =
        guest-carts-payment-information 
            %config,
            cart_id => '',
        data   => %t1_data;
    is True, True, 'guest carts-payment-information new';

    # GET    /V1/guest-carts/:cartId/payment-information
    my $t2_results =
        guest-carts-payment-information 
            %config,
            cart_id => '';
    is True, True, 'guest carts-payment-information by id';

}, 'Guest carts-payment-information';

subtest {

    # POST   /V1/guest-carts/:cartId/set-payment-information
    my %t1_data = Checkout::guest-carts-set-payment-information();

    my $t1_results =
        guest-carts-set-payment-information 
            %config,
            cart_id => '',
        data   => %t1_data;
    is True, True, 'guest carts-set-payment-information new';

}, 'Guest carts-set-payment-information';

subtest {

    # POST   /V1/guest-carts/:cartId/shipping-information
    my %t1_data = Checkout::guest-carts-shipping-information();

    my $t1_results =
        guest-carts-shipping-information 
            %config,
            cart_id => '',
        data   => %t1_data;
    is True, True, 'guest carts-shipping-information new';

}, 'Guest carts-shipping-information';

subtest {

    # POST   /V1/guest-carts/:cartId/totals-information
    my %t1_data = Checkout::guest-carts-totals-information();

    my $t1_results =
        guest-carts-totals-information 
            %config,
            cart_id => '',
        data   => %t1_data;
    is True, True, 'guest carts-totals-information new';

}, 'Guest carts-totals-information';

done-testing;
