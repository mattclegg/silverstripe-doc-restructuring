# Environment management

As website developers, we noticed that we had a few problems.  You may have the same problems:

*  On our development laptops, we have a number of sites, but the database connection details are the same for each of
them.  Why should we have to go through the installation process and re-enter them each time?
*  Each of those sites needed to be in development mode when we were editing them on our laptops, but in production mode
when we deploy them to our servers.  Additionally, our production host's database connection details will likely be
different than our local server.

SilverStripe comes with a solution to this: ths ''_ss_environment.php'' file.  You can put a single _ss_environment.php
file in your "projects" folder on your development box, and it will be used by each of your development sites.

#### Setting up your development machine with _ss_environment.php

In this example, we assume that you are managing multiple projects as subfolders of ''~/Sites/'', and that you can visit
these at ''http://localhost/''.  For example, you might have a project at ''~/Sites/myproject/'', and visit it at
''http://localhost/myproject/''.

*  Create a new file, ~/Sites/_ss_environment.php.  Put the following content in it, editing the values of the
''SS_DATABASE_...'' and ''SS_DEFAULT_ADMIN_...'' defines as appropriate.

	:::php
	<?php
	/* What kind of environment is this: development, test, or live (ie, production)? */
	define('SS_ENVIRONMENT_TYPE', 'dev/test/live');
	
	/* Database connection */
	define('SS_DATABASE_SERVER', 'localhost');
	define('SS_DATABASE_USERNAME', 'root');
	define('SS_DATABASE_PASSWORD', '');
	
	/* Configure a default username and password to access the CMS on all sites in this environment. */
	define('SS_DEFAULT_ADMIN_USERNAME', 'username');
	define('SS_DEFAULT_ADMIN_PASSWORD', 'password');


*  Now, edit each of your site's configuration file, ''~/Sites/(projectname)/mysite/_config.php''.  Delete all mention
of ''$databaseConfig'' and ''Director::set_dev_servers'', and instead make sure that you file starts like this.

	:::php
	<?php
	
	global $project;
	$project = 'mysite';
	
	global $database;
	$database = '(databasename)';
	
	// Use _ss_environment.php file for configuration
	require_once("conf/ConfigureFromEnv.php");


#### How it works

The mechanism by which the ''_ss_environment.php'' files work is quite simple.  Here's how it works:

*  At the beginning of SilverStripe's execution, the _ss_environment.php file is searched for, and if it is found, it's
included.  SilverStripe looks in 3 places for the file:
    * The site's base folder (ie, a sibling of sapphire, jsparty, and cms)
    * The parent of the base folder
    * The grandparent of the base folder
*  The ''_ss_environment.php'' file sets a number of ''define()''s.
*  ''conf/ConfigureFromEnv.php'' is included from within your ''mysite/_config.php''.  This file has a number of regular
configuration commands that use those defines as their arguments.  If you are curious, open up
''sapphire/conf/ConfigureFromEnv.php'' and see for yourself!
