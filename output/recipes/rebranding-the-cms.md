Some of our clients like to rebrand the CMS.

In SilverStripe 1, we had a lot of control in places where it wasn't really necessary.  In SilverStripe 2, I've focused
the rebranding support on the areas where it's actually useful.


*  The name of the application, with the exception of help.

*  The logo / name in the top-right.

LeftAndMain has two methods that help with this:


*  LeftAndMain::setApplicationName("something"): This will change the name of the application to "something".  As much
as possible, this name is used throughout the system.

*  LeftAndMain::setLogo("http://www.something.com/my-logo-file.gif", "padding-left: 50px"): This will use
my-logo-file.gif as the logo instead.  It needs to fit into a bar 48px high.  The second argument lets you specify
additional CSS attributes to the logo element, to get the logo positioned correctly.  Note that when you set a logo, the
application text in the top-right disappears.
   * LeftAndMain::set_loading_image('somepath/something.gif'): This will set the loading screen used between AJAX
requests in SilverStripe

### Rebranding configurations

#### Cube Media
Add the following to _config.php

	:::php
	LeftAndMain::setApplicationName("Cube CMS");
	LeftAndMain::setLogo("http://test.totallydigital.co.nz/logos/cube-logo.jpg", "position: relative; left: 5px; margin-top: -3px; padding-left: 50px;");

