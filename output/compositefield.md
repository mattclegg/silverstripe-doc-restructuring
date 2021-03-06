# CompositeField

Base class for all fields that contain other fields.

{{:compositefield.png|:compositefield.png}}

## Usage

### Make multi-column layouts
Use setColumnCount() to increase the columns for a specific CompositeField. Every child-item of this field will be
treated as a single column.

	:::php
	$multiColumnField = new CompositeField(
		new CompositeField(
			new HeaderField('Column 1'),
			new TextareaField('Firstname')
		),
		new CompositeField(
			new HeaderField('Column 2'),
			new TextField('Surname')
		)
	);
	$multiColumnField->setColumnCount(2);


## API Documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-structural/CompositeField.html).

