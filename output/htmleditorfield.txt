# HtmlEditorField

A WYSIWYG editor field, powered by tinymce.




### Example use

~~~ {php}
new HtmlEditorField(
   $name = "editor",
   $title = "HTML Editor"
)
~~~

You also need to add a HTMLText database field (which extends the Text field).
 
~~~ {php}
static $db = array(
   'FieldName' => 'HTMLText'
)
~~~

### API documentation
[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-formattedinput/HtmlEditorField.html). 
