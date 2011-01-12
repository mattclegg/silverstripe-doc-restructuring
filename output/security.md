# Introduction

The Security class implements a basic security model. See [secure-development](secure-development) for general
instructions on how to securely develop with Silverstripe.

To report a security issue with SilverStripe, please see
[http://silverstripe.org/security-releases/](http://silverstripe.org/security-releases/)


# Permission Codes

Codes assigned to specific groups through the "Security" administration interface give you flexible control over
permissions. See permissions:[permissions:codes](permissions/codes).

# Security in the datamodel

The security section  of the CMS (/admin/security) lets us manage members and groups, putting members into the different
groups and giving permission codes to each of them.

## CMS Author Access

You can overload the following methods for your custom [page-types](page-types):

*  **SiteTree::canView()** This should return true if the currently logged in user can view the given page

*  **SiteTree::canEdit()** This should return true if the currently logged in user can edit the given page

*  **SiteTree::canPublish()** This should return true if the currently logged in user can publish the given page

*  **SiteTree::canAddChildren()** This should return true if the currently logged in user can add children under the
given page

*  **SiteTree::canCreate()** This should return true.  To customise all page types in one function, it can be defined on
Page and refer to $this->class.

## CMS Sitetree Access

Server-side tree generation:

*  Show any pages that you can't edit in grey (li class="readonly").  Clicking them will do nothing.

*  Make use of canAddChildren() to set up the "nochildren" class on pages that you can't add to.

*  Add dropdown: The "add page" dropdown filters its contents based on singleton($className)->canCreate().

## CMS Form Access

*  Form editing: Get edit form should be made readonly in your [controller](controller) if this record can't be edited
by the current user.

## CMS Action Handlers

*  Action button generation: Use the canEdit() and canPublish() methods to provide the appropriate buttons.

*  Action handlers: All action handlers should call the appropriate permission methods before executing, to side-step
hack attempts.




# Security in Controllers


### Limiting URL-Access to Controller Methods

*Minimum Requirement: SilverStripe 2.3*

By default, all public methods on a controller can be accessed through a URL. Define a list of action handling methods
that are allowed to be called directly by URLs. The variable should be an array of action names. This sample shows the
different values that it can contain:

	:::php
	static $allowed_actions = array(
		'someaction', // someaction can be accessed by anyone, any time
		'otheraction' => true, // So can otheraction
		'restrictedaction' => 'ADMIN', // restrictedaction can only be people with ADMIN privilege
		'complexaction' => '->canComplexAction' // complexaction can only be accessed if $this->canComplexAction() returns true
	);


Example:

	:::php
	class MyController extends Controller {
		static $allowed_actions = array(
			'publicMethod' => true,
			'securedMethod' => 'MYPERMISSION',
			'adminMethod' => 'ADMIN'
		);
		
		function publicMethod() {
			return "Can be seen by everybdoy";
		}
		
		function securedMethod() {
			return "You have MYPERMISSION";
		}
		
		function adminMethod() {
			return "You are an Administrator";
		}
	}


Form getters count as URL actions as well, and should be included in allowed_actions.
Form actions on the other handed (first argument to FormAction() shoudl NOT be included,
these are handled separately through Form->httpSubmission. You can control access on form actions either by
conditionally removing FormAction in the form construction, or by defining $allowed_actions in your Form class.

	:::php
	class MyController extends Controller {
	
		static $allowed_actions = array(
			// don't include 'doSubmitOnController()' or 'doSubmitOnForm()' here
			'MyForm' => true,
		);
		
		function MyForm() {
			return new MyForm(
				$this,
				'Form',
				new FieldSet(
					new TextField('MyText')
				),
				new FieldSet(
					new FormAction('doSubmitOnController'),
					new FormAction('doSubmitOnForm')
				)
			);
		}
		
		function doSubmitOnController($data, $form) {
			return "Submitted on controller";
		}
	}
	
	class MyForm extends Form {
		
		// Additional protection to avoid 'methodWithoutButton()' being callable through URLs
		static $allowed_actions = array(
			'doSubmitOnForm' => true
		);
		
		function doSubmitOnForm($data, $form) {
			return "Submitted on form";
		}
		
		function methodWithoutButton() {
			// ...
		}
	}


## Recovering passwords

SilverStripe provides a 'reset password' (to email) function. If if you have lost all admin accounts, see instructions
at [recovering_password](recovering_password).

## System Configuration

## Add a global login account

	
	Security::setDefaultAdmin($username, $password)


You can use this method to hard-code an administrative login into the system.  This can be useful where you're
developing a number of sites for various clients, and want to install your own access details into the system.  The
login created doesn't appear in the security area of the CMS, so it can't be deleted.  When you use this username and
password, you will be logged in as one of the other access accounts in the system.




## Encrypt passwords

You can specify if you want store your passwords in clear text or encrypted by adding the following line to your
*_config.php*

**Security::encrypt_passwords($encrypt_passwords);**
If you choose to encrypt your passwords, you can choose which algorithm is used to and if a salt should be used to
increase the security level even more.

**Security::set_password_encryption_algorithm($algorithm, $use_salt);**
You can get a list of supported algorithms by calling

**Security::get_encryption_algorithms()**
If you update from an older version of SilverStripe that doesn't support password encryption just visit
*(site)/Security/encryptallpasswords*

##  Forcing a log-in without actually filling out the log-in form

If you're unable to view the log-in form, you can visit this URL to force execution of the security form.

	
	(site)/Security/LoginForm&action_dologin=1&AuthenticationMethod=MemberAuthenticator&Email=(email)&Password=(password)


Note that it won't give you any failure messages, and might not redirect you to the right place.

##  Force login to access-restricted areas

If you want people to log in at a particular juncture, call Security::permissionFailure.  It will redirect to the login
page and send the user back to this URL once they've logged in.

In combination with Permission::check, this provides a simple way of setting up security.  See [permission](permission)
for more information.

	:::php
	function init() {
	  if(!Permission::check("VIEW_SITE")) Security::permissionFailure(null);
	  parent::init();
	}


##  Redirect back to another page after Login

You can set the return destination URL of the Security actions when directing to them with an [URL
variable](urlvariabletools) of **BackURL**.  This are very useful when working with Login ( */Security/login* ) and
Change Password ( *Security/changepassword* ).

	:::php
	if( Member::CurrentUserID === 0 ) {
	  Director::redirect('Security/login?BackURL=mypage/action');
	}


Hint: This is great at the top of processing Form submissions where you want to gently require users to log in.

## Securing your entire site

One easy way to make your entire site private (eg, while under development or for an intranet site) require VIEW_SITE
permission on all pages, with the exception of your login form.

	:::php
	class Page_Controller extends ContentController {
	   function init() {   
	      parent::init();
	      if($this->URLSegment != 'Security' && !Permission::check("VIEW_SITE"))
	         Security::permissionFailure(null);
	      ...
	   }
	}

##  Enable/disable authentication methods

You can enable/disable different authentication methods like the traditional email/password method or OpenID/i-name
based authentication.

To enable an authentication method simple put the following snippet in your *_config.php*:

**Authenticator::register_authenticator($authenticator);**

*$authenticator* is a the name of the authenticator. Built-in are *MemberAuthenticator* (the traditional email/password
authentication) and *OpenIDAuthenticator* ([OpenID/i-name based authentication).

##  Building secure applications

*  Add methods called can(action-name) to each of your controllers

*  Add code that will call those methods in Controller::init(), and trigger a Security::permissionFailure() in cases
where it breaks.

*  See [secure-development](secure-development)




# API Documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/sapphire/Security.html).
