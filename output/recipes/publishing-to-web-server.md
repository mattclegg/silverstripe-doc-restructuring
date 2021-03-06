# Publishing your Site to a Webserver

** NOTE: TODO FINISH THIS **
 
So you have downloaded and installed SilverStripe on your computer. You might have made a custom layout and created a
few pages for a site. Now you want to take your site and publish it to a live webserver. So how do you do this?

## What You Need

*  A FTP program which you use to copy files from your computer to the live server. For FTP program suggestions see
Appendix - FTP Programs Down the bottom of this page. 


*  Login Details for your webserver. FTP Hostname, Username & Password. MySQL Database Name, Username & Password.


*  A Text Editor to tweak settings / conf. See Appendix - Text Editors for suggestions if you dont have one.


*  A Willingness to play/tweak/experiment. Sadly this cannot cover every situation so you might just have to follow your
nose.

## Step 1. Check your new host supports Silverstripe

SilverStripe has pretty high requirements for the Server - http://doc.silverstripe.com/doku.php?id=server-requirements.
I would say about 80% of problems setting up SilverStripe on a webserver is down to the configuration of the Server and
you can always save yourself a hassle to make sure you use a supported host -
http://doc.silverstripe.com/doku.php?id=suggested-web-hosts

Your host must be PHP5. SilverStripe will not run on PHP4. If you do try to run SilverStripe on a PHP4 server it will
usually result in this error - Parse error: parse error, unexpected T_STRING, expecting T_OLD_FUNCTION or T_FUNCTION or
T_VAR or '}. You can check that your server is PHP5 by creating a phpinfo.php page with the following content

	:::php
	`<?php phpinfo(); ?>`


It must have mod_rewrite enabled, GD2 support and others. But once you run the installer on the live site it will report
these missing to you.

## Step 2. Set up SilverStripe on your Server

Download a brand new shiny copy of silverstripe to your computer and upload this to your web server using your FTP
client. You host should have provided you with some information about where to store your files but normally its in the
'www' or 'public_html' folder. SilverStripe is made up of lots of files so this might take a while!.

Now that you have uploaded all the files go to http://www.yoursite.com/install.php to install SilverStripe. Enter your
MySQL database details and make sure you select install with BlackCandy rather then the tutorial theme. Enter your admin
user account details and password. Remember you are now working on a live site so make sure your passwords are strong!
(eg your password shouldn't be 'password')

Make sure it installs correctly and you can use the admin section and everything works. If the installation didn't work
then ask in the forum for some help

## Step 3. Upload your custom code (PHP / HTML / CSS) to the live Site

As you may have noticed installing SilverStripe on the live website it defaulted back to the default theme and content
etc. If you have made changes to your local copy on your computer

   * Copy your theme (the html / css / images) 
   * Copy your custom code (the php code) 

### Copy the Theme

The themes/ folder in SilverStripe contains all the html/css and images that makes up your site design. You can have
multiple themes in that themes folder or just the 1. By default SilverStripes theme is 'BlackCandy'.

If you have made a site with a theme 'MyLovelyTheme' or even if you overrided the blackcandy template files you need to
copy these changes from your local computer to the live site. So copy the whole themes/ folder from you local computer
and override the themes/ folder on the live webserver.

Now that you have uploaded your template files if you are using a custom theme (eg not using blackcandy) you will need
to also update the **SSViewer::set_theme('blackcandy')** line in the **mysite/_config.php** file to point to your custom
theme. eg **SSViewer::set_theme('MyLovelyTheme');**

### Copy the Custom PHP Code

Same with the code. Copy the contents of the mysite/code/* folder on your local to the same place on the live site
(mysite/code/*).


## Step 4. Export Your Content and Import it on the live site

Exporting the DB is a bit more tricky. If you have 'Phpmyadmin' installed on your local computer then you can go into
that by visiting http://localhost/phpmyadmin/ or something similar. Then select your database on the left hand side.
Click it. Then once it loads you need to click the 'Export' tab on the top center right of the page.

** Insert Screenshot **

Make sure you have ticked the 'Add Drop Table / Drop view' option and the 'Save as File' option then click Go down the
bottom.

** Insert Screenshot **


Hopefully your host has PHPmyadmin as well so now we want to import that file you saved in the last step to your live
website. So login to phpmyadmin on your live server and select the database on the left you setup the site with. Once
you have clicked your database and it has loaded then click the Import tab at the top center right of the page, select
the file you made in the last step and click 'Go'. This will import the database.

## Step 5. Make sure everything works

Try and visit your site :)

## Appendix

### FTP Clients
#### Windows

   * CuteFTP - http://www.cuteftp.com/
   * SmartFTP - http://www.smartftp.com/ 
#### Mac

   * CyberDuck - http://cyberduck.ch/
   * Trasmit - http://www.panic.com/transmit/

### Text Editors

#### Windows

   * Notepad (Default)
   * Notepad++ http://notepad-plus.sourceforge.net/

####  Mac

   * TextMate - http://macromates.com/
   * Smultron - http://smultron.sourceforge.net/

