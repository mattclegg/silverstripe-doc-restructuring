# FieldGroup
Lets you include a nested group of fields inside a template.

{{:fieldgroup2.png|:fieldgroup2.png}}

### Example usage
Here is an example on using FieldGroup:

~~~ {php}
new FieldGroup(
	new FieldGroup(
		new HeaderField('FieldGroup 1'),
		new TextField('Firstname')
	),
	new FieldGroup(
		new HeaderField('FieldGroup 2'),
		new TextField('Surname')
	)
)
~~~

### Using it in the CMS

~~~ {php}
function getCMSFields() {
	$fields = parent::getCMSFields();
	
	$fields->addFieldToTab(
		'Root.Content.Main', 
		new FieldGroup(
			new TimeField("StartTime","What's the start time?"),
			new TimeField("EndTime","What's the end time?")
		),
		'Content'
	);	
	
	return $fields;
		
}
~~~

Displays in the CMS like this.

{{:fieldgroup_cms.png|:fieldgroup_cms.png}}

### API documentation
[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-structural/FieldGroup.html).
