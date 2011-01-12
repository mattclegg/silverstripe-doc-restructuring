 ====== Introduction ====== 
Validator is the base class of all serverside-validation. It also controls inclusion of clientside-valiation (through
*Validator.js*).


# Usage

Validators are implemented as an argument to the [Form](http://api.silverstripe.org/trunk/forms/core/Form.html)
constructor.  You create a required fields validator like so.  In this case, we're creating a
[RequiredFields](http://api.silverstripe.org/current/sapphire/form/RequiredFields.html) validator - Validator itself is
an abstract class.

	:::php
	$validator = new RequiredFields("Email","FirstName");
	return new Form($this, "FormName", $fields, $actions, $validator);


To create your own validator, you need to subclass validator and define two methods:

*  **javascript()** Should output a snippet of JavaScript that will get called to perform javascript validation.

*  **php($data)** Should return true if the given data is valid, and call $this->validationError() if there were any
errors. 
 
## Disable JavaScript Validation

By default, SilverStripe forms with an attached Validator instance use the custom Validator.js clientside logic. It is
quite hard to customize, and might not be appropriate for all use-cases. You can disable integrated clientside
validation, and use your own (e.g. [jquery.validate](http://docs.jquery.com/Plugins/Validation)).

Disable for all forms (in mysite/_config.php):

	:::php
	Validator::set_javascript_validation_handler('none');


Disable for a specific form:

	:::php
	$myForm->getValidator()->setJavascriptValidationHandler('none');


# Implementations

*  [RequiredFields](http://api.silverstripe.org/current/forms/validators/RequiredFields.html)

*  [CustomRequiredFields](http://api.silverstripe.org/current/forms/validators/CustomRequiredFields.html)

# API Documentation

[Click here for the API documentation](http://api.silverstripe.org/2.4/forms/validators/Validator.html).
