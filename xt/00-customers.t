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
    plan 4;

    my %t1_data = group => %{ 
        code          => 'TestCustomerGroup',
        taxClassId    => 3,
        taxClassName  => 'Retail Customer'
    }
  
    %config ==> customer-groups-new(data => %t1_data) ==> my %t1_results;

    is %t1_results<code>, 'TestCustomerGroup', 'customer groups new [code]';
    is %t1_results<tax_class_id>, 3, 'customer groups new [tax_class_id]';
    is %t1_results<tax_class_name>, 'Retail Customer', 'customer groups new [tax_class_name]';

    my $t2_customer_group_id = %t1_results<id>;
    %config ==> customer-groups-delete(id => $t2_customer_group_id) ==> my $t2_results;
    is $t2_results, True, 'customer groups delete';

}, 'Customer groups';
