## Customising Image class output

Sometimes the default Image class can be too restrictive. The answer is to subclass [:Image](/Image) and define your own
custom functionality, so you have more freedom to customise the way your uploaded images can be resized and manipulated
in the templates.

So, we have our Page or [:DataObject](/DataObject) class set up with a relation to a custom Image class, this will be a
subclass of Image. For example:

	:::php
	
	class Page extends SiteTree
	
	...
	
	   static $has_one = array(
	      'Image' => 'Page_Image' // We define Page_Image, which is a subclass of Image
	   );
	
	...
	
	}
	
	class Page_Controller extends ContentController {
	
	...
	
	}


Then, we need to create the Page_Image class, which can go inside the same Page.php file to keep things tidier:

	:::php
	
	class Page_Image extends Image { // This class can go inside the same file as Page.php
	
	   function generateSmallimage($gd) {
	      return $gd->resizeRatio(289,177);
	   }
	
	   function generateLarger($gd) {
	      return $gd->paddedResize(100,150);
	   }
	
	}
	


For every "generate" prefixed function on your subclass of [:Image](/Image), SilverStripe will pick that up and allow it
to be used in the template. Each function must pass in a variable which is the GD object, so functions can be called on
it to produce different methods on outputting an image.

So, in your Page.ss template, you can now access two more methods on the $Image property, so in this case they would be
**$Image.Smallimage** as well as **$Image.Larger**, an arbitrary number of generate prefixed functions can be created,
which extends the customisation further. For example, you may 3 different types of thumbnails for an artwork image.

In the above example, we used ''resizeRatio()'' (which is useful for preserving aspect ratio while maintaining a maximum
height and width), as well as ''paddedResize()''. There's many more to use, so have a look at [:GD](/GD) to find out
what others are available!
