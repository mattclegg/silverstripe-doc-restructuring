# Poll Module

The Polls module provides a interface for adding polls like that from tutorial 3
http://doc.silverstripe.com/doku.php?id=tutorial:3-forms in the backend so creating and viewing results can be done via
the backend.

## Download

* 
[0.1](http://open.silverstripe.com/changeset/latest/modules/polls/tags/0.1?old_path=/&filename=/modules/polls/tags/0.1&format=zip)
(Latest Release)

*  [Daily
Build](http://open.silverstripe.com/changeset/latest/modules/polls/trunk?old_path=/&filename=/modules/polls/trunk&format=zip)
("trunk")

##  Installation

If you are running SilverStripe 2.3 or later then you will also need to install the
[modules:genericdataadmin](modules/genericdataadmin) module.

Once you have checked out the module visit yoursite.com/db/build?flush=1 to rebuild the database then reload the CMS.
You should now have a Polls Section in the CMS.

## How to Use

There is 2 steps in creating a poll on a site. You first need to create a poll in the CMS. Then you need to add a method
to your Site to create a new ShowPoll class.

### Creating a Poll in the CMS

 1.  Hit create poll in the top left of the screen
 2.  Enter the Poll Details in the right hand pane. Enter the Poll Title and the Various answers you will allow the user
to select.
 3.  Hit Save in the bottom right once you are done to save your poll.
 4.  If you want your poll to show on the site (rather then being archived) tick the Is this Poll Active checkbox under
Poll Details

### Showing the Poll On the frontend

Depending on which page you want to add the poll, you need to add a method which returns a new ''ShowPoll'' class with 2
constructors - the Controller and the name of the Poll. 

For example I have added this method to mysite/code/Page.php 

	:::php
	class Page_Controller extends ContentController {
	 ...
	 function MyPoll() {
	    return new ShowPoll($this, 'MyPoll');
	 }
	 ...
	}


Then all you need to do is open up your template file (in my case this is Sidebar.ss in
themes/myteheme/templates/Includes/) and add the following code 

	:::html
	$MyPoll


This will render the method we added to our Page.php file (MyPoll()) which in turn will create a new ShowPoll() which
will render one of our Polls randomly.

## To Do

*  Nice Graph based reporting

*  Admin UI Improvements

## ChangeLog

*  0.1 - Initial Stable Release. Includes support for creating polls and rendering a random poll on a page 



