# Managing your SS install

Also see:

* 
[http://doc.silverstripe.com/doku.php?id=environment-management](http://doc.silverstripe.com/doku.php?id=environment-management)

* 
[http://doc.silverstripe.com/doku.php?id=installation-into-subversion](http://doc.silverstripe.com/doku.php?id=installation-into-subversion)

I'd suggest you refer to those & improve them where nescessary - rather than repeat anything thats in there - the SS
wiki is already a little repetitive.
Also 'structural guidlines' doesn't really describe what you've talked about. How about a more informative title?
'Managing you SS install' 

This page explains best practice in managing your silverstripe installs.  It shows you how you can have multiple
installs (e.g. dev, live, test) of your website AND how you can setup your code in such a way that you can easily
upgrade to the next version of Silverstripe itself or any of its modules.... It is important to do so, because all
websites have bugs and it is much easier if a standard module gets debugged (often by someone else) rather than your
custom version of this standard module.

# Basic Setup

Every install should have the following files and directories:


*  .htaccess

*  index.php (from the SS install - tells you if the hosting setup is not working)
*  _ss_environment.php
*  /cms
*  /jsparty
*  /mysite (which can have any name, but lets keep it as mysite for now)
*  /sapphire
*  /themes
*  /module A(as many as you like)
*  /module B(as many as you like)


NOTE that the _ss_environment is not included by default and that you may also have one _ss_environment file for all
your projects on one server. Move your _ss_environment.php file one folder up. That is, if you will end up with the
following structure:

/project A
/project B
/project C
_ss_environment.php (for all projects)

Apart from that you can have X number of modules.  Each module folder should have a _config.php folder in its root.

In the /mysite/_config, you should start with:

	:::php
	/* startup */
	global $database; $database = "my_data_name here";
	require_once("conf/ConfigureFromEnv.php");
	global $project; $project = 'mysite';
	SSViewer::set_theme('mythemename');
	//... other configurations here


The *require_once("conf/ConfigureFromEnv.php");* links in a funny way through to _ss_environment.php where we add the
following:

	:::php
	define('SS_ENVIRONMENT_TYPE', 'dev'); //or test or live
	define('SS_DATABASE_SERVER', 'localhost');
	define('SS_DATABASE_USERNAME', 'root'); 
	define('SS_DATABASE_PASSWORD', '');
	define('SS_DATABASE_PREFIX', '');
	define('SS_DEFAULT_ADMIN_USERNAME', 'usernamehere');
	define('SS_DEFAULT_ADMIN_PASSWORD', 'passwordHere');
	define('SS_SEND_ALL_EMAILS_TO', 'myname@mysite.com'); //in dev sites only


For different installs of the same project there are two files that are customised to each install.  These are .htaccess
and _ss_environment.php.  All other files are the same in each install of the same project.

## adding other modules

The trick is to keep all of your custom code in /mysite and in /themes, where /mysite is the back-end and /themes is the
front-end. When you add other modules (e.g. googlesitemaps, hidemailto, gallery, etc...) then place all of your
configurations in /mysite/_config.php and NOT in the modules themselves.  This means that you can upgrade your module
without having to (re)overwrite any files.


## how do I customise modules?

If you would like to make changes to modules then there are a bunch of ways to do that without having to change the
actual module (thereby allowing module upgrades).  In order of preference, here are the ways to customise modules:

 1.  create a folder in the theme section and customise module through an adapted front-end.  The best way to do this is
to copy the cms, images and template folder from the module to (/themes/mytheme_mymodulename (e.g.
/themes/blackcandy_ecommerce) and edit the files you want to change and delete the ones you want to keep the same.  In
most instances you will find that the css will replace the css in the module itself (see themedCSS for more information)
and the same applies to the templates.
 2.  extend classes from the module.  For example, when you are working with ecommerce and you have a special type of
product then you can extend the product class and place this into your mysite folder.  To learn more about extending
classes, you need to understand PHP5 classes and the basics of object oriented programming. The Page class extends the
Sitetree Class. The product class in ecommerce extends the Page class and the MyProductClass can extend the Product
Class.  In this way you can add functionality to the ecommerce module without touching it.  NOTE: the static variable
`static $hide_ancestor = false;`{php} can be very useful in hiding parent the parent class (e.g. if, in the CMS, you
only want to show myproductpage and not the product page).
 3.  write a Data Object Decorator (DODs). The main pitfall of DODs is that they adjust every page on your website, as
far as I know, you can not let DODs change only this or that page(type).  This injects functionality into the actual
classes.
 4.  write a complementing module 

If all of this does not you where you want to be then the next best thing is to copy a php page from a module into your
/mysite/code folder, make the adjustments and then delete the original class in your imported module.  This is the best
way to still allow module updates with the least amount of hassle.


    

## In Summary

Only ever change your /mysite and /themes folder and you end up with the least amount of work in terms of keeping your
website up-to-date.





