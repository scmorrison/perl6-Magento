use v6;

# These tests are meant to run against
# live development system. Do not run
# this against a production system.

use Test;
use lib 'lib', 'xt'.IO.child('lib');

use Magento::Config;
use Magento::Search;

my %config = Magento::Config::from-file config_file => $*HOME.child('.6mag-testing').child('config.yml');


subtest {

    my %t1_search_criteria = %{
        searchCriteria => %{
            filterGroups => [
                {
                    filters => [
                        {
                            field => 'search_term',
                            value => 'Color',
                            condition_type => 'like'
                        },
                    ]
                },
            ],
            requestName => 'quick_search_container' # quick_search_container, advanced_search_container, catalog_view_container
        },
    }

    # GET    /V1/search
    my $t1_results =
        search 
            %config,
            search_criteria => %t1_search_criteria;
    is $t1_results<aggregations><buckets> ~~ Array, True, 'search all';

}, 'Search';

done-testing;