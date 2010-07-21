# Creating a simple image uploader

Creating a simple image uploader in SilverStripe is relatively easy. In this example we want to create a banner image
that will extend across all pages of our site, this banner will be able to be different on each page of the site.

### Step 1: Set up the Database!

First we need to add an image field to our page so we have somewhere to store our image. Open up the Page type you want
to add the image uploader to. For example we will use Page.php which is located in mysite/code/. So go ahead and open
that up.

If we want to add an Image to our database we need to add it in the $has_one array (at the top) of a type 'Image'

** mysite/code/Page.php **

	:::php
	 static $has_one = array(
	   'BannerImage' => 'Image'
	 );


Now visit yoursite.com/dev/build and recreate our database. 

###  Step 2: Add an image form to the CMS

We need to add a field to the CMS so that we can upload a image. So underneath that $db array we need to add this
getCMSFields function which overloads the CMS so we can add our field

** mysite/code/Page.php **

	:::php
	function getCMSFields() {
	  $fields = parent::getCMSFields();
	  $fields->addFieldToTab("Root.MyBannerImage", new ImageField("BannerImage"));
	  return $fields;
	}


Now reload the admin panel and you should be able to click a page and you should have a MyImage Tab

### Step 3: Mod the Template to output the image

If you upload the image at the correct size all you need to do to output that image is to add a $MyImage varible to the
template file.

** themes/blackcandy/templates/Page.ss **

	:::php
	..
	$BannerImage
	..


Thats all you need to do to create an image upload form and to output it in your template. But perhaps you want to do
some more fancy stuff with that image? Like dynamically resize it? Read on





## More Advanced Uses

We defined the Image field in the $has_one array as a type of Image. Now we can extend Image using our very own class
for that image field. Its really simple even though we declared it as a **Image** it is actually a class
NameOfPageClass_ImageName.

How does that work? well we created a Image field in the Page class called 'BannerImage' so in Page.php we can define
another class called Page_BannerImage which extends Image. This enables us to add methods to image. Eg generate
different versions of that same image!. In the example below we want our banner to be a set size without touching the
original image.

** mysite/code/Page.php **

	:::php
	class Page_Controller extends ContentController {
	  ...
	}
	class Page_BannerImage extends Image {
	
	  function generatePageBanner($gd) {
	    $gd->setQuality(100);
	    return $gd->paddedResize(619,154);
	  }
	
	}


Now, we need to change the has_one relation for the image:

** mysite/code/Page.php **

	:::php
	 static $has_one = array(
	   'BannerImage' => 'Page_BannerImage'
	 );


Lets step through this:

First we define a new class of Page_BannerImage. Remember the class is in the form of PageClass_ImageFieldName, in case
of this, a field of BannerImage in Page. *If you want to create an Image extention class that is not in this form it
must go into its own file, for example a class called 'BannerImage' would need to go into a file called
BannerImage.php.*

You can create any generate function, eg. function generateThumbnail, or function generateBanner. This allows us to
create multiple versions of the same image, for example thumbnails and large versions for a news feed.

$gd->setQuality defines the JPEG compression of the image. 100 being the best and taking the most space, 0 being the
worst and using the least space. 85% is convidered very high quality, 70% high, 50% ok, 30% poor. About 70-60% should be
good for most images.

return $gd->paddedResize is telling the GD libraries to resize at this size, padded (so that nothing of the image is
cropped). You can also use 'croppedResize' over 'paddedResize', so that it crops the image to the specified dimensions
if the image is large. (619,154) in this example means the image will be 619px in width, and 154px in height. See
http://doc.silverstripe.com/doku.php?id=gd for the various methods you can call.

## Using it in your template

	:::html
	<% if BannerImage.PageBanner %>
	 <img class="headerImage" src="$BannerImage.PageBanner.URL" alt="Header banner" />
	<% else %>
	 <% control Page(home) %>
	  <img class="headerImage" src="$BannerImage.PageBanner.URL" alt="Header banner" />
	 <% end_control %>
	<% end_if %>


Above is an example of using the BannerImage code that I wrote above in the Page.ss template.

$BannerImage is taken from the name of the image field, and PageBanner is the generated image (from the method
generatePageBanner). If I was to have another one called generateThumbnail then I would call it like this:

$Banner.Thumbnail.URL

This goes inside your <img> tag as the src attribute.

You may also notice that there is else logic in this statement. What this does it use the banner from the Home page if
subsequent pages don't have one uploaded yet. This is a simple way of making the template fall back to using a 'default'
banner.

You can also call [GD functions](http://doc.silverstripe.com/doku.php?id=gd) from the template, which will call the same
image generation functions.

	:::html
	<div id"Image">
	<% control Image %>
	  <% control ResizedImage(150,50) %>
	   <img src="$URL" alt="My resized Image" width="150px" height"50px" />
	  <% end_control %>
	 <% end_control %>
	</div>


## Template Image Resizing Functions

There is alot of functions available on the image class to make your life easier and cleaner. For a list of functions
that you can call see http://doc.silverstripe.com/doku.php?id=gd



## Form Image Upload

See [simpleimagefield](simpleimagefield)
