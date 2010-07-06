# Introduction

Usually an update or upgrade your SilverStripe installation just means overwriting files and updating your database-schema.


# Related

*  [Detailed changelogs](http://open.silverstripe.org/wiki/ChangeLog)
*  [Blog posts about releases on silverstripe.org](http://silverstripe.org/blog/tag/release)

# Versions
*  [trunk](upgrading/trunk)
*  [2.4.0](upgrading/2.4.0)
*  [2.3.3](upgrading/2.3.3)
*  [2.3.2](upgrading/2.3.2)
*  [2.3.1](upgrading/2.3.1)
*  [2.3.0](upgrading/2.3.0)
*  [2.2.0](upgrading/2.2.0)
*  [2.1.0](upgrading/2.1.0)

# Process
*  Check if any [modules](modules) (e.g. blog or forum) in your installation are compatible and need to be upgraded as well
*  Backup your database
*  Backup your webroot
*  Download the new release and uncompress it to a temporary folder
*  Leave custom folders like //mysite// or //themes// in place.
*  Identify system folders in your webroot (//cms//, //sapphire// and any additional modules). 
    * Delete existing system folders (or move them outside of your webroot)
    * Extract and replace system folders from your download (//Deleting instead of "copying over" existing folders ensures that files removed from the new SilverStripe release are not persisting in your installation//)
*  Visit http://yoursite.com/dev/build/?flush=1 (adds new fields/tables to the database, and empties your template cache)
*  Check if you need to adapt your code to changed APIs
*  Check if you need to adapt your code to changed CSS/HTML/JS
*  See [common-problems](common-problems) for a list of likely mistakes that could happen during an upgrade.

====== Decision Helpers =======
How easy will it be to update my project? It's a fair question, and sometimes a difficult one to answer.  This page is intended to help you work out how hard it will be to upgrade your site.

*  If you've made custom branches of the core, or of a module, it's going to be harder to upgrade.
*  The more custom features you have, the harder it will be to upgrade.  You will have to re-test all of those features and some of them may have broken.
*  Customisations of a well defined type - such as custom page types or custom blog widgets - are going to be easier to upgrade than customisations that use sneaky tricks, such as the subsites module.
