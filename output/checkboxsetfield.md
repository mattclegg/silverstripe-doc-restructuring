# CheckboxSetField

Displays a set of checkboxes as a logical group.

{{:checkboxsetfield.png|:checkboxsetfield.png}}


## Example use

If you want to implement a [CheckboxSetField](CheckboxSetField) into a form element, you need to pass it an array of
source data.

	:::php
	new CheckboxSetField(
	   $name = "topics",
	   $title = "I am interested in the following topics",
	   $source = array(
	      "1" => "Technology",
	      "2" => "Gardening",
	      "3" => "Cooking",
	      "4" => "Sports"
	   ),
	   $value = "1"
	)


## Data connectivity

The checkbox set field will save its data in one of ways:


*  If the field name matches a many-many join on the object being edited, that many-many join will be updated to link to
the objects selected on the checkboxes.  In this case, the keys of your value map should be the IDs of the database
records.

*  If the field name matches a database field, a comma-separated list of values will be saved to that field.  The keys
can be text or numbers. 

## API documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-basic/CheckboxSetField.html).

