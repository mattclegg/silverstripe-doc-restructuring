======= HTML Development Guidelines =======

These are general principles that are recommended to be applied to any new themes / projects in SilverStripe.

You might also want to read the first 2 SilverStripe tutorials to get a understanding of how the templating works.

These guidelines are designed to provide designers and developers of SilverStripe [widgets](Widgets), [themes](Themes)
and [modules](modules) with generic HTML that is easily adaptable in different modules and projects.

See [ContentNegotiator](http://api.silverstripe.org/2.3/sapphire/control/ContentNegotiator.html) class for automatically
converting between HTML and XHTML in SilverStripe responses (deprecated as of SilverStripe 2.4).

## DOCTYPES

Per HTML and XHTML standards, a DOCTYPE (short for “document type declaration”) informs the validator which version
of (X)HTML you’re using, and must appear at the very top of every web page. DOCTYPEs are a key component of compliant
web pages: your markup and CSS won’t validate without them. DOCTYPES are also essential to the proper rendering and
functioning of web documents in compliant browsers like Mozilla, IE5/Mac, and IE6/Win.

#### HTML5 (Recommended)

We are moving towards using HTML5 for all our projects as the doctype is backwards compatible. You do not need to use
all the features of HTML5 but using this doctype will work with older HTML4 tags

	:::html
	`<!DOCTYPE html>`
	`<html lang="en">`


#### HTML4 Strict DOCTYPE

Using HTML4 Strict is the standard way and is a safe choice if you do not want to use HTML5.

	:::html
	`<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">`
	`<html lang="en">`


#### XHTML

Previously we encouraged the use of semantic XHTML served as XML as it was designed. For sending your page as XHTML you
should also include the `<?xml ?>` header.

	:::html
	`<?xml version="1.0" encoding="UTF-8"?>`
	`<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">`
	`<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" >`


However this method is deprecated and should be used only when needed.

##  Its all in the HEAD

Our top part of our theme is something like this

	:::html
	`<?xml version="1.0" encoding="UTF-8"?>`
	`<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">`
	`<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">`
	  `<head>`
	    `<% base_tag %>`
	    $MetaTags
	  `</head>`


After the XML header and the DOCTYPE, The HEAD element contains information about the current document, such as its
title, keywords that may be useful to search engines, and other data that is not considered document content. User
agents do not generally render elements that appear in the HEAD as content. They may, however, make information in the
HEAD available to users through other mechanisms. There are 2 SilverStripe Specific Tags that are needed to be put
inside the HEAD section.

### Base tag

	:::html
	`<% base_tag %>`

base_tag is replaced with the HTML base element. Relative links within a document (such as <img src="someimage.jpg"...)
will become relative to the URI specified in the base tag. This ensures the browser knows where to locate your site’s
images and css files. So it is a must for templates!

It renders in the template as:

`<base href="http://www.mydomain.com" />`{html}

### Meta Tags

`$MetaTags`{html}
This returns a segment of HTML appropriate for putting into the `<head>` tag. It will set up title, keywords and
description meta-tags, based on the CMS content and is editable in the 'Meta-data' tab on a per-page basis. If you
don’t want to include the title-tag `<title>` (for custom templating), use ''$MetaTags(false)''.

By default $MetaTags renders:

	:::html
	`<title>`Title of the Page`</title>`
	`<meta name="generator" http-equiv="generator" content="SilverStripe 2.0" >`
	`<meta http-equiv="Content-type" content="text/html; charset=utf-8" >`


## Includes

Within SilverStripe templates we have the ability to include other templates from the Includes directory using the SS
'include' tag. For example, the following code would include the Includes/SideBar.ss code:

	:::html
	`<% include SideBar %>`


The "include" tag can be particularly helpful for nested functionality. In this example, the include only happens if a
variable is true

	:::html
	`<% if CurrentMember %>`
		<% include MembersOnlyInclude %>
	`<% end_if %>`


## Inclusion of external files (CSS/Javascript)

To include CSS and Javascript files in your site see http://doc.silverstripe.org/doku.php?id=requirements

## Dividing your site the correct way!


Most Web page designers 10 years ago used a table-based layout to achieve a consistent look. Now, (Thankfully) there's a
different way to achieve the same look.

Using **[CSS](css)** and tags (including ''DIV''s) reduces markup code, speeds up page downloads, separates content from
its visual presentation, and brings your code closer to web standards compliance--all while making your website more
appealing to search engine spiders.

For layout we tend to use ''DIV'' tags as the ''DIV'' tag defines a division/section in a document.

Let's have a look at part of a Page.ss for the main layout elements defining a 2 column layout.

	:::html
	`<div id="Container">`
	 `<div id="Header">`
	   `<!-- Header -->`
	 `</div>`
	
	 `<div id="Navigation">`
	   `<!-- The Main Site Nav -->`
	 `</div>`
	
	 `<div id="Layout">`
	   `<!-- The whole site content has to sit inside here! Anything you want to sub template (eg each page will be different, needs to be contained in $Layout. This calls the file /Layout/Page.ss or anyother sub page template -->`
	   $Layout
	 `</div>`
	
	 `<div id="Footer">`
	 `</div>`
	`</div>`


### A couple of notes on naming IDs and classes

*  Class names should be lowercase, or lowerCamelCase starting with a lowercase letter, for example, latestNews

*  IDs should be UpperCamelCase and remember ID's can only be used once per page.

	:::html
	`<div id="Container">``<!-- markup goes here -->``</div>`


As you can see we normally wrap the site in a container. For this we use the ID 'Container'. Then we divide the main
template into sections.

	:::html
	`<div id="Header">``<!-- markup goes here -->``</div>`


We have the Header section which includes things like any banner images/ mastheads/ logos or any stuff that belongs at
the top of the page, This might vary on the design of the page

	:::html
	`<div id="Navigation">``<!-- markup goes here -->``</div>`


Next is a division for the main navigation. This may contain something like:

	:::html
	`<div id="Navigation">`
	  `<% if Menu(1) %>`
	  `<ul>`
	    `<% control Menu(1) %>`	  
	      `<li>``<a href="$Link" title="Go to the $Title page" class="$LinkingMode">`$MenuTitle`</a>``</li>`
	    `<% end_control %>`
	 `</ul>`
	 `<% end_if %>`
	`</div>`


This is the standard for creating the main Navigation. As you can see it outputs the Menu 1 in a unordered list.

Before stepping into a control (a foreach loop) it's good practise to check if it exists first. This is not only
important in manipulating SilverStripe templates, but in any programming language!

	:::html
	`<% if MyFunction %>`
	  `<% control MyFunction %>`
	    $Title
	  `<% end_control %>`
	`<% end_if %>`


Last and probably least is the Footer division. Here is where you put all the Footer related stuff for your website.
Maybe even a nice link saying Website Powered by SilverStripe to show your support.

	:::html
	`<div id="Footer">`
	`<!-- markup goes here -->`
	`</div>`


### Our Basic Page.ss now

	:::html
	`<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">`
	`<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">`
	`<head>`
	  `<% base_tag %>`
	  $MetaTags(false)
	  `<title>`Bob's Chicken Shack | $Title`</title>`
	`</head>`
	
	`<body>`
	`<div id="Container">`
	  `<div id="Header">`
	    `<h1>`Bob's Chicken Shack`</h1>`
	  `</div>`
	
	  `<div id="Navigation">`
	    `<% if Menu(1) %>`
	    `<ul>`
	      `<% control Menu(1) %>`	  
	        `<li>``<a href="$Link" title="Go to the $Title page" class="$LinkingMode">`$MenuTitle`</a>``</li>`
	      `<% end_control %>`
	    `</ul>`
	   `<% end_if %>`
	  `</div>`
	
	  `<div id="Layout">`
	    $Layout
	  `</div>`
	
	  `<div id="Footer">`
	    `<p>`Copyright $Now.Year - Bob's Chicken Shack.`</p>`
	  `</div>`
	`</div>`
	`</body>`
	`</html>`
	

{{:bobschickenexample_sml.jpg|:bobschickenexample_sml.jpg}}

## $Layout

Now we have our root *Page.ss* file you'll notice there's a variable called ''$Layout''.

**Where does this come from and what does it do?**

This is where sub-templates defined in */templates/Layout* are rendered. In this case the page type as defined is just a
'Page', therefore it will use *templates/Layout/Page.ss*.

If you have a Page type of NewsHolder it will load the same *Page.ss* file. However, when it gets to $Layout it will go
looking for *templates/Layout/NewsHolder.ss*. If that doesn't exist, then it will default to *templates/Layout/Page.ss*.

So, at the very least, we need a *Page.ss* file and a *templates/Layout/Page.ss*. 

A sample *templates/Layout/Page.ss* file for our 2 column site might look like this:

	:::html
	`<div id="Content">`
	  `<div class="typography">`
	    `<!-- Renders the main content as in the CMS -->`
	    $Content
	
	    `<!-- Renders a Form defined for this page -->`
	    $Form
	
	    `<!-- Renders a page comment interface (provided it's enabled) for this page -->`
	    $PageComments
	  `</div>`
	`</div>`
	
	`<div id="Sidebar">`
	   `<!-- Sidebar stuff -->`
	`</div>`


## Menus

Below is a good example of a menu. It can be used for 2 levels of nesting. Beyond that, you'll probably need to create
functionality to recursively generate templating based on the level your pages are in.

What's special about this? We're using `<% if LinkingMode = current %>` to find out what the current page you're on in
the menu is. We then make that item in the menu a `<span>` element, so it isn't clickable (since you shouldn't be able
to click on the page you're currently on).

Menu items are also abstracted, so you're not relying on a certain element to be there, like a `<span>` or `<a>`. The
abstracted item has a class name of ''.item'', so you style menu items using the class instead of the element.

	:::html
	`<% if Menu(2) %>`
		<ul id="Menu2">
			<% control Menu(2) %>
			<li class="$LinkingMode<% if FirstLast %> $FirstLast<% end_if %>">
				<% if LinkingMode = current %>
					<span class="item selected">$MenuTitle</span>
				<% else %>				
					<a class="item" href="$Link" title="View more on $Title">$MenuTitle</a>
				<% end_if %>
				<% if Children %>
					<% if LinkingMode = section %>
						<ul id="Menu3">
							<% control Children %>
							<li class="$LinkingMode<% if FirstLast %> $FirstLast<% end_if %>">
								<% if LinkingMode = current %>
									<span class="item selected">$MenuTitle</span>
								<% else %>
									<a class="item" href="$Link" title="View more on $Title">$MenuTitle</a>
								<% end_if %>
							</li>
							<% end_control %>
						</ul>
					<% end_if %>
				<% end_if %>
			</li>
			<% end_control %>
		</ul>
	`<% end_if %>`


## Tables

Tables *are* okay in some circumstances, specifically where you want to present tabular data.  Make sure you follow a
few rules:


*  Use the summary attribute as you would use a title tag: explain what's been shown to someone who might not be
interested in the data.

*  Use the caption to provide some text to show on the the table.

*  Use thead, tbody and tfoot as applicable.

*  Make sure that any headings, on rows or columns, use th instead of td - even if they're in a thead block.

*  Use the abbr attribute to shorten any titles - this can be used by screen readers in repeated readings.

*  Use the scope attribute to indicate the scope of any headings.

Here's a sample to use as a template.

	:::html
	`<table summary="The number of employees and the foundation year of some imaginary companies.">`
	  `<caption>`Table 1: Company data`</caption>`
	  `<thead>`
	  `<tr>`
	    `<td>``</td>`
	    `<th scope="col" abbr="Employees">`Number of Employees`</th>`
	    `<th scope="col" abbr="Founded">`Year Founded`</th>`
	  `</tr>`
	  `</thead>`
	  `<tbody>`
	  `<tr>`
	    `<th scope="row">`ACME Inc`</th>`
	    `<td>`1000`</td>`
	    `<td>`1947`</td>`
	  `</tr>`
	  `<tr>`
	  `<th scope="row">`XYZ Corp`</th>`
	    `<td>`2000`</td>`
	    `<td>`1973`</td>`
	  `</tr>`
	  `</tbody>`
	`</table>`


# Resources

   * [Understanding HTML, XML and XHTML](http://webkit.org/blog/?p=68)
   * [A List Apart - Fix your site with the right DOCTYPE](http://www.alistapart.com/articles/doctype/)

   * [Tutorial 1: Building a basic site](tutorial/1-building-a-basic-site)
   * [Tutorial 2: Extending a basic site](tutorial/2-extending-a-basic-site)

   * [CSS guidelines](css)
   * [Themes](Themes)
   * [Widgets](Widgets)
   * [Modules](modules)
