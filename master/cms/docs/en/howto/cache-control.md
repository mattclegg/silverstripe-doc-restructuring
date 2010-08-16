#  Cache control

By default, PHP add caching headers that make the page appear "purely dynamic".  This isn't usually appropriate for most
sites, even ones that are updated reasonably frequently.  In particular, the default PHP cache-control settings prevent
sites from appearing in the internet archive.  SilverStripe overrides the default settings with the following:

Default setting:

*  The Last-Modified date is set to be most recent modification date of any database record queried in the generation of
the page.
*  The Expiry date is set by taking the age of the page and adding that to the current time.
*  Cache-Control is set to max-age=86400, must-revalidate
*  Since a visitor cookie is set, the site won't be cached by proxies
*  Ajax requests are never cached.

Overriding these defaults

*  HTTP::set_cache_age($age) can be used to set the max-age component of the cache-control line, in seconds.  Set it to
0 to disable caching; the "no-cache" clause in Cache-Control and Pragma will be included.
*  HTTP::register_modification_date($dateString) can be used to set the modification date to something more recent than
the default.
* You can also override these settings while working in dev mode in your _config.php file by using;
	:::php
	if (Director::isDev()) {SSViewer::flush_template_cache();}
	
	
How it works:

*  DataObject::__construct() calls HTTP::register_modification_date() whenever a record comes from the database
*  Controllers::run() calls HTTP::add_cache_headers() before outputting the page 
