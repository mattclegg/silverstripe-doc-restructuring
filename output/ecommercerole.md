EcommerceRole is a DataObjectDecorator for the member class to allow additional  member fields for the module. It has a
base set of contact fields that can be  statically called anywhere in the system using
singleton('Member')-&gt;getEcommerceFields();  The OrderForm and MemberForm class uses this call.
[Click here for the API documentation](http://doc.silverstripe.com/assets/classes/ecommerce/EcommerceRole.html).
