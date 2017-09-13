use v6;
use Base64;

unit module Products;

our sub downloadable() {
    product => %{
        sku            => 'P6-TEST-0001',
        name           => 'Downloadable Product Test',
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
        },
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
                  base64EncodedData => encode-base64(slurp('xt'.IO.child('assets').child('sample-file.png'), :bin), :str),
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
}

our sub downloadable-modified() {
    product => %{
        sku            => 'P6-TEST-0001',
        name           => 'Downloadable Product Test [modified]'
    }
}

our sub simple() {
    product => %{
        sku            => 'P6-TEST-0002',
        name           => 'Simple Product Test',
        attributeSetId => 4,
        price          => 19.95,
        status         => 1,
        visibility     => 1,
        weight         => 1.5,
        extensionAttributes => %{
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
        },
        productLinks => [
            %{
                sku               => 'P6-TEST-0002',
                linkType          => 'related', # 'related', 'up_sell', 'cross_sell', 'grouped'
                linkedProductSku  => 'P6-TEST-0001',
                linkedProductType => 'downloadable',
                position          => 0
             },
        ],
    }
}

our sub bundle() {
    product => %{
        sku            => 'P6-TEST-0003',
        name           => 'Bundle Product Test',
        typeId         => 'bundle',
        attributeSetId => 4,
        price          => 19.95,
        status         => 1,
        visibility     => 1,
        weight         => 1.5,
        customAttributes => [
            %{
                attributeCode => 'price_view',
                value         => 0
            },
        ],
        extensionAttributes => %{
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
          bundleProductOptions => [
              %{
                  title         => 'Simple Bundle',
                  type          => 'select',
                  required      => 'true',
                  position      => 0,
                  sku           => 'BUNDLE-SIMPLE-0001',
                  productLinks  => [   # simple / virtual products only
                     %{
                          sku               => 'P6-TEST-0002',
                          position          => 0,
                          isDefault         => 'true',
                          canChangeQuantity => 0
                      },
                  ],
              },
          ]
        },
        options => [
            %(
                productSku    => 'P6-TEST-0003',
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
    }
}

our sub configurable() {
    product => %{
        sku            => 'P6-TEST-0004',
        name           => 'Configurable Product Test',
        typeId         => 'configurable',
        attributeSetId => 4,
        price          => 19.95,
        status         => 1,
        visibility     => 1,
        weight         => 1.5,
        customAttributes => [
            %{
                attributeCode => 'price_view',
                value         => 0
            },
        ],
        extensionAttributes => %{
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
          configurableProductOptions => [
              %{
                  attributeId  => '93',
                  label        => 'Collection',
                  position     => 0,
                  isUseDefault => 'true',
                  values => [
                      %{
                          valueIndex => 9 
                      },
                  ],
                },
            ],
        },
        options => [
            %(
                productSku    => 'P6-TEST-0004',
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
    }
}

our sub delete-me() {
    product => %{
        sku            => 'P6-TEST-DELETE',
        name           => 'Deletable Product',
        typeId         => 'simple',
        attributeSetId => 4,
        price          => 19.95,
        status         => 1,
        visibility     => 1,
        weight         => 1.5,
    }
}

our sub product-attribute() {
    attribute => %{
        attributeCode        => 'deleteme',
        frontendInput        => 'multiselect',
        isRequired           => 'true',
        defaultFrontendLabel => 'delete_me',
        frontendLabels => [
            %{
                storeId => 0,
                label   => 'delete_me'
            },
        ],
        options => [
            %{
                label       => 'label opt1',
                value       => 'value_opt1',
                isDefault   => 'true',
                storeLabels => [
                    %{
                        storeId => 0,
                        label   => 'option_1_labl_en'
                     },
                ]   
            },
        ],  	
    }
}

our sub product-attribute-modified() {
    attribute => %{
        attributeCode        => 'deleteme',
        frontendInput        => 'multiselect',
        isRequired           => 'true',
        defaultFrontendLabel => 'delete_me',
        frontendLabels => [
            %{
                storeId => 0,
                label   => 'delete_me'
            },
        ],
        options => [
            %{
                label       => 'label opt1',
                value       => 'value_opt1',
                isDefault   => 'true',
                storeLabels => [
                    %{
                        storeId => 0,
                        label   => 'option_1_labl_en'
                     },
                ]   
            },
        ],  	
    }
}

our sub products-attribute-set() {
    attributeSet => %{
        attributeSetName => 'DeleteMe',
        entityTypeId     => 4,
        sortOrder        => 0
    },
    skeletonId => 4
}

our sub products-attribute-set-modified() {
    attributeSet => %{
        attributeSetName => 'DeleteMeModified',
        entityTypeId     => 4,
        sortOrder        => 0
    }
}

our sub products-attribute-group() {
    group => {
        attributeGroupName => 'Delete Me',
        attributeSetId     => 4
    }
}

our sub products-attribute-group-save() {
    group => {
        attributeGroupName => 'Delete Me Too',
        attributeSetId     => 4
    }
}

our sub products-attributes-option() {
    option => %{
        label => 'Delete Me',
        value => 'deleteme'
    }
}

our proto sub products-media(|) {*}
our multi products-media() {
    entry => %{
        mediaType  => 'image',
        label      => 'Media File',
        position   => 1,
        disabled   => 'false',
        content => %{
          base64EncodedData => encode-base64(slurp('xt'.IO.child('assets').child('media-file.png'), :bin), :str),
          type => 'image/png',
          name => 'media-file.png'
        }
    }
}

our multi products-media(
    Int :$entry_id!
) {
    entry => %{
        id         => $entry_id,
        mediaType  => 'image',
        label      => 'Media File',
        position   => 1,
        disabled   => 'false',
        content => %{
          base64EncodedData => encode-base64(slurp('xt'.IO.child('assets').child('media-file.png'), :bin), :str),
          type => 'image/png',
          name => 'media-file.png'
        }
    }
}
