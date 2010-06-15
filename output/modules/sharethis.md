# ShareThis Module

The ShareThis module enables automatic inserting of Social Bookmarks on Silverstripe sites. By default it comes packed with support for 10 of the most well know services including [ Digg](http://digg.com/ ) and [del.icio.us](http://del.icio.us/). Perfect addition to your blog or News installation!

## Maintainer
This module was created as part of the Google Summer of Code 07 program. ShareThis was created and maintained by Lakshan Perera.

## Download
*  [0.1](http://open.silverstripe.com/changeset/latest/modules/sharethis/tags/0.1?old_path=/&filename=/modules/sharethis/tags/0.1&format=zip) (Latest Release)
*  [Daily Build](http://open.silverstripe.com/changeset/latest/modules/sharethis/trunk?old_path=/&filename=/modules/sharethis/trunk&format=zip) ("trunk")

### Installing

*  Rename the extracted directory to "sharethis" and place in the root of your silverstripe installation.
*  Run /db/build/

*  Configure the module for your preference by editing _config.php (you could select the icons you want to appear)

*  Add the variable '$ShareThis' to the position you want to display the icons in your page template. (This step is REQUIRED to display the icons) 

*  Enable the ShareThis icons for each page via the CMS (to enable Go to Behaviour Tab and select the ShareThis checkbox) 

# Config Options

Options you can enable in the _config.php file via method calls -

### ShareIcons::$EnabledIcons = array()
The icons/services you will to enable for the module. 
##### Values
*  email
*  print
*  digg
*  reddit
*  delicious
*  furl
*  ma.gnolia
*  newsvine
*  live
*  myweb
*  google
*  stumbleupon
*  simpy 
##### Examples
** mysite/_config.php **
~~~ {php}
/* Will Show Digg this and Googlize this post buttons */
ShareIcons::$EnabledIcons = array('digg','google');
~~~

### ShareIcons::$IconTransparent = boolean
Do you want the icons for each of these services transparent? Then set this to true.
