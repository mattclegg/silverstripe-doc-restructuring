====Introduction====
The BulkUploader field is designed to simplify the uploading and management of file-containing DataObjects on a Page. It can be customized to work with the fields of a unique DataObject. The BulkUploaderField features a Flash-based uploading UI using the [swfupload](swfupload) module, which allows multiple file selection (bulk uploading), file type filtering, file size filtering, and upload progress indicators. It also works with the [SortableDataObject](SortableDataObject) extension to allow arbitrary drag-and-drop re-ordering of DataObjects in both the CMS and front end.

====Requirements====
Silverstripe 2.3+, the [swfupload](swfupload) module, and the [sortabledataobject](sortabledataobject) module (if sorting is required).


====Installation====
Download the BulkUploaderField module, and place the **bulk_uploader**, **swfupload**, and **sortable_dataobject** folders in the Silverstripe root. Run a /dev/build.

====What it does====
The BulkUploader field manages DataObjects that are associated with a page that each contain a relationship to a file. Ordinarily, this would have to be done in a ComplexTableField, add each DataObject in a popup, save it, add the file, and then repeat the process. Since many users think in terms of adding files to the page, the BulkUploaderField is designed to make this process more file-centric, and adding content fields to each DataObject is an ancillary task.

====What it does not do====
Currently, the BulkUploaderField only works with DataObjects containing files. It will not support a direct relationship of Page to File. This will change in the future.



====A Quick Tour====
===The Overview Page===
{{:modules:bulk01.gif|:modules:bulk01.gif}}

On the left, the file-containing DataObjects that are associated with this page are displayed. When the user clicks "edit" the fields for that DataObject are editable in the right-hand column. Files can be imported from another folder using the **Import** feature.
===The Upload===
{{:modules:bulk2.gif|:modules:bulk2.gif}}

Multiple files can be selected out of a dialog box in a Flash-based uploading UI. Allowed file types (if specified) are displayed at the bottom. Invalid files are greyed out of the dialog box.
===Adding Content===
{{:modules:bulk3.gif|:modules:bulk3.gif}}

Each file you have uploaded renders editable fields for the DataObject with which it is associated.
===Sorting===
{{:modules:bulk04.gif|:modules:bulk04.gif}}

If the [sortabledataobject](sortabledataobject) extension is installed, there is one line of code required in your //_config.php// to allow drag-and-drop sorting of the DataObjects in the CMS and front end.



====Example Usage====
Let's look at an example of a ResourcePage. Here's how the relationships are set up:

//mysite/code/ResourcePage.php//
~~~ {php}
class ResourcePage extends Page
{
  static $db = array ();
  static $has_many = array (
    'Resources' => 'Resource'
  );
}
~~~

//mysite/code/Resource.php//
~~~ {php}
class Resource extends DataObject
{
  static $db = array (
    'Name' => 'Text',
    'Description' => 'Text'
  );

  static $has_one = array (
    'ResourcePage' => 'ResourcePage',
    'PDF' => 'File'
  );
}
~~~

As you can see, each ResourcePage has many Resources associated with it. Ordinarily, we would manage this relationship in a [ComplexTableField](ComplexTableField), but because the DataObject has a relationship with a file, we can use the **BulkUploaderField**.

===Adding the Field===
//mysite/code/ResourcePage.php//
~~~ {php}
function getCMSFields()
{
  $fields = parent::getCMSFields();
  $fields->addFieldToTab("Root.Content.Files", new BulkUploaderField(
    $this,
    'Resources',
    'PDF'
  ));
  return $fields;
}
~~~

Let's look at each of these arguments:
- **$this** : The controlling Page object
- **Resources** : The //name// of the relationship being managed (not the ClassName)
- **PDF** : The //name// of the file relationship on the DataObject (not the ClassName)

===Configuring the DataObject===
The **BulkUploaderField** allows you to add some unique static variables to your DataObject class to help with the customization.

//mysite/code/Resource.php//
~~~ {php}
protected static $bulk_uploader_fields = array (
  'Name' => 'TextField',
  'Description' => 'TextField'
);

protected static $allowed_file_types = array (
  'pdf'
);
~~~

The **$bulk_uploader_fields** property instructs the **BulkUploaderField** which form fields to put in the edit forms. It works a lot like a [TableField](TableField) in that it takes strings that represent the name of the FormField object rather than actual objects. 

The **$allowed_file_types** property is optional. If file types are added to this array, all other types will be greyed out in the file upload dialog box. //Note: leading periods in the extension names are optional //.


====Enabling Sorting====
If the [sortabledataobject](sortabledataobject) extension is installed, you can enable drag-and-drop sorting with one line.

//bulk_uploader/_config.php//
~~~ {php}
SortableDataObject::add_sortable_class('Resource');
~~~

Now run a //dev/build// and sorting will be enabled.





====What's Next====

-Allow **$bulk_uploader_fields** to accept FormField //objects// rather than strings. This would allow more dynamic data including [DropdownField](DropdownField)s and [CheckboxSetFields](CheckboxSetFields).

-Integrate with the [image_gallery](image_gallery) module.
