use v6;

use Test;
use lib 'lib', 'xt'.IO.child('lib');
use Magento::Catalog;
use Magento::Config;
use Products;

plan 6;

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

subtest {

    plan 5;

    %config ==> products-attributes-types() ==> my @t1_results;
    is @t1_results.elems > 0, True, 'products attributes types';

    %config ==> products-attributes() ==> my %t2_results;
    is %t2_results<items>.defined, True, 'products attributes all';

    %config ==> products-attributes(attribute_code => 'name') ==> my %t3_results;
    is %t3_results<default_frontend_label>, 'Product Name', 'products attributes by attribute_code';

    my %t4_data = Products::product-attribute();
    %config ==> products-attributes(data => %t4_data) ==> my %t4_results;
    is %t4_results<default_frontend_label>, 'delete_me', 'products attributes new';

    # This fails with 'Attribute with the same code'. Revisit.
    #my %t5_data = Products::product-attribute-modified();
    #%config ==> products-attributes(attribute_code => 'deleteme', data => %t5_data) ==> my %t5_results;
    #is %t5_results<default_frontend_label>, 'delete_me', 'products attributes modified';

    %config ==> products-attributes-delete(attribute_code => 'deleteme') ==> my $t6_results;
    is $t6_results, True, 'products attributes delete';

}, 'Product attributes';

subtest {

    plan 3;

    %config ==> categories-attributes(attribute_code => 'name') ==> my %t1_results;
    is %t1_results<default_frontend_label>, 'Name', 'categories attributes by attribute code';

    %config ==> categories-attributes() ==> my @t2_results;
    is @t2_results.elems > 0, True, 'categories attributes all';

    %config ==> categories-attributes-options(attribute_code => 'display_mode') ==> my @t3_results;
    is @t3_results.elems > 0, True, 'categories attributes options all ';

}, 'Category attributes';

subtest {
    plan 8;

    %config ==> products-attribute-sets() ==> my %t1_results;
    is %t1_results<items>.head<attribute_set_name>, 'Default', 'products attribute sets all';

    my %t2_data = Products::products-attribute-set();
    %config ==> products-attribute-sets(data => %t2_data) ==> my %t2_results;
    is %t2_results<attribute_set_name>, 'DeleteMe', 'products attribute sets new';
    my $t2_attribute_set_id = %t2_results<attribute_set_id>;

    %config ==> products-attribute-sets(attribute_set_id => $t2_attribute_set_id) ==> my %t3_results;
    is %t3_results<attribute_set_name>, 'DeleteMe', 'products attribute sets by attribute set id';

    my %t4_data = Products::products-attribute-set-modified();
    %config ==> products-attribute-sets(attribute_set_id => $t2_attribute_set_id, data => %t4_data) ==> my %t4_results;
    is %t4_results<attribute_set_name>, 'DeleteMeModified', 'products attribute sets modified';

    # 
    # Attribute sets
    #

    my %t6_attribute = Products::product-attribute();
    %config ==> products-attributes(data => %t6_attribute);

    %config ==> products-attribute-sets-attributes(attribute_set_id => $t2_attribute_set_id) ==> my @t5_results;
    is @t5_results.head<attribute_code> , 'gift_message_available', 'products attribute sets attributes all';

    my %t6_search_criteria = %{
        searchCriteria => %{
            filterGroups => [
                {
                    filters => [
                        {
                            field => 'attribute_set_id',
                            value => $t2_attribute_set_id,
                            condition_type =>  'eq'
                        },
                    ]
                },
            ],
        }
    }

    %config
    ==> products-attribute-groups(search_criteria => %t6_search_criteria)
    ==> my %t6_attribute_groups;

    my %t6_data = %{
        attributeSetId   => $t2_attribute_set_id,
        attributeGroupId => %t6_attribute_groups<items>.head<attribute_group_id>,
        attributeCode    => 'deleteme',
        sortOrder        => 0
    }

    %config ==> products-attribute-sets-attributes(data => %t6_data) ==> my $t6_results;
    is $t6_results.Int > 0, True, 'products attribute sets attributes assign new';

    %config
    ==> products-attribute-sets-attributes-delete(
        attribute_set_id => $t2_attribute_set_id,
        attribute_code => 'deleteme')
    ==> my $t7_results;
    is $t7_results, True, 'products attribute sets attributes delete';

    # Clean up
    %config ==> products-attributes-delete(attribute_code => 'deleteme');

    %config ==> products-attribute-sets-delete(attribute_set_id => $t2_attribute_set_id) ==> my $fin_results;
    is $fin_results, True, 'products attribute sets delete';

}, 'Product attribute sets';

subtest {
    plan 4;

    my %t1_search_criteria = %{
        searchCriteria => %{
            filterGroups => [
                {
                    filters => [
                        {
                            field => 'attribute_set_id',
                            value => 4,
                            condition_type => 'eq'
                        },
                    ]
                },
            ],
        }
    }

    %config ==> products-attribute-groups(search_criteria => %t1_search_criteria) ==> my %t1_results;
    is %t1_results<items>.head<attribute_group_name>, 'Product Details', 'products attributes groups all';

    my %t2_data = Products::products-attribute-group();
    %config ==> products-attribute-groups(data => %t2_data) ==> my %t2_results;
    is %t2_results<attribute_group_name>, 'Delete Me', 'products attributes groups new';
    my $t2_group_id = %t2_results<attribute_group_id>;

    my %t3_data = Products::products-attribute-group-save();
    %config ==> products-attribute-groups(attribute_set_id => 4, data => %t3_data) ==> my %t3_results;
    is %t3_results<attribute_group_name>, 'Delete Me Too', 'products attributes groups modified';
    my $t3_group_id = %t3_results<attribute_group_id>;

    %config ==> products-attribute-groups-delete(group_id => $t2_group_id.Int) ==> my $fin_result;
    %config ==> products-attribute-groups-delete(group_id => $t3_group_id.Int);
    is $fin_result, True, 'products attributes groups delete';

}, 'Product attribute groups';

subtest {

    plan 3;

    # Get options
    %config ==> products-attributes-options(attribute_code => 'shipment_type') ==> my @t1_results;
    is @t1_results.head<label>, 'Together', 'products attributes options get by attribute code';

    my %t2_attribute = Products::product-attribute();
    %config ==> products-attributes(data => %t2_attribute) ==> my %t2_attribute_results;

    # New
    my %t2_data = Products::products-attributes-option();
    %config ==> products-attributes-options(attribute_code => 'deleteme', data => %t2_data) ==> my $t2_results;
    is $t2_results, True, 'products attributes options new';

    # Create temporary attribute
    %config ==> products-attributes(attribute_code => 'deleteme') ==> %t2_attribute;
    my $t2_option_id = %t2_attribute<options>.grep({$_<label> ~~ 'Delete Me'}).head<value>.Int;

    # Delete
    %config ==> products-attributes-options-delete(attribute_code => 'deleteme', option_id => $t2_option_id) ==> my $t3_results;
    is $t3_results, True, 'product attributes options delete';

    # Cleanup temporary attribute
    %config ==> products-attributes-delete(attribute_code => 'deleteme');
}, 'Product attribute options';
