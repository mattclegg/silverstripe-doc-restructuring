# Introduction

{{http://www.carlinowebdesign.com/assets/uploadify1.png?480}}

The Uploadify module is a FormField object that handles a variety of file upload features, and integrates easily into
any frontend or CMS edit form. Features include:


*  Bulk uploading

*  Upload progress

*  File type filtering

*  Upload folder selection/creation

*  Import files

*  Drag-and-drop reordering

*  Amazon S3 storage integration

{{http://www.carlinowebdesign.com/assets/uploadify2.png}}

# Components

The Uploadify package contains the following field types:


*  FileUploadField

*  MultipleFileUploadField

*  ImageUploadField

*  MultipleImageUploadField

*  S3UploadField

*  S3MultipleUploadField

All of these components are descendants of the abstract class *UploadifyField*.

# Usage

Uploadify works exactly the same way as a FileIFrameField, ImageField, or FileField. The first argument is the name of
the file relationship, and the second argument is used for a label or title of the field.

## Single File Upload

The most common type of file upload is a single attachment. We'll create a $has_one relationship in the page class, and
add the field.

Example:

	:::php
	class MyPageWithFile extends Page {
		static $has_one = array (
			'AttachedFile' => 'File'
		);
		
		public function getCMSFields() {
			$fields = parent::getCMSFields();
			$fields->addFieldToTab("Root.Content.File", new FileUploadField('AttachedFile','Upload a file'));
			return $fields;
		}
	}


This is the most simple integration of an Uploadify field. It could just as easily be substituted with FileIFrame field.
Notice that the name of the field is the $has_one relationship name on the page. It is not necessary to add "ID" to the
name.

## Multiple Files

Uploading multiple files is a little bit different, because we'll need a $has_many on the page class and a $has_one on
the File class. The latter is a bit more difficult. In order to give File a $has_one, we need to either decorate the
$has_one relationship, or we can subclass the File object. This example demonstrates how to create a multiple file
upload for a page using a file subclass.

// MyFile.php //

	:::php
	class MyFile extends File {
	
		static $has_one = array (
			'MyPageWithFiles' => 'MyPageWithFiles'
		);
	
	}


// MyPageWithFiles.php //

	:::php
	class MyPageWithFiles extends Page {
	
		static $has_many = array (
			'AttachedFiles' => 'MyFile'
		);
		
		public function getCMSFields() {
			$fields = parent::getCMSFields();
			$fields->addFieldToTab("Root.Content.Files", new MultipleFileUploadField('AttachedFiles','Upload several files'));
			return $fields;
		}
	}

## A Frontend Form Example

You can find a tutorial and screencast on using Uploadify in a frontend form here:
http://www.leftandmain.com/silverstripe-tutorials/2010/08/30/using-uploadify-in-frontend-forms/


## Configuration

Uploadify fields are highly configurable, allowing custom upload scripts, file type filtering, choosing upload
behaviours, and more. There are three ways to set configuration values.

### Setting a value globally

To set a value across all Uploadify form fields, invoke the static method // set_var($var, $value) //. For instance, to
set the text of the browse button on all Uploadify fields, use this command:

	:::php
	UploadifyField::set_var('buttonText', 'Click me!');


These global settings can be placed anywhere, as long as they will be read before the form is rendered. A _config.php
file, or somewhere in your getCMSFields() function will work fine.

### Setting a value for only one instance

To set a value for just one Uploadify field instance, use the object method // setVar($var, $value) //. For example, to
set the button text on just one Uploadify field, use this command:

	:::php
	$uploadify = new FileUploadField('SomeFile','Some title');
	$uploadify->setVar('buttonText','Click me!');


### Setting values in the constructor

You can set several values at once by supplying an array of parameters and their values in the third argument of the
constructor.

	:::php
	$uploadify = new FileUploadField('SomeFile', 'Some title', array (
	'buttonText' => 'Click me!',
	'script' => '/path/to/custom/upload/script/'
	));


### Magic settings

There are a few object methods that can be used to configure some common behaviours.
 

*  // imagesOnly() // -- Sets the uploader to only accept image files (see UploadifyField::$image_extensions)
 

*  // setFileTypes() // -- Takes an array of acceptable file types for the uploader. Note that using setVar('fileExt')
is a little more cumbersome because it takes a string of types separated by semicolons. This method creates the string
automatically.
 

*  // allowFolderSelection() // -- Available on backend uploaders only. Allows the user to select the destination folder
for the uploaded file.
 

*  // addParam($key, $value) // -- Adds an extra POST parameter to send to the upload script.
 

*  // uploadOnSubmit() // -- Holds queued files until the form is submitted. Files are then uploaded and the form is
submitted on complete.

 

## Amazon S3 Integration

Amazon S3 is a solution for data storage that is becoming increasingly popular, especially for sites that require a lot
of storage for user-submitted data. Uploadify field comes with a set of tools that make Amazon S3 storage easy and
seamless.

### Step 1: Set up the S3 integration

If you have have an S3 account, you should have an "access key" and a "secret key". Set up the authorization in your
_config.php file.

	:::php
	S3File::set_auth($access_key, $secret_key);


If you have a bucket you want to use globally, you can set that up, as well.

	:::php
	S3File::set_default_bucket('my-bucket');


The only change needed for the upload fields themselves is to use "S3UploadField" or "S3MultipleUploadField" in place of
"FileUploadField" and "MultipleFileUploadField."

Let's create a S3FilePage.

// S3FilePage.php //

	:::php
	class S3FilePage extends Page
	{
		static $has_one = array (
			'S3Test' => 'S3File'
		);
		
		
		public function getCMSFields() {
			$f = parent::getCMSFields();
			$f->addFieldToTab("Root.Content.S3 Storage", $s3 = new S3UploadField('S3Test','Send a file to Amazon S3'));
	                $s3->setVar('s3bucket', 'some-other-bucket');
			
			return $f;
		}
	}
	


Here we have overridden the default bucket set in the _config.php, and used a custom bucket for this instance.

### A note about S3File objects

Because S3File is not a subclass of File, it lacks a lot of the features you may be used to when working with Files,
although, some of the most important ones, such as Icon() and URL(), have been ported over.  Without physical files in
the local filesystem, the File table would get compromised when FileSystem::sync(); is run in AssetAdmin (and other
places). So until further notice, S3File records are stored as DataObject subclasses, and are largely agnostic of the
the File class.

Amazon S3 does not have a way of negotiating name conflicts, so S3File has a built-in mechanism to ensure uniqueness by
appending a uniqid() to the filenames. You can disable this feature by using

	:::php
	S3File::disable_unique_id();





## Authentication

Authenticating requests made by Uploadify fields is challenging, since it is actually a Flash object that is contacting
the server. Because the request comes from a foreign origin, the session data is lost, and Flash is considered a new
user. The upload handler knows nothing about the user who actually uploaded the file.

An easy solution to this problem is to pass PHPSESSID as a request parameter to the upload handler. Uploadify does this
automatically. However, some hosting environments do not allow sessions to be started based on request data. They may
have the setting // session_use_only_cookies // on. If this is the case, Uploadify will fall back on a // public //
controller for the uploads. Please note, there is a security risk associated with using a public-facing controller, and
it is best to turn the // session_use_only_cookies // off if possible.

Public-facing upload controllers include:


*  UploadifyUploader.php

*  S3Uploader.php

To determine if your server is capable of authenticating Uploadify, simply get the boolean value:

	:::php
	var_dump(UploadifyField::can_authenticate());


## Troubleshooting

The most common problem we see in Uploadify uploads is that the status bar returns "HTTP Error." This vague error is
often all that is available, because Flash can only report the HTTP response code, and not necessarily the error text
itself.

An easy, but tedious way to troubleshoot your upload is to packet sniff the request using a tool such as Wireshark.
Otherwise, add die('hello'); statements to various points of Uploadify::upload() (or S3UploadField::uploads3()).
Uploadify will alter the die statement if it has gotten that far in the function. Otherwise, it will return an HTTP
Error, and you need to move the die statement up further. Eventually, you will find the line that is causing the
problem.

Getting support:


*  [Left and Main](http://www.leftandmain.com) (The official UncleCheese blog)

*  [DataObjectManager forum](http://www.silverstripe.org/dataobjectmanager-module-forum/)