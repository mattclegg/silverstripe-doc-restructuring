Form validation is a combination of PHP and JavaScript
 

# PHP

##### Default validation on MemberTableField

getValidator() is a method to define your validation fields, used in MemberTableField. You can override this to define your own validation, for example, if you wanted to completely remove the validation you could just return false on your member sub-class, or decorator.

# JavaScript

*  initialiseForm(formEl) sets up the validation systme
*  require(fieldName) will throw an error if that field hasn't been filled out.

##### Customising validation errors

Setting fieldEl.requiredErrorMsg or formEl.requiredErrorMsg will override the default error message.  Both can include the string '$FieldLabel', which will be replaced with the field's label. Otherwise, the message is "Please fill out "$FieldLabel", it is required".

You can use Behaviour to load in the appropriate value:
~~~ {javascript}
Behaviour.register({
'#Form_Form' : {
   requiredErrorMsg: "Please complete this question before moving on.",
}
});
~~~
