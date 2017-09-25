## Magento::Backend
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|modules|    Hash $config|Returns an array of enabled modules|GET|/V1/modules|
## Magento::Bundle
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|bundle-products-links|    Hash $config,<br/>    Str  :$sku!,<br/>    Int  :$option_id!,<br/>    Hash :$data!|Add child product to specified Bundle option by product sku|POST|/V1/bundle-products/:sku/links/:optionId|
|bundle-products-links|    Hash $config,<br/>    Str  :$sku!,<br/>    Str  :$id!,<br/>    Hash :$data!||PUT|/V1/bundle-products/:sku/links/:id|
|bundle-products-children|    Hash $config,<br/>    Str  :$product_sku!|Get all children for Bundle product|GET|/V1/bundle-products/:productSku/children|
|bundle-products-options-children-delete|    Hash $config,<br/>    Str  :$sku!,<br/>    Int  :$option_id!,<br/>    Str  :$child_sku!|Remove product from Bundle product option|DELETE|/V1/bundle-products/:sku/options/:optionId/children/:childSku|
|bundle-products-options-all|    Hash $config,<br/>    Str  :$sku!|Get all options for bundle product|GET|/V1/bundle-products/:sku/options/all|
|bundle-products-options-types|    Hash $config|Get all types for options for bundle products|GET|/V1/bundle-products/options/types|
|bundle-products-options|    Hash $config,<br/>    Str  :$sku!,<br/>    Int  :$option_id!|Get option for bundle product|GET|/V1/bundle-products/:sku/options/:optionId|
|bundle-products-options-add|    Hash $config,<br/>    Hash :$data!|Add new option for bundle product|POST|/V1/bundle-products/options/add|
|bundle-products-options|    Hash $config,<br/>    Int  :$option_id!,<br/>    Hash :$data!|Add new option for bundle product|PUT|/V1/bundle-products/options/:optionId|
|bundle-products-options-delete|    Hash $config,<br/>    Str  :$sku!,<br/>    Int  :$option_id!|Remove bundle option|DELETE|/V1/bundle-products/:sku/options/:optionId|
## Magento::Catalog
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|products|    Hash $config,<br/>    Hash :$search_criteria = %{}|Get product list|GET|/V1/products|
|products|    Hash $config,<br/>    Hash :$data!|Create product|POST|/V1/products|
|products|    Hash $config,<br/>    Str  :$sku!,<br/>    Hash :$data!|Create product|PUT|/V1/products/:sku|
|products|    Hash $config,<br/>    Str  :$sku!|Get info about product by product SKU|GET|/V1/products/:sku|
|products-delete|    Hash $config,<br/>    Str  :$sku!||DELETE|/V1/products/:sku|
|products-attributes-types|    Hash $config,|Retrieve list of product attribute types|GET|/V1/products/attributes/types|
|products-attributes|    Hash $config,<br/>    Hash :$search_criteria = %{}|Retrieve all attributes for entity type|GET|/V1/products/attributes|
|products-attributes|    Hash $config,<br/>    Hash :$data!|Save attribute data|POST|/V1/products/attributes|
|categories-attributes|    Hash $config,<br/>    Hash :$search_criteria = %{}|Retrieve all attributes for entity type|GET|/V1/categories/attributes|
|products-types|    Hash $config|Retrieve available product types|GET|/V1/products/types|
|products-attribute-sets|    Hash $config,<br/>    Hash :$search_criteria = %{}|Retrieve list of Attribute Sets|GET|/V1/products/attribute-sets/sets/list|
|products-attribute-sets|    Hash $config,<br/>    Hash :$data!|Create attribute set from data|POST|/V1/products/attribute-sets|
|products-attribute-sets-attributes|    Hash $config,<br/>    Hash :$data!|Assign attribute to attribute set|POST|/V1/products/attribute-sets/attributes|
|products-attribute-groups|    Hash $config,<br/>    Hash :$data!|Save attribute group|POST|/V1/products/attribute-sets/groups|
|products-media|    Hash $config,<br/>    Str  :$sku!,|Retrieve the list of gallery entries associated with given product|GET|/V1/products/:sku/media|
|products-media|    Hash $config,<br/>    Str  :$sku!,<br/>    Hash :$data!|Create new gallery entry|POST|/V1/products/:sku/media|
|categories|    Hash $config,<br/>    Int  :$root_category_id = 1,<br/>    Int  :$depth = 1;|Retrieve list of categories|GET|/V1/categories|
|categories|    Hash $config,<br/>    Hash :$data!|Create category service|POST|/V1/categories|
|categories|    Hash $config,<br/>    Int  :$category_id!,<br/>    Hash :$data!|Create category service|PUT|/V1/categories/:id|
|products-options-types|    Hash $config|Get custom option types|GET|/V1/products/options/types|
|products-custom-options|    Hash $config,<br/>    Str  :$sku!|Get the list of custom options for a specific product|GET|/V1/products/:sku/options|
|products-custom-options|    Hash $config,<br/>    Hash :$data!|Save Custom Option|POST|/V1/products/options|
|products-links-types|    Hash $config|Retrieve information about available product link types|GET|/V1/products/links/types|
|products-links-attributes|    Hash $config,<br/>    Str  :$type|Provide a list of the product link type attributes|GET|/V1/products/links/:type/attributes|
|products-links|    Hash $config,<br/>    Str  :$sku!,<br/>    Str  :$type!|Provide the list of links for a specific product|GET|/V1/products/:sku/links/:type|
|products-links|    Hash $config,<br/>    Str  :$sku!,<br/>    Hash :$data!|Assign a product link to another product|POST|/V1/products/:sku/links|
|products-links-update|    Hash $config,<br/>    Str  :$sku!,<br/>    Hash :$data!|Save product link|PUT|/V1/products/:sku/links|
|products-links-delete|    Hash $config,<br/>    Str  :$sku!,<br/>    Str  :$type!,<br/>    Str  :$linked_product_sku!||DELETE|/V1/products/:sku/links/:type/:linkedProductSku|
## Magento::CatalogInventory
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|products-stock-items|    Hash $config,<br/>    Str  :$sku!,<br/>    Int  :$item_id!,<br/>    Hash :$data!||PUT|/V1/products/:productSku/stockItems/:itemId|
|stock-items|    Hash $config,<br/>    Str  :$sku!||GET|/V1/stockItems/:productSku|
|stock-items-low-stock|    Hash $config|Retrieves a list of SKU's with low inventory qty|GET|/V1/stockItems/lowStock/|
|stock-statuses|    Hash $config,<br/>    Str  :$sku!||GET|/V1/stockStatuses/:productSku|
## Magento::Checkout
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|carts-mine-payment-information|    Hash $config,<br/>    Hash :$data!|Set payment information and place order for a specified cart.|POST|/V1/carts/mine/payment-information|
|carts-mine-payment-information|    Hash $config|Get payment information|GET|/V1/carts/mine/payment-information|
|carts-mine-set-payment-information|    Hash $config,<br/>    Hash :$data!|Set payment information for a specified cart.|POST|/V1/carts/mine/set-payment-information|
|carts-mine-shipping-information|    Hash $config,<br/>    Hash :$data!||POST|/V1/carts/mine/shipping-information|
|carts-mine-totals-information|    Hash $config,<br/>    Hash :$data!|Calculate quote totals based on address and shipping method.|POST|/V1/carts/mine/totals-information|
|carts-shipping-information|    Hash   $config,<br/>    CartId :$cart_id!,<br/>    Hash   :$data!||POST|/V1/carts/:cartId/shipping-information|
|carts-totals-information|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Hash :$data!|Calculate quote totals based on address and shipping method.|POST|/V1/carts/:cartId/totals-information|
|guest-carts-payment-information|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Hash :$data!|Set payment information and place order for a specified cart.|POST|/V1/guest-carts/:cartId/payment-information|
|guest-carts-payment-information|    Hash $config,<br/>    Int  :$cart_id!|Get payment information|GET|/V1/guest-carts/:cartId/payment-information|
|guest-carts-set-payment-information|    Hash $config,<br/>    Str  :$cart_id!,<br/>    Hash :$data!|Set payment information for a specified cart.|POST|/V1/guest-carts/:cartId/set-payment-information|
|guest-carts-shipping-information|    Hash $config,<br/>    Str  :$cart_id!,<br/>    Hash :$data!||POST|/V1/guest-carts/:cartId/shipping-information|
|guest-carts-totals-information|    Hash $config,<br/>    Str  :$cart_id!,<br/>    Hash :$data!|Calculate quote totals based on address and shipping method.|POST|/V1/guest-carts/:cartId/totals-information|
## Magento::CheckoutAgreements
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|carts-licence|    Hash $config|Lists active checkout agreements.|GET|/V1/carts/licence|
## Magento::Cms
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|cms-page|    Hash $config,<br/>    Int  :$page_id!|Retrieve page.|GET|/V1/cmsPage/:pageId|
|cms-page-search|    Hash $config,<br/>    Hash :$search_criteria = %{}|Retrieve pages matching the specified criteria.|GET|/V1/cmsPage/search|
|cms-page|    Hash $config,<br/>    Hash :$data!|Save page.|POST|/V1/cmsPage|
|cms-page|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Save page.|PUT|/V1/cmsPage/:id|
|cms-page-delete|    Hash $config,<br/>    Int  :$page_id!|Delete page by ID.|DELETE|/V1/cmsPage/:pageId|
|cms-block|    Hash $config,<br/>    Int  :$block_id!|Retrieve block.|GET|/V1/cmsBlock/:blockId|
|cms-block-search|    Hash $config,<br/>    Hash :$search_criteria = %{}|Retrieve blocks matching the specified criteria.|GET|/V1/cmsBlock/search|
|cms-block|    Hash $config,<br/>    Hash :$data!|Save block.|POST|/V1/cmsBlock|
|cms-block|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Save block.|PUT|/V1/cmsBlock/:id|
|cms-block-delete|    Hash $config,<br/>    Int  :$block_id!|Delete block by ID.|DELETE|/V1/cmsBlock/:blockId|
## Magento::Customer
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|customer-groups|    Hash $config,<br/>    Int  :$id|Get customer group by group ID.|GET|/V1/customerGroups/:id|
|customer-groups|    Hash $config,<br/>    Hash :$data|Save customer group.|POST|/V1/customerGroups|
|customer-groups|    Hash $config,<br/>    Int  :$id,<br/>    Hash :$data|Save customer group.|PUT|/V1/customerGroups/:id|
|customer-groups-default|    Hash $config,<br/>    Int  :$store_id|Get default customer group.|GET|/V1/customerGroups/default/:storeId|
|customer-groups-default|    Hash $config|Get default customer group.|GET|/V1/customerGroups/default|
|customer-groups-permissions|    Hash $config,<br/>    Int  :$id|Check if customer group can be deleted.|GET|/V1/customerGroups/:id/permissions|
|customer-groups-search|    Hash $config,<br/>    Hash :$search_criteria|Retrieve customer groups. The list of groups can be filtered to exclude the NOT_LOGGED_IN group using the first parameter and/or it can be filtered by tax class. This call returns an array of objects, but detailed information about each object’s attributes might not be included. See http://devdocs.magento.com/codelinks/attributes.html#GroupRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/customerGroups/search|
|customer-groups-delete|    Hash $config,<br/>    Int  :$id|Delete customer group by ID.|DELETE|/V1/customerGroups/:id|
|customer-metadata-attribute|    Hash $config,<br/>    Str :$attribute_code|Retrieve attribute metadata.|GET|/V1/attributeMetadata/customer/attribute/:attributeCode|
|customer-metadata-form|    Hash $config,<br/>    Str :$form_code|Retrieve all attributes filtered by form code|GET|/V1/attributeMetadata/customer/form/:formCode|
|customer-metadata|    Hash $config<br/>    --> Array|Get all attribute metadata.|GET|/V1/attributeMetadata/customer|
|customer-metadata-custom|    Hash $config<br/>    --> Array|Get custom attributes metadata for the given data interface.|GET|/V1/attributeMetadata/customer/custom|
|customer-address-attribute|    Hash $config,<br/>    Str :$attribute_code|Retrieve attribute metadata.|GET|/V1/attributeMetadata/customerAddress/attribute/:attributeCode|
|customer-address-form|    Hash $config,<br/>    Str :$form_code|Retrieve all attributes filtered by form code|GET|/V1/attributeMetadata/customerAddress/form/:formCode|
|customer-address|    Hash $config|Get all attribute metadata.|GET|/V1/attributeMetadata/customerAddress|
|customer-address-custom|    Hash $config|Get custom attributes metadata for the given data interface.|GET|/V1/attributeMetadata/customerAddress/custom|
|customers-delete|    Hash $config,<br/>    Int  :$id|Delete customer by ID.|DELETE|/V1/customers/:customerId|
|customers|    Hash $config,<br/>    Int  :$id,<br/>    Hash :$data|Create or update a customer.|PUT|/V1/customers/:id|
|customers|    Hash $config,<br/>    Int  :$id|Get customer by customer ID.|GET|/V1/customers/:customerId|
|customers-me-activate|    Hash $config,<br/>    Hash :$data|Activate a customer account using a key that was sent in a confirmation email.|PUT|/V1/customers/me/activate|
|customers-me|    Hash $config|Get customer by customer ID.|GET|/V1/customers/me|
|customers-me|    Hash $config,<br/>    Hash :$data|Create or update a customer.|PUT|/V1/customers/me|
|customers-me-password|    Hash $config,<br/>    Hash :$data|Change customer password.|PUT|/V1/customers/me/password|
|customers-me-billing-address|    Hash $config|Retrieve default billing address for the given customerId.|GET|/V1/customers/me/billingAddress|
|customers-me-shipping-address|    Hash $config|Retrieve default shipping address for the given customerId.|GET|/V1/customers/me/shippingAddress|
|customers-search|    Hash $config,<br/>    Hash :$search_criteria|Retrieve customers which match a specified criteria. This call returns an array of objects, but detailed information about each object’s attributes might not be included. See http://devdocs.magento.com/codelinks/attributes.html#CustomerRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/customers/search|
|customers-email-activate|    Hash $config,<br/>    Str  :$email,<br/>    Hash :$data|Activate a customer account using a key that was sent in a confirmation email.|PUT|/V1/customers/:email/activate|
|customers-reset-link-token|    Hash $config,<br/>    Int  :$id,<br/>    Str  :$link_token|Check if password reset token is valid.|GET|/V1/customers/:customerId/password/resetLinkToken/:resetPasswordLinkToken|
|customers-password|    Hash $config,<br/>    Hash :$data|Send an email to the customer with a password reset link.|PUT|/V1/customers/password|
|customers-confirm|    Hash $config,<br/>    Int  :$id|Gets the account confirmation status.|GET|/V1/customers/:customerId/confirm|
|customers-confirm|    Hash $config,<br/>    Hash :$data|Resend confirmation email.|POST|/V1/customers/confirm|
|customers-validate|    Hash $config,<br/>    Hash :$data|Validate customer data.|PUT|/V1/customers/validate|
|customers-permissions|    Hash $config,<br/>    Int  :$id|Check if customer can be deleted.|GET|/V1/customers/:customerId/permissions/readonly|
|customers-email-available|    Hash $config,<br/>    Hash :$data|Check if given email is associated with a customer account in given website.|POST|/V1/customers/isEmailAvailable|
|customers-addresses|    Hash $config,<br/>    Int  :$address_id|Retrieve customer address.|GET|/V1/customers/addresses/:addressId|
|customers-addresses-billing|    Hash $config,<br/>    Int  :$id|Retrieve default billing address for the given customerId.|GET|/V1/customers/:customerId/billingAddress|
|customers-addresses-shipping|    Hash $config,<br/>    Int  :$id|Retrieve default shipping address for the given customerId.|GET|/V1/customers/:customerId/shippingAddress|
|customers-addresses-delete|    Hash $config,<br/>    Int  :$address_id|Delete customer address by ID.|DELETE|/V1/addresses/:addressId|
## Magento::CustomerBalance
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|carts-mine-balance-apply|    Hash $config,<br/>    Hash :$data!|Apply store credit|POST|/V1/carts/mine/balance/apply|
## Magento::Directory
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|directory-currency|    Hash $config|Get currency information for the store.|GET|/V1/directory/currency|
|directory-countries|    Hash $config|Get all countries and regions information for the store.|GET|/V1/directory/countries|
|directory-countries|    Hash $config,<br/>    Int  :$country_id!|Get country and region information for the store.|GET|/V1/directory/countries/:countryId|
## Magento::Downloadable
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|products-downloadable-links|    Hash $config,<br/>    Str  :$sku!|List of links with associated samples|GET|/V1/products/:sku/downloadable-links|
|products-downloadable-links-samples|    Hash $config,<br/>    Str  :$sku!|List of samples for downloadable product|GET|/V1/products/:sku/downloadable-links/samples|
|products-downloadable-links|    Hash $config,<br/>    Str  :$sku!,<br/>    Hash :$data!|Update downloadable link of the given product (link type and its resources cannot be changed)|POST|/V1/products/:sku/downloadable-links|
|products-downloadable-links|    Hash $config,<br/>    Str  :$sku!,<br/>    Str  :$id!,<br/>    Hash :$data!|Update downloadable link of the given product (link type and its resources cannot be changed)|PUT|/V1/products/:sku/downloadable-links/:id|
|products-downloadable-links-delete|    Hash $config,<br/>    Str  :$id!|Delete downloadable link|DELETE|/V1/products/downloadable-links/:id|
|products-downloadable-links-samples|    Hash $config,<br/>    Str  :$sku!,<br/>    Hash :$data!|Update downloadable sample of the given product|POST|/V1/products/:sku/downloadable-links/samples|
|products-downloadable-links-samples|    Hash $config,<br/>    Str  :$sku!,<br/>    Str  :$id!,<br/>    Hash :$data!|Update downloadable sample of the given product|PUT|/V1/products/:sku/downloadable-links/samples/:id|
|products-downloadable-links-samples-delete|    Hash $config,<br/>    Str  :$id!|Delete downloadable sample|DELETE|/V1/products/downloadable-links/samples/:id|
## Magento::Eav
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|eav-attribute-sets-list|    Hash $config|Retrieve list of Attribute Sets This call returns an array of objects, but detailed information about each object’s attributes might not be included. See http://devdocs.magento.com/codelinks/attributes.html#AttributeSetRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/eav/attribute-sets/list|
|eav-attribute-sets|    Hash $config,<br/>    Int  :$attribute_set_id!|Retrieve attribute set information based on given ID|GET|/V1/eav/attribute-sets/:attributeSetId|
|eav-attribute-sets-delete|    Hash $config,<br/>    Int  :$attribute_set_id!|Remove attribute set by given ID|DELETE|/V1/eav/attribute-sets/:attributeSetId|
|eav-attribute-sets|    Hash $config,<br/>    Hash :$data!|Create attribute set from data|POST|/V1/eav/attribute-sets|
|eav-attribute-sets|    Hash $config,<br/>    Int  :$attribute_set_id!,<br/>    Hash :$data!|Save attribute set data|PUT|/V1/eav/attribute-sets/:attributeSetId|
## Magento::GiftCardAccount
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|carts-giftCards|    Hash $config,<br/>    Int  :$quote_id!|Return GiftCard Account cards|GET|/V1/carts/:quoteId/giftCards|
|carts-giftCards|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Hash :$data!||PUT|/V1/carts/:cartId/giftCards|
|carts-mine-giftCards|    Hash $config,<br/>    Hash :$data!||POST|/V1/carts/mine/giftCards|
|carts-guest-carts-giftCards|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Hash :$data!||POST|/V1/carts/guest-carts/:cartId/giftCards|
|carts-guest-carts-checkGiftCard|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Str  :$gift_card_code!||GET|/V1/carts/guest-carts/:cartId/checkGiftCard/:giftCardCode|
|carts-mine-checkGiftCard|    Hash $config,<br/>    Str  :$gift_card_code!||GET|/V1/carts/mine/checkGiftCard/:giftCardCode|
## Magento::GiftMessage
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|carts-gift-message|    Hash $config,<br/>    Int  :$cart_id!|Return the gift message for a specified order.|GET|/V1/carts/:cartId/gift-message|
|carts-gift-message|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Int  :$item_id!|Return the gift message for a specified item in a specified shopping cart.|GET|/V1/carts/:cartId/gift-message/:itemId|
|carts-gift-message|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Hash :$data!|Set the gift message for an entire order.|POST|/V1/carts/:cartId/gift-message|
|carts-gift-message|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Int  :$item_id!,<br/>    Hash :$data!|Set the gift message for a specified item in a specified shopping cart.|POST|/V1/carts/:cartId/gift-message/:itemId|
|carts-mine-gift-message|    Hash $config|Return the gift message for a specified order.|GET|/V1/carts/mine/gift-message|
|carts-mine-gift-message|    Hash $config,<br/>    Int  :$item_id!|Return the gift message for a specified item in a specified shopping cart.|GET|/V1/carts/mine/gift-message/:itemId|
|carts-mine-gift-message|    Hash $config,<br/>    Hash :$data!|Set the gift message for an entire order.|POST|/V1/carts/mine/gift-message|
|carts-mine-gift-message|    Hash $config,<br/>    Int  :$item_id!,<br/>    Hash :$data!|Set the gift message for a specified item in a specified shopping cart.|POST|/V1/carts/mine/gift-message/:itemId|
|guest-carts-gift-message|    Hash $config,<br/>    Int  :$cart_id!|Return the gift message for a specified order.|GET|/V1/guest-carts/:cartId/gift-message|
|guest-carts-gift-message|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Int  :$item_id!|Return the gift message for a specified item in a specified shopping cart.|GET|/V1/guest-carts/:cartId/gift-message/:itemId|
|guest-carts-gift-message|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Hash :$data!|Set the gift message for an entire order.|POST|/V1/guest-carts/:cartId/gift-message|
|guest-carts-gift-message|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Int  :$item_id!,<br/>    Hash :$data!|Set the gift message for a specified item in a specified shopping cart.|POST|/V1/guest-carts/:cartId/gift-message/:itemId|
## Magento::GiftRegistry
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|giftregistry-mine-estimate-shipping-methods|    Hash $config,<br/>    Hash :$data!|Estimate shipping|POST|/V1/giftregistry/mine/estimate-shipping-methods|
|guest-giftregistry-estimate-shipping-methods|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Hash :$data!|Estimate shipping|POST|/V1/guest-giftregistry/:cartId/estimate-shipping-methods|
## Magento::GiftWrapping
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|gift-wrappings|    Hash $config,<br/>    Str  :$id!|Return data object for specified wrapping ID and store.|GET|/V1/gift-wrappings/:id|
|gift-wrappings|    Hash $config,<br/>    Hash :$data!|Create/Update new gift wrapping with data object values|POST|/V1/gift-wrappings|
|gift-wrappings|    Hash $config,<br/>    Int  :$wrapping_id!,<br/>    Hash :$data!|Create/Update new gift wrapping with data object values|PUT|/V1/gift-wrappings/:wrappingId|
|gift-wrappings|    Hash $config|Return list of gift wrapping data objects based on search criteria|GET|/V1/gift-wrappings|
|gift-wrappings-delete|    Hash $config,<br/>    Str  :$id!|Delete gift wrapping|DELETE|/V1/gift-wrappings/:id|
## Magento::Integration
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|integration-admin-token|    Hash $config,<br/>    Hash :$data!|Create access token for admin given the admin credentials.|POST|/V1/integration/admin/token|
|integration-customer-token|    Hash $config,<br/>    Hash :$data!|Create access token for admin given the customer credentials.|POST|/V1/integration/customer/token|
## Magento::Quote
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|carts|    Hash $config,<br/>    Int  :$cart_id!|Enables an administrative user to return information for a specified cart.|GET|/V1/carts/:cartId|
|carts|    Hash $config|Creates an empty cart and quote for a guest.|POST|/V1/carts/|
|carts|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Hash :$data!|Assigns a specified customer to a specified shopping cart.|PUT|/V1/carts/:cartId|
|carts-billing-address|    Hash $config,<br/>    Int  :$cart_id!|Returns the billing address for a specified quote.|GET|/V1/carts/:cartId/billing-address|
|carts-billing-address|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Hash :$data!|Assigns a specified billing address to a specified cart.|POST|/V1/carts/:cartId/billing-address|
|carts-coupons|    Hash $config,<br/>    Int  :$cart_id!|Returns information for a coupon in a specified cart.|GET|/V1/carts/:cartId/coupons|
|carts-coupons|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Str  :$coupon_code!|Adds a coupon by code to a specified cart.|PUT|/V1/carts/:cartId/coupons/:couponCode|
|carts-coupons-delete|    Hash $config,<br/>    Int  :$cart_id!|Deletes a coupon from a specified cart.|DELETE|/V1/carts/:cartId/coupons|
|carts-estimate-shipping-methods|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Hash :$data!|Estimate shipping by address and return list of available shipping methods|POST|/V1/carts/:cartId/estimate-shipping-methods|
|carts-estimate-shipping-methods-by-address-id|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Hash :$data!|Estimate shipping|POST|/V1/carts/:cartId/estimate-shipping-methods-by-address-id|
|carts-items|    Hash $config,<br/>    Int  :$cart_id!|Lists items that are assigned to a specified cart.|GET|/V1/carts/:cartId/items|
|carts-items|    Hash $config,<br/>    Int  :$quote_id!,<br/>    Hash :$data!|Add/update the specified cart item.|POST|/V1/carts/:quoteId/items|
|carts-items|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Int  :$item_id!,<br/>    Hash :$data!|Add/update the specified cart item.|PUT|/V1/carts/:cartId/items/:itemId|
|carts-items-delete|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Int  :$item_id!|Removes the specified item from the specified cart.|DELETE|/V1/carts/:cartId/items/:itemId|
|carts-mine-new|    Hash $config|Creates an empty cart and quote for a specified customer if customer does not have a cart yet.|POST|/V1/carts/mine|
|carts-mine|    Hash $config|Returns information for the cart for a specified customer.|GET|/V1/carts/mine|
|carts-mine-update|    Hash $config,<br/>    Hash :$data!|Save quote|PUT|/V1/carts/mine|
|carts-mine-billing-address|    Hash $config|Returns the billing address for a specified quote.|GET|/V1/carts/mine/billing-address|
|carts-mine-billing-address|    Hash $config,<br/>    Hash :$data!|Assigns a specified billing address to a specified cart.|POST|/V1/carts/mine/billing-address|
|carts-mine-collect-totals|    Hash $config,<br/>    Hash :$data!|Set shipping/billing methods and additional data for cart and collect totals.|PUT|/V1/carts/mine/collect-totals|
|carts-mine-coupons|    Hash $config|Returns information for a coupon in a specified cart.|GET|/V1/carts/mine/coupons|
|carts-mine-coupons|    Hash $config,<br/>    Str  :$coupon_code!,<br/>    Hash :$data!|Adds a coupon by code to a specified cart.|PUT|/V1/carts/mine/coupons/:couponCode|
|carts-mine-coupons-delete|    Hash $config|Deletes a coupon from a specified cart.|DELETE|/V1/carts/mine/coupons|
|carts-mine-estimate-shipping-methods|    Hash $config,<br/>    Hash :$data!|Estimate shipping by address and return list of available shipping methods|POST|/V1/carts/mine/estimate-shipping-methods|
|carts-mine-estimate-shipping-methods-by-address-id|    Hash $config,<br/>    Hash :$data!|Estimate shipping|POST|/V1/carts/mine/estimate-shipping-methods-by-address-id|
|carts-mine-items|    Hash $config|Lists items that are assigned to a specified cart.|GET|/V1/carts/mine/items|
|carts-mine-items|    Hash $config,<br/>    Hash :$data!|Add/update the specified cart item.|POST|/V1/carts/mine/items|
|carts-mine-items|    Hash $config,<br/>    Int  :$item_id!,<br/>    Hash :$data!|Add/update the specified cart item.|PUT|/V1/carts/mine/items/:itemId|
|carts-mine-items-delete|    Hash $config,<br/>    Int  :$item_id!|Removes the specified item from the specified cart.|DELETE|/V1/carts/mine/items/:itemId|
|carts-mine-order|    Hash $config,<br/>    Hash :$data!|Places an order for a specified cart.|PUT|/V1/carts/mine/order|
|carts-mine-payment-methods|    Hash $config|Lists available payment methods for a specified shopping cart. This call returns an array of objects, but detailed information about each object’s attributes might not be included.  See http://devdocs.magento.com/codelinks/attributes.html#PaymentMethodManagementInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/carts/mine/payment-methods|
|carts-mine-selected-payment-method|    Hash $config|Returns the payment method for a specified shopping cart.|GET|/V1/carts/mine/selected-payment-method|
|carts-mine-selected-payment-method|    Hash $config,<br/>    Hash :$data!|Adds a specified payment method to a specified shopping cart.|PUT|/V1/carts/mine/selected-payment-method|
|carts-mine-shipping-methods|    Hash $config|Lists applicable shipping methods for a specified quote.|GET|/V1/carts/mine/shipping-methods|
|carts-mine-totals|    Hash $config|Returns quote totals data for a specified cart.|GET|/V1/carts/mine/totals|
|carts-order|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Hash :$data!|Places an order for a specified cart.|PUT|/V1/carts/:cartId/order|
|carts-payment-methods|    Hash $config,<br/>    Int  :$cart_id!|Lists available payment methods for a specified shopping cart. This call returns an array of objects, but detailed information about each object’s attributes might not be included.  See http://devdocs.magento.com/codelinks/attributes.html#PaymentMethodManagementInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/carts/:cartId/payment-methods|
|carts-search|    Hash $config,<br/>    Hash :$search_criteria = %{}|Enables administrative users to list carts that match specified search criteria. This call returns an array of objects, but detailed information about each object’s attributes might not be included.  See http://devdocs.magento.com/codelinks/attributes.html#CartRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/carts/search|
|carts-selected-payment-method|    Hash $config,<br/>    Int  :$cart_id!|Returns the payment method for a specified shopping cart.|GET|/V1/carts/:cartId/selected-payment-method|
|carts-selected-payment-method|    Hash $config,<br/>    Int  :$cart_id!,<br/>    Hash :$data!|Adds a specified payment method to a specified shopping cart.|PUT|/V1/carts/:cartId/selected-payment-method|
|carts-shipping-methods|    Hash $config,<br/>    Int  :$cart_id!|Lists applicable shipping methods for a specified quote.|GET|/V1/carts/:cartId/shipping-methods|
|carts-totals|    Hash $config,<br/>    Int  :$cart_id!|Returns quote totals data for a specified cart.|GET|/V1/carts/:cartId/totals|
|customers-carts|    Hash $config,<br/>    Int  :$customer_id!|Creates an empty cart and quote for a specified customer if customer does not have a cart yet.|POST|/V1/customers/:customerId/carts|
|guest-carts|    Hash $config,<br/>    Str  :$cart_id!|Enable a guest user to return information for a specified cart.|GET|/V1/guest-carts/:cartId|
|guest-carts|    Hash $config|Enable an customer or guest user to create an empty cart and quote for an anonymous customer.|POST|/V1/guest-carts|
|guest-carts|    Hash $config,<br/>    Str  :$cart_id!,<br/>    Hash :$data!|Assign a specified customer to a specified shopping cart.|PUT|/V1/guest-carts/:cartId|
|guest-carts-billing-address|    Hash $config,<br/>    Str  :$cart_id!|Return the billing address for a specified quote.|GET|/V1/guest-carts/:cartId/billing-address|
|guest-carts-billing-address|    Hash $config,<br/>    Str  :$cart_id!,<br/>    Hash :$data!|Assign a specified billing address to a specified cart.|POST|/V1/guest-carts/:cartId/billing-address|
|guest-carts-collect-totals|    Hash $config,<br/>    Str  :$cart_id!,<br/>    Hash :$data!|Set shipping/billing methods and additional data for cart and collect totals for guest.|PUT|/V1/guest-carts/:cartId/collect-totals|
|guest-carts-coupons|    Hash $config,<br/>    Str  :$cart_id!|Return information for a coupon in a specified cart.|GET|/V1/guest-carts/:cartId/coupons|
|guest-carts-coupons|    Hash $config,<br/>    Str  :$cart_id!,<br/>    Str  :$coupon_code!|Add a coupon by code to a specified cart.|PUT|/V1/guest-carts/:cartId/coupons/:couponCode|
|guest-carts-coupons-delete|    Hash $config,<br/>    Str  :$cart_id!|Delete a coupon from a specified cart.|DELETE|/V1/guest-carts/:cartId/coupons|
|guest-carts-estimate-shipping-methods|    Hash $config,<br/>    Str  :$cart_id!,<br/>    Hash :$data!|Estimate shipping by address and return list of available shipping methods|POST|/V1/guest-carts/:cartId/estimate-shipping-methods|
|guest-carts-items|    Hash $config,<br/>    Str  :$cart_id!|List items that are assigned to a specified cart.|GET|/V1/guest-carts/:cartId/items|
|guest-carts-items|    Hash $config,<br/>    Str  :$cart_id!,<br/>    Hash :$data!|Add/update the specified cart item.|POST|/V1/guest-carts/:cartId/items|
|guest-carts-items|    Hash $config,<br/>    Str  :$cart_id!,<br/>    Int  :$item_id!,<br/>    Hash :$data!|Add/update the specified cart item.|PUT|/V1/guest-carts/:cartId/items/:itemId|
|guest-carts-items-delete|    Hash $config,<br/>    Str  :$cart_id!,<br/>    Int  :$item_id!|Remove the specified item from the specified cart.|DELETE|/V1/guest-carts/:cartId/items/:itemId|
|guest-carts-order|    Hash $config,<br/>    Str  :$cart_id!,<br/>    Hash :$data!|Place an order for a specified cart.|PUT|/V1/guest-carts/:cartId/order|
|guest-carts-payment-methods|    Hash $config,<br/>    Str  :$cart_id!|List available payment methods for a specified shopping cart. This call returns an array of objects, but detailed information about each object’s attributes might not be included.  See http://devdocs.magento.com/codelinks/attributes.html#GuestPaymentMethodManagementInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/guest-carts/:cartId/payment-methods|
|guest-carts-selected-payment-method|    Hash $config,<br/>    Str  :$cart_id!|Return the payment method for a specified shopping cart.|GET|/V1/guest-carts/:cartId/selected-payment-method|
|guest-carts-selected-payment-method|    Hash $config,<br/>    Str  :$cart_id!,<br/>    Hash :$data!|Add a specified payment method to a specified shopping cart.|PUT|/V1/guest-carts/:cartId/selected-payment-method|
|guest-carts-shipping-methods|    Hash $config,<br/>    Str  :$cart_id!|List applicable shipping methods for a specified quote.|GET|/V1/guest-carts/:cartId/shipping-methods|
|guest-carts-totals|    Hash $config,<br/>    Str  :$cart_id!|Return quote totals data for a specified cart.|GET|/V1/guest-carts/:cartId/totals|
## Magento::Reward
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|reward-mine-use-reward|    Hash $config,<br/>    Hash :$data!|Set reward points to quote|POST|/V1/reward/mine/use-reward|
## Magento::Rma
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|returns|    Hash $config,<br/>    Str  :$id!|Return data object for specified RMA id|GET|/V1/returns/:id|
|returns-delete|    Hash $config,<br/>    Str  :$id!|Delete RMA|DELETE|/V1/returns/:id|
|returns|    Hash $config,<br/>    Hash :$data!|Save RMA|POST|/V1/returns|
|returns|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Save RMA|PUT|/V1/returns/:id|
|returns|    Hash $config|Return list of rma data objects based on search criteria|GET|/V1/returns|
|returns-attribute-metadata|    Hash $config,<br/>    Str  :$attribute_code!|Retrieve attribute metadata.|GET|/V1/returnsAttributeMetadata/:attributeCode|
|returns-attribute-metadata|    Hash $config|Get all attribute metadata.|GET|/V1/returnsAttributeMetadata|
|returns-attribute-metadata-custom|    Hash $config|Get custom attribute metadata for the given Data object's attribute set|GET|/V1/returnsAttributeMetadata/custom|
|returns-attribute-metadata-form|    Hash $config,<br/>    Str  :$form_code!|Retrieve all attributes filtered by form code|GET|/V1/returnsAttributeMetadata/form/:formCode|
|returns-comments|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Add comment|POST|/V1/returns/:id/comments|
|returns-comments|    Hash $config,<br/>    Str  :$id!|Comments list|GET|/V1/returns/:id/comments|
|returns-labels|    Hash $config,<br/>    Str  :$id!|Get shipping label int the PDF format|GET|/V1/returns/:id/labels|
|returns-tracking-numbers|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Add track|POST|/V1/returns/:id/tracking-numbers|
|returns-tracking-numbers-delete|    Hash $config,<br/>    Str  :$id!,<br/>    Int  :$track_id!|Remove track by id|DELETE|/V1/returns/:id/tracking-numbers/:trackId|
|returns-tracking-numbers|    Hash $config,<br/>    Str  :$id!|Get track list|GET|/V1/returns/:id/tracking-numbers|
## Magento::Sales
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|orders|    Hash $config,<br/>    Str  :$id!|Loads a specified order.|GET|/V1/orders/:id|
|orders|    Hash $config|Lists orders that match specified search criteria. This call returns an array of objects, but detailed information about each object’s attributes might not be included. See http://devdocs.magento.com/codelinks/attributes.html#OrderRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/orders|
|orders-statuses|    Hash $config,<br/>    Str  :$id!|Gets the status for a specified order.|GET|/V1/orders/:id/statuses|
|orders-cancel|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Cancels a specified order.|POST|/V1/orders/:id/cancel|
|orders-emails|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Emails a user a specified order.|POST|/V1/orders/:id/emails|
|orders-hold|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Holds a specified order.|POST|/V1/orders/:id/hold|
|orders-unhold|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Releases a specified order from hold status.|POST|/V1/orders/:id/unhold|
|orders-comments|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Adds a comment to a specified order.|POST|/V1/orders/:id/comments|
|orders-comments|    Hash $config,<br/>    Str  :$id!|Lists comments for a specified order.|GET|/V1/orders/:id/comments|
|orders-create|    Hash $config,<br/>    Hash :$data!|Performs persist operations for a specified order.|PUT|/V1/orders/create|
|orders|    Hash $config,<br/>    Str  :$parent_id!,<br/>    Hash :$data!|Performs persist operations for a specified order address.|PUT|/V1/orders/:parent_id|
|orders-items|    Hash $config,<br/>    Str  :$id!|Loads a specified order item.|GET|/V1/orders/items/:id|
|orders-items|    Hash $config|Lists order items that match specified search criteria. This call returns an array of objects, but detailed information about each object’s attributes might not be included. See http://devdocs.magento.com/codelinks/attributes.html#OrderItemRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/orders/items|
|invoices|    Hash $config,<br/>    Str  :$id!|Loads a specified invoice.|GET|/V1/invoices/:id|
|invoices|    Hash $config|Lists invoices that match specified search criteria. This call returns an array of objects, but detailed information about each object’s attributes might not be included. See http://devdocs.magento.com/codelinks/attributes.html#InvoiceRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/invoices|
|invoices-comments|    Hash $config,<br/>    Str  :$id!|Lists comments for a specified invoice.|GET|/V1/invoices/:id/comments|
|invoices-emails|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Emails a user a specified invoice.|POST|/V1/invoices/:id/emails|
|invoices-void|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Voids a specified invoice.|POST|/V1/invoices/:id/void|
|invoices-capture|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Sets invoice capture.|POST|/V1/invoices/:id/capture|
|invoices-comments|    Hash $config,<br/>    Hash :$data!|Performs persist operations for a specified invoice comment.|POST|/V1/invoices/comments|
|invoices|    Hash $config,<br/>    Hash :$data!|Performs persist operations for a specified invoice.|POST|/V1/invoices/|
|creditmemo-comments|    Hash $config,<br/>    Str  :$id!|Lists comments for a specified credit memo.|GET|/V1/creditmemo/:id/comments|
|creditmemos|    Hash $config|Lists credit memos that match specified search criteria. This call returns an array of objects, but detailed information about each object’s attributes might not be included. See http://devdocs.magento.com/codelinks/attributes.html#CreditmemoRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/creditmemos|
|creditmemo|    Hash $config,<br/>    Str  :$id!|Loads a specified credit memo.|GET|/V1/creditmemo/:id|
|creditmemo|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Cancels a specified credit memo.|PUT|/V1/creditmemo/:id|
|creditmemo-emails|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Emails a user a specified credit memo.|POST|/V1/creditmemo/:id/emails|
|creditmemo-comments|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Performs persist operations for a specified entity.|POST|/V1/creditmemo/:id/comments|
|creditmemo|    Hash $config,<br/>    Hash :$data!|Performs persist operations for a specified credit memo.|POST|/V1/creditmemo|
|shipment|    Hash $config,<br/>    Str  :$id!|Loads a specified shipment.|GET|/V1/shipment/:id|
|shipments|    Hash $config|Lists shipments that match specified search criteria. This call returns an array of objects, but detailed information about each object’s attributes might not be included. See http://devdocs.magento.com/codelinks/attributes.html#ShipmentRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/shipments|
|shipment-comments|    Hash $config,<br/>    Str  :$id!|Lists comments for a specified shipment.|GET|/V1/shipment/:id/comments|
|shipment-comments|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Performs persist operations for a specified shipment comment.|POST|/V1/shipment/:id/comments|
|shipment-emails|    Hash $config,<br/>    Str  :$id!,<br/>    Hash :$data!|Emails user a specified shipment.|POST|/V1/shipment/:id/emails|
|shipment-track|    Hash $config,<br/>    Hash :$data!|Performs persist operations for a specified shipment track.|POST|/V1/shipment/track|
|shipment-track-delete|    Hash $config,<br/>    Str  :$id!|Deletes a specified shipment track by ID.|DELETE|/V1/shipment/track/:id|
|shipment|    Hash $config,<br/>    Hash :$data!|Performs persist operations for a specified shipment.|POST|/V1/shipment/|
|shipment-label|    Hash $config,<br/>    Str  :$id!|Gets a specified shipment label.|GET|/V1/shipment/:id/label|
|orders|    Hash $config,<br/>    Hash :$data!|Performs persist operations for a specified order.|POST|/V1/orders/|
|transactions|    Hash $config,<br/>    Str  :$id!|Loads a specified transaction.|GET|/V1/transactions/:id|
|transactions|    Hash $config|Lists transactions that match specified search criteria. This call returns an array of objects, but detailed information about each object’s attributes might not be included. See http://devdocs.magento.com/codelinks/attributes.html#TransactionRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/transactions|
|order-invoice|    Hash $config,<br/>    Int  :$order_id!,<br/>    Hash :$data!||POST|/V1/order/:orderId/invoice|
|order-ship|    Hash $config,<br/>    Int  :$order_id!,<br/>    Hash :$data!|Creates new Shipment for given Order.|POST|/V1/order/:orderId/ship|
|invoice-refund|    Hash $config,<br/>    Int  :$invoice_id!,<br/>    Hash :$data!|Create refund for invoice|POST|/V1/invoice/:invoiceId/refund|
|order-refund|    Hash $config,<br/>    Int  :$order_id!,<br/>    Hash :$data!|Create offline refund for order|POST|/V1/order/:orderId/refund|
## Magento::SalesRule
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|coupons|    Hash $config,<br/>    Int  :$coupon_id!|Get coupon by coupon id.|GET|/V1/coupons/:couponId|
|coupons|    Hash $config,<br/>    Hash :$data!|Save a coupon.|POST|/V1/coupons|
|coupons|    Hash $config,<br/>    Int  :$coupon_id!,<br/>    Hash :$data!|Save a coupon.|PUT|/V1/coupons/:couponId|
|coupons-delete|    Hash $config,<br/>    Int  :$coupon_id!|Delete coupon by coupon id.|DELETE|/V1/coupons/:couponId|
|coupons-delete-by-codes|    Hash $config,<br/>    Hash :$data!|Delete coupon by coupon codes.|POST|/V1/coupons/deleteByCodes|
|coupons-delete-by-ids|    Hash $config,<br/>    Hash :$data!|Delete coupon by coupon ids.|POST|/V1/coupons/deleteByIds|
|coupons-generate|    Hash $config,<br/>    Hash :$data!|Generate coupon for a rule|POST|/V1/coupons/generate|
|coupons-search|    Hash $config,<br/>    Hash :$search_criteria = %{}|Retrieve a coupon using the specified search criteria. This call returns an array of objects, but detailed information about each object’s attributes might not be included. See http://devdocs.magento.com/codelinks/attributes.html#CouponRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/coupons/search|
|sales-rules|    Hash $config,<br/>    Int  :$rule_id!|Get rule by ID.|GET|/V1/salesRules/:ruleId|
|sales-rules|    Hash $config,<br/>    Hash :$data!|Save sales rule.|POST|/V1/salesRules|
|sales-rules|    Hash $config,<br/>    Int  :$rule_id!,<br/>    Hash :$data!|Save sales rule.|PUT|/V1/salesRules/:ruleId|
|sales-rules-delete|    Hash $config,<br/>    Int  :$rule_id!|Delete rule by ID.|DELETE|/V1/salesRules/:ruleId|
|sales-rules-search|    Hash $config,<br/>    Hash :$search_criteria = %{}|Retrieve sales rules that match te specified criteria. This call returns an array of objects, but detailed information about each object’s attributes might not be included. See http://devdocs.magento.com/codelinks/attributes.html#RuleRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/salesRules/search|
## Magento::Search
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
## Magento::Store
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|store-store-views|    Hash $config|Retrieve list of all stores|GET|/V1/store/storeViews|
|store-store-groups|    Hash $config|Retrieve list of all groups|GET|/V1/store/storeGroups|
|store-websites|    Hash $config|Retrieve list of all websites|GET|/V1/store/websites|
|store-store-configs|    Hash $config||GET|/V1/store/storeConfigs|
## Magento::Tax
|Subroutine|Parameters|Description|HTTP<br/>Method|Path|
|:---|:---|:---|:---|:---|
|tax-rates|    Hash $config,<br/>    Hash :$data!|Create or update tax rate|POST|/V1/taxRates|
|tax-rates|    Hash $config,<br/>    Int  :$rate_id!|Get tax rate|GET|/V1/taxRates/:rateId|
|tax-rates|    Hash $config,<br/>    Hash :$data!|Create or update tax rate|PUT|/V1/taxRates|
|tax-rates-delete|    Hash $config,<br/>    Int  :$rate_id!|Delete tax rate|DELETE|/V1/taxRates/:rateId|
|tax-rates-search|    Hash $config,<br/>    Hash :$search_criteria = %{}|Search TaxRates This call returns an array of objects, but detailed information about each object’s attributes might not be included. See http://devdocs.magento.com/codelinks/attributes.html#TaxRateRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/taxRates/search|
|tax-rules|    Hash $config,<br/>    Hash :$data!|Save TaxRule|POST|/V1/taxRules|
|tax-rules|    Hash $config,<br/>    Hash :$data!|Save TaxRule|PUT|/V1/taxRules|
|tax-rules-delete|    Hash $config,<br/>    Int  :$rule_id!|Delete TaxRule|DELETE|/V1/taxRules/:ruleId|
|tax-rules|    Hash $config,<br/>    Int  :$rule_id!|Get TaxRule|GET|/V1/taxRules/:ruleId|
|tax-rules-search|    Hash $config,<br/>    Hash :$search_criteria = %{}|Search TaxRules This call returns an array of objects, but detailed information about each object’s attributes might not be included. See http://devdocs.magento.com/codelinks/attributes.html#TaxRuleRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/taxRules/search|
|tax-classes|    Hash $config,<br/>    Hash :$data!|Create a Tax Class|POST|/V1/taxClasses|
|tax-classes|    Hash $config,<br/>    Int  :$tax_class_id!|Get a tax class with the given tax class id.|GET|/V1/taxClasses/:taxClassId|
|tax-classes|    Hash $config,<br/>    Int  :$class_id!,<br/>    Hash :$data!|Create a Tax Class|PUT|/V1/taxClasses/:classId|
|tax-classes-delete|    Hash $config,<br/>    Int  :$tax_class_id!|Delete a tax class with the given tax class id.|DELETE|/V1/taxClasses/:taxClassId|
|tax-classes-search|    Hash $config,<br/>    Hash :$search_criteria = %{}|Retrieve tax classes which match a specific criteria. This call returns an array of objects, but detailed information about each object’s attributes might not be included. See http://devdocs.magento.com/codelinks/attributes.html#TaxClassRepositoryInterface to determine which call to use to get detailed information about all attributes for an object.|GET|/V1/taxClasses/search|
