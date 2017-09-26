use v6;
use Base64;

unit module Sales;

our sub creditmemo {
	entity => %{
        orderId => 0,
        items   => [

        ]
	}
}

our sub creditmemo-comments {
    %();
}

our sub creditmemo-emails {
    %();
}

our sub invoice-refund {
    %();
}

our sub invoices {
    %();
}

our sub invoices-capture {
    %();
}

our sub invoices-comments {
    %();
}

our sub invoices-emails {
    %();
}

our sub invoices-void {
    %();
}

our sub order-invoice {
    %();
}

our sub order-refund {
    %();
}

our sub orders {
    %();
}

our sub orders-address-update(
    Int :$entity_id,
    Int :$parent_id
) {
    entity => %{
        entityId      => $entity_id,
        parentId      => $parent_id,
        customerAddressId => 1,
        #customerId    => $customer_id,
        firstname     => 'Camelia',
        lastname      => 'Butterfly',
        postcode      => '90211',
        city          => 'Beverly Hills',
        street        => ['Zoe Ave'],
        regionId      => 12,
        countryId     => 'US',
        telephone     => '555-555-5555'
        #useForShipping => 'true'
    }
}

our sub orders-cancel {
    %();
}

our sub orders-comments {
    %();
}

our sub orders-create {
    %();
}

our sub orders-emails {
    %();
}

our sub order-ship {
    %();
}

our sub orders-hold {
    %();
}

our sub orders-unhold {
    %();
}

our sub shipment {
    %();
}

our sub shipment-comments {
    %();
}

our sub shipment-emails {
    %();
}

our sub shipment-track {
    %();
}

