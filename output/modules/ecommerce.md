
# E-commerce module

The e-commerce module lets you add online shopping to your site.

By default, it sets up a basic structure of some product groups, two products, a checkout page, an account page and a
terms and conditions page to describe your terms of use. These are used for examples, and the content for each
e-commerce page type can be changed like a normal page would using the SilverStripe CMS.

## Download

* 
[0.5.2](http://open.silverstripe.com/changeset/latest/modules/ecommerce/tags/0.5.2?old_path=/&filename=/modules/ecommerce/tags/0.5.2&format=zip)
(Latest Release)

*  [Daily
Build](http://open.silverstripe.com/changeset/latest/modules/ecommerce/trunk?old_path=/&filename=/modules/ecommerce/trunk&format=zip)
("trunk")

## Setting up

These were originally noted by Sam and extended by Sean to provide a broader understanding of what they do. Add these
setup changes to the **mysite/_config.php** file in your project folder.


### Payment processor setup

Currently the e-commerce module supports DPS (Direct Payment Solutions) via PxPost, and WorldPay for credit card
processing.

DPS and WorldPay and cheque are integrated into the e-commerce module out of the box. By default, the only payment type
accepted is cheque unless you enable DPS or WorldPay using the configuration.

The setup for payment methods is a line in mysite/_config.php, for example:

	:::php
	// Define which payment methods your site uses.
	Payment::set_supported_methods(array(
		'WorldpayPayment' => 'Credit card (WorldPay)'
	));


   * Parameters for ''Payment::set_supported_methods()''
      * ''array('PaymentClassName' => 'Title of payment method')''


### Setting up WorldPay

If you want to use WorldPay, you can add these lines to the same file we did above to set up your account.

You can also choose what the mode the processor operates in (''100'' is test, ''0'' is live).

The callback password needs to be defined so that WorldPay can redirect back to the site after WorldPay has processed
the payment. **(WARNING: Your site *needs* to be accessible by WorldPay (not password protected, like in a local
environment) for the callback to work. If callback fails, you will have to re-enable callback in your WorldPay
configuration (on the WorldPay site).)**

	:::php
	// Define which payment methods your site uses.
	Payment::set_supported_methods(array(
		'WorldpayPayment' => 'Credit card (WorldPay)'
	));


	:::php
	// Set the installation ID of your WorldPay account.
	WorldpayPayment::set_installation_id(111111);
	
	// Check if the site is in 'live' mode, use WP live mode.
	// otherwise, use WP test mode instead to be careful.
	if(Director::isLive()) {
		WorldpayPayment::set_testmode(0);
	} else {
		WorldpayPayment::set_testmode(100);
	}
	
	// Set the callback password for your account
	WorldpayPayment::set_callback_password(blahblah);


### Setting up DPS

Setting up DPS to work with the e-commerce module is a simple process of using the following code in your project's
_config.php file, and making sure the credentials are correct with your DPS account.

If you are signing up for a brand new DPS account, please ensure that you are using PxPost. Details of this can be found
at:
[http://www.dps.co.nz/technical_resources/ecommerce_nonhosted/pxpost.html](http://www.dps.co.nz/technical_resources/ecommerce_nonhosted/pxpost.html)

	:::php
	// Define which payment methods your site uses.
	Payment::set_supported_methods(array(
		'DPSPayment' => 'Credit card (DPS)'
	));


	:::php
	// Check if the site is in 'live' mode, use the live credentials.
	// otherwise, use test credentials instead to be careful.
	if(Director::isLive()) {
		DPSPayment::set_account('MyDPSAccountLive', '11111111');
	} else {
		DPSPayment::set_account('MyDPSAccountDev', '11111111');
	}



*  Arguments for ''DPSPayment::set_account()''
     * The DPS username
     * The password to authorise transactions

**Testing DPS**

A page for reference in terms of testing your DPS account with the e-commerce module can be found here:
[https://www.paymentexpress.com/knowledge_base/faq/developer_faq.html#testing](https///www.paymentexpress.com/knowledge_base/faq/developer_faq.html#testing)

### Setting up PayPal

To set up a PayPal payment, you need only the mail address of the account

	:::php
	// Check if the site is in 'live' mode, use the live credentials.
	// otherwise, use test credentials instead to be careful.
	if(Director::isLive()) {
		PayPalPayment::set_account_email('mymail@mydomain.com');
	} else {
		PayPalPayment::set_test_mode('mymailtest@mydomaintest.com');
	}


### Multiple payment methods

For example, if you want DPS and cheque as accepted payments on your site you would have something like this as your
Payment::set_supported_methods(array()) function in ''**mysite/_config.php**'':

	:::php
	// Define which payment methods your site uses.
	Payment::set_supported_methods(array(
		'DPSPayment' => 'Credit card (DPS)',
		'ChequePayment' => 'Cheque'
	));



### Shipping Calculation

By default, there is no shipping cost added to products. However, out of the box there is support for a fixed shipping
price for each country. You can define this by editing your ''_config.php'' file within the project directory (typically
''mysite'' on a default installation of SilverStripe).

Below is an example of how you would define this inside ''**mysite/_config.php**'':

This example below shows a fixed shipping price for all countries:

	:::php
	// Set a flat rate for shipping charges on an order.
	SimpleShippingCalculator::set_charges(5);


And this example demonstrates a fixed price of 5 for any country, with an override of 10 if the country shipping to is
Australia (AU):

	:::php
	// Set a flat rate for shipping charges on an order. If the user is from AU
	// (Australia), then their shipping becomes 10 for an order (overrided).
	SimpleShippingCalculator::set_charges(5);
	SimpleShippingCalculator::set_charges_for_countries(array(
		'AU' => 10,
	));


For a list of country codes you can use, please visit
[http://www.bcpl.net/~j1m5path/isocodes.html](http://www.bcpl.net/~j1m5path/isocodes.html)

### Tax Calcuation

Tax calculation is used for adding country tax onto orders. You can easily configure this the same way you would with
shipping calculation.

By default, there is no tax charged.

Below is an example of how to use tax calculation. It is added into ''**mysite/_config.php**'':

	:::php
	// Set the tax calculation to be for NZ customers at 12.5% exclusive
	// on the order price.
	TaxCalculator::set_for_country("NZ", 0.125, "GST", "exclusive");



*  Arguments for ''TaxCalculator::set_for_country()''
     * 2 letter country code.
     * Tax rate, float from 0-1.
     * Name of the tax, such as "GST" or "VAT".  Displayed on the user-interface.
     * "exclusive" / "inclusive" - how is the tax calculated.



### Setting Currency

You can choose which currency your site operates in. If you don't specify a currency in ''**mysite/_config.php**'' then
it defaults to USD (US Dollars).

   * A single currency can be used across the entire site.
   * It can be any currency that your payment processor supports.

Below is an example of how to choose the NZD currency. It is added into ''**mysite/_config.php**'':
 

	:::php
	// Set the currency of the site to be in NZD (New Zealand Dollars).
	Order::set_site_currency("NZD");


### Emails

After a user purchases their order they receive an email from the system showing a summary of what they ordered, and the
details that they submitted on the order form.

Below is an example of how to choose the email customers will see (the from address) when they receive their emails.
This email address also receives a copy of the receipt the customer will get (with their order details). It is defined
in ''**mysite/_config.php**'' like below:

	:::php
	// Set the email of the admin who looks after receiving the order emails.
	Order::set_email('bob@mygreatshop.com');


If you don't define ''Order::set_email()'' inside ''**mysite/_config.php**'' then it will attempt to get the admin email
address as defined in ''**Email::setAdminEmail()**''. Failing that, it won't send any admin emails at all until you
define one in **''mysite/_config.php''**.





## Extending

### Templates / CSS

#### CSS

Overriding the default CSS in the e-commerce module is easy. The classes like ''CheckoutPage'' are setup to use the
''CheckoutPage.css'' file found in the module (built for the Black Candy theme). You can, however, place a file of the
same name inside your project folder. For example, if you place CheckoutPage.css inside ''mysite/css/'' it will override
''ecommerce/css/CheckoutPage.css'' with your one as preference. All the main CSS files in the e-commerce module are
setup to do this using the init() function and Requirements::css().

#### Templates

Overriding the templates is the same as overriding the CSS. You would simply copy the template used in the module into
your project directory, as we would do above with CSS and it would take preference to your one over the e-commerce
module default template.



### Order form customisation

If you want to add or remove fields to the order form or my account page, you can create a Member role decorator with an
augmentEcommerceFields function defined.  This function will be passed a fieldset object with the member-specific
fields.  It won't include any payment fields, or the separate shipping address selector.

If you wish to show different fields for new users, you can check to see if $this->owner->ID has a value.  New users
will have this function called on the singleton object, which has no ID#.

	:::php
	class MyCustomRole extends DataObjectDecorator {
		function augmentEcommerceFields(&$fields) {
			// Returning users shouldn't be shown phone / email fields
			if($this->owner->ID) {
				$fields->removeByName('HomePhone');
				$fields->removeByName('MobilePhone');
				$fields->removeByName('Email');
			}
	
		}
	}


**Note:** This change went into trunk 2007-14-12, and won't be available in a stable release until 0.6.

### Shipping calculation

#### Introduction

By default the class ''**SimpleShippingCalculator**'' is used to calculate shipping. However, developers are able to
create their own classes to calculate shipping based on a custom set of rules.

#### Getting started

First of all, to override the default ''**SimpleShippingCalculator**'' class with an example class called
''**CustomShippingCalculator**'' you can use the line in your project ''**_config.php**'' file like this:

	:::php
	Object::useCustomClass('ShippingCalculator', 'CustomShippingCalculator');


Once you've done this, you can then create your file inside your project (inside ''**mysite/code**''  - replace mysite
with your project name if it isn't mysite) called ''**CustomShippingCalculator.php**'' and set it up like this, which
extends ''**ShippingCalculator**'':

	:::php
	<?php
	
	class CustomShippingCalculator extends ShippingCalculator {
	
	  function getCharge(Order $o) {
	    // insert logic to do shipping calculation, refer to SimpleShippingCalculator for how this works
	  }
	}
	
	?>


#### Where to from here?

You can examine **''SimpleShippingCalculator''** to see how that class works to calculate shipping as an example. From
there you're free to create it how you see fit.

There is also an experimental ''**WeightBasedShipping**'' class in the e-commerce code which can be used as a reference.

### Adding more payment methods

The e-commerce module features a Payment API that can be easily extended to allow addition of another payment gateway,
currently DPS and WorldPay have already been integrated into the module and are available to use. However, if you want
to add your own payment gateway a good place to start would be sub-classing Payment.

For example:

	:::php
	class CustomPayment extends Payment {
	
	// insert your payment code here, refer to DPSPayment.php or WorldpayPayment.php
	// for reference.
	
	}
	


Then, to use CustomPayment as a payment method you can use this:

	:::php
	// Define which payment methods your site uses.
	Payment::set_supported_methods(array(
		'CustomPayment' => 'My Custom Payment'
	));


Obviously you will want to rename 'Custom' to something a bit more appropriate to what gateway you're trying to
implement for your e-commerce site.

To get an idea of how DPS and WorldPay are currently implemented please see ''DPSPayment.php'' and
''WorldpayPayment.php'' which are included with the module.

## Known issues

WorldPay: The receipt email doesn't get sent out because of inaccurate information generated in it.

## Changelog

To see the changelog, [ecommerce-changelog](ecommerce-changelog).

## Features

### Version 0.5 - initial beta release

   * Standard fields:  
      * Product name *in the form of Page title/Navigation label*
      * Price *number inserted and currency can be changed using site-wide currency setting*
      * Author *this is optional, and suitable for books*
      * Product Groups *groups can be nested, e.g. having sub-groups*
      * Image-upload *standard size of 100x100px thumbnail and 200x200px large image*  
   * Deals with sales tax
      * Tax is set on a country by country basis
      * If no tax set for a particular country, the user doesn't see it
      * Can be set as inclusive or exclusive

   * CC Payments via DPS and WorldPay
   * Multiple Currency Support *You can set the currency on a site-wide basis - any currency is usable provided the
payment gateway like DPS supports it*
   * Featured products
   * Reports
      * Unprinted orders
      * Find an order
      * All products
      * Product popularity
   * Disable buying
   * T&C checkbox on checkout page

   * Fullfillment status
      * Statuses: Unpaid, Paid, Product Sourced, Product Sent, Product Received, Cancelled
      * Add form to details: Status Dropdown, Notes. 
         * Email buyer of new status (tickbox)
         * Show log (date/new status/note/cms user)
      * Update Find-A-Order report to show FullfullmentStatus and latest note-date
      * Add print icon to right, clicking number just shows it

### Proposed Features

   * Multiple-category support *Create some countries, and then set up exchange rates. Automatic cron job to update
exchange-rates*

   * Product sizes/colours/types. 
      * Stage 1. Just a list of options (e.g. red, blue, green, Big, Green, Small), but same weight/price for all
      * Stage 2. Different weights, prices and possibly photos could for the types.
   * Fulfillment
   * Inventory system - stock levels change automatically as goods are bought, and levels are updated.

   * Reserve funds then bill (payable)
   * Support for non New Zealand-centric businesses.



## Class Overview

Here is a small guide through all the classes included in the e-commerce platform.  





### Page types

The following classes extend the Page class:

*  AccountPage

*  CheckoutPage

*  Product

*  ProductGroup

*  EcommerceTermsPage













### Controllers

The following classes extend the Controller class: 

*  CheckoutPage_Controller

*  AccountPage_Controller

*  WorldpayPayment_Handler

*  PayPalPayment_Handler

*  Product_Controller

*  ProductGroup_Controller

*  EcommerceTermsPage_Controller

*  Order_Controller

*  Report_ProductReport_Controller

*  ViewAllProducts

### DataObject Extensions

The following classes extend the DataObject class:

*  Product_Attribute

### Forms

The following classes extend the Form Class:

*  MemberForm

*  OrderForm


### RequiredFields

The folliwng classes extend the RequiredField class:

*  EcommerceRequiredFields

### DataObjects

The following classes extend the DataObject class:

*  Product_Attribute

*  Order

*  Order_Item

*  Order_Item_Attribute

*  OrderStatusLog

*  Payment (in turn extended in this module by several classes)

### DataObjectDecorators

The following classes extend the DataObjectDecorators class:

*  EcommerceRole

### Payment Objects

The following classes extend the Payment class:

*  PayPalPayment

*  WorldpayPayment (note that WorldpayPayment_Handler extends the Controller class)

*  ChequePayment

*  DPSPayment

### Objects

The following classes extend the Object class:

*  ShippingCalculator - Abstract Class 

*  WeightBasedShipping - extends ShippingCalculator 

*  SimpleShippingCalculator - extends ShippingCalculator 

*  ShoppingCart

### ViewableData

The following classes extend the ViewableData class:

*  TaxCalculator

*  Report

### Reports

The following classes extend the Report class (the Report class is also defined in the e-commerce module):

*  Report_CurrentOrders

*  Report_FindAnOrder

*  Report_AllProducts

*  Report_ProductPopularity
 

### EmailTemplates

The following classes extend the Email_Template class:

*  Order_receiptEmail

*  Order_statusEmail

###  SideReports

The following classes extend the SideReport class:

*  EcommerceSideReport_FeaturedProducts

*  EcommerceSideReport_AllProducts

*  EcommerceSideReport_FeaturedProducts

*  EcommerceSideReport_AllProducts

*  FindOrderReport

*  OrderReport

*  OrderReport_Popup

### Other Classes

The following are stand alone classes for the ecommerce module:

*  DPS

*  DPS_MifMessage


# Core classes











## Overview

Here is a diagram on how the [data model](/datamodel) works for the eCommerce module core classes.

{{:ecommerce:data_model_0.21.png|:ecommerce:data_model_0.21.png}}

The eCommerce data model is centred around the
[Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html) and
[OrderAttribute](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderAttribute.html) classes. Each of
these core classes are [data bound](/dataobject) classes, meaning that instances of them are designed to be saved into
the [database](/database-structure), which describes the order. Both extend from [DataObject](/dataobject) in order to
achieve this. These two classes make up the bulk of the core eCommerce system, and as a result most of the other
components in the eCommerce package link to it in some form, either directly or indirectly. For example, the
[Product](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Product.html) class, which contains information
about the item for sale indirectly associates with
[Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html) through the
[Product_OrderItem](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Product_OrderItem.html) class, which
is an extension from [OrderItem](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderItem.html).

An [Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html) has a
//[one-to-many](/datamodel#has_many)// relationship with multiple classes. Specifically, an
[Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html) has a a
//[one-to-many](/datamodel#has_many)// relationship with these classes (as of the current version of eCommerce):


*  [OrderAttribute](#orderattribute) ([see API
documentation)](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderAttribute.html)

*  [OrderStatusLog](#orderstatuslog) ([see API
documentation)](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderStatusLog.html)

*  [Payment](#payment) ([see API
documentation)](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Payment.html)

To describe the //[one-to-many](/datamodel#has_many)// relationship for one of these classes to
[Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html), we will take
[Payment](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Payment.html) as an example.

An [Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html) has many
[Payment](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Payment.html) class instances related to it.
This would be the payments that make up the order from the customer who purchased the goods. The customer usually would
make one payment, which is the cost of the entire order. However, if they wished, they could pay for their order in
parts - such as half at the start, and another half later on. This is why an
[Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html) has many
[Payment](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Payment.html)s related to it, because it can
allow for multiple payments for an order.

[Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html) also has a
//[many-to-one](/datamodel#has_many)// relationship with [Member](/member), so a [Member](/member) can have many
**Orders**, and an [Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html) has one
[Member](/member). This [Member](/member) instance would be the person who ordered the goods, and thus makes up the
billing details of the order.








## Order

[Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html) is a core class to the eCommerce
module. It contains many number of "Order attributes" (see [OrderAttribute](#orderattribute)), properties, payments, and
functions for determining what's in the order at the time of checkout, finding out the current currency, and tax
information on order if applicable. It's also responsible for being the "glue" for all the other eCommerce core
components, in that it communicates with multiple classes.

A specific example of a property on [Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html) is
a boolean flag called **UseShippingAddress** that determines whether the order is to be shipped to an alternate address
than the member (billing) address who created the order. The alternate address is stored on the
[Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html) as well, through the **ShippingName**,
**ShippingAddress** and such properties. It also contains a **Status** property - for example, after the goods for that
order have been shipped, the **Status** property on Order would be set as *Sent*, thus giving an accurate representation
of where the order is currently at.

[Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html) has a
//[one-to-many](/datamodel#has_many)// relationship with multiple classes that make up the order. Here they are at the
time of writing:


*  [OrderAttribute](#orderattribute) ([see API
documentation)](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderAttribute.html)

*  [OrderStatusLog](#orderstatuslog) ([see API
documentation)](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderStatusLog.html)

*  [Payment](#payment) ([see API
documentation)](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Payment.html)

There are also some helper classes that relate to
[Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html):


*  [ShoppingCart](#shoppingcart) ([see API
documentation)](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/ShoppingCart.html)




## OrderAttribute

[OrderAttribute](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderAttribute.html) directly relates to
the [Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html) class, many
[OrderAttribute](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderAttribute.html) instances make up an
[Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html). [OrderModifier](#ordermodifier) and
[OrderItem](#orderitem) are two implementations of OrderAttribute, which provide specific functionality that modifies or
links products to the order. They are designed to be abstract, so a developer can create additional extensions which
implement existing [OrderModifier](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderModifier.html) and
[OrderItem](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderItem.html) features.

[OrderItem](#orderitem) and [OrderModifier](#ordermodifier) have functionality that is directly baked into the **Order
class**, so that the [Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html) knows what to do
with the functionality. We will now go through
[OrderModifier](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderModifier.html) and
[OrderItem](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderItem.html) explaining how they fit in,
and how to set them up.





### OrderModifier

**Introduction**

Order modifiers are a way of adding or deducting an amount to an order, for example, a tax calculator which adds
additional tax to an order, or a shipping module.

Two examples of existing functionality that implement OrderModifier are:


*  [SimpleShippingModifier](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/SimpleShippingModifier.html)

*  [TaxModifier](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/TaxModifier.html)

If any of these are enabled, they will change the order total by adding or subtracting from the total. Each have their
own encapsulated methods which handle the logic of how much to add or subtract based on the situation of the shop user.
Both SimpleShippingModifier and TaxModifier add to the total in this case, however, a modifier can be created that would
deduct an amount from the order instead of adding to it.

**Setting up**

''Order::$modifiers'' is a array of the OrderModifiers classes that are recognised as being "in use". They are defined
by calling ''Order::set_modifiers(Array)'' where ''Array'' is an array of
[OrderModifier](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderModifier.html) subclasses that should
be enabled. e.g. in your _config.php for your project:

	:::php
	Order::set_modifiers(array(
	   'SimpleShippingModifier',
	   'TaxModifier'
	));


**Extending**

In the above example, we've enabled
[SimpleShippingModifier](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/SimpleShippingModifier.html), and
[TaxModifier](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/TaxModifier.html). Each of these implement
[OrderModifier](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderModifier.html) by subclassing it. The
required variables/functions to be implemented are:

''$is_chargable'' [see API
documentation](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderModifier.html#$is_chargable)

''LiveAmount()'' [see API
documentation](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderModifier.html#LiveAmount)

''TableTitle()'' [see API
documentation](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderModifier.html#TableTitle)

**Example**

Here is a simple example of an
[OrderModifier](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderModifier.html) in action. In this
case, we have a simple voucher system that just takes $10 off the total of the order.

	:::php
	<?php
	
	class VoucherModifier extends OrderModifier {
		
		protected static $is_chargable = false;
	
		function LiveAmount() {
			return 10;
		}
		
		function TableTitle() {
			return 'Voucher deduction';
		}
		
	}
	
	?>


We also need to add VoucherModifier to the initialized modifier classes. This is done by defining
''Order::set_modifiers()'' - e.g.:

	:::php
	Order::set_modifiers(array(
	   'VoucherModifier'
	));


Now when someone creates a new order by adding items to their cart, the modifier is enabled and calculates how much is
to be deducted from the total price of their cart items.









### OrderItem

[OrderItem](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderItem.html) is the class that handles
determining what data type should be for purchase. By default, it's a Product data type.
[OrderItem](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderItem.html) is the base class for all
types of data that can be purchased. To show an example of the
[Product](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Product.html) data type being purchasable as an
order item, see [Product_OrderItem in the API
documentation](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Product_OrderItem.html).

Usually you would just use
[Product_OrderItem](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Product_OrderItem.html) to relate your
Product(s) to an [Order](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Order.html). However, if you want
to apply another type of data to be an
[OrderItem](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderItem.html), then you need to subclass
[OrderItem](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/OrderItem.html). For example, you may want to
put an event for sale, which should use the same checkout as normal products. In which case you'd call your class
Event_OrderItem where "Event" is the class name of the data type, and should be in the same file. In this case,
Event.php.


*  See [Product_OrderItem in the API
documentation](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Product_OrderItem.html) for an example of
how the standard [Product](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Product.html) data type has
been implemented.






## Payment

Payment is the base "abstract" class for all manner of payment types, ranging from cheque, to paypal to custom credit
card payment gateway solutions.

By default, a number of implementations come out of the box with the eCommerce module. Here they are, at the time of
writing:


*  [ChequePayment](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/ChequePayment.html)

*  [DPSPayment](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/DPSPayment.html) (for Direct Payment
Solutions pxPost non-hosted - [http://www.paymentexpress.com](http://www.paymentexpress.com))

*  [PayPalPayment](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/PayPalPayment.html)
([https://www.paypal.com/IntegrationCenter/ic_standard_home.html](https///www.paypal.com/IntegrationCenter/ic_standard_home.html))

*  [PaystationHostedPayment](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/PaystationHostedPayment.html)
([http://www.paystation.co.nz](http://www.paystation.co.nz))

*  [PaystationPayment](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/PaystationPayment.html)
([http://www.paystation.co.nz](http://www.paystation.co.nz))

*  [WorldpayPayment](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/WorldpayPayment.html) (for WorldPay -
[http://www.worldpay.com](http://www.worldpay.com))

*  [EwayXMLPayment](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/EwayXMLPayment.html) (eWAY -
[http://www.eway.com.au](http://www.eway.com.au))

In order to create your own types of payment, you need to create a new class that subclasses Payment.

There are some methods that must be implemented on your class in order for the payment to operate correctly. These are:


*  ''processPayment()'' ([See API
documentation)](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Payment.html#processPayment)

*  ''getPaymentFormFields()'' ([See API
documentation)](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Payment.html#getPaymentFormFields)

*  ''getPaymentFormRequirements()'' ([See API
documentation)](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/Payment.html#getPaymentFormRequirements)

See [DPSPayment in the API documentation](http://api.silverstripe.org/modules/ecommerce/trunk/ecommerce/DPSPayment.html)
for an example of how DPS is implemented for Payment.

