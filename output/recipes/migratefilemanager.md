# Migrating HasManyFileManager to DataObjectManager

The [HasManyFileManager](http://silverstripe.org/has-many-file-manager-module/) isn't compatible with SilverStripe
Versions 2.3.2 and above. With the
[DataObjectManager](http://www.leftandmain.com/silverstripe-modules/2010/08/23/dataobjectmanager/) there's a much better
replacement available though.

But what if you have some Websites that still use the HasManyFileManager Module and you wish to update them? Then this
recipe is for you.

## Preparation

### Backup your data

First of all, **create a backup** of your Website. I know, everybody is telling you this, but seriously, just do it.
Since we'll modify DB entries only, a Database dump will do as backup.

### Perform SilverStripe upgrade

After you created a backup of your data, it's time to update your Website to the latest Version of SilverStripe
(currently 2.4.2). Follow the [upgrade instructions](http://doc.silverstripe.org/upgrading) to do that.

Leave the ''filemanager'' module folder in place. It won't cause any issues and is needed for the further steps.

Also install the DataObjectManager module and SWFUpload or Uploadify (I'm using uploadify in the following code
snippets).

### Getting the migration script

Download the migration script here: http://bummzack.ch/assets/Uploads/Software/tasks.zip
Unzip the file and copy the ''tasks'' folder in your ''mysite/code/'' directory.

Run ''dev/build''.

You should now be ready to start the migration from HasManyFileManager to the DataObjectManager. Make sure you can login
to the CMS and that you don't get any errors from other modules.

**Notice:** the HasManyFileManager will not be functional inside the CMS after the upgrade. This doesn't matter though,
since we're swapping it for the DataObjectManager in the next steps.

## Migrating your "AttachedFiles" to DataObjects

### Create replacement DataObject classes

The data-model of the HasManyFileManager is quite different from the one of the DataObjectManager. The
HayManyFileManager uses decorators to extend the File class, where the DataObjectManager manages custom DataObjects.

Try to identify all different file-decorators you used within your site and create DataObject classes for them. Make
sure you choose the same field-names as used for the file-decorators. Eg. a File has a ''Title'' field. If that title
should be migrated, you have to add the ''Title'' to the DataObject as well (see code listing below). The same is true
for all ''has_one'' relations, **except** the File and Page relation.

Don't update the ''has_many'' relations in your Page-classes yet!

Here's an example DataObject class that can be used as a replacement for the decorated file-class.

	:::php
	<?php
	class ImageAttachment extends DataObject
	{
		// adding title here, since the title of the file should
		// be migrated to the DataObject.
		public static $db = array(
			'Title'	=> 'Varchar(255)'
		);
		
		public static $has_one = array(
			'Image'	=> 'Image',
			'Page'	=> 'Page'
		);
		
		
		public function getCMSFields(){
			// using the uploadify module here, so make sure
			// to install this module as well.
			$imageUpload = new FileUploadField('Image');
			$imageUpload->imagesOnly();
			
			return new FieldSet(array(
				new TextField('Title'),
				$imageUpload
			));
		}
	}


Once you created the DataObject classes, it's time to run ''dev/build'' once more to create the DB tables.


### Define the mapping table

For this example, I'm going to assume that we have a Page-Class (''PortfolioPage'') that used the HasManyFileManager.
The class looks like this:

	:::php
	class PortfolioPage extends Page 
	{
		static $db = array();
		static $has_one = array();
		static $has_many = array(
			'Images' => 'Image'
		);
		
		public function getCMSFields() {
			$fields = parent::getCMSFields();
			
			$manager = new HasManyFileManager(
				$this,
				'PortfolioImages', // name -> will be used for file grouping
				'Images' // relation name defined in $has_many
			);
			
			$fields->addFieldToTab('Root.Content.Images', $manager);
			return $fields;
		}
	}


The migration script needs to know which relations will map to which DataObject. You can specify this mapping-table in
your ''mysite/_config.php'' file. For the above class it should look like this:

	:::php
	MigrateFileManagerToDOM::$migrationMap = array(
		// array keys are page-class names
		'PortfolioPage' => array(
			// array keys map to the has_many relations, the value
			// should be the classname of the DataObject that will be
			// used as a replacement
			'Images' => 'ImageAttachment'
		)
	);


You can add further page-classes to the array. Make sure you also add any subclasses!

### Run the migration script

Open ''dev/tasks'' in your browser. You should get a list of tasks, one task should be named **Migrate
HasManyFileManager to DataObjectManager**. 

Click it (don't worry, it won't change anything yet).

You will see a list of all your pages. Each page that has attached files will be highlighted *green* (if ok) or *red*
(if somethings missing). Make sure that all pages are marked *green*, by adding their classes to the ''$migrationMap''.
You'll also get a debug output for each page that will show which fields will be migrated.

If everything is alright, click the **Perform the migration** link at the bottom of the page. This will perform the
actual migration.

### Moving to the DataObjectManager

Now that all the *attached files* were migrated to DataObjects, you can start to use the DataObjectManager within the
CMS. To do this, you'll have to replace all your ''HasManyFileManager'' instances with ''DataObjectManager'' instances.
Here's how the ''PortfolioPage'' should be changed to work with the DataObjectManager (previous code is commented out).

	:::php
	class PortfolioPage extends Page 
	{
		static $db = array();
		static $has_one = array();
		static $has_many = array(
			//'Images' => 'Image'
			'ImageAttachments' => 'ImageAttachment'
		);
		
		public function getCMSFields() {
			$fields = parent::getCMSFields();
			/*
			$manager = new HasManyFileManager(
				$this,
				'PortfolioImages', // name -> will be used for file grouping
				'Images' // relation name defined in $has_many
			);

			*/
			$manager = new ImageDataObjectManager(
				$this,
				'ImageAttachments',
				'ImageAttachment',
				'Image'
			);
			$fields->addFieldToTab('Root.Content.Images', $manager);
			return $fields;
		}
	}


That's it. The DataObjectManager should now show up in the CMS instead of the HasManyFileManager!

### Cleaning up

Once you have successfully migrated from HasManyFileManager to the DataObjectManager, you may delete the following
things:

 1.  The ''tasks'' folder that we created previously can now be deleted
 2.  The migration map that was added to ''_config.php'' can be removed
 3.  The HasManyFileManager module can be removed by deleting the ''filemanager'' folder.

After these changes, run ''dev/build'' and you're done.
