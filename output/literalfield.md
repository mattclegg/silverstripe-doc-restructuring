# LiteralField

This field lets you put an arbitrary piece of HTML into your forms. If there's not much behaviour around the HTML, it
might not be worth going to the effort of making a special field type for it. So you can use LiteralField. If you pass
it a viewabledata object, it will turn it into a string for you.

{{:literalfield.png|:literalfield.png}}


### Example use

If you want to implement a [LiteralField](LiteralField) into a form element, you need to pass it an array of source
data.

	:::php
	new LiteralField (
	   $name = "literalfield",
	   $content = "`<b>`some bold text`</b>``<br />``<br />`
	               `<a href=\"http://silverstripe.com\">`a link`</a>``<br />``<br />`"
	)


### API documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-dataless/LiteralField.html).
