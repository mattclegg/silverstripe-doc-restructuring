# Installation on Windows using WAMP (Apache webserver)

{{http://doc.silverstripe.com/assets/windows.png }}

An easy and reliable approach to getting SilverStripe running on Windows is to use Apache, which can be convieniently
done through [WampServer](http://www.wampserver.com/en/). This can be useful if you are deploying on Linux Apache and
want a Microsoft Windows machine with a very similar environment.


*  Note: Installing on Microsoft's IIS webserver is likely to be easier - See
[installation-on-windows-pi](installation-on-windows-pi)

##### Installing using WampServer

*  [Watch as video.](http://www.silverstripe.org/assets/screencasts/silverstripe-installation-wamp/index.html)

 1.  Download WampServer from http://www.wampserver.com/en/download.php
 2.  Run the installer.  By default, it will install to C:\wamp.  You can choose your own install path if you wish; the
directories mentioned below will also be different.
 3.  Once WampServer has been installed and launched, you will see a little half circle gauge in the task bar, next to
the clock.  If everything is working, then it will be white.  If it's yellow or red, then something is wrong.  If you
can't see the gauge, then WampServer hasn't been started and you should start WampServer from the start menu.
 4.  If something's wrong, this usually means that you have another service on port 80 or port 3306.   Here are some
common sources of problems to check.  After correcting these issues, left-click the gauge and choose 'restart all
services'.  It might a short while to restart, but the gauge should go to white.

    * You might have IIS running.  Check Start -> Control Panel -> Administrative Tools -> Internet Information
Services.   Ensure that any web site services are stopped.
    * If you run Skype, visit Select "Tools" -> "Options" in Skype's menu.  Find an option "Use port 80 and 443 as
alternatives for incoming connection".  Make sure that it is de-selected.
 5.  Left-click the gauge, then select Apache -> Apache Modules -> Rewrite Module.  The gauge will flick to yellow, and
then return to white.
 6.  Left-click the gauge, then select MySQL -> my.ini. At the very bottom of the file, and add the following to a new
line (without the quotes): "lower_case_table_names = 2". Save the file, close Notepad and left-click the gauge, and
selected 'Restart all services'. This is used to ease the transition between a Windows-based install and a Linux-based
install where case-sensitivity is important.
 7.  [Download](http://silverstripe.org/download) the latest SilverStripe installer package
 8.  Unpack the archive into C:\wamp\www
 9.  Rename the unpacked directory from C:\wamp\www\silverstripe-vX.X.X to C:\wamp\www\silverstripe
 10.  Visit http://localhost/silverstripe - you will see SilverStripe's installation screen.
 11.  You should be able to click "Install SilverStripe" and the installer will do its thing.  It takes a minute or two.
 12.  Once the installer has finished, visit http://localhost/silverstripe.  You should see your new SilverStripe site's
home page.

#### Troubleshooting

If it didn't go to plan, you can try the following things:


*  If you get an error after clicking the "Install SilverStripe" button, try visiting
http://localhost/silverstripe/db/build?flush=1 and then going back to http://localhost/silverstripe

*  If you see the install screen when visiting http://localhost/silverstripe after installation, then check the file
permissions on c:\wamp\www and update them so that everyone can edit files in there.

##### Vista

Vista's security controls can cause issues. If you have installed on Vista but you're getting errors, there is a chance
that SilverStripe does not have sufficient permissions.

Right clicked on the installation folder and go to Permissions > Security > Users > Advanced and give the user full
control. 

*This could use refinement!*

#### Advanced features

You don't need to do things things just to get SilverStripe going, but they can help you set up a more sophisticated
development environment.

##### TortoiseSVN

I use [TortiseSVN](http://tortoisesvn.tigris.org/) to mnage my SVN repos - gives me nice icons inside Windows Explorer
and let's you commit/update etc easily. I like it better than Eclipse because it's a little more graphical but your
mileage may vary.

##### Virtual hosts

Virtual hosts let you run multiple sites on different domain names from your windows machine.

 1.  Open httpd.conf and uncomment the line at the bottom of the file that includes httpd-vhosts.conf
 2.  Open httpd-vhosts.conf and delete all the current stuff in it
 3.  Leave (or-recreate) the "NameVirtualHost" line, remove :80 if it exists (so the line now reads "NameVirtualHost *"
without quotes
 4.  Make this your default (it must be the very first `<VirtualHost>` block in the file to be classed as the default)

	
	##
	## Site list, phpMyAdmin, WAMP-specific config etc.
	##
	`<VirtualHost *>`
	    DocumentRoot C:/serveweb/sites/default
	    ServerName localhost
	
	    CustomLog ../logs/default/access.log common
	`</VirtualHost>`


 1.  Add extra ones for each project you work on. For example:

	
	##
	## ssopen
	##
	`<VirtualHost *>`
	    DocumentRoot c:/serveweb/sites/ssopen
	    ServerName ssopen
	    CustomLog ../logs/ssopen/access.log common
	`</VirtualHost>`
	
	##
	## uPlay
	##
	`<VirtualHost *>`
	    DocumentRoot c:/serveweb/sites/uplay
	    ServerName uplay
	    CustomLog ../logs/uplay/access.log common
	`</VirtualHost>`


 1.  Create directories inside the logs/ folder for each project (you can remove the line, but it helps to debug issues
when Apache doesn't like what you're passing it)
 2.  Create these directories. What I find works well is to install TortiseSVN, open c:\serveweb\sites, then right click
and select SVN Checkout. Add the project name to the end of the destination directory and modify the SVN source path to
suit. It'll check out the project into c:\serveweb\sites\uplay, for example.
