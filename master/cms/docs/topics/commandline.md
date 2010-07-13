# SAKE: Sapphire make

**NOTE:** This feature is currently only available in trunk and will be released in SilverStripe 2.3.

Sake is a wrapper around Sapphire's cli-script.php, designed to be used for build related tasks such as testing and
database upgrades.

**If you are using a debian server:** Check you have the php-cli package installed for sake to work. 
If you get an error when running the command php -v, then you may not have php-cli installed so sake won't work.

#### Installation

**Linux / Mac**

	
	cd /your/site/folder
	sudo ./sapphire/sake installsake


** Windows **

Coming soon....

#### Setting up your environment for command-line support

Sometimes SilverStripe needs to know the URL of your site, for example, when sending an email.  When you're visiting
your site in a web browser this is easy to work out, but if you're executing scripts on the command-line, it has no way
of knowing.

To work this out, you should add lines of this form to your [_ss_environment.php](environment-management) file.

	:::php
	global $_FILE_TO_URL_MAPPING;
	$_FILE_TO_URL_MAPPING['/Users/sminnee/Sites'] = 'http://localhost';


What the line says is that any Folder under /Users/sminnee/Sites/ can be accessed in a web browser from
http://localhost.  For example, /Users/sminnee/Sites/mysite will be available at http://localhost/mysite.

You can add multiple file to url mapping definitions.  The most specific mapping will be used. For example:

	:::php
	global $_FILE_TO_URL_MAPPING;
	$_FILE_TO_URL_MAPPING['/Users/sminnee/Sites'] = 'http://localhost';
	$_FILE_TO_URL_MAPPING['/Users/sminnee/Sites/mysite'] = 'http://mysite.localhost';


Using this example, /Users/sminnee/Sites/mysite/ would be accessed at http://mysite.localhost/, and
/Users/sminnee/Sites/othersite/ would be accessed at http://localhost/othersite/

#### Use

Sake will either run ./sapphire/cli-script.php or ./cli-script.php, depending on what's available.

It's particularly useful for running build tasks...

	
	cd /your/site/folder
	sake db/build
	sake dev/tests/all


It can also be handy if you have a long running script.

	
	cd /your/site/folder
	sake MyReallyLongTask


#### Running processes

You can use sake to make daemon processes for your application.

Step 1: Make a task or controller class that runs a loop.  Because Sapphire has memory leaks, you should make the PHP
process exit when it hits some reasonable memory limit.  Sake will automatically restart your process whenever it exits.

The other thing you should do is include some appropriate sleep()s so that your process doesn't hog the system.  The
best thing to do is to have a short sleep when the process is in the middle of doing things, and a long sleep when
doesn't have anything to do.

This code provides a good template:

	:::php
	class MyProcess extends Controller {
	  function index() {
	    set_time_limit(0);
	    while(memory_get_usage() < 32*1024*1024) {
	      if($this->somethingToDo()) {
	        $this->doSomething();
	        sleep(1)
	      } else {
	        sleep(300);
	      }
	    }
	  }
	}



Step 2: Install the "daemon" command-line tool on your server.

Step 3: Use sake to start and stop your process

	
	sake -start MyProcess
	sake -stop MyProcess


Note that sake processes are currently a little brittle, in that the pid and log files are placed in the site root
directory, rather than somewhere sensible like /var/log or /var/run.

#### To Do

*  Build sake.bat for windows users
*  Have a tighter integration between sake and Mark's task runner work.  For example, we might signal that either sake
can run only URLs in the dev/ namespace, or that any action without a "/" is assumed to be a command in the dev/
namespsace.
*  Add a bunch of task runner tasks to do the command-line-esque things.
*  If you just run sake, then show a list of possible commands
