# Introduction
From time to time, things will go wrong.  Here's a few things to try when you're confused:

##### Put ?flush=1 on the end of the URL
Putting ?flush=1 on the end of the URL will clear out all cached content; this is a pretty common solution to a lot of development problems.  Here are some specifics situations:

*  You've created a new SS or PHP file
*  You've edited a nested template (one inserted with the <% include %> tag)
*  You've published a new copy of your site
*  You've upgraded your version of SilverStripe

##### Visit (mysite)/dev/build?flush=1
Visiting db/build runs a script that will check the database schema and update it as necessary.  Putting ?flush=1 on the end makes sure that nothing that's linked to the old database structure will be carried over.  If things aren't saving, pages aren't loading, or other random things aren't working it's possible that the database hasn't been updated to handle the new code.  Here are some specifics situations:

*  You've created a new page type / other data object type
*  You've change the type of one of your database fields
*  You've published a new copy of your site
*  You've upgraded your version of SilverStripe

##### Put images/flush to the end of the URL
If you've changed the resize functions of your image uploaders you can run this again - and all the images will be resampled to the new arguments for the GD functions. This also, in some cases, repairs broken image links that can happen from time to time.


##### Publish your draft content
If you've set up your site and it used to be working, but now it's suddenly totally broken, you may have forgotten to publish your draft content.  Go to the CMS and use the "publish" button.  You can visit //**admin/publishall**// to publish every page on the site, if that's easier.

##### Clear Browser Cache
If you have made sure the templates have been flushed ?flush=1 you should try Ctrl + F5 to clear your browsers cache.

##### Procedural PHP Output
Please make sure all code inside '*.php' files is wrapped in classes. Due to the way [ManifestBuilder](ManifestBuilder) includes all files with this extension, any **procedural code will be executed on every call**. Most common error here is putting a test.php/phpinfo.php file in the document root. See [datamodel](datamodel) and [controllers](controllers) for ways how to structure your code.

Example: Wrong file /<mysite>/phpinfo.php
~~~ {php}
<?php
phpinfo(); // this will execute and output before any Silverstripe-code
~~~


## Installation problems

##### File permissions

*  The php installer needs to be able write files during installation, which should be restricted again afterwards. It needs to create/have write-access to:
     * The main installation directory (for creating .htaccess file and assets directory)
     * The mysite folder (to create _config.php)
     * After the install, the assets directory is the only directory that needs write access.
        * Image thumbnails will not show in the CMS if permission is not given 


##### mod_rewrite

mod_rewrite not configured correctly. The module needs to be enabled, and AllowOverride needs to be enabled for the current path


##### Lighttpd since version 1.4.18 breaks rewrite

*  lighttpd 1.4.18 does not support rewrites inside $HTTP['url'] conditional
 SilverStripe CMS essentialy depends on rewrites, so here is a quick fix for version 1.4.18 and later.

~~~

var.usualUrlCharClasses = "[\w\d\%\&\/\\\-\_\+\=\@\.\,\>\<\~]"

server.error-handler-404   = "/sapphire/main.php"

url.rewrite-once = (
	"^([^\?\ ]*\.pdf)$" => "$1",
	"^([^\?\ ]*\.swf)$" => "$1",
	"^([^\?\ ]*\.gif)$" => "$1",
	"^([^\?\ ]*\.jpg)$" => "$1",
	"^([^\?\ ]*\.jpeg)$" => "$1",
	"^([^\?\ ]*\.png)$" => "$1",
	"^([^\?\ ]*\.xbm)$" => "$1",
	"^([^\?\ ]*\.xpm)$" => "$1",
	"^([^\?\ ]*\.css)$" => "$1",
	"^([^\?\ ]*\.html)$" => "$1",
	"^([^\?\ ]*\.htm)$" => "$1",
	"^([^\?\ ]*\.js)$" => "$1",
	"^([^\?\ ]*\.text)$" => "$1",
	"^([^\?\ ]*\.txt)$" => "$1",
	"^([^\?\ ]*\.dtd)$" => "$1",
	"^([^\?\ ]*\.xml)$" => "$1",
	"^/assets/(.*)$" => "/assets/$1",
	"^/("+usualUrlCharClasses+"*)\??(.*)" => "/sapphire/main.php?url=$1&$2",
	)
~~~

*  This should handle most of cases

*  usualUrlCharClasses - is pretty much all available chars that go in to URL's, the regexp is **not exhaustive** if you create sites with national characters in URLs please test and modify the regexp. You can possibly change it to "[^\?]"(anything BUT a question mark)

*  Tested on Fedora Core 6 and 7 and FreeBSD with PHP 5.1 and 5.2
*  Put this into your lighttpd.conf or included configuration files (see lighttpd docs for further reference)



## Basic Questions once installed
== How do I access custom methods in my controller class in my template==
Just add $myMethod in your template (e.g. page.ss) and you will get data from your method. You can also do it by browsing to http://www.mysite.com/mypage/mymethod/

## Problems with customization
##### Sapphire core only, no CMS, no jsparty
These are some general notes relating to the creation of a site that didn't do things 'normally' (e.g. it doesn't use cms/ or jsparty/, just the sapphire/ core)

*  ErrorPage requires a Page class (which isn't created for you unless you use the installer etc). I didn't need one for the project, but ended up creating a blank one to appease ErrorPage
*  Page needs to extend SiteTree, not DataObject. (This will be a problem when you want to move SiteTree into cms, because ErrorPage needs to extend SiteTree so that it can call methods on the Versioned decorator that SiteTree defines)
*  There's no PagelessController-type implementation that I could find. I wound up not needing it (just linking to the class name instead), but SS has a number of project-specific PagelessController-type classes that we could use if it was in the core.
    * This would be cool because a lot of times, deleting a page accidentally in the CMS can destroy functionality - e.g. deleting the 'Search Results' page means that all the search boxes on your site no longer work. Using PagelessController, the Search Results page wouldn't show up at all in the CMS.
*  Can't create abstract base classes, because SS tries to instantiate every class it can find. Ended up using a base object that just had all the methods defined with user_error() function calls inside instead - ultimately achieves the same thing, but with more effort.
    * Another way to do this would be to use implementors - put the methods you want a class to define in an interface and them implement that interface on all sub-classes. Just need to make sure all sub-classes implement the interface properly.
      * Solution: Move ModelAsControlller, ContentController, SiteTree, ErrorPage, and other cms-related DataObject/Controller types into cms.
      * Solution: Move the director rules into CMS
      * Solution: Genericise the PagelessController implementation from uplay or another project, clean up and deficiencies that we've learned during its development, and move it into sapphire.

