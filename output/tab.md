# Tab

Base class for all fields that contain other fields.

{{:tab.png|:tab.png}}


### Code Example

Here is a simple implementation of a Tab. Obviously, you can include as many fields inside as you want, and you can
include other tabs, too!

	:::php
	new Tab(
		$title='Tab one',
		new HeaderField("A header"),
		new LiteralField("Lipsum","Lorem ipsum dolor sit amet enim.")
	)


### API documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-structural/Tab.html).
