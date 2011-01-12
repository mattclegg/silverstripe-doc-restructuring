# getCMSFields

This is the method you need to call to add / remove / edit fields in the CMS. For a tutorial on how to add your own
fields to the CMS see [tutorial 2](http://doc.silverstripe.com/doku.php?id=tutorial:2-extending-a-basic-site) which
covers how to add fields to your page types

## Adding Fields / Tabs

	:::php
	// add a another textbox under the Content tab
	$fields->addFieldToTab("Root.Content", new TextField("ExtraContent", "Extra Content"));
	
	// Make a new tab 'BioPic' and add a image field
	$fields->addFieldToTab("Root.BioPic", new ImageField("Picture", "Staff Photo"));


## Removing Fields / Tabs

	:::php
	// remove the content text area 
	$fields->removeFieldFromTab("Root.Content.Main","Content");
	
	// remove the whole reports tab
	$fields->removeFieldFromTab("Root","Reports");


## Renaming Fields

	:::php
	// Don't like the title for 'Content'?
	$fields->renameField("Content", "A better Title for Content");


