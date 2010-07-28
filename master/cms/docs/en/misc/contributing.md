# Contributing

Any open source product is only as good as the 
community behind it. You can participate by sharing 
code, ideas, or simply helping others. No matter what 
your skill level is, every contribution counts.

See http://silverstripe.org/contributing-to-silverstripe for a highlevel overview
on how you can help out.

## Sharing your Opinion

*  [silverstripe.org/forums](http://silverstripe.org/forums): Forums on silverstripe.org
*  [silverstripe-dev](http://groups.google.com/group/silverstripe-dev): Core development mailinglist
*  [silverstripe-documentation](http://groups.google.com/group/silverstripe-documentation): Documentation team
mailinglist


## Submitting Patches

If you have created a patch to fix a bug in one the modules - thank you so much! :D To submit the patch,
[register](http://open.silverstripe.com/register) and attach the patch to the appropriate ticket. Please include in the
comment the revision number that the patch is applicable for and a brief outline of what you fixed and how. 
Only use the provided link to submit patches, as it prefills information about owner and ticket-type:

[Submit a patch (requires account on
open.silverstripe.org)](http://open.silverstripe.com/newticket?field_type=patch&field_owner=ischommer&attachment=1)

The core team is responsible for reviewing the patches and deciding if they will make it into core.  If
there are any problems they will assign the ticket back to you, so make sure you have an email address loaded into Trac
so that it will notify you! The Trac report [Active Patches](http://open.silverstripe.com/report/10) will let you see
where all the patches are at.

You can create a patch file through the svn diff-command on the command-line. 
More info in the [svn redbook](http://svnbook.red-bean.com/en/1.1/ch03s05.html#svn-ch-3-sect-5.3.2). 
Note: Your code-editor might have a GUI for creating patches.

	# in a working copy folder (e.g /myproject)
	svn diff sapphire/ > ~/patch.diff

*  Submit your patch in *diff -u* or *diff -c format*. 

*  **Check your patches against a svn checkout of the [current trunk](http://open.silverstripe.com/browser/modules)**. 
Please not that the latest stable release will often not be sufficient! (of all modules)

*  If your patch is extensive, discuss it first on the [silverstripe
forum]([[http///www.silverstripe.com/silverstripe-forum/) (optimally before doing any serious coding)

*  Adhere to our [coding conventions](http://doc.silverstripe.com/doku.php?id=coding-conventions)
*  Provide complete [unit test coverage](/topics/testing) - depending on the complexity of your work, this is a required
step.

*  Describe specifics on how to test the effects of the patch
*  It's better to submit multiple patches with separate bits of functionality than a big patch containing lots of
changes

*  If your patch involves new files, create a compressed archive for them (including any required directory-structures)
*  Create patches relative to the working copy (//sapphire/main.php// instead of */Users/myuser/sapphire/main.php*)
*  Document your code inline through [PHPDoc](http://en.wikipedia.org/wiki/PHPDoc) syntax. See our [API
documentation](http://api.silverstripe.org/trunk) for good examples.

*  Also check and refer to wiki documentation on [doc.silverstripe.com](http://doc.silverstripe.com ) which needs
changes. Check for any references to functionality deprecated or extended through your patch. Please don't alter the
documentation before your patch is integrated.

*  Remember the [shortcomings](http://subversion.tigris.org/project_tasks.html#svn-augmented-diff) of *svn diff*: Please
document moved files and created/deleted directories separately

## Reporting Security Issues

Report security issues to [security@silverstripe.com](mailto/security@silverstripe.com). Please don't file security
issues in our [bugtracker](http://open.silverstripe.org). In the event of a confirmed vulnerability in SilverStripe
core, we will take the following actions:

*  Acknowledge to the reporter that we’ve received the report and that a fix is forthcoming. We’ll give a rough
timeline and ask the reporter to keep the issue confidential until we announce it.

*  Halt all other development as long as is needed to develop a fix, including patches against the current and one
previous major release (if applicable).

*  We will inform you about resolution and [announce](http://groups.google.com/group/silverstripe-announce) a [new
release](http://silverstripe.org/security-releases/) publically.

You can help us determine the problem and speed up responses by providing us with more information on how to reproduce
the issue: SilverStripe version (incl. any installed modules), PHP/webserver version and configuration, anonymized
webserver access logs (if a hack is suspected), any other services and web packages running on the same server.

## Writing Documentation

### Repositories

*  End-user: [userhelp.silverstripe.com](http://userhelp.silverstripe.com): 
*  Developer Guides: [doc.silverstripe.com](http://doc.silverstripe.com)
*  Developer API Docuumentation: [api.silverstripe.com](http://api.silverstripe.com)

### Recommendations

*  Search for **existing places** to put your documentation. Do you really require a new page, or just a new paragraph
of text somewhere?

*  Leave lowlevel technical documentation to class-level [PHPDoc](http://en.wikipedia.org/wiki/PHPDoc). Remember: Both
forms of documenting sourcecode (PHPDoc/wiki) are valueable ressources, **one should complement the other**.

*  Refer to wiki documentation inside your **PHPDoc**.
*  Linking your page: A wiki lives by **interlinking content**, so please make sure your contribution doesn't become an
inaccessible island. Check the startpage for common index-repositories to extend.

*  Linking other pages: Make sure to **refer to related topics** (e.g. [templates](/topics/templates) could refer to
[javascript](/topics/javascript)).

*  Consider **namespacing** your page to keep things coherent (e.g. "tutorial:customizing-contact-forms" instead of
"customizing-contact-forms"). Please contact Silverstripe-staff before adding any new namespaces.

*  **Image-linking**: We'd like to keep all ressources for documentation in one place. DokuWiki doesn't provide a public
upload, so please ask Silverstripe-staff to add your image to doc.silverstripe.com. This is preferred to linking files
on your own server.#

*  Try to **avoid FAQs** as a replacement of a coherent, well explained documentation. If you've done a good job
documenting, there shouldn't be any "frequently asked questions" left ;)

*  You don't need to completely finish documentation, as long as you **mark areas needing refinement**.
*  If referring to any technical features, please **refer to the Silverstripe-release** where they have been introduced.
*  Further info: [How tech writing sucks: Five
Sins](http://www.slash7.com/articles/2006/11/15/tech-writing-the-five-sins) and [What is good
documentation?](http://www.techscribe.co.uk/techw/whatis.htm)