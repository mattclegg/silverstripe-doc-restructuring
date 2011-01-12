 If you're making a page type to replace an existing class, you don't want CMS authors to be able to create pages of the
original type.

You can set the **$hide_ancestor** static variable to the name of the class that you're replacing, and it will no longer
be listed in the "create page" dropdown.

For example, in PerweekProduct.php:


	:::php
	  class PerweekProduct extends Product{
	  // do not show the given ancestor in CMSMain.AddPageOptionsForm, and potentially elsewhere too.
	  static $hide_ancestor = "Product";
	  static $db = array(
		"RRP" => "PerweekCurrency",
	         ... 

