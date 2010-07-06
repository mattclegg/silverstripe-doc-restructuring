# InlineFormAction
Render a button that will act as FormAction. If you want to add custom behaviour, please set {inlcudeDefaultJS} to false and work with behaviour.js.

{{:formaction.png|:formaction.png}}


### Example use
If you want to implement a [InlineFormAction](InlineFormAction) into a form element, you need to pass it an array of source data.

~~~ {php}
new InlineFormAction (
   // doAction has to be a defined controller member
   $action = "doAction",
   $title = "Submit button"
)
~~~
### API  documentation
[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/actions/InlineFormAction.html).
