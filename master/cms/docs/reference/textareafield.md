# TextareaField
Multi-line text area.

{{:textareafield2.png|:textareafield2.png}}

 
### Example use
If you want to implement a [Text](http://api.silverstripe.org/current/sapphire/model/Text.html) into a form element, you need to pass it an array of source data.

~~~ {php}
new TextareaField(
   $name = "description",
   $title = "Description",
   $rows = 8,
   $cols = 3,
   $value = "This is the default description"
   );
~~~

### API documentation
[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-basic/TextareaField.html).
