# Introduction

This page documents all the steps from an URL request to the delivered page. 
## .htaccess and RewriteRule

Silverstripe uses **[mod_rewrite](http://httpd.apache.org/docs/2.0/mod/mod_rewrite.html)** to deal with page requests.
So instead of having your normal everyday ''index.php'' file which tells all, you need to look elsewhere. 

The basic .htaccess file after installing SilverStripe look like this:
`<file>`
### SILVERSTRIPE START ###

`<Files *.ss>`
	Order deny,allow
	Deny from all
	Allow from 127.0.0.1
`</Files>`

`<Files web.config>`
	Order deny,allow
	Deny from all
`</Files>`

ErrorDocument 404 /assets/error-404.html
ErrorDocument 500 /assets/error-500.html

`<IfModule mod_alias.c>`
	RedirectMatch 403 /silverstripe-cache(/|$)
`</IfModule>`

`<IfModule mod_rewrite.c>`
	RewriteEngine On
	RewriteCond %{REQUEST_URI} ^(.*)$
	RewriteCond %{REQUEST_FILENAME} !-f
	RewriteRule .* sapphire/main.php?url=%1&%{QUERY_STRING} [L]
`</IfModule>`
### SILVERSTRIPE END ###

`</file>`
The `<Files>` section denies direct access to the template files from anywhere but the server itself.

The next section enables the rewriting engine and rewrites requests to ''sapphire/main.php'' if they meet the following
criteria:

*  URI doesn't end in .gif, .jpg, .png, .css, or .js

*  The requested file doesn't exist on the filesystem
''sapphire/main.php'' is called with the REQUEST_FILENAME (%1) as the ''url'' parameter and also appends the original
QUERY_STRING.

See the [mod_rewrite documentation](http://httpd.apache.org/docs/2.0/mod/mod_rewrite.html) for more information on how
mod_rewrite works.


## main.php

All requests go through main.php, which sets up the environment and then hands control over to Director. 

**See:** [The API documentation of main.php](http://api.silverstripe.org/trunk/sapphire/core/_sapphire---main.php.html)
for information about how main.php processes requests.
## Director and URL patterns

main.php relies on Director to work out which controller should handle this request.  Director will instantiate that
controller object and then call
[Controller::run()](http://api.silverstripe.org/trunk/sapphire/control/Controller.html#run).

**See:** [The API documentation of Director](http://api.silverstripe.org/trunk/sapphire/control/Director.html) for
information about how Director parses URLs and hands control over to a controller object.

In general, the URL is build up as follows: page/action/ID/otherID - e.g. http://www.mysite.com/mypage/addToCart/12. 
This will add an object with ID 12 to the cart.

When you create a function, you can access the ID like this:

	:::php
	 function addToCart ($request) {
	  $param = $r->allParams();
	  echo "my ID = ".$param["ID"];
	  $obj = DataObject::get("myProduct", $param["ID"]);
	  $obj->addNow();
	 }




## Controllers and actions

Controllers are the building blocks of your application.

**See:** [The API documentation for Controller](http://api.silverstripe.org/trunk/sapphire/control/Controller.html)


*  You can access the following controller-method with /team/signup

	:::php
	class Team extends DataObject {}
	
	class Team_Controller extends Controller {
	  function signup($id, $otherId) {
	    return $this->renderWith('MyTemplate');
	  }
	}


## SSViewer template rendering

See [templates](templates) for information on the SSViewer template system.

**See:** [The API documentation for SSViewer](http://api.silverstripe.org/trunk/sapphire/view/SSViewer.html)
