# CheckboxField

Single checkbox field.

{{:checkboxfield.png|:checkboxfield.png}}


## Example use

First add the new field to the database:

	:::php
	"db" => array(
	   'newsletter' => 'Boolean'
	)

Then add the field to the form

	:::php
	new CheckboxField(
	   $name = "newsletter",
	   $title = "I would like to receive a monthly newsletter"
	);


## API documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-basic/CheckboxField.html).
