# Simple Guestbook module

Welcome to the wiki page of the simple guestbook module :-)

## Introduction

Here you'll find most information you need to install and configure the module

## Installation

### Prerequisites

What do I need to use this module?

*  Silverstripe 2.3.x or 2.4x

*  [SpamProtection Module](http://www.silverstripe.org/spam-protection-module)

*  [ReCaptcha Module](http://www.silverstripe.org/recaptcha-module)

*  [Simplest Spam Module](http://www.silverstripe.org/simplest-spam-module/)

*  [Guestbook Module](http://www.silverstripe.org/simple-guestbook-module) (latest version)

**NOTE:** Last release for 2.3x will be 0.92!

### Installation steps

In general this works like every module installation:
 1.  download the modules (see: Prerequisites)
 2.  unpack each module and, if not already correct, rename the guestbook to "guestbook"
 3.  place the unpacked modules in your silverstripe directory
 4.  run http://yourdomain/dev/Build to initialize the DB build
 5.  check your admin backend for a new tab "Guestbook"

After doing so, there should be a new pagetype "Guestbook" available for new pages.

### Configuration

**NOTE:** For ReCaptcha an SpamProtection you should visit the specific Wiki-entries for configuration help.

Configuration for the guestbook is quite simple ;-)
 1.  add new page, type "Guestbook"
 2.  go to "Config" tab
 3.  check or uncheck the options you need

    * Encrypt eMail addresses: shows encrypted or hides the mail address
    * New entries need activation: Does exactly what it says
    * Show Pagination for entries: If you want the "next/previous page" stuff
    * Entries per page: Sets the limit of entries per page
    * Allow comments for entries: Enables commenting feature for logged in users. So if a guest writes an entry, you can
answer without creating a new entry.
    * Which spamprotection? Choose none (-), Math, ReCaptcha, SimplestSpam
    * ReCaptcha Style: Gives you the opportunity to set - only appears if ReCaptcha is enabled
    * ReCaptcha language: Sets the ReCaptcha language (if i118n is not yet set/enabled) - only appears if ReCaptcha is
enabled

The "Entries" tab now only contents the guestbook entries for the specific page.

**NOTE:** MathSpam protection is already initialized in the module's configuration!

### Issues/ToDos

Known issues:

*  Through the useage of ReCaptcha, there could be an error with XHTML pages with XML-header.

ToDos:

*  (1.1) add frontent editing for entries and comments

*  (1.1) configurable entry form (e.g. no last name or email address needed)

*  (1.2) add optional mail to a defined member-pool on new entry

## Working with the module

To easily change the css for the module, just copy guestbook/css/guestbook.css into your mysite/css/ directory and feel
free to change. The module recognizes if this css file is present and then skips its own one. So make sure you have
everything you need in that css ;-)

If you're interested in the code, just have a look at the [documentation](http://docs.aschmann.org/guestbook)

## Releases, Revisions and SS updates

Since I found out that Silverstripe API tends to change from one release to another, I'll maintain a branch for each
revision.
Works like that:

*  http://aschmann.org/svn/mod_guestbook/branches/ss_2_3/ will hold the last version for the 2.3-compatible guestbook.
Feature-freeze, just bugfixes

*  http://aschmann.org/svn/mod_guestbook/trunk will hold the current development version of the guestbook

*  http://aschmann.org/svn/mod_guestbook/tags/ contains all releases as tags for checkout


## Want to join?

If you feel the need to participate in this project, just let me know :-)
