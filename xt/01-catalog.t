use v6;

use Test;
use lib 'lib', 'xt'.IO.child('lib');
use Magento::Catalog;
use Magento::Config;
use Products;

plan 1;

my %config = Magento::Config::from-file config_file => $*HOME.child('.6mag-testing').child('config.yml');

subtest {
    plan 8;

    my %t1_data = Products::downloadable();
    %config ==> products(data => %t1_data) ==> my %t1_results;
    is %t1_results<name>, 'Downloadable Product Test', 'products new';
    my $t1_product_id  = %t1_results<id>;
    my $t1_product_sku = %t1_results<sku>;

    my %t2_data = Products::simple();
    %config ==> products(data => %t2_data) ==> my %t2_results;
    is %t2_results<name>, 'Simple Product Test', 'products new [linked]';
    my $t2_product_id  = %t2_results<id>;
    my $t2_product_sku = %t2_results<sku>;

    my %t3_data = Products::bundle();
    %config ==> products(data => %t3_data) ==> my %t3_results;
    is %t3_results<name>, 'Bundle Product Test', 'products new [bundle]';
    my $t3_product_id  = %t3_results<id>;
    my $t3_product_sku = %t3_results<sku>;

    my %t4_data = Products::configurable();
    %config ==> products(data => %t4_data) ==> my %t4_results;
    is %t4_results<name>, 'Configurable Product Test', 'products new [configurable]';
    my $t4_product_id  = %t4_results<id>;
    my $t4_product_sku = %t4_results<sku>;

    my %t5_data = Products::downloadable-modified();
    %config ==> products(sku => 'P6-TEST-0001', data => %t5_data) ==> my %t5_results;
    is %t5_results<name>, 'Downloadable Product Test [modified]', 'products update';

    # Create short-lived product
    my %delete_me = Products::delete-me();
    %config ==> products(data => %delete_me);

    %config ==> products(sku => 'P6-TEST-DELETE') ==> my %t6_results;
    is %t6_results<name>, 'Deletable Product', 'products by sku';

    %config ==> products-delete(sku => 'P6-TEST-DELETE') ==> my $t7_results;
    is $t7_results, True, 'products delete';

    %config ==> products() ==> my %t8_results;
    is %t8_results<items>.elems > 0, True, 'products get all';

}, 'Products';
