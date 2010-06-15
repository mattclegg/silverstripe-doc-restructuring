# Site Tree Importer Module

## Introduction

The site tree import module lets you take a tabbed out file of the following format, and load it into your CMS as a site tree.

~~~
Home
About
	Staff
		Sam
		Sig
Products
	Laptops
		Macbook
		Macbook Pro
	Phones
		iPhone
~~~


## Requirements
*  SilverStripe 2.3



## Download

See [silverstripe.org/sitetree-importer-module](http://silverstripe.org/sitetree-importer-module/)

## Installation

There is only one step beyond simel

*  Visit the URL ''SiteTreeImporter?flush=1'' on your site; eg, http://localhost/mysite/sitetreeimporter?flush=1 or http://www.example.com/sitetreeimporter?flush=1
*  Add a page - change its title to "Home", and its URL Segment will be changed to "home".  Save the page.
*  Update your DNS and, if necessary, your webserver configuration, so that your subdomain will point to the SilverStripe installation on your webserver.  Visit this new subdomain.  You should see the new subsite homepage.

## Usage

*  Make a tabbed-out file as directed in the form that appears above.  **Make sure that you use tabs, not spaces**.
*  Visit the /SiteTreeImporter/ page.  
*  Select your tabbed-out file in the file field, and tick the other two boxes as appropriate:
    * **Clear out all existing content?** - This will delete everything from your site before running the importer.  Use with caution!  If you don't tick this, then the pages will be added to the existing site.
    * **Publish everything after the import?** - This will publish each of the pages that the importer creates.  If you don't tick this, then the pages will be left as draft-only.

## Related

 * [:modules:staticimporter](/modules/staticimporter)

