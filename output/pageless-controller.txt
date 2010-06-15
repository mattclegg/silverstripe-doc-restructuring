# Creating a Pageless Controller

**REQUIRES SILVERSTRIPE 2.3.0 OR GREATER**

Sometimes, it's not appropriate to include a page in the site tree for the function that you are building.  However, you still want to be able to keep your system fitting in with the standard look and feel of the site.

As of SilverStripe 2.3.0, this is very easy to achieve:

*  Create a controller that is a subclass of ''Page_Controller''
*  Define ''Title()'' and ''Content()'' methods

Here is a simple example taken from the [modules:sitetreeimporter](modules/sitetreeimporter) module.

~~~ {php}
<?php

class SiteTreeImporter extends Page_Controller {

	function init() {
		parent::init();
		if(!Permission::check('ADMIN')) Security::permissionFailure();
	}
	
	function Title() {
		return "Site Tree Importer";
	}
	
	function Content() {
		return "<p>This tool will let you generate pages from a text file"
			. " that has a site-tree represented with tabs.</p>"
	}

	...
}

?>
~~~
