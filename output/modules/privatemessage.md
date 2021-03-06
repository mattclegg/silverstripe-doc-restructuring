# Privatemessage module

This is the privatemessage module's wiki page!

## Introduction

What does this module do? It's a possibility for your members to write messages to one another without access to each
other's mail addresses. It's built to work as a standalone module, based on usernames or in addition to i.e. the forums
module where you have nicknames.
You have a username/nickname autocompletion within the "new message" form - you're also able to call this form from
another module with or without a userID added. Basically it's three folders: Inbox, Archive and Sent, where you can
organize messages on your personal "private-message" page within the cms frontend.

## Installation

### Prerequisites

At the moment there are no dependencies

### Installation steps

In general this works like every module installation:
 1.  download the module (latest release is recommended)
 2.  unpack module and, if not already correct, rename the privatemessage directory to "privatemessage"
 3.  place the unpacked module in your silverstripe directory
 4.  run http://yourdomain/dev/Build to initialize the DB build
 5.  check your admin backend for a new page called "private-message" and rename if you like. Also I suggest you hide
the page from not logged in users, although the page checks for permissions on call ;-)

### Configuration

 1.  Open the "private-message" page in the backend
 2.  check/uncheck your desired options

      * Use nicknames: Enables nickname-support for forums (keep in mind, normal usernames won't work any more!!!)
      * Send a mail if user... : Does exactly what it says ;-) Text could be changed within the language file
      * Show pagination: Not yet working
      * Entries per page: Not yet working
      * Address from which the mails...: Enter a mail to be shown as "from" within the notification mail. Default is
noreply@$_Server['HHTP_HOST']

Well... now you're done :-)


### Issues/ToDos

Known issues:

*  some forms aren't that pretty yet...

ToDos:

*  if viewing a message you can't reply directly, yet

*  add paging

*  add more mail-client like look and handling

*  external call for new message form without ajax...

*  add a way to also pre-set the subject of the message via URL param

*  E-Mail Templates


## Working with the module

I'll ist a few features and tricks here... 

*  for some privacy reasons, usernames when sending mails are stripped down to "name" "first letter of surname"
"mailaddres@123..." (stripped the last part from mail address to have uniqueness for the names in the autocomplete list.

*  As sender, only name will be shown

*  When answering a message, the text will be pasted in your message-window. Also the subject gets a "Re: " attached.

**External calling of the "new message" form:**
If you need to have to send a private message from somewhere else, you can easily get it via an ajax call. I've done it
this way:

	:::html
	`<a href="{$BaseHref}private-messages/doAction/?type=getMessageForm&aid=$AuthorID" class="popForm" title="<% _t('EntryCategory_showentry.ss.CONTACTTEXT', 'Send a message') %>`">`<% _t('EntryCategory_showentry.ss.CONTACTTEXT', 'Send a message') %>``</a>`

this is the link. Noticed the "aid" param? It's the userID (check Member table). If this param is set, the message form
wil automatically use this user as the receiver. You'll also need a jQuery function to send this as an ajax call:

	:::javascript
	jQuery( document ).ready( function()
	{
		jQuery( '#popForm' ).dialog(
		{
			bgiframe: true,
			height: 270,
			width: 385,
			modal: true,
			autoOpen: false
		});
	
		addPopForm();
	}
	function addPopForm()
	{
		jQuery( 'a.popForm' ).click( function(){
			//jQuery( '#popForm' ).empty().html( getLoadImg( 'popup' ) );
			jQuery( '#popForm' ).dialog( 'open' );
			jQuery( '#popForm' ).load( jQuery( this ).attr( 'href' ) );
			return false;
		});
	}

You can do this, of course, within the template and script-tags :-)
Note: The "getLoadImg" function call shows the ajax-loading image. If you want to have it, check the privatemssage.js. 

For everyone interested in the code, have a look at the [documentation](http://docs.aschmann.org/privatemessage).

## Want to join?

If you feel the need to participate in this project, just let me know :-)
