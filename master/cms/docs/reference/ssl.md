# Introduction
Switching between SSL and Non-SSL is handled by the [Director](director) class.

**Note:** Director::forceSSL() does not work if your site is in Dev mode, see ticket [#4509](http://open.silverstripe.org/ticket/4509) if you need to test in Dev.

# Recipes

## Force SSL Redirection on all pages
For some sites, you will want everyone to access them using SSL / HTTPS.  To facilitate this, put the following line into _config.php:

~~~
Director::forceSSL();
~~~

This will automatically every http:// request to https://

**Note:** You won't notice the redirection when accessing the URL using the Development Server hostname.


## Force SSL Redirection on certain page types
This technique forces SSL on some page types, while the base page type makes sure to redirect to non-SSL if need be. It will not do simply to call Director::setBaseURL with the non-SSL URL as the base, because this will cause your secure page to link to graphics, CSS, and other assets insecurely. More than that, your secure form will post insecurely. Such a setup will make modern browsers complain. So we will modify Page as well as MyPage, as shown below.



### Custom page type forcing SSL
~~~ {php}
class MySecurePage extends Page {
    /* ... */
}

class MySecurePage_Controller extends Page_Controller {
    
    function init() {
        parent::init();

        // causes an HTTP Redirect if in Non-SSL mode
        Director::forceSSL();
    }
    
    function SecurePage() {
        return true;
    }
}
~~~



### Page class modifications to return non-secure pages to HTTP
~~~ {php}
class Page_Controller extends ContentController {

    function init() {
        parent::init();
        if ( !$this->SecurePage() ) {
            $this->force_HTTP();
        }
    }
    
    function SecurePage() {
        return false;
    }
    
    // if we are on https, redirect to the http version of this page's URL
    function force_HTTP() {
        $page_url    = Director::absoluteURL( $_SERVER['REQUEST_URI'] );
        $https_regex = '{^https:}';
        if ( preg_match( $https_regex, $page_url ) ) {
            $new_url = preg_replace( $https_regex, 'http:', $page_url );
            Director::redirect($new_url);
        }
    }
}

~~~
