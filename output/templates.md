# Introduction

SilverStripe templates consist of HTML code augmented with special control codes, described below.  Because of this, you
can have as much control of your site's HTML code as you like.

Because the SilverStripe templating language is a string processing language it can therefore be used to make other
text-based data formats, such as XML or RTF.

Here is a very simple template:

	:::html
	`<html>`
	`<head>`
	  `<% base_tag %>`
	  `<title>`$Title`</title>`
	`</head>`
	`<body>`
	  `<h1>`$Title`</h1>`
	  `<p>`
	  `<% control Menu(1) %>`
	  `<a href="$Link" title="$Description.JS">`$Title`</a>`
	  `<% end_control %>`
	  `</p>`
	  `<div class="typography">`
	     $Content
	  `</div>`
	`</body>`
	`</html>`


# Template Syntax

The following control codes are available. For a more details list see [built-in-page-controls](built-in-page-controls):

## Variables

	:::html
	$Property
	$Property(param)
	$Property.SubProperty


These **variables** will call a method/field on the object and insert the returned value as a string into the template.


*  $Property will call $obj->Property() (or the field $obj->Property)

*  $Property(param) will call $obj->Property("param")

*  $Property.SubProperty will call $obj->Property()->SubProperty() (or field equivalents)

If a Variable returns a string, that string will be inserted into the template. If the variable returns an object, then
the system will attempt to render the object through its forTemplate() method. If the forTemplate() method has not been
defined, the system will return an error.

Note you also cannot past a variable into a variable, so using $Property($Value) within your template will not work

##  Includes 

You can perform includes using the Requirements Class via the template controls.  See the section on [Includes in
Templates](requirements#including_inside_template_files) for more details and examples.

	:::html
	`<% require themedCSS(LeftNavMenu) %>`


##  Controls 

	:::html
	`<% control Property %>`
	... content ...
	`<% end_control %>`
	
	`<% control Property.SubProperty %>`
	... content ...
	`<% end_control %>`
	
	`<% control Property(param) %>`
	... content ...
	`<% end_control %>`


Control blocks reference the same methods / fields as variables. Think of it as a foreach loop in PHP or other template
languages. `<% control Property %>` gets the same data as $Property.  However, instead of interpreting the result as a
string, control blocks interpret the result as an object or a array of objects.  The content between `<% control %>` and
`<% end_control %>` acts as a sub-template that is used to render the object returned.

In this example, $A and $B refer to $obj->Property()->A() and $obj->Property()->B().

	:::html
	`<% control Property %>`
	  `<span>`$A`</span>`
	  `<span>`$B`</span>`
	`<% end_control %>`


If the method/field returned is an iterator such as a
[DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html), then the control block will be repeated
for each element of that iterator.  This is the cornerstone of all menu and list generation in SilverStripe.  

In this example, Menu(1) returns a DataObjectSet listing each top level main menu item (for more info on Menu(1):
[Making a Navigation
System](http://doc.silverstripe.com/doku.php?id=tutorial:1-building-a-basic-site#making_a_navigation_system)).  The
`<a>` tag is repeated once for each main menu item, and the $Link and $Title values for each menu item is substituted
in.

	:::html
	`<% control Menu(1) %>`
	`<a href="$Link">`$Title`</a>`
	`<% end_control %>`



## If blocks

	:::html
	`<% if Property %>`
	... optional content ...
	`<% else_if OtherProperty %>`
	... alternative content ...
	`<% else %>`
	... alternative content ...
	`<% end_if %>`
	
	`<% if Property == value %>`
	`<% else %>`
	`<% end_if %>`
	`<% if Property != value %>`
	`<% end_if %>`
	
	`<% if Property && Property2 %>`
	`<% end_if %>`
	
	`<% if Property || Property2 %>`
	`<% end_if %>`


If blocks let you mark off optional content in your template.  The optional content will only be shown if the requested
field / method returns a nonzero value.  In the second syntax, the optional content will only be shown if the requested
field / method returns the value you specify.  You should **not** include quotes around the value.

The `<% else %>` blocks perform as you would expect - content between `<% else %>` and `<% end_if %>` is shown if the
first block fails.  `<% else %>` is an optional part of the syntax - you can just use `<% if %>` and `<% end_if %>` if
that's appropriate.
## Modulus and MultipleOf

New in 2.4 you can use 2 new controls $Modulus and $MultipleOf to help build column layouts.

$Modulus(value, offset) returns an int
$MultipleOf(factor, offset) returns a boolean. 

The following example demonstrates how you can use $Modulus(4) to generate custom column names based on your control
statement. Note that this works for any control statement (not just children)

	:::html
	`<% control Children %>`
	`<div class="column-{$Modulus(4)}">`
	...
	`</div>`
	`<% end_control %>`


Will return you column-3, column-2, column-1, column-0, column-3 etc. You can use these as styling hooks to float,
position as you need.

You can also use $MultipleOf(value, offset) to help build columned layouts. In this case we want to add a `<br>` after
every 3th item

	:::html
	`<% control Children %>`
	`<% if MultipleOf(3) %>`
	`<br>`
	`<% end_if %>`
	`<% end_control %>`


## Comments

Using standard HTML comments is supported. These comments will be included in the published site. 

	:::html
	$EditForm `<!-- Some Comment About the Edit Form -->`


However you can also use special SilverStripe comments which will be stripped out of the published site. This is useful
for adding notes for other developers but for things you don't want published in the public html.

	:::html
	$EditForm `<%-- This is Located in MemberEditForm.php --%>`


## Formatting Template Values

The following example takes the Title field of our object, casts it to a [Varchar](data-types) object, and then calls
the $XML object on that Varchar object.

	:::html
	`<% control Title %>`
	$XML
	`<% end_control %>`


Note that this code can be more concisely represented as follows:

	:::html
	$Title.XML


See [data-types](data-types) for more information.

## Escaping

Sometimes you will have template tags which need to roll into one another. This can often result in SilverStripe looking
for a "FooBar" value rather than a "Foo" and then "Bar" value or when you have a string directly before or after the
variable you will need to escape the specific variable. In the following example $Foo is 3.

	:::html
	
	$Foopx // returns "" (as it looks for a Foopx value)
	{$Foo}px  // returns "3px" (CORRECT)
	


Or when having a $ sign in front of the variable

	:::html
	$$Foo // returns ""
	${$Foo} // returns "$3"


## Partial Caching

From SilverStripe 2.4 you can specify a block to cache between requests

	:::html
	`<% cacheblock 'slowoperation', LastEdited %>`
	$SlowOperation
	`<% end_cacheblock %>`


See [partial-caching](partial-caching) for more information.


# Built In Template Variables and Controls

Out of the box, the template engine gives you lots of neat little variables and controls which you will find useful. For
a list of all the controls see [built-in-page-controls](built-in-page-controls).

# Creating your own Template Variables and Controls

There are 2 ways you can extend the template variables you have available. You can create a new Database field in your
$db or if you do not need the variable to be editable in the cms you can create a function which returns a value in your
Page.php class.

	:::php

	**mysite/code/Page.php**
	...
	function MyCustomValue() {
	    return "Hi, this is my site";
	}


Will give you the ability to call $MyCustomValue from anywhere in your template. 

	:::html
	I've got one thing to say to you: `<i>`$MyCustomValue`</i>`
	
	// output "I've got one thing to say to you: `<i>`Hi, this is my site`</i>`" 


Your function could return a single value as above or it could be a subclass of [ArrayData](ArrayData) for example a
[DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html) with many values then each of these could
be accessible via a control loop

	:::php
	..
	function MyCustomValues() {
	    return new ArrayData(array("Hi" => "Kia Ora", "Name" => "John Smith"));
	}


And now you could call these values by using

	:::html
	`<% control MyCustomValues %>`
	$Hi , $Name
	`<% end_control %>`
	
	// output "Kia Ora , John Smith" 


Or by using the dot notation you would have

	:::html
	$MyCustomValues.Hi , $MyCustomValues.Name
	
	// output "Kia Ora , John Smith"


##### Side effects

All functions that provide data to templates must have no side effects, as the value is cached after first access.

For example, this Controller method

	:::php
	private $counter = 0;
	
	function Counter() {
	    $this->counter += 1;
	    return $this->counter;
	}


and this template

	:::html
	$Counter, $Counter, $Counter


will give "1, 1, 1", not "1, 2, 3"

# Calling templates from PHP code

This is all very well and good, but how do the templates actually get called?  

Templates do nothing on their own.  Rather, they are used to render *a particular object*.  All of the `<% if %>`, `<%
control %>`, and variable codes are methods or parameters that are called *on that object*.  All that is necessary is
that the object is an instance of ViewableData (or one of its subclasses).

The key is ViewableData::renderWith().  This method is passed a For example, within the controller's default action,
there is an instruction of the following sort:

	:::php
	$controller->renderWith("TemplateName");


Here's what this line does:

*  First renderWith() constructs a new object: $template = new SSViewer("TemplateName");

*  SSViewer will take the content of TemplateName.ss, and turn it into PHP code.

*  Then renderWith() passes the controller to $template->process($controller);

*  SSViewer::process() will execute the PHP code generated from TemplateName.ss and return the results.

renderWith() returns a string - the populated template.  In essence, it uses a template to cast an object to a string.

renderWith() can also be passed an array of template names.  If this is done, then renderWith() will use the first
available template name.

Below is an example of how to implement renderWith.  In the example below the page is rendered using the myAjaxTemplate
if the page is called by an ajax function (using Director::is_ajax()).  Note that the index function is called by
default if it exists and there is no action in the url parameters.

	:::php
	class MyPage_Controller extends Page_Controller {
	
	 function init(){
	  parent::init();  
	 }
	 
	 function index() {
	  if(Director::is_ajax()) {
	   return $this->renderWith("myAjaxTemplate");
	  }
	  else {
	   return Array();// execution as usual in this case...
	  }
	 }
	}


##### How does ViewableData work?

ViewableData provides two methods that perform the casting necessary for templates to work as we have described.


*  obj("Parameter") - Return the given field / method as an object, casting if necessary 

*  XML_val("Parameter) - Return the given field / method as a scalar, converting to an XML-safe format and casting if
necessary

These methods work as described in the syntax section above.  SSViewer calls these methods when processing templates. 
However, if you want, you can call obj() and val() yourself.

# Fragment Link rewriting

Fragment links are links with a "#" in them.  A frequent use-case is to use fragment links to point to different
sections of the current page.  For example, we might have this in our template.

For, example, we might have this on http://www.example.com/my-long-page/

	:::html
	`<ul>`
	`<li>``<a href="#section1">`Section 1`</a>``</li>`
	`<li>``<a href="#section2">`Section 2`</a>``</li>`
	`</ul>`


So far, so obvious.  However, things get tricky because of we have set our `<base>` tag to point to the root of your
site.  So, when you click the first link you will be sent to http://www.example.com/#section1 instead of
http://www.example.com/my-long-page/#section1

In order to prevent this situation, the SSViewer template renderer will automatically rewrite any fragment link that
doesn't specify a URL before the fragment, prefixing the URL of the current page.  For our example above, the following
would be created:

	:::html
	`<ul>`
	`<li>``<a href="my-long-page/#section1">`Section 1`</a>``</li>`
	`<li>``<a href="my-long-page/#section2">`Section 2`</a>``</li>`
	`</ul>`


There arecases where this can be unhelpful.  HTML fragments created from Ajax responses are the most common.  In these
situations, you can disable fragment link rewriting like so:

	:::php
	SSViewer::setOption('rewriteHashlinks', false);


# Related Pages

[HTML Guidelines](http://doc.silverstripe.com/doku.php?id=html)
[Themes](http://doc.silverstripe.com/doku.php?id=themes)
