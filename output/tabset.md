# TabSet

Defines a set of tabs in a form.

{{:tabset1.png|:tabset1.png}}

{{:tabset2.png|:tabset2.png}}

### Code Example

Here is a simple implementation of a TabSet including some tabs. The following example is shown on the screenshots.

	:::php
	new TabSet(
		$name = "TheTabSetName",
		new Tab(
			$title='Tab one',
			new HeaderField("A header"),
			new LiteralField("Lipsum","Lorem ipsum dolor sit amet enim.")
		),
		new Tab(
			$title='Tab two',
			new HeaderField("A second header"),
			new LiteralField("Lipsum","Ipsum dolor sit amet enim.")
		)
	)


### API documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-structural/TabSet.html).
