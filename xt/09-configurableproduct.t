use v6;

# These tests are meant to run against
# live development system. Do not run
# this against a production system.

use Test;
use lib 'lib', 'xt'.IO.child('lib');

use Magento::Config;
use Magento::ConfigurableProduct;
use Magento::Catalog;
use ConfigurableProduct;

my %config       = Magento::Config::from-file config_file => $*HOME.child('.6mag-testing').child('config.yml');
my $configurable = products %config, data => %( ConfigurableProduct::configurable() );
my $simple       = products %config, data => %( ConfigurableProduct::simple() );
my $option_id;

subtest {

    # POST   /V1/configurable-products/:sku/child
    my $t1_results =
        configurable-products-child 
            %config,
            sku  => 'P6-CONFIGURABLE-0001',
            data => %{ childSku => 'P6-SIMPLE-0001' };
            note $t1_results;
    is True, True, 'configurable products-child new';

}, 'Configurable products-child';

subtest {

    # GET    /V1/configurable-products/:sku/children
    my $t1_results =
        configurable-products-children 
            %config,
            sku => 'P6-CONFIGURABLE-0001';
    is $t1_results.head<sku>, 'P6-SIMPLE-0001', 'configurable products-children all';

    # DELETE /V1/configurable-products/:sku/children/:childSku
    my $t2_results =
        configurable-products-children-delete 
            %config,
            sku       => 'P6-CONFIGURABLE-0001',
            child_sku => 'P6-SIMPLE-0001';
    is $t2_results, True, 'configurable products-children delete';

}, 'Configurable products-children';


subtest {

    # GET    /V1/configurable-products/:sku/options/all
    my $t1_results =
        configurable-products-options-all 
            %config,
            sku => 'P6-CONFIGURABLE-0001';
    is $t1_results.head<label>, 'Color', 'configurable products-options-all all';
    $option_id = $t1_results.head<id>;

}, 'Configurable products-options-all';

subtest {

    # GET    /V1/configurable-products/:sku/options/:id
    my $t1_results =
        configurable-products-options 
            %config,
            sku => 'P6-CONFIGURABLE-0001',
            id  => $option_id;
    is $t1_results<label>, 'Color', 'configurable products-options by id';

#    revisit: This works the first time, but creates a broken product if run
#    a second time:
#     
#    https://github.com/magento/magento2/issues/9798
#
#    # POST   /V1/configurable-products/:sku/options
#    my %t2_data = ConfigurableProduct::configurable-products-options();
#
#    my $t2_results =
#        configurable-products-options 
#            %config,
#            sku  => 'P6-CONFIGURABLE-0001',
#            data => %t2_data;
#            note $t2_results;
#    is $t2_results ~~ Int, True, 'configurable products-options new';

    # PUT    /V1/configurable-products/:sku/options/:id
    my %t3_data = ConfigurableProduct::configurable-products-options-update();

    my $t3_results =
        configurable-products-options 
            %config,
            sku  => 'P6-CONFIGURABLE-0001',
            id   => $option_id,
            data => %t3_data;
            note $t3_results;
    is $t3_results ~~ Int, True, 'configurable products-options update';

    # DELETE /V1/configurable-products/:sku/options/:id
    my $t4_results =
        configurable-products-options-delete 
            %config,
            sku => 'P6-CONFIGURABLE-0001',
            id => $option_id;
    is $t4_results, True, 'configurable products-options delete';

}, 'Configurable products-options';

subtest {

    # PUT    /V1/configurable-products/variation
    my %t1_data = ConfigurableProduct::configurable-products-variation();

    # revisit with valid variation data
    my $t1_results =
        configurable-products-variation 
            %config,
            data => %t1_data;
    is $t1_results, False, 'configurable products-variation update';

}, 'Configurable products-variation';

# Cleanup
products-delete %config, sku => 'P6-CONFIGURABLE-0001';

done-testing;
