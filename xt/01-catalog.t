use v6;

use Test;
use lib 'lib', 'xt'.IO.child('lib');
use Magento::Catalog;
use Magento::Config;
use Products;

plan 12;

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

subtest {
    plan 5;

    my %t1_attribute_set = Products::products-attribute-set();
    %config ==> products-attribute-sets(data => %t1_attribute_set) ==> my %t1_attribute_set_results;
    my $t1_attribute_set_id = %t1_attribute_set_results<attribute_set_id>.Int;
    %config ==> products-media-types(attribute_set_name => 'DeleteMe') ==> my @t1_results;
    is @t1_results.head<attribute_code>, 'image', 'products media types all';

    %config ==> products-media(sku => 'P6-TEST-0001') ==> my @t2_results;
    like @t2_results.head<file>, /'sample-file'/, 'products media by sku';
    
    my %t3_data = Products::products-media();
    %config ==> products-media(sku => 'P6-TEST-0001', data => %t3_data) ==> my @t3_results;
    is @t3_results.elems, 1, 'products media new';
    my $t3_entry_id = @t3_results.head.Int;

    my %t4_data = Products::products-media(entry_id => $t3_entry_id);
    %config ==> products-media(sku => 'P6-TEST-0001', entry_id => $t3_entry_id, data => %t4_data) ==> my $t4_results;
    is $t4_results, True, 'products media modify';

    %config ==> products-media-delete(sku => 'P6-TEST-0001', entry_id => $t3_entry_id) ==> my $t5_results;
    is $t5_results, True, 'products media delete';

    # Cleanup temporary attribute set
    %config ==> products-attribute-sets-delete(attribute_set_id => $t1_attribute_set_id);

}, 'Product media';

subtest {
    plan 3;

    %config
    ==> products-tier-prices(
        sku               => 'P6-TEST-0001',
        customer_group_id => 1,
        qty               => 10,
        price             => 12.95)
    ==> my $t1_results;
    is $t1_results, True, 'products tier prices new';

    %config ==> products-tier-prices(sku => 'P6-TEST-0001', customer_group_id => 1) ==> my @t2_results;
    is @t2_results.head<value>, '12.95', 'products tier prices all';

    %config
    ==> products-tier-prices-delete(
        sku               => 'P6-TEST-0001',
        customer_group_id => 1,
        qty               => 10)
    ==> my $t3_results;
    is $t3_results, True, 'products group prices delete';

}, 'Product tier prices';

subtest {
    plan 6;

    %config ==> categories() ==> my %t1_results;
    is %t1_results<children_data>.head<name>, 'Default Category', 'categories all';

    %config ==> categories(category_id => 1) ==> my %t2_results;
    is %t2_results<name>, 'Root Catalog', 'categories by id';

    my %t3_data = Products::category();
    %config ==> categories(data => %t3_data) ==> my %t3_results;
    is %t3_results<name>, 'Delete Me', 'categories new';
    my $t3_category_id = %t3_results<id>;

    my %t4_data = category => %( |%t3_results, name => 'Delete Me Modified' );
    %config ==> categories(category_id => $t3_category_id, data => %t4_data) ==> my %t4_results;
    is %t4_results<name>, 'Delete Me Modified', 'categories update';

    my %t5_data = %{
        parentId => 1,
        afterId  => 1
    }
    %config ==> categories-move(category_id => $t3_category_id, data => %t5_data) ==> my $t5_results;
    is $t5_results, True, 'categories move';

    %config ==> categories-delete(category_id => $t3_category_id) ==> my $fin_results;
    is $fin_results, True, 'categories delete';

}, 'Categories';

subtest {
    plan 4;

    %config ==> products-options-types() ==> my @t1_results;
    is @t1_results.grep({$_<code> ~~ 'date'}).head<label>, 'Date', 'products custom options types';

    my %t2_data = Products::products-option();
    %config ==> products-custom-options(data => %t2_data) ==> my %t2_results;
    is %t2_results<title>, 'Delete Me', 'products custom options new';
    my $t2_option_id = %t2_results<option_id>.Int;

    %config ==> products-custom-options(sku => 'P6-TEST-0001') ==> my @t3_results;
    is @t3_results.grep({$_<title> ~~ 'Delete Me'}).head<type>, 'multiple', 'products custom options by sku';

    # Revisit: This is currently not working in Magento, updating a custom option creates a new option
    # https://github.com/magento/magento2/issues/5972
    #my %t4_data = option => %( |%t2_data<option>, isRequire => 'false' );
    #%config ==> products-custom-options(option_id => $t2_option_id, data => %t4_data) ==> my %t4_results;
    #is %t4_results<option_id>, $t2_option_id, 'products custom options update [optionId]';
    #is %t4_results<is_require>, 'False', 'products custom options update [isRequire]';

    %config ==> products-custom-options-delete(sku => 'P6-TEST-0001', option_id => $t2_option_id) ==> my $fin_results;
    is $fin_results, True, 'products custom options delete';
}, 'Product custom options';

subtest {
    plan 5;

    %config ==> products-links-types() ==> my @t1_results;
    is @t1_results.head<name>, 'related', 'products links types all';

    my %t2_data = Products::products-links();
    %config ==> products-links(sku => 'P6-TEST-0001', data => %t2_data) ==> my $t2_results;
    is $t2_results, True, 'products links new';

    %config ==> products-links(sku => 'P6-TEST-0001', type => 'related') ==> my @t3_results;
    is @t3_results.head<linked_product_sku>, 'P6-TEST-0002', 'products links by sku and type';

    my %t3_data = Products::products-links-update();
    %config ==> products-links-update(sku => 'P6-TEST-0001', data => %t3_data) ==> my $t3_results;
    is $t3_results, True, 'products links update';

    %config ==> products-links-delete(sku => 'P6-TEST-0001', type => 'related', linked_product_sku => 'P6-TEST-0002') ==> my $fin_results;
    is $fin_results, True, 'products links delete';

}, 'Product links';

subtest {
    plan 4;

    my %t1_data = Products::categories-products();
    %config ==> categories-products(category_id => 2, data => %t1_data) ==> my $t1_results;
    is $t1_results, True, 'categories products new';

    %config ==> categories-products(category_id => 2) ==> my @t2_results;
    is @t2_results.elems > 0, True, 'categories products all';

    my %t3_data = Products::categories-products();
    %config ==> categories-products-update(category_id => 2, data => %t3_data) ==> my $t3_results;
    is $t3_results, True, 'categories products update';

    %config ==> categories-products-delete(category_id => 2, sku => 'P6-TEST-0001') ==> my $t4_results;
    is $t4_results, True, 'categories products delete';

}, 'Categories products';
