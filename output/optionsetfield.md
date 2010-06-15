# OptionsetField

This field allows you to ensure that a form element is submitted is not optional and is part of a fixed set of data. This field uses the input type of radio. It's a direct subclass of [DropdownField](DropdownField), so the constructor and arguments are in the same format.

{{:optionsetfield.png|:optionsetfield.png}}
 

### Example use
If you want to implement a [OptionsetField](OptionsetField) into a form element, you need to pass it an array of source data.

~~~ {php}
new OptionsetField(
   $name = "Foobar",
   $title = "FooBar's optionset",
   $source = array(
      "1" => "Option 1",
      "2" => "Option 2",
      "3" => "Option 3",
      "4" => "Option 4",
      "5" => "Option 5"
   ),
   $value = "1"
);
~~~

You can use the helper functions on data object set to create the source array. eg: 

~~~ {php}
//Database request for the object
$myDoSet = DataObject::get("FooBars","");
if($myDoSet){
 // This returns an array of ID => Title
 $map = $myDoSet->toDropDownMap();
 
  // Instantiate the OptionsetField 
  $fieldset = new Fieldset(
    new OptionsetField(
     $name = "Foobar",
     $title = "FooBar's optionset",
     $source = $map,
     $value = $map[0]
    )
  );
}

// Pass the fields to the form constructor. etc

~~~
    

### API documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-basic/OptionsetField.html).

