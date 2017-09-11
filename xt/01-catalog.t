use v6;

use Test;
use Base64;
use lib 'lib';
use Magento::Catalog;
use Magento::Config;

plan 1;

my %config = Magento::Config::from-file config_file => $*HOME.child('.6mag-testing').child('config.yml');

subtest {
    plan 2;

    # configurableProductOptions => [
        #  %{
#              attributeId   => 'P6-Magento-Color',
#              label         => 'Colors',
#              position      => 0,
#              isUseDefault  => 'true',
#              values => [
#                %{
#                  valueIndex => 0
#                }
#              ]
#            }
#          ],
#          "configurableProductLinks": [
#            0
#          ],

    my %t1_data = product => %{
        sku            => 'P6-TEST-0001',
        name           => 'Perl 6 Magento Module',
        typeId         => 'downloadable',
        attributeSetId => 4,
        price          => 19.95,
        status         => 1,
        visibility     => 1,
        weight         => 1.5,
        extensionAttributes => %{
          downloadableProductLinks => [
            %{
              title             => 'Downloadable Test',
              sortOrder         => 0,
              isShareable       => 1,
              price             => 4.99,
              numberOfDownloads => 100,
              linkType          => 'file',
              linkFile          => 'xt'.IO.child('assets').child('link-file.gif').path,
              sampleFileContent => %{
                fileData => encode-base64(slurp('xt'.IO.child('assets').child('sample-file.png'), :bin), :str),
                name     => 'sample-file.png'
              },
            },
          ],
          downloadableProductSamples => [
            %{
              title      => 'Downloadable Product Sample Test',
              sortOrder  => 0,
              sampleType => 'url',
              sampleUrl  => 'https://raw.githubusercontent.com/scmorrison/perl6-Magento/master/xt/assets/downloadable-sample-file.gif'
            },
          ],
          stockItem => %{
            qty                      => 100,
            isInStock                => 'true',
            isQtyDecimal             => 'true',
            useConfigMinQty          => 'true',
            minQty                   => 10,
            useConfigMinSaleQty      => 1,
            minSaleQty               => 1,
            useConfigMaxSaleQty      => 'true',
            maxSaleQty               => 5,
            useConfigBackorders      => 'true',
            backorders               => 0,
            useConfigNotifyStockQty  => 'true',
            notifyStockQty           => 0,
            useConfigQtyIncrements   => 'true',
            qtyIncrements            => 0,
            useConfigEnableQtyInc    => 'true',
            enableQtyIncrements      => 'true',
            useConfigManageStock     => 'true',
            manageStock              => 'true'
          },
#          "bundleProductOptions": [
#            {
#              "optionId": 0,
#              "title": "string",
#              "required": true,
#              "type": "string",
#              "position": 0,
#              "sku": "string",
#              "productLinks": [
#                {
#                  "id": "string",
#                  "sku": "string",
#                  "optionId": 0,
#                  "qty": 0,
#                  "position": 0,
#                  "isDefault": true,
#                  "price": 0,
#                  "priceType": 0,
#                  "canChangeQuantity": 0,
#                  "extensionAttributes": {}
#                }
#              ],
#              "extensionAttributes": {}
#            }
#          ]
        },
#        "productLinks": [
#          {
#            "sku": "string",
#            "linkType": "string",
#            "linkedProductSku": "string",
#            "linkedProductType": "string",
#            "position": 0,
#            "extensionAttributes": {
#              "qty": 0
#            }
#          }
#        ],
        options => [
            %(
                productSku    => 'P6-TEST-0001',
                title         => 'Color',
                type          => 'multiple',
                sortOrder     =>  0,
                isRequire     => 'true',
                values => [
                  %{
                    title       => 'Green',
                    sortOrder   =>  0,
                    price       =>  0,
                    priceType   => 'fixed'
                  },
                  %{
                    title       => 'Blue',
                    sortOrder   =>  1,
                    price       =>  0,
                    priceType   => 'fixed'
                  },
                  %{
                    title       => 'Gold',
                    sortOrder   =>  2,
                    price       =>  10.00,
                    priceType   => 'fixed'
                  }
                ]
            ),
        ],
        mediaGalleryEntries => [
            %{
                mediaType  => 'image',
                label      => 'Media File',
                position   => 0,
                disabled   => 'false',
                content => %{
                  base64EncodedData => encode-base64(slurp('xt'.IO.child('assets').child('media-file.png'), :bin), :str),
                  type => 'image/png',
                  name => 'sample-file.png'
                },
            },
        ],
        tierPrices => [
          %{
            customerGroupId => 1,
            qty             => 10,
            value           => 5.00
           }
        ]
    }

    %config ==> products(data => %t1_data) ==> my %t1_results;
    is %t1_results<name>, 'Perl 6 Magento Module', 'products new';
    my $t1_product_id  = %t1_results<id>;
    my $t1_product_sku = %t1_results<sku>;

    %config ==> products() ==> my %t2_results;
    is %t2_results<items>.elems > 0, True, 'products get all';

}, 'Products';
