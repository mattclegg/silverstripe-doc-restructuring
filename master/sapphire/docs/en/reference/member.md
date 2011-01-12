# Member

**This is partially deprecated - see the `[api:DataObject]` page for more information**

## Introduction

The Member class is used to represent user accounts on a SilverStripe site (including newsletter recipients).
 

## Testing For Logged In Users

The Member class comes with 2 static methods for getting information about the current logged in user.

**Member::currentUserID()**

Retrieves the ID (int) of the current logged in member.  Returns *0* if user is not logged in.  Much lighter than the
next method for testing if you just need to test.

	:::php
	// Is a member logged in?
	if( Member::currentUserID() ) {
		// Yes!
	} else {
		// No!
	}


**Member::currentUser()**

Returns the full *Member* Object for the current user, returns *null* if user is not logged in.

	:::php
	if( $member = Member::currentUser() ) {
		// Work with $member
	} else {
		// Do non-member stuff
	}



## Subclassing

[note]
This is the least desirable way of extending the Member class. It's better to use DataObjectDecorator (see below).
[/note]

You can defined subclasses of member to add extra fields or functionality to the built-in membership system.

	:::php
	class ParishouseMember extends Member {
		static $db = array(
			"Age" => "Int",
			"Address" => "Text",
		);
	}


To ensure that all new members are created using this class, put a call to Object::useCustomClass in
(project)/_config.php:

	:::php
	Object::useCustomClass("Member", "ParishouseMember");

Note that if you want to look this class-name up, you can call Object::getCustomClass("Member")

## Overloading getCMSFields()

If you overload the built-in function getCMSFields(), then you can change the form that is used to view & edit member
details in the newsletter system.  This function returns a FieldSet object.  You should generally start by calling
parent::getCMSFields() and manipulate the FieldSet from there.

	:::php
	function getCMSFields() {
		$fields = parent::getCMSFields();
		$fields->insertBefore(new TextField("Age"), "HTMLEmail");
		$fields->removeByName("JobTitle");
		$fields->removeByName("Organisation");
		return $fields;
	}


## Extending Member or DataObject?

Basic rule: Class "Member" should just be extended for entities who have some kind of login.
If you have different types of Members in the system, you have to make sure that those with login-capabilities have
unique email-addresses (as this is used for login-credentials). 
For persons without login-capabilities (e.g. for an address-database), you shouldn't extend member to avoid conflicts
with the Member-database. This enables us to have a different subclass of Member for an email-address with login-data,
and another subclass for the same email-address in the address-database.

## New Idea: Member Role Decorator

Using inheritance to add extra behaviour or data fields to a member is limiting, because you can only inherit from 1
class.  A better way is to use role decorators to add this behaviour.

	:::php
	DataObject::add_extension('Member', 'ForumRole');
	// OR
	Member::add_role('ForumRole');


A role decorator is simply a subclass of DataObjectDecorator that is designed to be used to add behaviour to Member. 
The roles affect the entire class - all members will get the additional behaviour.  However, if you want to restrict
things, you should add appropriate Permission::checkMember() calls to the role's methods.

	:::php
	class ForumRole extends DataObjectDecorator {
	  /**
	
	   * Modify the field set to be displayed in the CMS detail pop-up
	   */
	  function updateCMSFields(FieldSet $currentFields) {
	    // Only show the additional fields on an appropriate kind of use 
	    if(Permission::checkMember($this->owner->ID, "VIEW_FORUM")) {
	      // Edit the fieldset passed, adding or removing fields as necessary
	    }
	  }
	
	  function extraStatics() {
	    // Return an array containing keys 'db', 'has_one', 'many_many', 'belongs_many_many',
	  }
	
	  function somethingElse() {
	    // You can add any other methods you like, which you can call directly on the member object.
	  }
	}


Sam is going to implement this change; Romain will be using it to create a ForumRole for the new forum module.

## TODO

*  MemberTableField has to determine which fields is should display based on the subclass of the requested record
*  MemberTableField needs to have a switch for creating new Members with different fields
*  We should add a getOverviewFields() to each Member-class which specifiy which fields to use in the overview (and
accordingly have different tables for each subclass of members)

## API Documentation

`[api:Member]`
