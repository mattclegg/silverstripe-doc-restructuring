# CSS: A guide to best Practices

The idea of this page is to create a repository of best practises for CSS, and recommendations for when you're doing
template development. 

It's all focused around making your life easier when developing templates using SilverStripe. These recommendations
aren't here to be forced upon you, but rather to help you out based on previous experiences with styling SilverStripe
sites.

## Use External Stylesheets, not inline!

It's a good idea to add your styles to a stylesheet, rather than having styles in a ''STYLE'' element within the
''HEAD'' element, or inline on the element itself.

If you use a stylesheet you separate the presentation from the structure, and make it easier to update the styles if it
gets more complex.

### Bad:

	:::html
	`<!-- styles within the style element in head -->`
	`<style type="text/css">`
	   p {
	      color: red;
	   }
	`</style>`
	
	`<!-- inline styles for an element -->`
	`<span style="color: red;">`my text`</span>`



### Good:

Normally you can either link a stylesheet using the ''LINK'' element, or ''@import'' inside the ''STYLE'' element.

	:::html
	`<link rel="stylesheet" type="text/css" media="all" href="$project/css/layout.css" />`


	:::html
	`<style type="text/css" media="all">`@import "$project/css/layout.css";`</style>`


But in SilverStripe you can include your CSS Files through PHP via the [Requirements](Requirements) Class. This means
you can load / choose not to load files based on your code. If you want to include CSS files you need to know when your
going to use it. Most of the time you want it on everypage of the site at all times so you can add it to the init()
function on the Page Controller.

** mysite/code/Page.php ** 

	:::php
	<?
	 ...
	   class Page_Controller extends ContentController {
	
	          function init() {
	              parent::init();
	              Requirements::themedCSS('layout');
	              Requirements::themedCSS('typography');
	              Requirements::themedCSS('form');
	          }
	 ...
	?>


This is the default init function. This will load the layout.css, typography.css and form.css files from your theme
directory.


## IDs and Classes

IDs (marked with a # in CSS) are a way of uniquely identifying an element. Do not use the same ID more than once in your
document. Classes may be used more than once, and are used for applying the same styling more than once to multiple
elements.

At SilverStripe also use UpperCamelCase for IDs and lowerCamelClass for class names to distinguish between the two
easily.

IDs and classes should be descriptive and semantic. For example - blueText isn't semantic, as it describes the colour,
not the function, whereas readMore or loginLink allows for generic improvement without changing the name, or colour as
we described in this example.

	:::css
	/* Good - naming based on function */
	.articleLink {
	   color: green;
	}
	
	/* Bad - naming based on style */
	.greenLink {
	   color: green;
	}



## Selectors

You should only be specific enough to allow for further refinement.

	:::css
	/* bad */
	#Content div.innerContent div.newsItem ul li { color: #f00; }
	
	/* good */
	.newsItem li { color: #f00; }


It is a good idea not to select tags where they're "interchangeable". For example, you can rely on an `<input>` tag, but
`<div>` can be easily exchanged by a `<p>` or a `<fieldset>`.

Keeping your CSS light is important to minimize download times; as much as possible, group selectors and rely on
inheritance.

## Block / inline elements

Do not use a `<ul>` inside a `<span>`, which is the same as saying 'Don't use a block-level element inside an
inline-level element'. This will stop the document validating, as well as produce unpredictable rendering results.

**Good:**

	:::html
	`<ul class="list">`
	   `<li>`
	      `<span>`My list item.`</span>`
	   `</li>`
	`</ul>`


**Bad:**

	:::html
	`<span class="container">`
	   `<ul class="list">`
	      `<li>`
	         My list item.
	      `</li>`
	   `</ul>`
	`</span>`


## Formatting your CSS and Keeping it Clean

### Commenting

If you've got some CSS that you know will become complex, or will be viewed by other developers - please make sure you
comment at least one line in the stylesheet for each selector you know will require it. Adding a little comment will go
a long way for another developer to figure out what you're trying to do.

	:::css
	/* Feature box element, this styles a box using some default

	 * styles which can be extended by creating an ID on it, or another class 
	 * ------------------------------------------------------------------------ */
	.featureBox {
	   margin-top: 15px;
	   border: 1px solid #999;
	   background: #ccc;
	   position: relative;
	}


### Tabbing out CSS

Consider the following HTML markup.

	:::html
	`<ul class="articles">`
	   `<li>`
	       `<a class="item" href="$Link" title="View this page">`Item`</a>`
	   `</li>`
	`</ul>`


A good way to make up the CSS is by tabbing out relating elements.

	:::css
	.articles {
	   margin-left: 10px;
	}
	   .articles li {
	      list-style: url(my/images/checkmark.gif) circle inside;
	   }
	      .articles li .item {
	         color: green;
	      }


## Debugging CSS

### Box model issues

Avoid using padding and width on the same element, unless it's just top/bottom padding (''padding: 10px 0;''). IE
doesn't use the same box model as the W3C specification.

	:::css
	#news {
	   padding: 10px;
	   width: 228px;
	}


The original width of 228px will get reduced by 20px (10px left, 10px right) if you apply padding in this method. This
is confusing, as the original width isn't correct.

If you require padding, separate the padding and the width using the parent element. Like this:
 

	:::css
	#container {
	   width: 228px;
	}
	   #news {
	      padding: 10px;
	   }


A great write-up on the box model in IE can be found here:

[http://www.456bereastreet.com/archive/200612/internet_explorer_and_the_css_box_model/](http://www.456bereastreet.com/archive/200612/internet_explorer_and_the_css_box_model/)


## IE6/7 gotcha: hasLayout

IE6 and 7 have some interesting thing called 'hasLayout', where it changes the way elements render with CSS. I would
suggest reading up in the article below about it in terms of creating a ''display: block'' anchor element, and having
the entire area clickable - which will not occur if there lacks a hasLayout CSS property like ''width'', or an IE
proprietry value ''zoom''.

Concept: **On having layout — the concept of hasLayout in IE/Win**

[http://www.satzansatz.de/cssd/onhavinglayout.html](http://www.satzansatz.de/cssd/onhavinglayout.html)

Practical problem solving: **IE/Win: Clickable area of block anchors and hasLayout**

[http://www.brunildo.org/test/IEABlock1.html](http://www.brunildo.org/test/IEABlock1.html)

	:::css
	.menu2 li {
	   background: #eee;
	   /* IE requires this width, so it doesn't add weird spacing */
	   width: 100%;
	}
	   .menu2 li .item {
	      color: #333;
	      font-size: 11px;
	      text-decoration: none;
	      display: block;
	      padding: 4px 15px;
	      /* IE proprietary attribute which forces this element into hasLayout */
	      zoom: 1;
	}


### Input widths problem (and fix)

IE6 and 7 have funny gaps around input action buttons even if there is padding 0 and margin 0 applied. There is,
however, a way around it.

[http://jehiah.cz/archive/button-width-in-ie-revised](http://jehiah.cz/archive/button-width-in-ie-revised)

	:::html
	`<style>`
	   input.action { 
	      margin: 0;
	      padding: 0 .25em;
	      width: auto;
	      overflow:visible;
	      `<!--[if IE]>`
	      width: 1;
	      `<![endif]-->`
	   }
	`</style>`



### Hack management

Build and test your CSS in the most advanced browser available before testing in others, not after.
If you build a site testing in a broken browser, your code begins relying on the broken rendering of that browser. When
it comes time to test in a more standards-compliant browser, you will be frustrated when that browser renders it
improperly. Instead, start from perfection and then hack for the less able browsers. Your code will be more
standards-compliant from the start, and you won’t have to hack as much to support other browsers:

[http://www.mezzoblue.com/archives/2003/11/17/css_best_pra/](http://www.mezzoblue.com/archives/2003/11/17/css_best_pra/)

#### IE

IE 6 or higher statement. Only IE 6 or higher will use this stylesheet.

	:::html
	`<!--[if gte IE 6]>`
	   `<link rel="stylesheet" type="text/css" href="$project/css/iehacks.css" />`
	`<![endif]-->`


IE 6 only statement

	:::html
	`<!--[if IE 6]>`
	   `<link rel="stylesheet" type="text/css" href="$project/css/ie6hacks.css" />`
	`<![endif]-->`


You can find a whole write up on these conditional statements here, on the Microsoft site, ironically:

[http://msdn2.microsoft.com/en-us/library/ms537512.aspx](http://msdn2.microsoft.com/en-us/library/ms537512.aspx)

#### IE Expressions

If required, IE supports inline expressions in CSS. You can do the below expression, which selectively styles the
previous element to a P tag if it's an H1-6 element. Nice as a replacement for H1 + p adjacent selectors.

	:::html
	`<!--[if IE 6]>`
		<style type="text/css">
		p { margin: expression(this.previousSibling.tagName.match(/^[hH][1-6]$/) ? '5px 0 0 0 !important' : '10px 0 0 0'); }
		</style>
	`<![endif]-->`


The best way to apply the hack is to put it in it's own stylesheet using the conditions for IE. Don't put it in the
`<style>` element in the header like the above example.

#### IE Conditionals using Requirements

In Silverstripe you cant add IE specific Stylesheets correctly (it will load over the Requirements) so things will not
work as expected

a better(?) way to doit is using this in your Page_Controller : 

	:::php
	function init() {         
	parent::init();      
	Requirements::css( project() . "/css/default.css");      
	if($pos = strpos( $_SERVER[ 'HTTP_USER_AGENT' ], 'MSIE' ) ) {      
	Requirements::css( project() . "/css/ie.css");      
	$version = substr( $_SERVER[ 'HTTP_USER_AGENT' ], $pos + 5, 3 );
	if( $version < 7 ) {
	Requirements::css( project() . "/css/ie6.css");
	}
	if( $version < 6 ) {
	Requirements::css( project() . "/css/ie5.css");
	}
	}      
	}
	}
	


Another way to accomplish the same is using this code inside your init function in your Page_Controller:

	:::php
	Requirements::insertHeadTags("`<!--[if IE 6]>``<style type='text/css'>`@import url(themes/" . SSViewer::current_theme() . "/css/ie6.css);`</style>``<![endif]-->`");
	
	Requirements::insertHeadTags("`<!--[if IE 7]>``<style type='text/css'>`@import url(themes/" . SSViewer::current_theme() . "/css/ie7.css);`</style>``<![endif]-->`");


## Form Styling

### Structure

`<form>` is the main element for a form, you then place your fields inside a `<fieldset>`.**

	:::html
	`<form id="NewsletterSubscription">`
	   `<fieldset>`
	      `<!-- place your fields in here -->`
	   `</fieldset>`
	`</form>`


### Organising

A good way to structure your fields inside a `<fieldset>` is to wrap the `<label>` and `<input>` or `<textarea>` /
`<select>` in a `<div>`, like the following:

	:::html
	`<div id="MenuTitle" class="field text">`
	   `<label class="left" for="MenuTitle_Input">`My form field`</label>`
	   `<input id="MenuTitle_Input" class="text" type="text" value="Some text here please" />`
	`</div>`


There's an ID on the container `<div>`, as well as an ID for the `<input>` itself - so you've got plenty of selectors to
apply CSS to.

### Usability

#### For attribute on label

*It's a good usability practise to use a ''for'' attribute on your `<label>` elements, as shown in the above example.
This means if you click the label, it will focus on the input associated with it.*

#### Legend element

It's a good idea to use a `<legend>` element (one for each fieldset), inside the `<fieldset>` element. This labels your
`<fieldset>` appropriately, and makes it more usable.

	:::html
	`<form>`
	   `<fieldset>`
	      `<legend>`Contact`</legend>`
	   `</fieldset>`
	`</form>`


### Sapphire

*Usually sapphire (SilverStripe's core module) generates the form for you anyway - but this is advice for when, and if,
you're marking up the form yourself, and bypassing the sapphire form generation. Sometimes you may not want it to
generate for you - to be more specific with your HTML.*



## Short hand tricks

** Margins **

	:::css
	/* Good way - short hand method (10px top/bottom and 5px left/right) */
	.myelement {
	   margin: 10px 5px;
	}


	:::css
	/* Bad way - specifying each direction one-by-one,
	bad unless you're only applying in one direction. */
	.myelement {
	   margin-top: 10px;
	   margin-bottom: 10px;
	   margin-right: 5px;
	   margin-left: 5px;
	}


	:::css
	/* Good way - short hand method (5px top/3px right/8px bottom/1em left) */
	.myelement {
	   margin: 5px 3px 8px 1em;
	}


	:::css
	/* Bad way - specifying margin attributes one-by-one */
	.myelement {
	   margin-top: 5px;
	   margin-right: 3px;
	   margin-bottom: 8px;
	   margin-left: 1em;


** Backgrounds **

	:::css
	/* Good way - short hand background (color/image/repeat/position) */
	.myelement {
	   background: #333 url(my/image/here.gif) no-repeat top left;
	}


	:::css
	/* Bad way - specifying background attributes one-by-one */
	.myelement {
	   background-color: #333;
	   background-image: url(my/image/here.gif);
	   background-position: top left;
	   background-repeat: no-repeat;
	}


** Lists **

	:::css
	/* Good way - short hand lists (image/type/position) */
	.myelement {
	   list-style: url(my/image/here.gif) disc inside;
	}


	:::css
	/* Bad way - specifying list attributes one-by-one (not recommended) */
	.myelement {
	   list-style-type: disc;
	   list-style-image: url(my/image/here.gif);
	   list-style-position: inside;
	}


** Unit-less line-height **

line-height doesn't require a unit, because it takes the ''font-size'' as the base and times it by the ''line-height''.
So if you have 15px font-size on your element, with a ''line-height'' of 1.5 it will be 15px * 1.5 = 22.5px. This makes
sense, and it works better than specifying a unit.

Read more about this here, from Eric Meyer:

[http://meyerweb.com/eric/thoughts/2006/02/08/unitless-line-heights/](http://meyerweb.com/eric/thoughts/2006/02/08/unitless-line-heights/)

	:::css
	/* Good way - unit-less line-height (figured out from font-size) */
	.myelement {
	   font-size: 15px;
	   line-height: 1;


	:::css
	/* Bad way - specifying a unit for line-height */
	.myelement {
	   line-height: 15px;
	}


** Unit-less nil value **

	:::css
	/* Good way - clean and concise without a unit for 0 */
	.myelement {
	   padding: 0;


	:::css
	/* Bad way - unnecessary unit on 0. 0 is 0, not 0px. */
	.myelement {
	   padding: 0px;
	}


## Other tricks

### Table widths

If you're applying an implicit width on a table it's recommend to use this CSS property on the `<table>` element to stop
it from overflowing (if the content gets too large), which could ultimately break your layout:

	:::css
	table {
	   table-layout: fixed
	   width: 400px;
	}



### Blockquotes

If you use blockquote, be aware that you should only put block-level elements inside it.

	:::html
	`<!-- Bad -->`
	`<blockquote>`
	   This is a quoted paragraph of text, directly inside a BLOCKQUOTE element,
	   which makes this quote valid only in Transitional Doctypes.
	`</blockquote>`
	
	`<!-- Good -->`
	`<blockquote>`
	   `<p>`This is a quoted paragraph of text, wrapped inside a P element,
	  which is valid in both Strict and Transitional Doctypes.`</p>`
	`</blockquote>`


For reference:
[http://www.w3.org/TR/html4/struct/text.html#edef-BLOCKQUOTE](http://www.w3.org/TR/html4/struct/text.html#edef-BLOCKQUOTE)


### Images

Don't use quotation marks around paths for images linked in stylesheets. They're not necessary, and IE5/Mac will choke.
And If using images try and use a backup color (or inherit, transparent)

** Good **

	:::css
	body {
	  background: #fff url(myfolder/with/apic.gif) no-repeat;
	}


** Bad **

	:::css
	body {
	  background: url('myfolder/with/apic.gif');
	}


### Alpha PNGs in IE6

Here's a possible solution to getting alpha transparent PNGs to work in IE6:
[http://bjorkoy.com/past/2007/4/8/the_easiest_way_to_png/](http://bjorkoy.com/past/2007/4/8/the_easiest_way_to_png/).

The original source of this guide is found here:
[http://www.twinhelix.com/css/iepngfix/](http://www.twinhelix.com/css/iepngfix/).


### WYSIWYG editor stylesheet (typography.css & editor.css)

This stylesheet is used to "namespace" rules which just apply in a rendered site and the WYSIWYG-editor of the CMS. This
is needed to get custom styles in the editor without affecting the remaining CMS-styles.

*An example of a good location to use ''class="typography"'' is the container element to your WYSIWYG-editor field. The
''$Content'' WYSIWYG editor field already comes with SilverStripe out-of-the-box. So you would do it like this:*

	:::html
	<!--
	   This is a good way, you're only applying class="typography"
	   to where the WYSIWYG editor is, and not the entire layout.
	-->
	`<div id="Main">`
	   `<div id="LeftContent">`
	      `<p>`We have a lot of content to go here.`</p>`
	   `</div>`
	
	   `<div id="Content" class="typography">`
	      $Content
	   `</div>`
	`</div>`


The typography.css file should contain only styling for these elements (related to the WYSIWYG editor):

   * **Headers (h1 - h6)**
   * **Text (p, blockquote, pre)**
   * **Lists (ul, li)**
   * **CSS alignment (img.left, .left, .right etc)**
   * **Tables**
   * **Miscellaneous (hr etc)**

The advantages are that it's fully styled, as a default starting point which you can easily tweak. It also doesn't
affect the CMS styling at all (except for the WYSIWYG), which is what we want.

It's also separated from the rest of the layout. If you wanted to change typography only, for where you usually edit the
content you don't need to go wading through other CSS files related to the actual layout.

To get these styles working in the CMS. Eg you use a font you want in the CMS area you need to create an editor.css
file. Then with this file you can define styles for the CMS or just import the styles from typography. Unlike
typography.css, editor.css is NOT included in the front end site. So this is 

** themes/your_theme/css/editor.css **

	:::css
	/* Import the common styles from typography like link colors. */
	@import 'typography.css';
	
	/* We want the backend editor to have a bigger font as well though */
	.typography * { font-size: 200% }


## Good techniques



### Global white space reset

This technique is good for removing the 'mystery dimension' surrounding elements. Doing this resets all margin and
padding elements. It also removes cross-browser inconsistencies with default values so you can target styling and start
from scratch.

*Note: You have to re-style everything - headings and paragraphs with appropriate spacing, since everything is reset to
nil. This approach should only be used in combination with a CSS-framework or default-styling-file.*

	:::css

	* {
	   padding: 0;
	   margin: 0;
	}


### Float clearing

Clearing floats is an age old CSS art of making sure your layout doesn't fall apart when you start floating elements. It
shouldn't be such a chore, and this example below should clear things up: (excuse the pun).

[http://robertdot.org/files/2007/04/24/floats.html](http://robertdot.org/files/2007/04/24/floats.html)

Basically you have your floats inside a container element with 'overflow: auto' or 'overflow: hidden' depending on
whether you want to 'massage' it to eliminate the scrollbars if they appear. This is stated in the example, if you
inspect the CSS properties in Firebug.

**What are the advantages of this over any 'clear: left' on elements below it?**

Well, for starters it requires you have another element below your floats to stop it from overflowing off the layout and
breaking everything. Usually this is achieved by applying the clear: left or right on the footer, which may be okay for
the basic clearing of floats on the main structure.

Clearing these is a pain, because then you can't use margin on the actual footer to move it, since it's already been
pushed through clear.

This also eliminates the need to add hacks like `<div class="clear">``<!-- -->``</div>` or `<br class="clear />`, if you
are using the floats anywhere else in your layout.


### Scaling images

For scalable liquid layouts, you can employ this technique to images inside a `<div>` container with a maximum width.

The div has to have a reasonable maximum width however, otherwise the images would look a bit silly being far bigger
than the original size.

	:::css
	img {
	   width: 100%;
	}


This makes the image scale to the size of the div, if you resize the window - the image will get smaller instead of
bleeding over the edge like it would normally do.

The disadvantage of this method is on Windows machines the images look horrible when they resize in the browser. On the
Mac it looks nice, however. ;-)

### Cropping images

This method is better if you don't mind the image being cropped a bit on a liquid layout, when the window is smaller:

	:::css
	img {
	   overflow: hidden;
	}

