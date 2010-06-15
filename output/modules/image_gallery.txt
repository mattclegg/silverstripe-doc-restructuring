### Introduction

The Image Gallery module facilitates the management and display of photos on your website. An extension to the [DataObjectManager](DataObjectManager) module, It features:

*  A bulk uploader
*  Caption editing
*  Drag-and-drop reordering
*  An image resizing tool
*  Image rotation
*  All other features of the DataObjectManager not listed here.

The ImageGallery module also comes bundled with 7 different open source photo viewers including Lightbox, NyroModal, and PrettyPhoto.

### Requirements

Silverstripe 2.3


### Installation

First, follow the instructions for the installation of the [DataObjectManager](DataObjectManager), and [swfupload](swfupload). Run a /dev/build, and place the image_gallery folder in your Silverstripe root. Run another /dev/build.

### Creating an ImageGallery

After creating a new ImageGalleryPage in the CMS, the a new folder will be created for your ImageGallery in:

// assets/ImageGallery/MyImageGalleryPage //

You may now configure your ImageGallery on the //Configuration// tab.

{{:modules:imagegallery_4.png|:modules:imagegallery_4.png}}

*  //Album cover images (width and height)//: The width and height of the album cover images displayed on the main page of your ImageGallery

*  //Thumbnail size / Normal size//: The size, in pixels, of the thumbnails and full-size images, respectively

*  //Number of Images per page//: The number of thumbnail images that will be displayed on each page of the ImageGallery

*  //Popup style//: The javascript popup UI that will be used to display the full-size images.

### Adding an Album

{{:modules:imagegallery_1.png|:modules:imagegallery_1.png}}

All images must go into an album. By default, a new ImageGallery page creates "Default Album" for you to start adding images. You may modify its title or leave it as is. Saving the album will create its folder in:

// assets/ImageGallery/MyImageGalleryPage/MyAlbum //

### Adding Images

After having created the albums you wish to use, you may add Images to them on the //Photos// tab. Select the album you wish to upload to in the dropdown menu on the right-hand side. If your album does not appear or if the list is outdated, hit the //refresh// button.

{{:modules:imagegallery_2.png|:modules:imagegallery_2.png}}

Click the "Add Images to [Album Name]" button, and go through the upload/import process. If an image comes in with the wrong aspect ratio, use the //Rotate// feature.

{{:modules:imagegallery_5.png|:modules:imagegallery_5.png}}

After you have uploaded all of your images, you can manage them in the ImageGalleryManager. Use the image resizing tool to get a closer look at your images, or to give it a more macroscopic view.

{{:modules:imagegallery_3.png|:modules:imagegallery_3.png}}

### Single-Album Galleries

If you only have one album in your gallery, the ImageGalleryPage will bypass the album view and go straight to your album view.

### Getting Support

The Silverstripe forum is the best resource for support. The following thread has been very active:

http://www.silverstripe.org/all-other-modules/show/250910

### To Do

*  Allow video uploads

*  Allow slideshow presentation

