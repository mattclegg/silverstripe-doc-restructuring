For more information on forms, see the [:form](/form) page.

# Introduction

Form syntax is quite complex, so you'll need to know a little bit of PHP, or be willing to tinker with it to get things going. There are two main aspects to forms in Silverstripe:

1.  The HTML form that you see on your web page, and
2.  The PHP function to process the data the user submits back.

# Quick Start
## Page Template Example
The following code is all you need to get a basic signup form on your page. I recommend placing a file like this in <mysite>/code/RegistrationForm.php

~~~ {php}
class RegistrationForm extends Page {
}

class RegistrationForm_Controller extends Page_Controller {

	// Make sure you set this to the right group.
	// See http://doc.silverstripe.com/doku.php?do=show&id=recipes%3Aforms
	private $defaultGroupID = 2;

	/**
	* This function lets you put a form on your page, using $Form.
	*/
	function Form() {
		return new Form($this, "Form", new FieldSet(

			// List your fields here
			new TextField("FirstName", "First name"),
			new TextField("Surname"),
			new EmailField("Email", "Email address")

		), new FieldSet(

			// List the action buttons here
			new FormAction("SignupAction", "Sign up")

		), new RequiredFields(

			// List the required fields here: "Email", "FirstName"

		));
	}

	/**
	* This function is called when the user submits the form.
	*/
	function SignupAction($data, $form) {

		// Create a new Member object and load the form data into it
		$member = new Member();
		$form->saveInto($member);

		// Write it to the database.  This needs to happen before we add it to a group
		$member->write();

		// Add the member to group. (Check if it exists first)
		if($group = DataObject::get_one('Group', "ID = $this->defaultGroupID")) { 

			$member->Groups()->add($group);
			// Redirect to a page thanking people for registering
			Director::redirect('thanks-for-registering/');

		}else{

			// Redirect to a failure page
			Director::redirect('registration-failed/');

		}

	}
}
~~~
## Newsletter Sign-up / Default Group
Using the above code, you will need to adjust the $defaultGroupID variable to a group you wish the user to be added to by default. You may have the user automatically added to your newsletter group, for instance.

Finding the group ID is a little obscure, but not too difficult.
1.  To find the right group ID, you will need to go into the Security tab of your administrative panel.
2.  Hover your cursor over the relevant group.
3.  You should see your status bar change at the bottom of your browser. The group ID is a number at the very end of the link, in the form of http://yoursite.com/admin/show/**1**
4.  Memorise the number, and replace the $defaultGroupID value in the PHP example.

Be careful not to add add users to the administrative group (ID 1) by accident.

# Troubleshooting
*  The "Form" string that's listed near the top **must** be set to the name of your function, otherwise you won't be able to submit the form.
*  The list of fields, actions, and required fields must have commas between them, but **must not have a comma after the last one**.
*  To learn how to make more complex forms, you really need to get your head around PHP's syntax, especially the object oriented stuff.
*  Please use [:FormResponse](/FormResponse) for more complex situations, to add javascript-callbacks and redirection. It automatically determines the appropriate response for Ajax/Non-Ajax-calls.

# Multi-column fields
See [:CompositeField](/CompositeField)


# Best Practices

### Updating DataObjects
see [:dataobject](/dataobject) and [:datamodel](/datamodel)


### Creating different forms on different actions of our page controller
Sometimes, you'll want a page to show different forms depending on which action you're using.  For example, you could have mysite/register/ and them mysite/register/step2 on a 2-step registration process.  You can't exactly define 2 different methods both called Form(), and it would be a pain to create a different tempalte

~~~ {php}
class RegistrationForm_Controller extends Page_Controller {
    function Form() {
        // ... you already made this ...
    }
    function doform($data, $form) {
        // ... you already made this ...
    }

    function Step2Form() {
        return new Form($this, "Step2Form", new FieldSet( // ... you can copy the form from elsewhere       
    }
}
~~~

### Using the UserDefinedForm page type
The UserDefinedForm page type provides capabilities for editing simple forms within the CMS.  This can save a lot of iteration time.

*  To come: how can I subclass UserDefinedForm to make my own behaviour linked to user-editable forms?

### Adding Ajax-Behaviour to your Forms
*  Please use [:FormResponse](/FormResponse) to compile an appropriate Javascript-response for an Ajax-Request. This is the preferred method to simply returning a Javascript-string, because other formfields (e.g. [:TableField](/TableField)) might hook in here to produce additional output.
~~~ {php}
class RegistrationForm_Controller extends Page_Controller {
    function doform($data, $form) {
        // your form actions
        FormResponse::update_dom_id('myForm', '<form>myformcontent</form>');
        FormResponse::status_message('Done', 'good');
        
        // will automatically show the status-message if called by ajax, or redirect on a normal HTTP-request
        return FormResponse::respond()
    }
}
~~~
