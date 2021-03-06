# Installation On Mac OSX using MAMP

This topic covers setting up your Mac as a Web Server and installing SilverStripe. If you want to watch the video see
the online tutorial at http://silverstripe.com/assets/screencasts/Tutorial-InstallingMAMP-SW08.swf

## Setting Up MAMP

 

*  While OSX Comes bundled with PHP and Apache (Thanks Apple!) Its not quite ideal for SilverStripe so for setting up a
webserver on OSX we suggest using MAMP - http://www.mamp.info/en/index.php. If you want to use the default OSX PHP
version then you will need to recompile your own versions of PHP with GD so you can probably work out how to Install
SilverStripe! but for those normal folk you want to go download the latest and greatest [MAMP
Version](http://www.mamp.info/en/download.html) and run the installer.


*  Once you have downloaded and Installed MAMP start the Application and Make sure everything is running by clicking the
MAMP icon. Under Preferences -> PHP make sure Version 5 is Selected.


*  I had to make 1 change to MAMP to make sure SilverStripe ran, That was increasing the PHP Memory limit. To do this
Open up /Applications/MAMP/conf/PHP5/php.ini and Go down to about line 232 and change memory_limit = 8M to something
like 64M. If you are working on a Big Site I would suggest 128M.


*  Once you make that change open the MAMP App Again by clicking on the MAMP Icon and click Stop Servers then Start
Servers - this is so our changes to the php.ini take effect.
## Installing SilverStripe


*  Okay! Hard part done. Now for the fun!. [Download](http://silverstripe.org/download) the latest SilverStripe
installer package.
 

*  Once its downloaded copy the tar.gz file to the 'Document Root' for MAMP - By Default its /Applications/MAMP/htdocs.
Don't know what your Document Root is? Open MAMP Click Preferences -> Apache. It is the directory defined there. I use
/User/Will/Sites/ instead so I don't keep my important Site files inside an Application. 


*  Extract The tar.gz file to a folder, e.g., silverstripe/ (You always move the tar.gz file first and not the other way
around as SilverStripe uses a '.htaccess' file which is hidden from OSX so if you move SilverStripe the .htaccess file
won't come along.


*  So you have extracted SilverStripe to a folder called silverstripe/ in your web servers Document Root? So now lets
install it! Open your web browser and go to http://localhost:8888/silverstripe/ and you should see the Installer Screen!


*  Enter your DB details - By default with MAMP its user: root/ password: root and Select your account details. Click
Check Details


*  Once everything is sorted hit Install! and Voila you have SilverStripe installed 

# Installation using Mac OS X's built-in webserver

This is really more than a collection of points than a complete how-to.


*  To get GD working, you will need to download and install a new version of PHP.  [This link on the moodle
documentation](http://docs.moodle.org/en/Step_by_Step_Installation_on_a_Mac_OS_X_10.5_Server#Install_the_GD_Library_on_the_Mac_OS_X_10.5_Server)
explains how.
