### Introduction

The dataobject_manager module is an extension to ComplexTableField that allows robust management of DataObjects related to a Page. Features:

*  Column sorting

*  Live search field

*  Custom filter field

*  Live page sizing

*  Drag-and-drop reordering

*  Clean and intuitive UI


The DataObjectManager class further cascades into subclasses FileDataObjectManager and ImageDataObjectManager, which add more features specific to file-containing DataObjects, including:

*  Bulk uploading

*  File type and size filtering

*  Upload progress bar
    
*  File importing

*  Toggleable list/grid view of files

*  Image sizing tool (ImageDataObjectManager only)



### Requirements

*  Silverstripe 2.3

*  [SWFUploadField](SWFUploadField) (Optional, for FileDataObjectManager and ImageDataObjectManager)

### Installation

Place the //dataobject_manager// folder in the Silverstripe root and run a /dev/build. If you wish to take advantage of FileDataObjectManager or ImageDataObjectManager, install the [swfuploadfield](swfuploadfield) module, as well. 

### Usage

=== DataObjectManager ==

##### Code

A subclass of [ComplexTableField](ComplexTableField), the DataObjectManager takes the same arguments and configuration as its parent. In the example below we will use a DataObjectManager to manage //Testimonial// DataObjects on a given page type.
// mysite/code/Testimonial.php //
~~~ {php}


class Testimonial extends DataObject
{
	static $db = array (
		'Date' => 'Date',
		'Author' => 'Text',
		'Quote' => 'HTMLText'
	);
	
	static $has_one = array (
		'TestimonialPage' => 'TestimonialPage'
	);
		
	public function getCMSFields_forPopup()
	{
		return new FieldSet(
			new CalendarDateField('Date'),
			new TextField('Author'),
			new TextareaField('Quote')
		);
	}
}



~~~

// mysite/code/TestimonialPage.php //

~~~ {php}


class TestimonialPage extends Page
{
	static $has_many = array (
		'Testimonials' => 'Testimonial'
	);
	
	public function getCMSFields()
	{
		$f = parent::getCMSFields();
		$f->addFieldToTab("Root.Content.Testimonials", new DataObjectManager(
			$this,
			'Testimonials',
			'Testimonial',
			array('Date' => 'Date','Author'=>'Author','Quote' => 'Quote'),
			'getCMSFields_forPopup'
		));
		return $f;
	}

}


~~~

##### User Interface

After running a /dev/build (assuming the relationship had not already been created), we should get something like this in the CMS:

{{:modules:dom_1.png|:modules:dom_1.png}}

To edit a record, simply click the edit button on any given row, and save the new information.

{{:modules:dom_2.png|:modules:dom_2.png}}

You may search the displayed records using the live search bar.

{{:modules:dom_3.png|:modules:dom_3.png}}

If you have any custom filters or sorting applied to the list, the search will retain its state.

##### Adding a Custom Filter

If you would like to filter your records by a specific field on the DataObject, you can apply a custom filter field, which will appear as a dropdown menu above the list of records. In the below example, we will add a filter to the list of testimonials that will only show us records with a given Author.

~~~ {php}
$myDataObjectManager->setFilter(
   'Author', // The field we're filtering
   'Filter by Author', // The label for the filter field
   array(
     'Bob' => 'Bob',
     'Suzy' => 'Suzy',
     'Lisa' => 'Lisa'
   ) // The dropdown map of values => display text. The values will be matched against the Author field.
); 
~~~

##### Activate Drag-and-Drop Sorting

Because drag-and-drop sorting adds custom functionality to all eligible DataObject subclasses, the DataObjectManager requires that the user opt into sorting capability.

// mysite/_config.php //
~~~ {php}
SortableDataObject::add_sortable_class('Testimonial');
~~~

After running a /dev/build, the following will be modified to give Testimonials sorting capability.

*  The field //SortOrder// will be added to the Testimonial table
    
*  The $default_sort property of the Testimonial will be set to //SortOrder//. This will ensure that the frontend template displays the objects in the correct order.

// Note: To add several sortable classes at once, use **SortableDataObject::add_sortable_classes(array $classNames)** //

##### Useful Methods

**// setAddTitle($title) //**
The text that will be displayed on the Add button. Defaults to // Title // field (in this case, // Testimonial //).

**// setSingleTitle($title) //**
The text that will be displayed on saving of the record, e.g. // Saved $SingleTitle successfully. //. Defaults to // Title // field of the DataObjectManager.


#### FileDataObjectManager

##### Code

A FileDataObjectManager takes one more argument than a standard DataObjectManager. It requires the name of the File relationship on the DataObject. In the following example, we'll create a // Resource // object that contains a PDF file. The //Resource// objects are contained in a //ResourcePage// page type.

// mysite/code/Resource.php //
~~~ {php}
class Resource extends DataObject
{
	static $db = array (
		'Name' => 'Text',
		'Description' => 'Text',
		'Category' => "Enum('Industry, Finance, Education')"
	);
	
	static $has_one = array (
		'Attachment' => 'File',
		'ResourcePage' => 'ResourcePage'
	);
	
	public function getCMSFields_forPopup()
	{
		return new FieldSet(
			new TextField('Name'),
			new TextareaField('Description'),
			new DropdownField('Category','Category', singleton('Resource')->dbObject('Category')->enumValues()),
			new FileIFrameField('Attachment')
		);
	}
}


~~~

// mysite/code/ResourcePage.php //

~~~ {php}
class ResourcePage extends Page
{
	static $has_many = array (
		'Resources' => 'Resource'
	);
	
	public function getCMSFields()
	{
		$f = parent::getCMSFields();
		$manager = new FileDataObjectManager(
			$this, // Controller
			'Resources', // Source name
			'Resource', // Source class
			'Attachment', // File name on DataObject
			array(
				'Name' => 'Name', 
				'Description' => 'Description', 
				'Category' => 'Category'
			), // Headings 
			'getCMSFields_forPopup' // Detail fields (function name or FieldSet object)
			// Filter clause
			// Sort clause
			// Join clause
		);
                $f->addFieldToTab("Root.Content.Resources",$manager);
                return $f;
	}
}
~~~

##### User Interface

{{:modules:dom_7.png|:modules:dom_7.png}}

The primary difference between a FileDataObjectManager and a standard DataObjectManager is that its focus is on the File object //related to// the DataObject. By default, all the records in a FileDataObjectManager are displayed in a grid view, each represented by an icon of its related File object.

{{:modules:dom_9.png|:modules:dom_9.png}}

This view can be toggled by clicking "List view" or "Grid view" on the FileDataObjectManager.

Further, adding records to a FileDataObjectManager begins with a bulk upload or import of files.

{{:modules:dom_4.png|:modules:dom_4.png}}

After uploading a batch of files, the FileDataObjectManager walks through each one and allows the user to add attributes to its related DataObject. Notice that the FileField is automatically removed from this process. It is replaced when editing a record to allow file replacement.

{{:modules:dom_5.png|:modules:dom_5.png}}

##### Useful Methods

**//setAllowedFileTypes(array $types)//**
Sets the file types that are allowed to be uploaded through the bulk uploader. All invalid types will be greyed out in the dialog box. File types are passed as an array of extensions, with or without a leading period, e.g. // array('pdf','doc') //.

**//setBrowseButtonText($text)//**
Sets the text that will appear on the upload button. e.g. "Upload (PDF of DOC only)".

**//setGridLabelField($field)//**
Sets the name of the field that will label each Object in the grid view. Defaults to the Filename of the related File object, but can also be a property of the DataObject itself, e.g. // $myFileDataObjectManager->setGridLabelField('Name') //

**//setPluralTitle($title)//**
Sets the plural form of the DataObjects being managed. Used for display in the upload popup window, e.g. "Upload MyObjects"

**//setButtonAddTitle($title)//**
The text that will appear on the Add button of the FileDataObjectManager. Defaults to //PluralTitle//.


**//setUploadLimit($limit)//**
Sets the maximum number of files that can be added to the upload queue. Default is 20.

**//allowUploadFolderSelection()//**
Allows the user to select the destination folder of all uploaded files. Default is // /assets/Uploads //.

**//enableUploadDebugging()//**
Activates a debugging window for the bulk upload tool.

#### ImageDataObjectManager

##### Code

The ImageDataObjectManager takes the same arguments and configuration as a FileDataObjectManager. The only difference is that its only allowed file classes are Image or subclasses thereof.

##### User Interface

The ImageDataObjectManager adds an image resizing tool in place of the List/Grid view buttons.

{{:modules:imagegallery_3.png|:modules:imagegallery_3.png}}

#### Relation DataObjectManagers

To manage $has_one, $has_many, or $many_many relationships of Pages to DataObjects, the following classes are available as subclasses of their respective ComplexTableField:

*  HasOneDataObjectManager

*  HasManyDataObjectManager

*  ManyManyDataObjectManager

*  HasOneFileDataObjectManager (coming soon)

*  HasManyFileDataObjectManager (coming soon)

*  ManyManyFileDataObjectManager (coming soon)

### Other Goodies

The DataObjectManager comes bundled with a few extra useful goodies:

*  [SimpleHTMLEditorField](http://doc.silverstripe.com/doku.php?id=simplehtmleditorfield) : Allows WYSIWYG editing in popup windows.

*  [SimpleTreeDropdownField](http://doc.silverstripe.com/doku.php?id=simpletreedropdownfield) : A lightweight, non-javascript version of TreeDropdownField. Works in popups.

*  [DatePickerField](http://doc.silverstripe.com/doku.php?id=datepickerfield) : A jQuery-based calendar date picker. Compliant in DataObjectManager popups.

### Getting Support

The best way to get support is through the Silverstripe forum. The following thread has been very active:

http://www.silverstripe.org/all-other-modules/show/253878?start=96#post255678
