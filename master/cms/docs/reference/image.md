# Introduction

Represents an image object, inheriting all base functionality from the [file](file) class with extra functionality including resizing.

# Usage

## Form Fields

*  `[api:Image]`. Designed to provide a complex image uploader for the CMS.
*  [SimpleImageField](SimpleImageField). A Simple Image Upload Form
*  See [recipes:imageupload](recipes/imageupload) for a example

## Resizing Images in PHP

The following are methods defined on the GD class which you can call on Image Objects. Note to get the following to work you need to have GD2 support in your PHP installation and because these generate files you must have write access to your tmp folder. 

	:::php
	// manipulation functions
	$image->resize(width,height); // Basic resize, just skews the image
	$image->resizeRatio(width,height) // Resizes an image with max width and height
	$image->paddedResize(width,height) // Adds padding after resizing to width or height.
	$image->croppedResize(width,height) // Crops the image from the centre, to given values.
	$image->resizeByHeight(height) // Maximum height the image resizes to, keeps proportion
	$image->resizeByWidth(width) // Maximum width the image resizes to, keeps proportion 
	$image->greyscale(r,g,b) // alters image channels ===
	
	// values
	$image->getHeight() // Returns the height of the image.
	$image->getWidth() // Returns the width of the image
	$image->getOrienation() // Returns a class constant: ORIENTATION_SQUARE or ORIENTATION_PORTRAIT or ORIENTATION_LANDSCAPE


## Resizing in Templates

You can call certain resize functions directly from the template, to use the inbuilt GD functions as the template parser supports these, for example SetWidth() or SetHeight().  

For output of an image tag with the image automatically resized to 80px width, you can use:

	:::php
	$Image.SetWidth(80) // returns a image 80px wide, ratio kept the same
	$Image.SetHeight(80) // returns a image 80px tall, ration kept the same
	$Image.SetSize(80,80) // returns a 80x80px padded image
	$Image.SetRatioSize(80,80) // **New in 2.4** returns an image scaled proportional, with its greatest diameter scaled to 80px
	$Image.PaddedImage(80, 80) // Returns an 80x80 image. Unused space is padded white. No crop
	$Image.Width // returns width of image
	$Image.Height // returns height of image
	$Image.Orientation // returns Orientation
	$Image.Filename // returns filename
	$Image.URL // returns filename


## Form Upload

For usage on a website form, see [recipes:imageupload](recipes/imageupload) and [simpleimagefield](simpleimagefield).
If you want to upload images within the CMS, see [imagefield](imagefield).

## Clearing Thumbnail Cache

Images are (like all other Files) synchronized with the SilverStripe database.
This syncing happens whenever you load the "Files & Images" interface,
and whenever you upload or modify an Image through SilverStripe.

If you encounter problems with images not appearing, or have mysteriously disappeared, you can try manually flushing the image cache.

	
	http://www.mysite.com/images/flush

# Examples

*  [Insert an ImageField into the CMS](recipes/imageupload)

# API Documentation

*  [Click here for the Image API documentation](http://api.silverstripe.org/trunk/sapphire/Image.html).
*  [Click here for the GD API documentation](http://api.silverstripe.org/trunk/sapphire/GD.html)
