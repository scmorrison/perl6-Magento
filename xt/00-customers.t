use v6;

# These tests are meant to run against
# live development system. Do not run
# this against a production system.

use Test;
use lib 'lib';

use Magento::Config;
use Magento::Customer;
use Magento::Store;

plan 3;

my %config = Magento::Config::from-file config_file => $*HOME.child('.6mag-testing').child('config.yml');

subtest {
    plan 12;

    my %t1_data = group => %{ 
        code          => 'TestCustomerGroup',
        taxClassId    => 3,
        taxClassName  => 'Retail Customer'
    }
  
    # Customer Groups New
    %config ==> customer-groups(data => %t1_data) ==> my %t1_results;
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

    my %t4_data = group => %{ 
        code => 'TestCustomerGroupModded',
        taxClassId    => 3,
        taxClassName  => 'Retail Customer'
    }

    # Customer Groups update 
    %config ==> customer-groups(id => $t1_customer_group_id, data => %t4_data) ==> my %t4_results;
    is %t4_results<code>, 'TestCustomerGroupModded', 'customer groups update [code]';

    my %t5_search_criteria = %{
        searchCriteria => %{
            filterGroups => [
                {
                    filters => [
                        {
                            field => 'code',
                            value => '%TestCustomerGroup%',
                            condition_type =>  'like'
                        },
                    ]
                },
            ],
            current_page => 1,
            page_size    => 10
        }
    }
    # Customer Groups search
    %config ==> customer-groups-search(search_criteria => %t5_search_criteria) ==> my %t5_results;
    is %t5_results<items>.head<code>, 'TestCustomerGroupModded', 'customer groups search [code]';

    # Customer Group Delete
    %config ==> customer-groups-delete(id => $t1_customer_group_id) ==> my $fin_results;
    is $fin_results, True, 'customer groups delete';

}, 'Customer groups';

subtest {
    plan 8;

    # Customer Metadata all
    %config ==> customer-metadata() ==> my @t1_results;
    is @t1_results.head<attribute_code>, 'website_id', 'customer metadata all';

    # Customer Metadata attribute
    %config ==> customer-metadata-attribute(attribute_code => 'website_id') ==> my %t2_results;
    is %t2_results<frontend_label>, 'Associate to Website', 'customer metadata attribute';

    # Customer Metadata form
    %config ==> customer-metadata-form(form_code => 'adminhtml_customer') ==> my @t3_results;
    is @t3_results.head<attribute_code>, 'created_at', 'customer metadata form';

    # Customer Metadata custom
    %config ==> customer-metadata-custom() ==> my @t4_results;
    is @t4_results, (), 'customer metadata custom';

    # Customer Metadata address attribute
    %config ==> customer-address-attribute(attribute_code => 'postcode') ==> my %t5_results;
    is %t5_results<store_label>, 'Zip/Postal Code', 'customer metadata address attribute';

    # Customer Metadata address form
    %config ==> customer-address-form(form_code => 'customer_register_address') ==> my @t6_results;
    is @t6_results.head<store_label>, 'Prefix', 'customer metadata address form';

    # Customer Metadata address
    %config ==> customer-address() ==> my @t7_results;
    is @t7_results.head<store_label>, 'Prefix', 'customer metadata address';

    # Customer Metadata address custom
    %config ==> customer-address-custom() ==> my @t8_results;
    is @t8_results, (), 'customer metadata address custom';


}, 'Customer metadata';

subtest {
    plan 16;

    my %t1_data = %{
        customer => %{
            email      => 'camelia@p6magentofakemail.com',
            firstname  => 'Camelia',
            lastname   => 'Butterfly',
            middlename => 'Perl 6'
        }
    }

    # Customer new
    %config ==> customers(data => %t1_data) ==> my %t1_results;
    is %t1_results<firstname>, 'Camelia', 'customer new [firstname]';
    is %t1_results<lastname>, 'Butterfly', 'customer new [lastname]';
    is %t1_results<created_in>, 'Default Store View', 'customer new [created_in]';
    my $t1_customer_id = %t1_results<id>;

    my %t2_data = %{
        customer => %{
            email      => 'camelia1@p6magentofakemail.com',
            firstname  => 'Camelia',
            lastname   => 'Butterfly',
            middlename => 'Perl 6!!!!',
            websiteId  => 1 
        }
    }

    # Customer update
    %config ==> customers(id => $t1_customer_id, data => %t2_data) ==> my %t2_results;
    is %t2_results<firstname>, 'Camelia', 'customer new [firstname]';
    is %t2_results<lastname>, 'Butterfly', 'customer new [lastname]';
    is %t2_results<middlename>, 'Perl 6!!!!', 'customer new [middlename]';

    my %t3_data = %{
        email      => 'camelia1@p6magentofakemail.com',
        websiteId  => 1
    }
    # Customer send verification email
    #
    # This will only work if Stores > Configuration > Customer Configuration 
    # > Create New Account Options > Require Emails Confirmation = Yes
    %config ==> customers-confirm(data => %t3_data) ==> my %t3_results;
    # This should return the following message:
    is %t3_results<message>, 'No confirmation needed.', 'customer confirm email';

    my %t4_search_criteria = %{
        searchCriteria => %{ 
            filterGroups => [
                {
                    filters => [
                        {
                            field => 'email',
                            value => 'camelia1@p6magentofakemail.com',
                            condition_type =>  'eq'
                        },
                    ]
                },
            ],
            current_page => 1,
            page_size    => 10
        }
    }

    # Customer search
    %config ==> customers-search(search_criteria => %t4_search_criteria) ==> my %t4_results;
    is %t4_results<items>.head<firstname>, 'Camelia', 'customer search [firstname]';
    is %t4_results<items>.head<lastname>, 'Butterfly', 'customer search [lastname]';

    my %t5_data = %{
        confirmationKey => 'aklsjdkljasdjklasdjklasjkldlkajsdjklasdlkj' 
    }
    # Customer email activate
    %config ==> customers-email-activate(email => 'camelia1@p6magentofakemail.com', data => %t5_data) ==> my %t5_results;
    is %t5_results<message>, 'Account already active', 'customer email activate';

    # Customer reset link token
    %config ==> customers-reset-link-token(id => $t1_customer_id, link_token => 'asdasdasd') ==> my %t6_results;
    is %t6_results<message>, 'Reset password token mismatch.', 'customer reset link token';

    my %t7_data = %{
        email      => 'camelia1@p6magentofakemail.com',
        template   => 'email_reset',
        websiteId  => 1
    }
    # Customer password
    #
    # This will only work if Stores > Configuration > Customer Configuration 
    # > Password Options > Max Number of Password Reset Requests = 0
    # and:
    # Stores > Configuration > Customer Configuration > Password Options
    # > Min Time Between Password Reset Requests = 0
    %config ==> customers-password(data => %t7_data) ==> my $t7_results;
    is $t7_results, True, 'customer password';

    # Customer confirm by id
    %config ==> customers-confirm(id => $t1_customer_id) ==> my $t8_results;
    is $t8_results, 'account_confirmed', 'customer confirm by id';

    my %t9_data = %{
        customer => %{
            email      => 'camelia1@p6magentofakemail.com',
            firstname  => 'Camelia',
            lastname   => 'Butterfly',
            middlename => 'Perl 6!!!!',
            websiteId  => 1,
            groupId    => 2
        }
    }
    # Customer validate
    %config ==> customers-validate(data => %t9_data) ==> my %t9_results;
    is %t9_results<valid>, True, 'customer validate';

    # Customer permissions read-only (Check if customer can be deleted)
    %config ==> customers-permissions(id => $t1_customer_id) ==> my $t10_results;
    is $t10_results, False, 'customer permissions read-only';

    # Customer delete
    %config ==> customers-delete(id => $t1_customer_id) ==> my $fin_results;
    is $fin_results, True, 'customer delete';

}, 'Customers';
