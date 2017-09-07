Magento [![build status](https://travis-ci.org/scmorrison/perl6-Magento.svg?branch=master)](https://travis-ci.org/scmorrison/perl6-Magento)
===

Perl 6 Magento 2 API client module.

- [Features](#features)
* [Getting started](#getting-started)
- [CLI usage](#cli-usage)
- [Config](#config)
  * [Config variables](#config-variables)
- [Installation](#installation)
- [Todo](#todo)
- [Requirements](#requirements)
- [Troubleshooting](#troubleshooting)
- [Authors](#authors)
- [License](#license)
- [See also](#see-also)

Features
========
* **Magento 2 compatable**: Works with the latest Magento 2 API
* **Integration token support**: Can utilize Integration tokens for authentication
* **Admin & Customer token support**: Supports username / password authentication for access token generation
* **Use Perl 6 hash for search critera**: Write complex search criteria queries as Perl 6 Hash

Getting started
===============

For long-use Integration Access Token usage use the `6mag init` command:

```
6mag init
```

Enter your Magento installation base URL (e.g. https://my.magento), store identifier (e.g. default), and Integration Access Token (generated in Magento > System > Integrations).

By default this will generate the file `~/.6mag/config.yml`:

```yaml
---
host: "https://my.magento"
store: default
access_token: ********************************
```
Module Usage
============

Using long-use Integration Access Token from `~/.6mag/config.yml`:

```perl
use Magento::Config;
use Magento::Customers;

my %config = Magento::Config::from-file;

#GET    /V1/customers/:customerId
%config ==> customers(id => 1) ==> say();
```

Using pre-generated Access Token without `~/.6mag/config.yml`:

```perl
use Magento::Customers;

my $host   = 'http://localhost';
my %config = %(
    host         => $host,
    access_token => '********************************',
    store        => 'default'
);

#GET    /V1/customers/:customerId
%config ==> customers(id => 1) ==> say();
```

Using password authentication as Admin:

```perl
use Magento::Auth;
use Magento::Customers;

my $host   = 'http://localhost';
my %config = %(
    host         => $host,
    access_token => request-access-token(username => 'admin', password => '****', :$host),
    store        => 'default'
);

#GET    /V1/customers/:customerId
%config ==> customers(id => 1) ==> say();
```

Using password authentication as Customer:

```perl
use Magento::Auth;
use Magento::Customers;

my $host         = 'http://localhost';
my $access_token = 
    request-access-token(
        :$host,
        username  => 'customer@emailaddy.magento',
        password  => '****',
        user_type => 'customer');

my %config = %(:$host, :$access_key, store => 'default');

#GET    /V1/customers/me
%config ==> customers-me() ==> say();
```

### Search criteria

Use a `Perl 6` Hash to define search criteria:

```perl
use Magento::Config;
use Magento::Customers;

my %config = Magento::Config::from-file;

my %customer_search_criteria = %{
    searchCriteria => %( 
        filterGroups => [
            {
                filters => [
                    {
                        field => 'email',
                        value => 'customer@myemail.somewhere',
                        condition_type => 'eq'
                    },
                ]
            },
        ],
        current_page => 1,
        page_size    => 10
    )
}

# Do a customer search using the search criteria hash
%config
==> customers-search(search_criteria => %customer_search_criteria)
==> say();
```


CLI Usage
=====

```
Usage:
  6mag init         - Generate Integration token based config
  6mag print-config - Print Integration token config
  6mag version      - Print 6mag version and exit

Optional arguments:
  
  --config=         - Specify a custom config file location
                      Default is `~/.6mag/config.yml`

  e.g. 6mag --config=path/to/config.yml init 
```

Config
======

Each project has its own `config.yml` which uses the following format:

```yaml
---
host: "https://my.magento"
store: default
access_token: ********************************
```

### Config variables

Config variables are defined in `config.yml`:

* `host`: Magento base URL
* `store`: Store identifier (e.g. default)
* `access_token`: Magento access token. For long-use configurations, integrations, use an Integration Access Token.

Installation
============

```
git clone https://github.com/scmorrison/perl6-Magento.git
cd perl6-Magento/
zef install .
```
Installation issue? See [Troubleshooting](#troubleshooting).

Todo
====

* More tests
* More API endpoints

Requirements
============

* [Perl 6](http://perl6.org/)

Troubleshooting
===============

* **Errors installing from previous version:**
  
  Remove the zef tmp / store perl6-Magento.git directories:

  ```
  # Delete these folders from your zef install 
  # directory.
  rm -rf ~/.zef/store/perl6-Magento.git ~/.zef/tmp/perl6-Magento.git 
  ```

  In some instances it might help to delete your local `~/.perl6/precomp` directory. 

Authors
=======

* [Sam Morrison](@samcns)

License
=======

This Perl 6 Magento module is free software; you can redistribute it and/or modify it under the terms of the Artistic License 2.0. (Note that, unlike the Artistic License 1.0, version 2.0 is GPL compatible by itself, hence there is no benefit to having an Artistic 2.0 / GPL disjunction.) See the file LICENSE for details.

See also
========

* [Magento](https://magento.com/)
