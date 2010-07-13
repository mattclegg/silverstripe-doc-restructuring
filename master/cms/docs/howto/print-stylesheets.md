# Adding a Print Stylesheet

You can add a print stylesheet to you site by adding a Stylesheet to the css folder in your theme and including it via the [Requirements](http://doc.silverstripe.com/doku.php?id=requirements) class in your code files. 

First task is to create a __MyPrintFile.css__ file in __themes/yourtheme/css/__.

** themes/yourtheme/css/MyPrintFile.css **

	:::css
	/* Print Stylesheet */
	/* Do Things! */


You then need to open **mysite/code/Page.php** and add a Requirements::themedCSS() call to your css file.

** mysite/code/Page.php **

	:::php
	<?php
	 ...
	
	 class Page_Controller extends ContentController {
	
		function init() {
			parent::init();
	                ...
	                Requirements::themedCSS('MyPrintFile', 'print');
	       }
	}
	?>


[Requirements::themedCSS](http://doc.silverstripe.com/doku.php?id=requirements) will go to the folder themes/yourtheme/css and load the filename (first argument - 'MyPrintFile') and then the second argument - 'print' refers to the media type for the stylesheet - in this case we want a media="print" but you can use any of the media types available - http://www.w3.org/TR/REC-CSS2/media.html

