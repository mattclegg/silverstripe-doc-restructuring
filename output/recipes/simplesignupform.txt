### NOTE: This page is outdated!
Adding a newsletter subscription form is simply accomplished by creating a new '**newsletter subscription form**' type page.

Alternatively, there's a recipe for [creating a custom registration form](recipes/forms), similar to below.

### Creating a Newsletters section
This is a guide to creating a simple email newsletter form (with first name, last name and email address) in SS2. It doesn't cover creating or sending email newsletters yet.  Hayden has now built this system, so go talk to him :P

#### Creating the form
*  Create a new file in <projectname>/code/ called SignupPage.php
*  Add in the following code to generate the form:
~~~ {php}
<?
class SignupPage extends Page {
}

class SignupPage_Controller extends Page_Controller {
	function AfterContent() {
		// This is a dirty hack, suggestions?
		// It returns early if we're on the thanks page - we don't want the form on that page
		if($this->urlParams[Action] == 'thanks') return;
		
		return new SignupForm($this, "AfterContent", 
			new FieldSet(
				new TextField("FirstName", "First Name:"),
				new TextField("Surname", "Surname:"),
				new TextField("Email", "Email:")
				
			), 
			new FieldSet(
				new FormAction("signup", "Sign up")

			), 
			new RequiredFields(
				"FirstName",
				"Surname",
				"Email"
			));
	}
}
?>
~~~

#### Creating a template
*  Create a new file called SignupPage.ss in <projectname>/templates/layout/.
*  Add the form into your code:
~~~ {php}
$AfterContent
~~~
*  This template-variable will automatically be replaced by the rendered return-value of SignupPage_Controller::AfterContent().

#### Creating the form and setting actions (adding the user to database)
*  Create a new file called SignupForm.php in <projectname>/code/
*  Add the following code:
~~~ {php}
<?
class SignupForm extends Form {	
	function signup($data,$form) {
		// Create a new member using the data from the form
		// TODO: needs validation - all fields filled out, email doesn't exist already etc
		$member = new Member($data);
		$member->write();
		
		// Add the new member to the 'newslettersubscribe' group
		$groups = $member->Groups();
		$groups->setByCheckboxes(array("newslettersubscribe"), $data);
		
		// Write the Member table row
		$member->write();
		
		Director::redirect('thanks');
	}
}	
?>
~~~

#### Adding a form submitted page
*  Part 1: Add 'ThanksContent' as a 'Text' field to the static $db array,
*  Part 2: Add the field to the Thanks tab in the CMS,
*  Part 3: Add the thanks function which overwrites the $Content variable with the value of the Thanks box:
~~~ {php}
class SignupPage extends Page {
	// Part 1
	static $db = array(
		"ThanksContent" => "Text",
	);
	// End Part 1

	// Part 2
	public function getCMSFields($cms) {
		$fields = parent::getCMSFields($cms);
		$fields->addFieldsToTab("Root.Content.Thanks", new HeaderField("Text to show after they've signed up"));
		$fields->addFieldsToTab("Root.Content.Thanks", new HTMLEditorField("ThanksContent", ""));
		return $fields;
	}
	// End Part 2
}

class SignupPage_Controller extends Page_Controller {
	// Part 3
	function thanks() {
		return array(
			"Content" => $this->ThanksContent, // Replace $Content with $ThanksContent
		);
	}
	// End Part 3
}
~~~

#### Flush, Create groups, Add content and Test
*  Visit http://<yourserver>/<projectname>/db/build/ to reflect the new changes in the database (red and orange entries).
*  Create two new groups manually in your database - one with the 'Code' field called 'newslettersubscribers' - the other fields can be named whatever makes sense. Leave all the fields after 'Code' blank - we don't want these users having CMS privileges.

#### Create the page
*  Now you can head the backend at to http://<yourserver>/<projectname>/admin
*  Create a new page of type "SignupPage"
*  The form will be automatically inserted
*  Visit http://<yourserver>/<projectname>/admin goto the SignupForm page and add content into the thanks box.
*  Visit the page and submit your information, make sure it saves to the database correctly.

#### Optional: Adding CSS-Styles
*  Create a new file in <projectname>/css/ called form.css
*  Add the following styles to make the form look prettier:
~~~ {css}
/* FORM STYLES */

form,fieldset {
	border:0;
}
fieldset {
	margin-top:5px;
}
form div {
	margin-bottom:3px;
}
input.text,
textarea {
	width:146px;
	border:1px solid #999;
}
	input.text {
		height:1.5em;
	}
	textarea {
		height:3.5em;
	}
label.left {
	float:left;
	width:10em;
	text-align:right;
	padding-right:7px;
}
p.Actions {
	text-align:right;
	margin:10px 187px 0 0;
}
~~~
*  Add the following code in <projectname>/code/SignupPage.php SignupPage_Controller::AfterContent():
~~~ {php}
Requirements::css("<projectname>/css/form.css");
~~~
