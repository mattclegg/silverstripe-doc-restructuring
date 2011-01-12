## FormAction

Single action button.

**FormAction**

{{:formaction_withoutlabel.png|:formaction_withoutlabel.png}}


**FormAction_WithoutLabel**

{{:formaction.png|:formaction.png}}

### Example use

If you want to implement a [Form](http://api.silverstripe.org/trunk/forms/core/Form.html) into a form element, you need
to pass it an array of source data.

Upon clicking the button below will redirect the user to *doAction* under the current controller.

	:::php
	new FormAction (
	   // doAction has to be a defined controller member
	   $action = "doAction",
	   $title = "Submit button"
	)


### Labels

By Default **FormAction** will use the title as the label for the left margin.  This can look redundant on the form.  If
you'd rather have just the button alone with as pictured above try using **FormAction_WithoutLabel** instead.

#### API documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/actions/FormAction.html). 
