## Overview

This tutorial explains the creation of a module for the SilverStripe CMS system. This module, once the tutorial is
finished, will provide the ability to have randomly selected URL links displayed on a page on your website.

An example of this feature is shown on the homepage of the http://www.pyenet.co.nz website.

The rational for this module is to provide a function that my original, non SilverStripe website, provided via some
server side scripting trickery and at the same time allow me to research the inner working of the SilverStripe
framework.

The Random Links module is small enough to allow it to be used as a basis of this tutorial and to be the starting point
for your own extensions to the SilverStripe framework.

Have Fun!!!

## What we are working towards

The Random Links module adds an administration component to the SilverStripe CMS to manage the links, and the ability to
add an unordered list to page template(s) where you want the links to appear.

{{ :private:tutorial:startpagescaled.png |Random Links Administration}}

The screenshot above shows the administration screen for the Random Links module.

And here we have an example of the Random Links appearing on a web page.

{{ :private:tutorial:randomlinksexample.png |Example of Random Links in action}}



## Required knowledge

Developing a module for the SilverStripe framework requires some knowledge in the following scripting languages


*  PHP


*  Javascript


*  SilverStripe's Template language

However I am not an expert in any of these languages and was able to piece together this module from reading source code
of the SilverStripe CMS, Documentation from the SilverStripe website and other sources. So don't be put off.

Also some knowledge of:


*  CSS


*  HTML

Will not go amiss.

## Setting up the development environment

To aid in the development of a SilverStripe module several tools will make your life easier.


*  Editor:
    * A text editor that provides syntax highlighting for the 3 main file types:- PHP scripts (.php), Javascript    
scripts (.js) and SilverStripe HTML templates (.ss) will make writing the code easier.


*  Tools:
    * The DOM inspector of the Firefox web browser, however this only provides limited capabilities. A better Firefox
extension to use is the Firebug development tools. These provide several levels of interrogation of the processes going
on during the browser's conversation with the SilverStripe server. Firebug is available from the [Firefox Extension
Repository](https///addons.mozilla.org/en-US/firefox/addon/1843)


*  Log files:
    * Access to the web servers log files can also provide helpful information while developing a SilverStripe module.
If you have errors in your .php files, typically the browser will not see a problem, or only report a 500 error code. To
gain more insight into the issue the web server's log files can provide another avenue of investigation.


*  Programming resources:
    * The main website I use for the language reference is the [w3schools.com](http://w3schools.com). Here they have the
                      references for HTML, CSS, Javascript and PHP. Other places of interest might be the SilverStripe
[Coding Conventions](/coding-conventions), Advice for [Module Maintainers](/module-maintainers)




## To Start

Think up a name for your module that is unique. We need to create a directory in the SilverStripe installation directory
along side cms, sapphire, themes etc. directories that uniquely identifies the module.

xxxx This next bit I know I saw somewhere but cannot find it again xxxx From the SilverStripe module documentation 
xxxLink herexxx  the name needs to be all lowercase and no non alpha-numeric characters. ie. for Random Links I used
randomlinks.

Within this directory we need to create the following sub directories. Not all of these are used for the Random Links
module but your application may need them.

xxxx Here we need the graphic from the creating-modules wiki page or similar xxxx

	
	randomlinks
	     \
	      \_code
	      |
	      |_css
	      |
	      |_images
	      |    \
	      |     \_treeicons
	      |
	      |_javascript
	      |
	      |_lang
	      |
	      |_templates
	            \
	             \_Includes
	             |
	             |_Layout
	


The first file we need to create is the _config.php file that is located in the root directory of the module (eg.
randomlinks in this case).

The file is read by the SilverStripe system and allows it to determine that the rest of the directory structure contains
the files that make up the module.

randomlinks/_config.php

	:::php
	<?php
	
	/**

	 * Add Static Var for the Random Links menu item
	 */
	Object::addStaticVars('LeftAndMain', array(
		'extra_menu_items' => array(
			'Random Links' => 'admin/randomlinks/',
		)
	));
	
	
	/**

	 * URL rules for the RandomLinks module
	 */
	Director::addRules(100, array(
		'admin/randomlinks/$Action/$ID' => 'RandomLinksAdmin',
	));
	


The Object::addStaticVars() function tells SilverStripe that we wish to add a menu item to the main menu of the CMS. It
also informs the CMS what URL to return to the browser when the menu item is chosen, the admin/randomlinks/ above.

You need to change the line 8 to match your requirements.

The Director::addRules() function tells SilverStripe how to make up the URLs that allow movement within the module. The
$Action part will be something like show, add etc. and the $ID part translates to the ID of the record within the
database we wish to act upon.

Line 17 is where you make the changes for your module.

You may also notice that the trailing ?> is missing from this file. A problem occurs with the SilverStripe page renderer
if there are blank lines after the closing ?> in the .php files. These show up in the browser as an invalid XML format
error. If the ?> it is missing the .php interpreter on the server implies it is there and avoids this issue.

The [Module Maintainers](/module-maintainers) documentation also suggests that a README file be placed in the root
directory of your module explaining the functions and requirements of the module.






## Next Step - Creating the data store

The next step is to set up the storage for the links we are going to provide for the Random Links module. For Random
Links this is not very fancy, all we need is a separate table (Class in SS terminology) in the database and 3 fields.
For more background see the [Tutorial 2:Extending a basic site](/tutorial/2-extending-a-basic-site) and the
[DataModel](/datamodel) reference document.

For our purposes a Random Link will have 3 properties. A name, A URL and a path to an image. To create these in the
database we need to create the following file in the randomlinks/code directory.

randomlinks/code/RandomLinks.php

	:::php
	<?php
	
	class RandomLinks extends DataObject {
		static $db = array(
			'LinkTitle' => 'Text',
			'LinkURL' => 'Text',
			'LinkImage' => 'Text'
		);
	
	}
	


The static $db array defines the fields which we have called LinkTitle, LinkURL and LinkImage each is defined as a Text
data type. Remember that the names used here have to be unique to the whole of SilverStripe so names like: Content, Name
etc. are NOT good choices as they have already been used.

Once this file is in place we need to run the /db/build?flush=1 process to actually create the RandomLinks table and its
fields.

The following information should be included in the page sent back from the web server after the build has completed:

	
	# RandomLinks
	# Table RandomLinks: created
	# Field RandomLinks.ClassName: created as enum('RandomLinks') character set utf8 collate utf8_general_ci default 'RandomLinks'
	# Field RandomLinks.Created: created as datetime
	# Field RandomLinks.LastEdited: created as datetime
	# Field RandomLinks.LinkTitle: created as mediumtext character set utf8 collate utf8_general_ci
	# Field RandomLinks.LinkURL: created as mediumtext character set utf8 collate utf8_general_ci
	# Field RandomLinks.LinkImage: created as mediumtext character set utf8 collate utf8_general_ci
	# Index RandomLinks.ClassName: created as (ClassName)


To confirm that the table was created correctly, and if you have the necessary SQL skills, doing a login to the MySQL
database and several SHOW and DESCRIBE commands should prove that the database has been updated correctly.

Now that we have the table we need to extend the CMS interface to allow us to add, modify and delete random links.

## Administration Interface

The Administration interface of SilverStripe (the CMS) is divided into 2 main panels. On the left is the tree that gives
us the ability to move about the website and select a page that we wish to edit. For the Random Links module this is
going to be the area where the titles of currently defined links are displayed, and where we have the controls to add
more links or delete ones we do not require.

The right panel of the CMS is usually used to display a form that allows details for a new page to be entered, or to be
updated. The Random Links module does not vary from this convention.
















## Main Administration Script

The first file that needs to be generated is the main PHP file that will respond to administration requests from the
browser.

If you have been impatient, and have clicked on the Random Links menu item that has appeared in the CMS main menu an
error will have been generated saying the next file we are going to generate is missing.

For the Random Links module this file is:

randomlinks/code/RandomLinksAdmin.php

We will build this file piece by piece, explaining each function as we go.

	:::php
	<?php
	
	/**

	 * See http://doc.silverstripe.com/doku.php?id=leftandmain&s=admin
	 */
	
	class RandomLinksAdmin extends LeftAndMain {
		static $tree_class = "RandomLinks";
	
	
		/**

		 * Initialisation method called before accessing any functionality that RandomLinksAdmin has to offer
		 */
		public function init() {
			parent::init();
	
			Requirements::javascript ("randomlinks/javascript/RandomLinksAdmin_left.js");
			Requirements::css ("randomlinks/css/randomlinksadmin.css");
	
			LeftAndMain::setApplicationName('Random Links', 'Random Links');
			LeftAndMain::setLogo('randomlinks/images/RandomLinksLogo.png',
	                             'background-attachment:fixed; background-position: 80% 80%;');
	
		}
	}
	


As the comment at the top of this file suggests the key documentation for developing an administration interface is the
[LeftAndMain.php documentation](http://doc.silverstripe.com/doku.php?id=leftandmain&s=admin) but also another source is
the [source code of
LeftAndMain.php](http://api.silverstripe.com/__filesource/fsource_cms_core_cmscodeLeftAndMain.php.html). The
Administration interface will extend the LeftAndMain class and therefore inherit the methods and other code that his
class provides.

The first thing we do is redefine the static variable $tree_class. This defines the class (ie. database table) that is
used to generate the tree of link titles on the left hand panel of the CMS.

The init() function is then defined which makes sure that the parent::init() (ie. LeftAndMain's init()) function is
called.

The requirements for the Random Links module are pretty small with just the javascript file that is added to the web
pages that this PHP script generates for the client. And a small style sheet. We will create, and discuss, these files a
little later.

We then call the LeftAndMain::setApplicationName() function that sets up the Application Name variable used elsewhere in
the CMS.

Also we set the logo of the Random Links module which, in this case, gets displayed when the module is opened for the
first time.

The Random Links logo graphic file referred to is [available
here](http://www.pyenet.co.nz/assets/images/RandomLinksLogo.png).

The next function we require is shown below, add this to the RandomLinksAdmin.php file, before the last }:

	:::php
		/**

		 * Override of the Link function in the LeftAndMain.php as requested in that file
		 */
		function Link($action = null) {
			return "admin/randomlinks/$action";
		}


The Link() function overrides the LeftAndMain::Link() function as the comment in the cms/code/LeftAndMain.php file
requires. This function returns the relative URL for the administration interface for this module. Change the
randomlinks text in the URL to match the name you have given to the root level directory of the module.

The next function we require is used to override LeftAndMain::LogoStyle() function. It was during the research into
constructing this module I noticed an issue with the LeftAndMain::LogoStyle() function. As it stands the call used in
LeftAndMain will not function correctly. See the [enhancement request](http://open.silverstripe.com/ticket/2539) that
requests the function be modified to allow the above call to work correctly. If the enhancement request is implemented
in LeftAndMain then this override function will not be needed.

	:::php
		/**

		 * This LogoStyle() function overrides the LeftAndMain one as it is not correct
		 * The following is the original line as per silverStripe Trac ticket #1931
		 * return "background: url(" . self::$application_logo . ") no-repeat; " . self::$application_logo_style;
		 * This override version means the $application_logo_style variable works correctly.
		 *
		 * @return String - the contents of the style attribute that adds a background image.
		 */
		function LogoStyle() {
	 		return "background-image: url(" . LeftAndMain::$application_logo . ");background-repeat: no-repeat; " . LeftAndMain::$application_logo_style;
		}


Next we require a function that generates the form that is used to enter a new link or modify a link in the database. 

	:::php
		/**

		 * Generate the input form for creating and updating a RandomLink
		 *
		 * @return Form
		 */
		function getEditForm($id) {
			// Create a validator
			$validator = new RequiredFields('LinkTitle', 'LinkURL');
	
			// Create form fields
			$fields = new FieldSet(
				// TODO The ID field needs to be hidden but while testing make it readonly
				new ReadonlyField('ID','id #',$id),
				new TextField('LinkTitle', _t('RandomLinksAdmin.LINKTITLE','Link Title xXx'), _t('RandomLinksAdmin.NEWRNDLINK','New Random Link xXx')),
				new TextField('LinkURL', _t('RandomLinksAdmin.LINKURL','Link URL xXx'), ""),
				new TextField('LinkImage', _t('RandomLinksAdmin.LINKIMAGE','Link Image xXx'), "")
			);
	
		    if ($id != 'new') {
				$actions = new FieldSet(
					new FormAction('doUpdateLink', _t('RandomLinksAdmin.UPDATELINK','Update Link xXx'))
				);
			} else {
				$actions = new FieldSet(
					new FormAction('doSaveLink', _t('RandomLinksAdmin.SAVELINK','Save Link xXx'))
				);
			}
	
			$form = new Form($this, "EditForm", $fields, $actions, $validator);
	
			if ($id != 'new') {
				$currentLink = DataObject::get_by_id( 'RandomLinks', $id );
				$form->loadDataFrom(array(
					'ID' => $currentLink->ID,
					'LinkTitle' => $currentLink->LinkTitle,
					'LinkURL' => $currentLink->LinkURL,
					'LinkImage' => $currentLink->LinkImage
				));
			}
			return $form;
		}


First off we define the fields from the form that must be valid for the form to be submitted. In this case they are
required fields. Then we create the FieldSet that contains the main input fields.

Sidenote: While you are setting things up it is a good idea to show the ID field as a read-only field but when the
module goes into production this could be changed to a hidden field.

Sidenote: You may notice the xXx in the strings used for the labels of the fields. This is a little trick I use to make
sure that I get all the strings correct in the language specific file. If the xXx appears in the interface then
something has not gone right, it should have been overridden by the string in the language file. This language file will
be [discussed below](#right_hand_panel_template).

The *if ($id != 'new')* tests make sure the returned form contains the correct components based on whether the form is
for a new link or it is for updating an existing link.

A method of adding links to the database is required:

	:::php
		/**

		 * Function that responds to the addlink action
	         *
		 * @return FormResponse - A javascript snippet to manipulate the contents of the Form_EditForm div
		 */
		public function addlink() {
			$id = $_REQUEST['ID'];
			FormResponse::add("$('Form_EditForm').getPageFromServer('$id');");
			return FormResponse::respond();
		}


The $_REQUEST array contains the contents of the form that is posted to the server and that this function handles. In
this case, as can be seen in the RandomLinksAdmin_left.ss file, the form is made up of one field; ID and in the case of
a request for a new link the ID will be 'new'.

The FormResponse::add() function basically takes the text in the parameter as javascript, in this case a call to
protoype.js's getPageFromServer, and returns it to the browser. The browser has an Evaluator loaded via the requirements
listed in the class hierarchy of RandomLinksAdmin.php ie. LeftAndMain and Controller, which will interpret and act upon
this code snippet.

As will be seen below, in the doSaveLink and doUpdateLink functions, multiple FormResponses can be cascaded together and
the final FormResponse::respond() function will actually do the sending of the response.

We now need to generate a list of random link titles that will be used in the left hand panel to allow for the selection
and updating of current the links.

	:::php
		/**

		 * Send the SiteTree for RandomLinks as a Unordered List
		 *
		 * @return String - An HTML UL made up of LIs of the titles of the RandomLinks
		 */
		public function SiteTreeAsUL() {
			$siteTree = "";
			$randomlinks = DataObject::get("RandomLinks");
	                if ($randomlinks) {
	        		foreach($randomlinks as $ID => $data) {
		        		$siteTree .= "<li id=\"record-" . $data->ID . "\" class=\"" . $data->class . " " .
			        	($data->Locked ? " nodelete" : "") . "\" >" . 
	        			"`<a href=\"" . Director::link("randomlinks", "show", $data->`ID) . "\" >" . $data->LinkTitle . "`</a>`";
		        	}
	                }
	
			$siteTree = "<ul id=\"sitetree\" class=\"tree unformatted\">" .
							"<li id=\"record-0\" class=\"Root nodelete\">" .
								"<a href=\"admin/randomlinks/show/0\" ><strong>"._t('RandomLinksAdmin.CURLINKS',"Current Links xXx")."</strong></a>"
								. $siteTree .
							"</li>" .
						"</ul>";
			return $siteTree;
		}


This function basically reads the complete RandomLinks table returning each row into a LI of an unordered list. This
string is then surrounded by a title LI and the UL tag.

To change this for your own module several things could be done. Changing the DataObject::get call to only include a sub
set of records from the database based on some criteria. xxxxMore detailsxxxx.

The SiteTreeAsUL() is actually overriding the function provided by LeftAndMain so the facilities provide by it may meet
your requirements and you may want to not have this function here at all.

Sidenote: When using the language i18n function to generate strings in a .php file we must use the filename.stringname
syntax as shown with the CURLINKS above. When the language specific text is used in a .ss file then the filename part is
not required. See an example of the usage in the [RandomLinksAdmin_right.ss file below](#right_hand_panel_template).

Again we are overriding another function here as the one provided by LeftAndMain is not quite right for the Random Links
module. In this case the deleteitems() call in LeftAndMain deals with a site tree that has parent/child relationships
between it's contents. As the Random Links module does have these we have overridden the code to take out the
parent/child relationships.

	:::php
		/**

		 * Delete a number of RandomLinks from the database and update the LHS SiteTree
		 *
		 * @return String Containing javascript snippets that delete the nodes from the LHS SiteTree
		 */
		public function deleteitems() {
			$ids = split(' *, *', $_REQUEST['csvIDs']);
	
			$script = "var st = \$('sitetree'); \n";
			foreach($ids as $id) {
				if(is_numeric($id)) {
					DataObject::delete_by_id($this->stat('tree_class'), $id);
					$script .= "var node = st.getTreeNodeByIdx('$id'); if( node ) st.removeTreeNode( node ); \$('Form_EditForm').closeIfSetTo($id); \n";
				}
			}
			FormResponse::add($script);
			return FormResponse::respond();
		}


Again the main purpose of this function is to delete records from the RandomLinks tables and to generate, and send to
the browser, a javascript snippet to delete the titles from the left hand panel. See the [Troubleshooting
section](#troubleshooting) for details on how to see the requests, and their responses generated by this code, directly
in a browser.

If you scroll back to the getEditForm() function above you will see that the FormAction objects vary depending on
whether the form is for a new link or for updating a link. And that the action to be performed sends the data to either
the doSaveLink or doUpdateLink function. Below are the handlers for these requests.

	:::php
		/**

		 * Save new link data handler
		 *
		 * @return String Statusmessage, javascript snippet to append a new tree node to the LHS
		 */
		function doSaveLink($data, $form) {
			$submitLink = new RandomLinks();
			$submitLink->Status = "Saved (new)";
			$form->saveInto($submitLink);
			if ( $submitLink->write() ) {
				FormResponse::status_message(_t('RandomLinksAdmin.SAVEDNEWLINK','Saved New Link xXx'), 'good');
				FormResponse::update_status($submitLink->Status);
				$title = Convert::raw2js($submitLink->LinkTitle);
				$response = <<<JS
	var newNode = $('sitetree').createTreeNode($submitLink->ID, "$title", "$submitLink->class");
	$('sitetree').appendTreeNode(newNode);
	JS;
				FormResponse::add($response);
				Session::set('currentRandomLinkPage', $submitLink->ID);
				FormResponse::get_page($submitLink->ID);
			} else {
				FormResponse::status_message(_t('RandomLinksAdmin.SAVEFAILED','Save Failed xXx'), 'bad');
			}
			return FormResponse::respond();
		}
	
		/**

		 * Update link data handler
		 *
		 * @return String Statusmessage
		 */
		function doUpdateLink($data, $form) {
			$id = $_REQUEST['ID'];
	
			$submitLink = DataObject::get_one("RandomLinks", "`RandomLinks`.ID = $id");
			$submitLink->Status = "Saved (update)";
			$form->saveInto($submitLink);
			if ( $submitLink->write() ) {
				FormResponse::status_message(_t('RandomLinksAdmin.UPDATEDLINK','Updated Link xXx'), 'good');
				FormResponse::update_status($submitLink->Status);
				FormResponse::set_node_title($id, $submitLink->LinkTitle);
				FormResponse::get_page($id);
				Session::set('currentRandomLinkPage', $id);
			} else {
				FormResponse::status_message(_t('RandomLinksAdmin.UPDATEFAILED','Update Failed xXx'), 'bad');
			}
			return FormResponse::respond();
		}
	


You may notice that the functions are similar, but they do vary. For example the Update Link request will have the ID of
the record to be updated, so we need to find this record and save the contents of the fields into it. The function also
makes sure the LinkTitle field is used to update the site tree title via the FormResponse::set_node_title() function.

However the Save Link function does not have an ID yet and so it has to create a new object of the RandomLinks class. It
then saves the data into the new object. If this is successful it updates the status messages, makes sure we update the
display correctly by interrogating the database to get the newly assigned ID of the just added record and generates the
code snippets to generate a new entry in the site tree on the LHS of the CMS.

This pretty much finishes the RandomLinksAdmin.php file, so go ahead and save it.


## Left hand side display template

The next file we will move onto is the:

randomlinks/templates/RandomLinksAdmin_left.ss

This file is the SilverStripe template file that handles the left hand panel of the Random Links module administration.
It is coded in the SS template language.

	:::php
	`<div class="title">``<div>``<% _t('RANDLINKS','Random Links xXx') %>``</div>``</div>`
	
	`<div id="treepanes" style="overflow-y: auto;">`
		<ul id="TreeActions">
			<li class="action" id="addlink"><button><% _t('CREATENL','Create New Link xXx') %></button></li>
			<li class="action" id="deletelink"><button><% _t('DEL','Delete Link xXx') %></button></li>
		</ul>
		<div style="clear:both;"></div>
		<form class="actionparams" id="addlink_options" style="display: none" action="admin/randomlinks/addlink">
			<input type="hidden" name="ID" value="new" />
			<input type="submit" value="<% _t('ADDLINK','Add a link xXx') %>" />
		</form>
		<form class="actionparams" id="deletelink_options" style="display: none" action="admin/randomlinks/deleteitems">
			<p><% _t('SELECTLINKS','Select the links that you want to delete and then click the button below xXx') %></p>
			<input type="hidden" name="csvIDs" />
			<input type="submit" value="<% _t('DELLINKS','Delete the selected links xXx') %>" />
		</form>
		$SiteTreeAsUL
	`</div>`


The title div is the top line of the panel that displays a title. The treepanes is the main divison of the left hand
panel that holds the TreeActions buttons (and their forms) and the site tree which is called via the $SiteTreeAsUL
function.

When the window is first opened both forms are hidden via the style="display: none" attribute. However when we click on
the Delete Link button the style is changed to allow the form to be seen. This is achieved via some javascript that is
discussed in the next section. This javascript also changes the link icons to allow selection of multiple random links
and generates a list of IDs of the selected ones. This is passed into the form so when the Delete Selected Links button
is pressed these IDs are set to the server.

For the Create New Link button the javascript does not unhide the associated form, it however does send the request
Ajaxy style to the server to open a new form in the right hand side of the CMS.

Sidenote: As mentioned above the language strings in a .ss file do NOT require the filename.stringname syntax, they only
require stringname.




## Left hand side javascript

As mentioned above when need to have some javascript associated with the left hand panel to allow manipulation of the
panel contents. Using javascript means we can make requests to the server via Ajax type calls and therefore minimise the
need to regenerate full page downloads when something needs changing in the browser display.

In a file called:

randomlinks/javascript/RandomLinksAdmin_left.js

place the following code:

	:::javascript
	if(typeof SiteTreeHandlers == 'undefined') SiteTreeHandlers = {};
	SiteTreeHandlers.loadPage_url = 'admin/randomlinks/getitem';
	SiteTreeHandlers.controller_url = 'admin/randomlinks';
	
	_HANDLER_FORMS['addlink'] = 'addlink_options';
	_HANDLER_FORMS['deletelink'] = 'deletelink_options';


Leave the editor open for the moment as we will add more code to this javascript file.

These variables are set to values needed for our specific module. The SiteTreeHandlers are used to specify URLs that
maybe needed to reach particular functions.

The _HANDLER_FORMS array define the tag ids of the forms that make up site tree actions defined in the .ss file
[discussed above](#left_hand_side_display_template).

Now add the following code:

	:::javascript
	/**

	 * New link action
	 */
	addlink = {
		button_onclick : function() {
			addlink.showNewForm();
			return false;
		},
	
		showNewForm : function() {
			Ajax.SubmitForm('addlink_options', null, {
				onSuccess : function(response) {
					Ajax.Evaluator(response);
				},
				onFailure : function(response) {
					errorMessage('Error adding link', response);
				}
			});
		}
	}


As the comment suggests this snippet defines the onclick action for the Add Link button on the interface. The actual
observer for this onclick is defined below. Basically the addlink object responds the the onclick action by generating
an Ajax request made up of the addlink_options form.

The next snippet of code is a little more complex. This is due to the need to change the site tree list icons when we
wish to delete links. The site tree list changes to allow the ability to select multiple links.

So add the following code:

	:::javascript
	/**

	 * Delete link action
	 */
	deletelink = {
		button_onclick : function() {
			if(treeactions.toggleSelection(this)) {
				$('deletelink_options').style.display = 'block';
	
				deletelink.o1 = $('sitetree').observeMethod('SelectionChanged', deletelink.treeSelectionChanged);
				deletelink.o2 = $('deletelink_options').observeMethod('Close', deletelink.popupClosed);
				addClass($('sitetree'),'multiselect');
	
				deletelink.selectedNodes = { };
	
				var sel = $('sitetree').firstSelected();
				if(sel && sel.className.indexOf('nodelete') == -1) {
					var selIdx = $('sitetree').getIdxOf(sel);
					deletelink.selectedNodes[selIdx] = true;
					sel.removeNodeClass('current');
					sel.addNodeClass('selected');
				}
			} else {
				$('deletelink_options').style.display = 'none';
			}
			return false;
		},
	
		treeSelectionChanged : function(selectedNode) {
			var idx = $('sitetree').getIdxOf(selectedNode);
	
			if(selectedNode.className.indexOf('nodelete') == -1) {
				if(selectedNode.selected) {
					selectedNode.removeNodeClass('selected');
					selectedNode.selected = false;
					deletelink.selectedNodes[idx] = false;
				} else {
					selectedNode.addNodeClass('selected');
					selectedNode.selected = true;
					deletelink.selectedNodes[idx] = true;
				}
			}
			return false;
		},
	
		popupClosed : function() {
			removeClass($('sitetree'),'multiselect');
			$('sitetree').stopObserving(deletelink.o1);
			$('deletelink_options').stopObserving(deletelink.o2);
	
			for(var idx in deletelink.selectedNodes) {
				if(deletelink.selectedNodes[idx]) {
					node = $('sitetree').getTreeNodeByIdx(idx);
					if(node) {
						node.removeNodeClass('selected');
						node.selected = false;
					}
				}
			}
		},
	
		form_submit : function() {
			var csvIDs = "";
			for(var idx in deletelink.selectedNodes) {
				if(deletelink.selectedNodes[idx]) csvIDs += (csvIDs ? "," : "") + idx;
			}
			if(csvIDs) {
				if(confirm("Do you really want to delete these links?")) {
					$('deletelink_options').elements.csvIDs.value = csvIDs;
	
					Ajax.SubmitForm('deletelink_options', null, {
						onSuccess : function(response) {
							Ajax.Evaluator(response);
							var sel;
							if((sel = $('sitetree').firstSelected()) && sel.parentNode) sel.addNodeClass('current');
							else $('Form_EditForm').innerHTML = "";
							treeactions.closeSelection($('deletelink'));
						},
						onFailure : function(response) {
							errorMessage('Error deleting links', response);
						}
					});
	 
					$('deletelink').getElementsByTagName('button')[0].onclick();
				}
			} else {
				alert("Please select at least one link.");
			}
			return false;
		}
	}


The button_onclick function defines a toggle of the display of the dropdown form that has the Delete Selected Links
button. If the form is displayed then the random link icons change to selectable checkboxes. If a link has been defined
with the class attribute of nodelete then the checkbox is disabled from selection.

Sidenote: In the Random Links module I have not implemented the isLocked field to stop a link from being deleted. This
maybe a feature to be added if the need for it is required.

The TreeSelectionChanged function makes sure that the selected nodes are checked/unchecked as required.

The popupClosed function returns the link icons to normal, cancels observers and hides the delete_options form when the
Delete Links button is pressed a second time.

The form_submit function is called when the Delete Selected Links button is pressed ie. the delete_options form is
submitted.

The last piece of code we need to add to the javascript is to set up the observers that will trap the mouse clicks etc
on the left hand panel. add this last piece of code to the RandomLinksAdmin_left.js file:

	:::javascript
	/** 

	 * Initialisation function to set everything up
	 */
	Behaviour.addLoader(function () {
		// Set up add link
		Observable.applyTo($('addlink_options'));
		$('addlink').onclick = addlink.button_onclick;
		$('addlink').getElementsByTagName('button')[0].onclick = function() {return false;};
	
		// Set up delete link
		Observable.applyTo($('deletelink_options'));
		$('deletelink').onclick = deletelink.button_onclick;
		$('deletelink').getElementsByTagName('button')[0].onclick = function() {return false;};
		$('deletelink_options').onsubmit = deletelink.form_submit;
	});


One more file is needed before we can say the left hand panel is complete. A small style sheet is required to help with
the formatting of the link icons.





## Administration Style Sheet

We need to create a small CSS file to handle the display of the random link icons in the site tree. Create the following
file:

randomlinks/css/randomlinksadmin.css

And place the following in it:

	:::css
	ul.tree li.RandomLinks  a { 
	        background-image: url(../images/treeicons/RandomLinksIcon16x16-file.gif) !important;
	}


This defines the background-image file that will be used as the icon in the CMS to represent a random link.

The icon file is [available here](http://www.pyenet.co.nz/assets/images/RandomLinksIcon16x16-file.gif) and needs to be
placed in the randomlinks/images/treeicons directory.

We should now have a completed left hand panel. However because we don't have the right hand panel to display anything
in, and we don't have any random links in the database yet, it is not going to do much except produce errors until we
have the right hand side panel. So now we move onto the right hand panel of the CMS for this module.


## Right hand panel template

There is only one file needed at the moment to get the right hand panel working, a .ss template file. So create the
file:

randomlinks/templates/RandomLinksAdmin_right.ss

And add the following:

	:::php
	`<div class="title">``<div>``<% _t('RANDLINKADMIN','Random Links Administration xXx') %>``</div>``</div>`
	
	`<% if EditForm %>`
		$EditForm
	`<% else %>`
			<form id="Form_EditForm" action="admin/randomlinks/?executeForm=EditForm" method="post" enctype="multipart/form-data" style="$LogoStyle">
				<% _t('WELCOME1','<p>Welcome to the Random Links -- xXx') %>
				<% _t('WELCOME2','admin section.  Please choose a link from the left. --xXx </p>') %>
			</form>
	`<% end_if %>`
	
	`<p id="statusMessage" style="visibility:hidden">``</p>`


Again like the left hand .ss file the title line defines the title for this panel. As the right hand panel is usually
bigger than the left, slightly more text can be used here.

The *if EditForm* control will either display an entry form for the details of a random link, if the Session variable is
set. Otherwise we assume this is the first time the user has visited the Random Links administration in this browser
session and we display a welcome message along with a logo.

The paragraph tag at the bottom of the file is a holder for status messages that the server returns to the browser via
the FormResponse::status_message functions.

As it stands we now should have a functioning Random Links administration. However if you start using it you will notice
all the labels and messages will have the xXx text. To stop these we need to setup the language file for the language we
wish the messages to appear. So, in the:

randomlinks/lang

directory create a file called en_US.php and add the following code to it.

	:::php
	<?php
	
	global $lang;
	
	$lang['en_US']['RandomLinksAdmin_left.ss']['RANDLINKS'] = 'Random Links';
	$lang['en_US']['RandomLinksAdmin_left.ss']['CREATE'] = 'Create';
	$lang['en_US']['RandomLinksAdmin_left.ss']['CREATENL'] = 'Create New Link';
	$lang['en_US']['RandomLinksAdmin_left.ss']['DEL'] = 'Delete';
	$lang['en_US']['RandomLinksAdmin_left.ss']['ADDLINK'] = 'Add new link';
	$lang['en_US']['RandomLinksAdmin_left.ss']['GO'] = 'Go';
	$lang['en_US']['RandomLinksAdmin_left.ss']['SELECTLINKS'] = 'Select the links that you want to delete and then click the button below';
	$lang['en_US']['RandomLinksAdmin_left.ss']['DELLINKS'] = 'Delete the selected links';
	$lang['en_US']['RandomLinksAdmin_left.ss']['CURLINKS'] = 'Current Links';
	$lang['en_US']['RandomLinksAdmin_left.ss']['NOLINKS'] = 'No Links defined yet';
	$lang['en_US']['RandomLinksAdmin_left.ss']['USEBUTTON'] = 'Use the create button above';
	
	$lang['en_US']['RandomLinksAdmin_right.ss']['RANDLINKADMIN'] = 'Random Links Administration';
	$lang['en_US']['RandomLinksAdmin_right.ss']['WELCOME1'] = array(
	        `<p>`Welcome to the',
	        50,
	        'Followed by application name'
	);
	$lang['en_US']['RandomLinksAdmin_right.ss']['WELCOME2'] = array(
	        'Random Links admininistration section.`</p>``<p>`The Random Links module of the SilverStripe CMS allows you to add URLs to pages on your web site that will be randomly selected and displayed each time a visitor views the page.`</p>``<p>`For an example of this please visit `<a href="http://www.pyenet.co.nz" title="PyeNet Universal Homepage" target="_blank">`http://www.pyenet.co.nz`</a>``</p>``<p>`Please choose a link from the left.`</p>`,
	        50
	);
	$lang['en_US']['RandomLinksAdmin_right.ss']['CANCEL'] = 'Cancel';
	
	$lang['en_US']['RandomLinksAdmin']['LINKTITLE'] = 'Link Title';
	$lang['en_US']['RandomLinksAdmin']['NEWRNDLINK'] = 'New Random Link';
	$lang['en_US']['RandomLinksAdmin']['CURLINKS'] = 'Current Links';
	$lang['en_US']['RandomLinksAdmin']['LINKURL'] ='Link URL';
	$lang['en_US']['RandomLinksAdmin']['LINKIMAGE'] = 'Link Image';
	$lang['en_US']['RandomLinksAdmin']['UPDATELINK'] = 'Update Link';
	$lang['en_US']['RandomLinksAdmin']['SAVELINK'] = 'Save Link';
	$lang['en_US']['RandomLinksAdmin']['SAVEDNEWLINK'] = 'Saved New Link';
	$lang['en_US']['RandomLinksAdmin']['SAVEFAILED'] = 'Save Failed';
	$lang['en_US']['RandomLinksAdmin']['UPDATEDLINK'] = 'Updated Link';
	$lang['en_US']['RandomLinksAdmin']['UPDATEFAILED'] = 'Update Failed';
	
	?>


If all goes to plan a reload of the Random Links module in the browser should have all the messages and labels appearing
without the xXx added to them. As I mentioned above having the additional text in the defaults means we can pick up
problems with the language PHP files that we may not see until another language is tried.

Before we move onto [displaying the Random Links on the web page](#displaying_random_links_within_a_web_page) we better
add some links and test that the administration of the Random Links module is working correctly.

When entering a new link the fields are:


*  Link Title - The text that identifies the Random Link. This is also used as the alternative text if the Link Image is
not available.


*  Link URL  - The URL to the destination of the Random Link. It must have the http:\/\/ included if it is to be an
external link.
    * (TODO there is no verification on this in the current version of the Random Links module).


*  Link Image - This field contains the URL to the Image that will be used for the Random Link.

For my system I created a folder in the Files & Images section of the CMS called something like:

randomlinkimages

I upload all the graphics for the links into this folder. To use one of these files the text in the Link Image field
will need to be:

assets/randomlinkimages/xxxx.png

Using a plain text field here, instead of a file/image selector means that we can enter full URL paths to image files
allowing us to refer to a image on another website etc. 


## Troubleshooting

As mentioned in the introduction section several troubleshooting tools are available during the development of a
SilverStripe module.

When to use them and what to look for can be a bit of a challenge. This section will introduce you some of the tools I
used during the development of the Random Links module.



### Reading error messages

The first step to tracking down issues can be to read, and understand, the error messages that maybe shown.

#### Ajax.Evaluator

The Ajax.Evaluator will produce errors if the information being passed from the server to the client via the
FormResponse methods is incorrect. The screen snippet below shows a possible error.

{{ :private:tutorial:ajaxerror.png |Ajax.Evaluator Error Message}}

Note that the line number reported here can be a bit misleading. It is actually the line number within the evaluator
that tripped up on the data being evaluated, NOT the line number within the data.

#### Blank Browser

Occasionally you will reload the CMS to review changes you have made and the browser "goes blank" eg. a white screen
with no graphics or text showing, or a loading... with the SilverStripe logo. When this happens the first place to look
is the web server log files, especially the error log. Typically when this problem occurs a PHP error has occurred in
your script. The data that would have been passed to the page renderer in the SilverStripe system has not been generated
and the page seems to get stuck showing the white page.

Sidenote: If you are developing on a Linux based system the tail command can come in handy here. The tail command has
the option to keep monitoring a file as new information is added; the -f option. One other feature that is handy is the
ability to monitor multiple files at once. This can be useful to see the request to the web server and any errors at the
same time. So using the syntax:

	
	tail -f /var/log/apache2/access_log /var/log/apache2/error_log


will monitor both the access and error log files of the Apache web server at the same time.

A 500 error in the log file indicates that the web server failed to respond to the browser because of an internal error
in the code being executed. The error will indicate the file and line number that generated the problem, a good place to
start tracking down the issue.



### Seeing responses

To see the contents of a FormResponse call, to make sure variables etc. are being correctly picked up in the code
snippets being passed back to the browser, use the Firebug tool.

Once installed, the Firebug extension has to be enabled for the site that you are using for the development. Browse to
the site and then click on the gray circle icon in the bottom right status bar. Once Firebug has been enabled for a site
a Green check mark will appear when accessing that site.

When the green check mark is clicked the bottom half of the browser window will change to show the Firebug console.

{{ :private:tutorial:firebugconsolescaled.png |Firebug Console}}

From here we can see:

The Firebug Console tab shows the requests being sent from the browser to the web server. Each request can be expanded
to allow access to the response from the server, the actual data sent in the request, etc.

{{ :private:tutorial:firebugconsoleoutputscaled.png |Firebug Console Tab}}

The HTML tab allows you to walk over the HTML of the web page currently being displayed. As the cursor is moved over a
tag the corresponding item on the web page is highlighted. Also if you click on an appropriate attribute the text can be
changed on the fly allowing you to see what effect this would have immediately.

{{ :private:tutorial:firebugconsolehtmlscaled.png |Firebug Console HTML Tab}}

The CSS tab shows all the cascading style sheets that have an effect on the page being displayed. Again clicking on a
style allows for a change to be immediately seen in the browser.

{{ :private:tutorial:firebugconsolecssscaled.png |Firebug Console CSS Tab}}

The Script tab allows for interrogation of the all the javascript code associated with the current page being shown on
the browser with Breakpoints and Expression watching included.

{{ :private:tutorial:firebugconsolescriptscaled.png |Firebug Console Script Tab}}

The DOM tab allows for interrogation of the DOM for the web page being displayed.

{{ :private:tutorial:firebugconsoledomscaled.png |Firebug Console DOM Tab}}

And finally the Net tab provides performance profiling for the browser/web server request/response processes.

{{ :private:tutorial:firebugconsolenetscaled.png |Firebug Console Net Tab}}

Overall a very powerful tool for website development at this level.


## Bundling the module for distribution

Once  you have the module working and ready for distribution we need to follow the [rules of
engagement](/module-maintainers) as laid out by the SilverStripe core development team.



## Displaying Random Links within a web page

Now back to the Random Links module and getting it to do something useful. If you follow the module publishing
requirements as laid out by [Module Maintainers](/module-maintainers) document then the Random Links module from this
point on breaks those rules. A fully compliant module is supposed to integrate to a SilverStripe system with a simple
running of the /db/build?flush=1 URL. However the Random Links module requires a little more to be done. This is because
it is not adding new page types to the SilverStripe system but is requiring a web author to add components to their
current website templates, which can not really be scripted successfully.

To integrate the Random Links into a web page we need to add a unordered list to the page template which will display
the links. Then we need to modify the page controller to actually retrieve the random link information from the
database. And finally we need to include a requirement that loads the CSS file for the random links. This CSS can be
modified as needed to allow the display of the Random Links to be merged into the current format of the page they are
being displayed on.


### Template modifications

The following snippet needs to be added to the page template (.ss) that is going to display the links.

	:::php
		<ul id="RandomLinksList">
			<li class="randomlinksTitle">Some Random Links</li>
			<% control RandomLinks %>
				<li class="randomlinksLink"><a href="$LinkURL" title="$LinkTitle"><img src="$LinkImage" alt="$LinkTitle" class ="randomlinksImage" /></a></li>
			<% end_control %>
		</ul>




### Page Controller Modifications

The following function needs to added to the xxxxPage_Controller class definition in the xxxxPage.php file:

	:::php
		function RandomLinks() {
			return DataObject::get("RandomLinks", "", "RAND()", "", 2);
		}


This snippet will randomly fetch 2 links (the 2 in the parameters of the call) from the RandomLinks table of the
database.

If you wish to display a different amount of random links change the number 2 as required.



### A Stylesheet

The file:

randomlinks/css/randomlinks.css

needs to be created and the following style sheet defined:

	:::css
	/**

	 * Stylesheet for the RandomLinks module for the SilverStripe CMS 
	 * Jim Pye
	 * PyeNet Universal 20080523
	 * http://www.pyenet.co.nz
	 */
	
	#RandomLinksList {
		background:#f0f0f0;
		float: left;
		border: 1px dotted #ccc;
		padding: 5px;
		width: 90%
	}
	
	#RandomLinksList li {
		margin: 0;
		list-style-type: none;
	}
	
	#RandomLinksList li.randomlinksTitle {
		font-size:1.3em;
		font-weight:bold;
		color:#0083C8;
		text-decoration:none;
		background:#ffffff;
		padding-left:25px;
		margin-bottom:5px;
	}
	
	.randomlinksImage {
		width:180px;
		height:60px;
	}


This style, as it is defined here, fits nicely into the current [www.pyenet.co.nz](http://www.pyenet.co.nz) website.
Modifications will be required to make it more friendly towards your site.

The .randomlinksImage class definition defines the width and height of the graphic that is used for the link. To avoid
distortion or clipping of the image it is suggested that the image being used for the link fit to these dimensions.

To make the Stylesheet available for the page we need to do one final addition to the xxxxPage_Controller class. In the
init() function we need to add after the parent::init() call the following line:

	:::php
		Requirements::css("randomlinks/css/randomlinks.css");


So to finally test we need to load the page that the Random Links UL has been added to. When the page is reloaded we
should see a different set of links being displayed.







## TODO

Keep up with the changes in the SilverStripe core:-


*  The way to add a new menu item to the CMS is changing in v2.3


*  A new ModelAdmin class will be introduced that will reduce some of the coding required to produce a module as
described here. Have to keep this tutorial up to date with these changes.


## References


*  [SilverStripe Coding Conventions](/coding-conventions)


*  [Writing Tests](/testing-guide-intro)


*  [Secure Development](/secure-development)

more to come...
