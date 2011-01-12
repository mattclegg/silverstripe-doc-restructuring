# SimpleImageField

SimpleImageField provides an easy way of uploading images to Image has_one relationships. Unlike
[Image](http://api.silverstripe.org/trunk/sapphire/model/Image.html), it doesn't use an iframe.

You can't use SimpleImageField inside a CMS popup window, which is submitted via AJAX. Instead, use an iframe
[Image](http://api.silverstripe.org/trunk/sapphire/model/Image.html).

{{:filefield.png|:filefield.png}}


### Example use

If you want to implement a [SimpleImageField](SimpleImageField) into a form element, you need to pass it an array of
source data.

First add your $has_one relationship:

	:::php
	static $has_one = array(
	   'FileName' => 'FileType'
	);

(i.e. Image for a FileType)

Then add your Field into your form:

	:::php
	function Form() {
	   return new Form($this, "Form", new FieldSet(
	       new SimpleImageField (
	           $name = "FileTypeID",
	           $title = "Upload your FileType"
	       )
	   ), new FieldSet(
	
	   // List the action buttons here - doform executes the function 'doform' below
	       new FormAction("doform", "Submit")
	
	   // List the required fields here
	   ), new RequiredFields(
	       "FileTypeID"
	   ));
	}
	// Then make sure that the file is saved into the assets area:
	function doform($data, $form) {
	   $file = new File();
	   $file->loadUploaded($_FILES['FileTypeID']);
			
	   // Redirect to a page thanking people for registering
	   Director::redirect('thanks-for-your-submission/');
	}


Your file should be now in the uploads directory

### API documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-files/SimpleImageField.html).
