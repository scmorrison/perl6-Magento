use v6;

# These tests are meant to run against
# live development system. Do not run
# this against a production system.

use Test;
use lib 'lib';

use Magento::Config;
use Magento::Customers;

plan 1;

my %config = Magento::Config::from-file config_file => $*HOME.child('.6mag-testing').child('config.yml');

subtest {
    plan 10;

    my %t1_data = group => %{ 
        code          => 'TestCustomerGroup',
        taxClassId    => 3,
        taxClassName  => 'Retail Customer'
    }
  
    # Customer Groups New
    %config ==> customer-groups-new(data => %t1_data) ==> my %t1_results;

    is %t1_results<code>, 'TestCustomerGroup', 'customer groups new [code]';
    is %t1_results<tax_class_id>, 3, 'customer groups new [tax_class_id]';
    is %t1_results<tax_class_name>, 'Retail Customer', 'customer groups new [tax_class_name]';
    my $t1_customer_group_id = %t1_results<id>;

    # Customer Group by ID
    %config ==> customer-groups(id => $t1_customer_group_id) ==> my %t2_results;
    is %t2_results<code>, 'TestCustomerGroup', 'customer groups by id [code]';
    is %t2_results<tax_class_id>, 3, 'customer groups by id [tax_class_id]';
    is %t2_results<tax_class_name>, 'Retail Customer', 'customer groups by id [tax_class_name]';

    # Customer Group store default
    %config ==> customer-groups-default(store_id => 1) ==> my %t3_results;
    is %t3_results<code>, 'General', 'customer groups store default [code]';
    is %t3_results<tax_class_id>, 3, 'customer groups store default [tax_class_id]';
    is %t3_results<tax_class_name>, 'Retail Customer', 'customer groups store default [tax_class_name]';

    # Customer Group Delete
    %config ==> customer-groups-delete(id => $t1_customer_group_id) ==> my $t4_results;
    is $t4_results, True, 'customer groups delete';

}, 'Customer groups';
