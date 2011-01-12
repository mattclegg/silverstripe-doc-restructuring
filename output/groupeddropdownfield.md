# GroupedDropdownField

Dropdown field, created from a select tag.

{{:groupeddropdown.png|:groupeddropdown.png}}

### Example use

If you want to implement a [GroupedDropdownField](GroupedDropdownField) into a form element, you need to pass it an
array of source data.

	:::php
	new GroupedDropdownField(
	   $name = "dropdown",
	   $title = "Simple Grouped Dropdown",
	   $source = array(
	      "numbers" => array(
	      		"1" => "1",
	      		"2" => "2",
	      		"3" => "3",
	      		"4" => "4"
	   		),
	      "letters" => array(
	      		"1" => "A",
	      		"2" => "B",
	      		"3" => "C",
	      		"4" => "D",
	      		"5" => "E",
	      		"6" => "F"
	   		)
	   )
	)


### API documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-basic/GroupedDropdownField.html).
