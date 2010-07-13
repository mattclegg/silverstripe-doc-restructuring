CMSMain is part of the CMS.  It is the controller for the content editor.

# Creating another hierarchical editor by subclassing CMSMain

Sometimes you'll want to provide an administration interface that is pretty much exactly what CMSMain provides, but it's not appropriate to include your data in with the site content.  For example, Hayden developed a hierarchical category administrator on the Guano application.

Here's how you can do this: 

## Using classes other than SiteTree in the site tree

It is possible to use to different classes in two separate site trees. In Guano for example, there is the usual site content tree and a category tree. To change that find:

`static $tree_class = 'SiteTree';`{php}

And change the string to the name of the class that will be the base class for classes visible in the site tree.


## Overloading page urls

If using a url other than admin/ for your section then you will need to change the SiteTreeHandlers to use the correct controller.

Create the init method:

`function init() { parent::init(); Requirements::javascript('project-name/javascript/Classname_left.js'); }`{php}

Where project-name and Classname are changed as appropriate.

Create the javascript file and add the handlers:

<code javascript>if(typeof SiteTreeHandlers == 'undefined') SiteTreeHandlers = {};
SiteTreeHandlers.parentChanged_url = 'url/ajaxupdateparent';
SiteTreeHandlers.orderChanged_url = 'url/ajaxupdatesort';
SiteTreeHandlers.showRecord_url = 'url/show/';
SiteTreeHandlers.loadPage_url = 'url/show/';
SiteTreeHandlers.loadTree_url = 'url/getsubtree';</code>

where url is the relative link to the page (eg 'admin/categories'). You can change the handler functions as necessary.

## Overloading EditForm

You may need to overload EditForm if your class does not use the Versioned extension.

## Overloading SiteTreeAsUL

The tree hints can sometimes cause problems when reorganising the tree, and the CMSMain::SiteTreeAsUL function uses SiteTree explicitly. Use:

<code php>public function SiteTreeAsUL() {
		// $this->generateDataTreeHints();
		$this->generateTreeStylingJS();
		
		return $this->getSiteTreeFor( $this->stat('tree_class') );
	}
</code>

