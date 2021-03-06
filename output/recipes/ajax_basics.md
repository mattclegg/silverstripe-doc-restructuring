# Ajax in Silverstripe


Ajax ([http://en.wikipedia.org/wiki/Ajax_framework](http://en.wikipedia.org/wiki/Ajax_framework)) makes pages faster and
more user-friendly. Gmail is a great example of how Ajax can be used to create faster working applications.

Here is how to do it in Silverstripe.  For this example, we will use JQuery (http://jquery.com) to assist with the Ajax
calls.  Silverstripe usually employs prototype (http://www.prototypejs.org/)  as its Javascript library of choice.
Jquery has been used here because its syntax is even shorter than prototype.












## PHP code

Here is the /mysite/code/Page.php page:

	:::php
	
	class Page extends SiteTree {
	   static $db = array();
	   ......
	} 
	
	class Page_Controller extends ContentController {
	 
	 // below we work out if the page is called as AJAX or as a normal page
	 // the init function always runs.
	 // we have added the $_GET["ajaxDebug"] for testing purposes
	 // you can test the ajax output by loading the page as /mysite/?ajaxDebug=1
	 function init(){
	  //add a javascript library for easy interaction with the server
	  Requirements::javascript('mysite/javascript/jQuery.js');
	  if(Director::is_ajax() || $_GET["ajaxDebug"]) {
	   $this->isAjax = true;
	  }
	  else {
	   $this->isAjax = false;
	  } 
	  parent::init();
	 }
	 
	 // if no action is called (i.e. the URL does not have a second part to it)
	 // www.mysite.com/mypage rather than www.mysite.com/mypage/myaction/ 
	 // then the index function runs automatically
	 function index() { // index runs if no other function is being called - it is like a second init()
	  if($this->isAjax) {
	   // do something 
	  }
	  else {
	   // do something else
	  }  
	 }
	 
	 // see comments below for explanation
	 function addProduct($action) {
	  $productNumber = Director::urlParam("ID"); // you can also put $productNumber = $action["ID"];
	  $this->addProductToDatabase($productNumber);
	  if($this->isAjax) {
	   return "your product (# $productNumber) has been added";
	  }
	  else {
	   return Array();
	  }
	 }
	 function showImage () {
	  if($this->isAjax) {
	   return $this->renderWith("ajaxSnippet");
	  }
	  else {
	   return Array();
	  }
	 }
	}


Above is an example of an action (addProduct) that can be called from your site. In the html it is shown how to call
this action.  Above we use this technique to display the message about the product being added.  We also retrieve the
third part of the URL as the ID... That is, the Silverstripe syntax for URLs is /$page/$action/$id.  The
Director::urlParam("ID") function can be used to retrieve the ID in www.mysite.com/mypage/addProduct/3.   

Note that *return Array()* will basically allow for the normal template to be outputted (in case you would like the same
action in a non-ajax call).  That is, for any action if you put something like return *xyz* then only *xyz* would show
on the screen, but by returning an empty array it renders the template as usual. 





## HTML Code

So far we have done the PHP code, now here are the silverstripe templates (html) showing you how to interact with the
code. On any page you can add a link like this.  Note that the jQuery call for loading asynchronous content is
jQuery(element).load(url).  Since Silverstripe may use other JS libraries using the $ sign, it would be better to write
jQuery rather than its shorthand friend "$". 

	:::html
	 `<div id="ajaxContent">`ajax will appear here...`</div>`
	 `<p>`
	  `<a href="mypage" onclick="$('#ajaxContent').load('$URLSegment/showImage'); return false;">`click here to load new picture`</a>`
	  `<a href="mypage/addProduct/3" onclick="$('#ajaxContent').load('$URLSegment/addProduct/3'); return false;">`add product`</a>`
	 `</p>`


There are two ajax examples here.  The first one is to load a picture the second one is used to add a product using the
action in the php code.  

For most ajax returns, you do not need a header and a footer of the page. Usually, the header and footer are in the
/mysite/templates/Page.ss file.  The Ajax snippets should thus be at the same level as the basic template file to avoid
having the header and footer included.  So, create /mysite/templates/ajaxSnippet.ss which can look something like:

	:::html
	 `<img src="/mysite/images/pic.gif" alt="freshly loaded pig" />` 
	 $Title


Make sure that your Ajax content validates (e.g. dont leave any divs open) unless you like spending extra time with your
best friend: firebug. In the php file you can see how this template is being asked to help out: 

	:::php
	return $this->renderWith("ajaxSnippet");






## Javascript code

This code makes use of jQuery. While jQuery has excellent ajax functions, this makes it even a little easier.  It does
assume basic jQuery knowledge:

	:::javascript
	function loadAjax(loadIntoElID, page) {
	 var completeURL = jQuery('base').attr('href') + page; //NOTE THAT jQuery('base').attr('href') should work as the base tag should be included in your header.
	 var imgHtml = `<img src="mysite/javascript/loading.gif" alt="loading . . ." />`;
	 jQuery("#" + loadIntoElID).html(imgHtml);
	 jQuery("#" + loadIntoElID).load(URL, {}, function() {/* another function here that runs after content has been loaded */});
	 return true;
	}
	

To make this work, you add the following to your html template (*.ss file):

	:::html
	 `<a href="IdontHaveAjaxPage" onclick="return !loadAjax('{$URLSegment}/showImage/')">`click to see image`</a>`


## secret hint

If you find your ajax generated html is not loading, then add `ContentNegotiator::disable();`{php} to your
/mysite/_config.php file.  It will stop your html from being altered.



