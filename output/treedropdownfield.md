# TreeDropdownField

{{:treedropdownfield2.png|:treedropdownfield2.png}}

Creates a field which opens a dropdown (actually a div via javascript included for you) which contains a tree with the
ability to select a singular item for the value of the field. This field has the ability to store one-to-one joins
related to hierarchy or a hierarchy based filter.

**Note:** your source object must use an implementation of hierarchy for this field to generate the tree correctly, e.g.
groups, sitetree etc.

All operations are carried out through behaviour and javascript.

For arguments, please see the API documentation. 

Examples.

treedropdownfield is used on [virutalpage](virutalpage) a class which creates another instance of a page, with exactly
the same fields that can be represented on another part of the site. The code below is taken from an example of this.

	:::php
	// Put this at the top of the class that defines your model (e.g. the class that extends DataObject).
	static $has_one = array(
	  'RightContent' => 'SiteTree'
	);
	
	// Setup the linking to the original page. (Put this in your getCMSFields() method or similar)
	$treedropdownfield = new TreeDropdownField("RightContentID", "Choose a page to show on the right:", "SiteTree");


This will generate a tree allowing the user to expand and contract subsections to find the appropriate page to save to
the field.

### API documentation

[Click here for the API
documentation](http://api.silverstripe.org/trunk/forms/fields-relational/TreeDropdownField.html).
