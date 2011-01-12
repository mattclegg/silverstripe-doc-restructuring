# ImageField

A field that will upload attached images.

{{:imagefield.png|:imagefield.png}}


## Choosing a Folder

If you want to upload all assets from this field to a given folder you can define the folder in 2 ways. Either in the
constructor or as a method on the field

	:::php
	$myField = new ImageField("myName", "Upload image below", null, null, null, "myFolder");


Will upload images into the assets/myFolder folder. If that folder does not exist it will create it for you. You can
also define it as a method

	:::php
	$myField = new ImageField("myName");
	$myField->setFolderName('myFolder');


## API documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-files/ImageField.html).
