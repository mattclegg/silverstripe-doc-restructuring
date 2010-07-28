# BBcode support

Yes! SilverStripe supports BBCode

*  A bbcode tags help box shows when the "BBCode help" link is clicked. Javascript is required for this to work.
*  It has been encorporated as a modified version of PEAR's
[HTML_BBCodeParser](http://pear.php.net/package/HTML_BBCodeParser)
*  BBCode is used by default in blog and forum.

To add bbcode parsing to a template, instead of $Content use:

	:::php
	$Content.Parse(BBCodeParser)


BBCode can be enabled in comments by adding the following to _config.php

	:::php
	PageComment::enableBBCode();




## Currently Supported Tags
