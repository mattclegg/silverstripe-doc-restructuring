# Introduction

The Postale module is a full-featured private messaging tool that can install into any Silverstripe application. It is
especially useful for websites that are member-based and require communication between users.


*  Threads, messages, users 

*  Multiple users/messages per thread 

*  Message creation with live search for adding/removing recipients 

*  Pagination 

*  Message search 

*  Show all, unread, sent, deleted 

*  Mark as unread, read, deleted 

*  Email notification 

*  Live notification for active sessions 

*  Global functions decorated into SiteTree including: $NewMessagesCount and $SendMessageLink for access to module
features on any page 

*  Loaded with AJAX 

*  Graceful degradation for non-javascript users 

# Requirements

*  Silverstripe 2.4.x

*  [DataObjectManager module](http://silverstripe.org/dataobjectmanager-module/)

# Installation

*  Install the [DataObjectManager module](http://silverstripe.org/dataobjectmanager-module/)

*  Download the Postale module, and drop the contents into your Silverstripe root directory. The module directory for
the Postale module must be named *postale*.

*  Run /dev/build.


# Screenshots

Messages dashboard view

{{http://carlinowebdesign.com/assets/postale1.png}}

Create message form

{{http://carlinowebdesign.com/assets/postale2.png}}

{{http://carlinowebdesign.com/assets/postale3.png}}

Message detail view

{{http://carlinowebdesign.com/assets/postale4.png}}

# Usage

One of the first things you'll notice about the Postale module that makes it different from other modules is that there
is no CMS interface. This is because there is no concept of multiple message pages, so the messages feature of a website
is treated only as a controller, and not a data model. 

That being said, there is still a lot to configure in the Postale module. Rather than editing page in the CMS, this can
all be done by modifying static class properties in your _config.php file.

## Basic Settings

Here is an example of the configuration needed for some of the most important settings in the Postale module.

	:::php
	MessagesPage::set_url("messages");
	MessagesPage::$from_address = "Your Site `<webmaster@mysite.com>`";
	MessagesPage::$from_name = "Web Site";


The first setting is for the url segment of the messages section. This will set the property and also add a rule to
Director to point to the MessagesPage controller.

The second setting is the address from which the new messages notifications will originate.

Lastly, the third setting is for the closing section of the new message email. In this example, the text will read:

// Sincerely,
Web Site //

## Advanced Settings

You may also wish to add:

	:::php
	MessagesPage::$messages_per_page = 10; // defaults to 25
	MessagesPage::$summary_length = 100; // Length of a message body summary, in characters. Defaults to 40


## Template customisation

It is likely that you will want to override some or all of the templates included with the Postale module to fit better
into your site design. To do that, just copy the template you want to override to the respective directory in your
theme. 

For instance, to override the *MessagesInterface.ss* template:

Copy // /postale/templates/Includes/MessagesInterface.ss // to //
/themes/your_theme/templates/Includes/MessagesInterface.ss // and make any necessary changes there.

Likewise, to override the new message notification template:

Copy // /postale/templates/MessageNotification.ss // to // /themes/your_theme/templates/MessageNotification.ss //.

## CSS customisation

Postale is a themeable module, so all you need to do is include a // messages.css // stylesheet in your theme to
override the core stylesheet. Most of the time, you will want to copy over the contents of the original stylesheet and
make any necessary modifications from within your theme.


# Troubleshooting

Support is available through:


*  [The DataObjectManager forum](http://silverstripe.org/dataobjectmanager-module-forum/)

*  [Left and Main](http://www.leftandmain.com), the official UncleCheese blog
