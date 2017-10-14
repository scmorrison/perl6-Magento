use v6;

# These tests are meant to run against
# live development system. Do not run
# this against a production system.

use Test;
use lib 'lib', 'xt'.IO.child('lib');

use Magento::Config;
use Magento::Integration;

my %config = Magento::Config::from-file config_file => $*HOME.child('.6mag-testing').child('config.yml');
my $password = 'fakeMagent0P6';

subtest {

    # POST   /V1/integration/customer/token
    my %credentials = %{
        username => 'p6magento@fakeemail.com',
        password => $password
    }

    my $t1_results =
        integration-token 
            %{ host => %config<host> },
            user_type => 'customer',
            data      => %credentials;
    is $t1_results.chars, 32, 'integration admin token new';

}, 'Integration customer token';

subtest {

    # POST   /V1/integration/admin/token
    my %credentials = %{
        username => 'admin',
        password => $password
    }

    my $t1_results =
        integration-token 
            %{ host => %config<host> },
            user_type => 'admin',
            data      => %credentials;
    is $t1_results.chars, 32, 'integration admin token new';

}, 'Integration admin token';

done-testing;
