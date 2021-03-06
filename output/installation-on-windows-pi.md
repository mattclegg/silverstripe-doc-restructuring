##### Installation on Windows using Web Platform Installer

{{http://doc.silverstripe.com/assets/windows.png }}
(Windows XP, 2003, 2008, Vista and 7)

##### Installing SilverStripe

*  Download and run Microsoft Web Platform Installer (WebPI):
[{{http://www.silverstripe.org/assets/downloads/webpi/wpiBadgeGreen.png}}](http://www.microsoft.com/web/gallery/install.aspx?appsxml=www.microsoft.com%2fweb%2fwebpi%2f2.0%2fWebApplicationList.xml&amp;appid=105)


*  In WebPI, select 'SilverStripe' from the 'Content Management System' link

*  Select install. It will install dependencies like the Microsoft SQL Server database, as well as PHP (if you don't
have these installed already). You can alternatively choose MySQL as a database in the setup wizard.

*  Type in the questions it asks you, such as the username/password you set in the above database installation:

*  Everything should be installed, with you seeing the initial webpage

*  And you can log-in to the CMS

##### Important: Installation issue on XP

After you've installed SilverStripe on XP using WebPI. You'll need to make a configuration change to get it working.

Specifically, you need to configure XP not to check that a script file exists before executing the script.  This is
necessary for URLs of the form http://localhost/silverstripe/index.php/about-us/ to work.


*  Open IIS Administrator

*  Expand the local computer tree node

*  Expand the Web Sites tree node

*  Right click on "Default Web Site" and select "Properties"

*  Select the "Home Directory" Tab.

*  Click the "Configuration Button towards the bottom on the right

*  Select the "Mappings" Tab

*  Find the .php mapping, select it and click the "Edit" button

*  Make sure the check box "Check that file exists" is cleared.

*  Hit OK's all the way back up and restart IIS

##### Support

*  http://www.silverstripe.org/installing-on-windows-now-easier-thanks-to-microsoft-web-platform-installer/  (This shows
a beta version of the software)

*  Microsoft Forum: http://forums.iis.net/1155.aspx

*  SilverStripe Installation Issues Forum: http://silverstripe.org/installing-silverstripe/

##### Screenshots of this installation process

{{:webpi-2-a-silverstripe-choice.png|:webpi-2-a-silverstripe-choice.png}}
{{:webpi-2-b-dependencies.png|:webpi-2-b-dependencies.png}}
{{:webpi-2-c-downloading-and-installaing.png|:webpi-2-c-downloading-and-installaing.png}}
{{:webpi-2-d-installer-questions-step1.png|:webpi-2-d-installer-questions-step1.png}}
{{:webpi-2-e-installer-questions-step2.png|:webpi-2-e-installer-questions-step2.png}}
{{:webpi-2-f-success-message.png|:webpi-2-f-success-message.png}}
{{:webpi-2-g-silverstripe-homepage.png|:webpi-2-g-silverstripe-homepage.png}}
{{:webpi-2-h-cms-interface-working.png|:webpi-2-h-cms-interface-working.png}}
