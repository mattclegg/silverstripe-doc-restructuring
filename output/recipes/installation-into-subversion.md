# How can I use Subversion to manage my sites

This page describes how the core SilverStripe team manage their own projects.  We create a large number of SilverStripe
projects on the same server.

Our set-up has a number of characteristics:


*  We use [subversion](http://subversion.tigris.org/) to manage our project code.

*  We use svn:externals to link SilverStripe core packages and modules to our projects.

*  We use [:environment-management](/environment-management) to share one set of database configuration details across
all our projects.

*  Rather than using the installer to 

This has the following advantages:


*  We can easily create new projects.

*  We can easily reconfigure the modules in our projects:
   * switch between different versions of the core packages and modules
   * switch to trunk versions of the core or of modules
   * add and remove modules.

Here's how you can set up such a configuration yourself:

#### Moving your project into subversion


*  Install SilverStripe as described in [:installation](/installation)

*  Delete the installation files:
    * check-php.php
    * config-form.css
    * config-form.html
    * index.html
    * index.php
    * install.php
    * rewritetest.php
    * tutorial (the directory)

*  Delete the core silverstripe folders (yes, you read that correctly!)
    * sapphire
    * cms
    * jsparty
    * auth_openid

You're left with the files that unique to your project.  Now, import these files into subversion.  Here's some example
shell commands to give you an idea:

	
	svn import http://svn.yourserver.com/yourproject/trunk 
	cd ..
	svn checkout http://svn.yourserver.com/yourproject/trunk yoursite
	cd yoursite


Finally, edit the svn:externals.

	
	svn propedit svn:externals .


The svn:externals entry will configure the core package and modules to include with your site.  This means that there is
no one value to put in here.  But we have 3 examples to get you started.  Choose the one that most suits your needs.

This will connect you to version 2.2.2:

	
	cms/ http://svn.silverstripe.com/open/modules/cms/tags/2.2.2
	jsparty/ http://svn.silverstripe.com/open/modules/jsparty/tags/2.2.2
	sapphire/ http://svn.silverstripe.com/open/modules/sapphire/tags/2.2.2


This will connect you to the the 2.2.x branch, so that you get minor bugfixes and security enhancement as soon as we
make them.  This is a good option to choose if you're not sure.

	
	cms/ http://svn.silverstripe.com/open/modules/cms/branches/2.2
	jsparty/ http://svn.silverstripe.com/open/modules/jsparty/branches/2.2
	sapphire/ http://svn.silverstripe.com/open/modules/sapphire/branches/2.2


This will connect you to trunk, which means you will get new developments as they happen.  Not for beginners!

	
	cms/ http://svn.silverstripe.com/open/modules/cms/trunk
	jsparty/ http://svn.silverstripe.com/open/modules/jsparty/trunk
	sapphire/ http://svn.silverstripe.com/open/modules/sapphire/trunk


#### Moving your database configuration into an _ss_environment.php file

See [:environment-management](/environment-management).
