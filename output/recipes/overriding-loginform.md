## Overriding the default member login form behaviour

To achieve this, there's a couple of things you'll need to do.

 1.  Edit **_config.php** (inside mysite directory). Add this line: ''Object::useCustomClass('MemberLoginForm',
'CustomLoginForm');''
 2.  Create a new file called ''CustomLoginForm.php'' inside mysite/code
 3.  Edit your newly created file. Example below of how this will work (as a subclass of MemberLoginForm). We are
overloading the function dologin, which controls what happens after someone submits the login form.
 4.  Refresh the page with ?flush=1 at the end of the URL (so it detects your new PHP file).

NOTE: This redirects based on the group ID, and does not use any of the permission flags that are available to groups.
It assumes that group IDs are always going to be the same for your groups. It redirects to the first group the member is
in, if the member is in multiple groups (in order of group ID).

	:::php
	<?php
	
	class CustomLoginForm extends MemberLoginForm {
	 
		// this function is overloaded on our sublcass (this) to do something different
		public function dologin($data) {
			if($this->performLogin($data)) {
			        $this->redirectByGroup($data);
			} else {
				if($badLoginURL = Session::get("BadLoginURL")) {
					Director::redirect($badLoginURL);
				} else {
					Director::redirectBack();
				}
			}      
		}
	 
		function redirectByGroup($data) {
	
			// gets the current member that is logging in.
			$member = Member::currentUser();
	
			// Switch redirection based on ID of group, if not found, just redirect back (default behaviour)
			// ASSUMPTION is that the user is only in one group. IF the member is in multiple groups
			// that are listed here, it redirects to the first group it finds for the member.
			if($member->inGroup(1)) {
				Director::redirect(Director::baseURL() . 'articles');
			} elseif($member->inGroup(2)) {
				Director::redirect(Director::baseURL() . 'home');
			} elseif($backURL = Session::get("BackURL")) {
				Session::clear("BackURL");
				Director::redirect($backURL);
			} else {
				Director::redirectBack();
			}
		}
	 
	}
	
	?>


In this example we used the inGroup() method on the Member class. Have a look at that class for more possibilities in
terms of manipulating the login form based on the member who is logging in.
