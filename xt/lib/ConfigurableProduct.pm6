use v6;
use Base64;

unit module ConfigurableProduct;

our sub simple(
    :$sku = 'P6-SIMPLE-0001'
) {
    product => %{
        sku            => $sku,
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
        }
    }
}

our sub configurable() {
    product => %{
        sku            => 'P6-CONFIGURABLE-0001',
        name           => 'Configurable Product Test',
        typeId         => 'configurable',
        attributeSetId => 4,
        price          => 19.95,
        status         => 1,
        visibility     => 2,
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
              minQty                   => 1,
              useConfigMinSaleQty      => 1,
              minSaleQty               => 1,
              useConfigMaxSaleQty      => 'true',
              maxSaleQty               => 5,
              useConfigBackorders      => 'true',
              backorders               => 0,
              useConfigNotifyStockQty  => 'true',
              notifyStockQty           => 0,
              useConfigQtyIncrements   => 'true',
              qtyIncrements            => 1,
              useConfigEnableQtyInc    => 'true',
              enableQtyIncrements      => 'false',
              useConfigManageStock     => 'false',
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
                productSku    => 'P6-CONFIGURABLE-0001',
                title         => 'Color',
                type          => 'drop_down', # field, area, file, drop_down, radio, checkbox, multiple, date, date_time, time
                sortOrder     =>  0,
                isRequire     => 'true',
                values => [
                    %{
                        title       => 'Green',
                        sortOrder   =>  0,
                        price       =>  0,
                        priceType   => 'fixed',
                        sku         => 'P6-CONFIGURABLE-0001-Green'
                    },
                    %{
                        title       => 'Blue',
                        sortOrder   =>  1,
                        price       =>  0,
                        priceType   => 'fixed',
                        sku         => 'P6-CONFIGURABLE-0001-Blue'
                    },
                    %{
                        title       => 'Gold',
                        sortOrder   =>  2,
                        price       =>  10.00,
                        priceType   => 'fixed',
                        sku         => 'P6-CONFIGURABLE-0001-Gold'
                    }
                ]
            ),
        ],
    }
}


our sub configurable-products-child {
    %();
}

our sub configurable-products-options {
    option => %{
        attributeId  => '13',
        label        => 'Collection Delete Me',
        position     => 1,
        isUseDefault => 'false',
        values => [
            %{
                valueIndex => 6 
            },
        ],
    }
}

our sub configurable-products-options-update {
    option => %{
        attributeId  => '93',
        label        => 'Collection',
        position     => 1,
        isUseDefault => 'false',
        values => [
            %{
                valueIndex => 9
            },
        ],
    }
}
our sub configurable-products-variation {
    product => %{
        sku            => 'P6-CONFIGURABLE-0001-Blue',
        name           => 'Configurable Product Test Variation',
        typeId         => 'configurable',
        attributeSetId => 4,
        price          => 19.95,
        status         => 1,
        visibility     => 2,
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
                minQty                   => 1,
                useConfigMinSaleQty      => 1,
                minSaleQty               => 1,
                useConfigMaxSaleQty      => 'true',
                maxSaleQty               => 5,
                useConfigBackorders      => 'true',
                backorders               => 0,
                useConfigNotifyStockQty  => 'true',
                notifyStockQty           => 0,
                useConfigQtyIncrements   => 'true',
                qtyIncrements            => 1,
                useConfigEnableQtyInc    => 'true',
                enableQtyIncrements      => 'false',
                useConfigManageStock     => 'false',
                manageStock              => 'true'
            },
            #configurableProductOptions => [
            #    %{
            #        attributeId  => '93',
            #        label        => 'Collection',
            #        position     => 0,
            #        isUseDefault => 'true',
            #        values => [
            #            %{
            #                valueIndex => 9 
            #            },
            #        ],
            #      },
            #  ],
        },
        #options => [
        #    %(
        #        productSku    => 'P6-CONFIGURABLE-0001',
        #        title         => 'Color',
        #        type          => 'drop_down', # field, area, file, drop_down, radio, checkbox, multiple, date, date_time, time
        #        sortOrder     =>  0,
        #        isRequire     => 'true',
        #        values => [
        #            %{
        #                title       => 'Green',
        #                sortOrder   =>  0,
        #                price       =>  5,
        #                priceType   => 'fixed',
        #                sku         => 'P6-CONFIGURABLE-0001-Green'
        #            },
        #            %{
        #                title       => 'Blue',
        #                sortOrder   =>  1,
        #                price       =>  10,
        #                priceType   => 'fixed',
        #                sku         => 'P6-CONFIGURABLE-0001-Blue'
        #            },
        #            %{
        #                title       => 'Gold',
        #                sortOrder   =>  2,
        #                price       =>  10.00,
        #                priceType   => 'fixed',
        #                sku         => 'P6-CONFIGURABLE-0001-Gold'
        #            }
        #        ]
        #    ),
        #],
    },
    options => [
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
}

