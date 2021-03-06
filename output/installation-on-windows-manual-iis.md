This page explains installing SilverStripe manually, without the use of (the easy to use) Web Platform Installer, and
instead of Apache on Windows. See [installation-on-windows](installation-on-windows) to learn about those ways to
install SilverStripe on Windows.
## IIS 7.x

IIS 7.x ships with Windows Vista and Server 2008 or later.

A [full guide is available](installation-on-windows-server-manual-iis) on installing SilverStripe on Windows Server,
Windows Vista, Windows Server 2008 R2 or Windows 7.



## IIS 6

IIS 6 ships with Windows Server 2003.

This guide will help you get SilverStripe installed on IIS 6 and use a third-party tool called IIRF for rewriting:
http://doc.silverstripe.org/installation-on-windows-server-2003-iis-6

## Installing on IIS 5.1 and 6.0


*  Microsoft has no URL rewriting module for anything less than IIS 7.x. This will mean your URLs are like
yoursite.com/index.php/about-us rather than yoursite.com/about-us. However, if you do want friendly URLs you must you
must buy or use other URL rewriting software: 
    * IIRF: http://iirf.codeplex.com/
    * ISAPI_Rewrite: http://www.helicontech.com/download-isapi_rewrite3.htm
       * (The freeware, lite version should be fine for simple installations.)
    * If you have 64-bit windows, you can try this one: 
        * http://www.micronovae.com/ModRewrite/ModRewrite.html

*  Instructions for installing PHP IIS 5.1 and 6 may be different that for 7. See
http://learn.iis.net/page.aspx/248/configuring-fastcgi-extension-for-iis60/

*  On XP, you need to disable 'Check that file exists' (See [installation-on-windows-pi](installation-on-windows-pi))

Matthew Poole has expanded on these instructions with this tutorial:
http://cubiksoundz.blogspot.com/2008/12/tech-note-installing-silverstripe-cms.html
