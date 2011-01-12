## Introduction

The forum module allows you to create a community of people who can share information. The forum code runs
SilverStripe's forum, so [check out the site for a demo](http://www.silverstripe.com/silverstripe-forum/).


## Requirements

SilverStripe 2.3+
For some moderation tools you will need to install the [TagField](TagField) module.

## Download

* 
[0.2.5](http://open.silverstripe.com/changeset/latest/modules/forum/tags/0.2.5?old_path=/&filename=/modules/forum/tags/0.2&format=zip)
Latest Stable Release


*  [Daily
Build](http://open.silverstripe.com/changeset/latest/modules/forum/trunk?old_path=/&filename=/modules/forum/trunk&format=zip)
("trunk")


## Feature Overview

*  Allows multiple forums nested in forum categories, each with seperate security permissions and moderators which can
be adjusted inside the CMS.

*  RSS feeds for posts to all forums, and posts to a specific forum. RSS Feed support for a given search as well allows
to keep track of topics which appeal you you

*  Each member has profiles that show their posts and details about them

*  Signature support

*  Posts allow bbcode and file uploads

*  Can easily extend the registration form

*  Topic subscription (Subscribe to a topic and get an email when someone posts something new)

*  Gravatar and OpenID Support lets you bring users profiles with them 

*  Read Only Threads and Sticky Threads allow you to post annoucements

*  Basic front end reporting tools for member list and top threads





## Extending Forum Members

A Forum Member is created by adding new fields to a Member thanks to the [DataObjectDecorator](/dataobjectdecorator)
file.

This fields can be edited by each member who logs in. Moreover, the user has the possibility to make public or not his
personal details.

If you want to customize the details of a forum member and be able to see them even in the CMS part, you have to do
several modifications :

Create the file /mysite/code/CustomForumRole.php and add the following functions :

	:::php
	<?php
	
	class CustomForumRole extends DataObjectDecorator {
	
	function extraStatics() {
	  // To modify the fields of the database
	}
	
	function getForumFields() {
	  // To modify the forum member form (registration) of the forum
	}
	
	function updateCMSFields() {
	  // To modify the forum member view of the popup window in the CMS part
	}
	}
	?>


And to point this file to override the forum member you need to set in /mysite/_config.php:

	:::php
	DataObject::add_extension('Member', 'CustomForumRole');


## Topic And Post

When you begin a topic, add a post or edit one, you have the possibility to :

*  Format your post using [BBCode](http://en.wikipedia.org/wiki/Bbcode) (some codes exist on these forums that aren't
noted on the Wikipedia article).

*  Attach files

*  Suscribe to the topic.

NB : The file size limit is by default 2 Mb.
