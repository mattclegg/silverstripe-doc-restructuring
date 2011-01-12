# Introduction

The **HasManyFileManager** is a extension to the SilverStripe CMS that allows the user to attach multiple Files or
Images to a SiteTree Object (a Page).
As of now, it's a pure backend extension but can be used to build Gallerys or other fancy stuff for your website.

## Features

*  *Attach* files to your pages for a gallery or file lists.

*  Order your files with drag'n'drop

*  Simple installation...

*  ... yet easy to extend with custom file decorator classes.


## How does it look like?

HasManyFileManager for images. Reorder your images or files with drag'n'drop\\
{{:modules:hasmanyfilemanager-inaction.jpg?600x459|The HasManyFileManager CMS extension}}

...same goes for files instead of images\\
{{:modules:hasmanyfilemanager-files2.png|HasManyFileManager for files}}

## Known issues

There seems to be a conflict when using the HasManyFileManager in conjunction with the Gallery Module. For the time
being, please try to avoid a SilverStripe installation with both modules.

Problems occur when the HasManyFileManager is used in a i18n enabled Site.

# Installation


## Requirements

This module has been tested with the May 2008 release of **SilverStripe 2.2.2**
([http://silverstripe.org/assets/downloads/PHPInstaller/silverstripe-v2.2.2.tar.gz](http://silverstripe.org/assets/downloads/PHPInstaller/silverstripe-v2.2.2.tar.gz)),
and with **SilverStripe 2.3.0**
([http://silverstripe.org/assets/downloads/SilverStripe-v2.3.0.tar.gz](http://silverstripe.org/assets/downloads/SilverStripe-v2.3.0.tar.gz))

For SilverStripe 2.2, please use the 0.3.1 release. For SilverStripe 2.3, use the current 0.3.2 release or trunk.

Other Versions are currently untested and might not work. If you manage to run this module on another SilverStripe
installation, please let me know (post in the [forum thread](http://silverstripe.org/all-other-modules/show/251371)?).



## Getting the sources

Currently the HasManyFileManager module is available as zipped Sources (get them here:
[http://bummzack.ch/hasmanyfilemanager/](http://bummzack.ch/hasmanyfilemanager/)) or via SVN:

**0.3.2 for SilverStripe 2.3**

	:::bash
	svn co http://svn.silverstripe.com/open/modules/hasmanyfilemanager/branches/0.3.2 filemanager


**0.3.1 for SilverStripe 2.2**

	:::bash
	svn co http://svn.silverstripe.com/open/modules/hasmanyfilemanager/branches/0.3.1 filemanager



### Installing the Module

Download and extract/move the sources to a directory named "filemanager" in your SilverStripe installation directory.
After that, your directory structure should look similar to the depicted structure:
{{:modules:hasmanyfilemanager-installdir.png|Directory structure after installation of the HasManyFileManager}}

After this basic installation, all that is left to do is to run 

	
	http://`<yoursite.com>`/db/build?flush=1

on your website (make sure to login to the CMS first).

# Usage instructions

## Adding a HasManyFileManager to your Page
The HasManyFileManager is basically just a form field for the CMS. To get an idea how you can use the HasManyFileManager
in your CMS there's a documented DEMO-File called "FilePage.php" in the ''filemanager/code'' directory.

The DEMO-File (FilePage.php) covers all **three relevant points** that you should consider implementing for your own
Pages that make use of the HasManyFileManager.

**1)** define at least one **has_many** (file/images) relation for your page. In the example we use both, images and
files

	:::php
	static $has_many = array(
	    'Files' => 'File',
	    'Images' => 'Image'
	);


**2)** add HasManyFileManager form fields to your getCMSFields method

	:::php
	public function getCMSFields() {
	    $fields = parent::getCMSFields();
	
	    $manager = new HasManyFileManager(
	        $this,
	        'Testing', // name -> will be used for file grouping
	        'Files' // relation name defined in $has_many
	    );
	
	    $manager2 = new HasManyFileManager(
	        $this,
	        'MyImages', // name -> will be used for file grouping
	        'Images' // relation name defined in $has_many
	    );
	    
	    // creating tab for the "Files" Manager
	    $fields->addFieldToTab('Root.Content.Files', $manager);
	    // creating tab for the "Images" Manager
	    $fields->addFieldToTab('Root.Content.Images', $manager2);
	    return $fields;
	}


As you can see, we add a HasManyFileManager for each one of our **has_many** relations. By giving a distinct name
(//Testing// and *MyImages* in our example) to each HasManyFileManager instance, we can later access these groups
separately.

I previously mentioned that the HasManyFileManager behaves just like a form element. Well, that's true, except that you
should always add each HasManyFileManager field to it's own tab! In the above example we add the manager for files to a
tab called *"Files"* and the manager for the Images to a Tab called *"Images"*.

**3)** making sure your files are deleted when they are no longer being used

	:::php
	public function onBeforeDelete(){
	    parent::onBeforeDelete();
	    $this->deleteAttachedFiles();
	}


Just implement a onBeforeDelete method for your Page Class. There is already a implementation that will delete the files
for you, so you basically just have to call ''$this->deleteAttachedFiles();'' inside your onBeforeDelete method and
everything is taken care of.

## Output the files on your website

Outputting your attached Files on your site is simple. There's a ''AttachedFiles'' control that's ready-to-use for your
templates.
Here's a simple example that will output a unordered list of all Filenames of the files attached to the current page:

	:::html
	`<% if AttachedFiles %>`
	    `<ul>`
	        `<% control AttachedFiles %>`
	            `<li>`$Name`</li>`
	        `<% end_control %>`
	    `</ul>`
	`<% end_if %>`


If you have multiple HasManyFileManagers for one page, you can get the files of one filemanager by adding the group name
as parameter to the AttachedFiles control. The following example will only output the files of the *MyImages* group and
scale the images to a width of 300 pixels:

	:::html
	`<% control AttachedFiles(MyImages) %>`
	    `<div>`$SetWidth(300)`</div>`
	`<% end_control %>`


This should enable you to build your own galleries or file-download lists.

## Create your custom "file class"

The HasManyFileManager uses it's own decorator class for attached files (''class AttachedFile''). The basic
implementation allows you to upload a file and specify a title for every file. You can easily implement your own File
Decorator to add more Fields to the HasManyFileManager. 

Here's the full source code for such a class, called ''MyFile'' (normally, you would save this code in
''/mysite/code/MyFile.php'', not in the filemanager directory!)

	:::php
	<?php
	/**

	 * Some custom File to use in the HasManyFileManager
	 * Extends the File-Table in the Database
	

	 */
	class MyFile extends DataObjectDecorator
	{
	    /**

	     * Adding additional DB Fields to the File Table.
	     * @see http://doc.silverstripe.com/doku.php?id=dataobjectdecorator
	     * 
	     * @return array containing additional DB information
	     */
	    public function extraStatics() {
	        return array(
	            'db' => array(
	                'isFavorite' => 'Boolean',
	                'Description' => 'Varchar(255)',
	                'Category' => "Enum('photography, graphics, painting, other', 'photography')"
	            )
	        );
	    }
	
	    /**

	     * Get the custom CMS Fields for this Class (to be used by the
	     * HasManyFileManager).
	     * As you can see we make a distinction between Images and other files!
	     *
	     * @return FieldSet
	     */
	    public function getMyCMSFields(){
	        if($this->owner instanceof Image){
	            return new FieldSet(
	                new TextField(
	                    'Title', 
	                    'Title', 
	                    $this->owner->ID ? $this->owner->Title : ''
	                ),
	                new TextField(
	                    'Description',
	                    'Short Description',
	                    $this->owner->ID ? $this->owner->Description : ''
	                ),
	                new DropdownField(
	                    'isFavorite', 
	                    'is this a favorite?', 
	                    array(1=> 'Yes', 0 => 'No'), 
	                    $this->owner->ID ? $this->owner->isFavorite : 0
	                ),
	                new DropdownField(
	                    'Category', 
	                    'Category', 
	                    singleton('File')->dbObject('Category')->enumValues(), 
	                    $this->owner->ID ? $this->owner->Category : 0
	                )
	            );
	        } else {
	            return new FieldSet(
	                new TextField('Title', 'Title', $this->owner->Title)
	            );
	        }
	    }
	}


As you can see, we add some extra Database fields to our Files table. The syntax might be new to you if you didn't use
Decorators before. If you're interested in more information on that topic, please read the
[DataObjectDecorator](/dataobjectdecorator) documentation.

The **getMyCMSFields** method is being used by the HasManyFileManager to display your form-fields. This is the place for
you to define some form fields for your newly added database fields.

### Install your custom "file class"

After you created a class as described above, you have to register it as a decorator for the ''File'' class. This can be
done by adding the following line to the end of your _config.php file (to be found in ''/mysite/_config.php''):

	:::php
	DataObject::add_extension('File', 'MyFile');


This registers your class (MyFile) as extension of the File class.
After that, you should rebuild your database tables:

	
	http://`<yoursite.com>`/db/build?flush=1



### The custom class in action

If you followed the previous steps, you should now be able to manage your files using the HasManyFileManager and your
File Decorator. The following screenshot shows how this looks like with the MyFile class:
{{:modules:hasmanyfilemanager-customform-detail.jpg|Custom form fields for your files}}

# Maintainer

Roman Schmid (banal)
http://silverstripe.com/ForumMemberProfile/show/1644

