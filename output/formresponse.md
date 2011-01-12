#  Introduction

This class collects all output that needs to be returned after a Form-Request to the client. It automatically determines
if it needs to send back javascript after an Ajax-Request or just redirect to another page (on a normal request). 
 
FormResponse is also responsible for keeping the client and server sides in sync after an HTTP-Request by collecting
javascript commands (which mostly trigger subsequent update calls by Ajax.)
Use the output as a return-value for Ajax-based saving methods. Be sure to check if the call is actually "ajaxy" by
checking Director::is_ajax(). It is the developer's responsibility to include this in custom form methods.

Example: A [TableField](TableField) is in an incorrect state after being saved, as it still has rows marked as "new"
which are already saved (and have an ID) in the database. By using AjaxSynchroniser we make sure that every instance is
refreshed by Ajax and reflects the correct state.

## Examples

	:::php
	function savegrant($urlParams, $form) {
	       // your form logic
	
			if($form->saveInto($data)) {
	         FormResponse::status_message("Saved", "good");
	         FormResponse::add("$('Form_EditForm').updateStatus('$generic->Status');");
	       } else {
	         FormResponse::status_message("Saving failed", "bad");     
	       }
	
	       // FormResponse will automatically return javascript-output for an Ajax-call,
	       // or redirect to the previous page for a Non-Ajax-Call
	       return FormResponse::respond();
		}

# API Documentation

[Click here for the API documentation](http://api.silverstripe.org/2.4/forms/core/FormResponse.html)
