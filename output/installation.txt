# How to install SilverStripe

SilverStripe is a web application.  This means that you will need to have a web server meeting SilverStripe's  [requirements](server-requirements) running.

The installation instructions below will take you through setting up an appropriate web server on your system.  The installation instructions will set you up with a SilverStripe website very similar to our [our demo site](http://demo.silverstripe.com/) uses. 

#### Windows
{{http://doc.silverstripe.com/assets/windows.png }}

If you run Windows, we recommend that you use [Microsoft's free Web Platform installer](installation-on-windows-pi). If you are more technically inclined you can install using [Apache on Windows](installation-on-windows-wamp) or [Manually install on IIS](installation-on-windows-manual-iis).
#### Mac OS X
{{http://doc.silverstripe.com/assets/osx.png }}

If you run Mac OS X, we recommend that you install MAMP first, and then install SilverStripe.

**[Instructions for installing on Mac OS X](installation-on-mac-osx)** or 
[ Watch installation video contributed by an open source member](http://www.silverstripe.org/assets/screencasts/Tutorial-InstallingMAMP-SW08.swf )

#### Linux
{{http://doc.silverstripe.com/assets/linux.png }}

If you run Linux, we assume that you know how to get a web-server going.

**[Instructions for installing on an existing webserver](installation-on-webserver)**

#### Installation on existing webservers

*  [Apache](installation-on-webserver)
*  [Lighttpd (lighty)](installation-on-lighttpd)
*  [Microsoft IIS](installation-on-windows)
*  [Nginx](installation-on-nginx)
*  [Other](installation-on-webserver)
## Further reading

If you run into trouble, see [common-problems](common-problems) or post to [the SilverStripe forum](http://www.silverstripe.com/silverstripe-forum/).

If your installation does not allow PHP short tags i.e. you must have <%php, there is a bug in the current install package (2.3.1, 20 March 2009) that prevents Silverstripe installing. See this [forum thread](http://silverstripe.org/installing-silverstripe/show/256795?start=0) for details and how to fix it.

For advanced set-ups, see these pages.  These describe our the core SilverStripe team manage their own projects:

*  [installation-into-subversion](installation-into-subversion)
*  [environment-management](environment-management)

You might also be interested in some of these related topic:

*  [http://silverstripe.org/download](http://silverstripe.org/download)
*  [upgrading](upgrading)
*  [installing-modules](installing-modules)
*  [server-requirements](server-requirements)
*  [daily-builds](daily-builds)
*  [common-problems](common-problems)
