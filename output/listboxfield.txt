# ListboxField

Dropdown field, created from a select tag.

{{:listboxfield.png|:listboxfield.png}}
### Example use
If you want to implement a [ListboxField](ListboxField) into a form element, you need to pass it an array of source data.

~~~ {php}
new ListboxField(
   $name = "pickanumber",
   $title = "Pick a number",
   $source = array(
      "1" => "one",
      "2" => "two",
      "3" => "three"
   ),
   $value = 1
)
~~~

### API documentation
[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-basic/ListboxField.html).
