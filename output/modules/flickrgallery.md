# Introduction

Similar to Gallery page you can create a Flickr Gallery page. This page type is available with the
[FlickrService](FlickrService) module.

## Download

* 
[0.2.2](http://open.silverstripe.com/changeset/latest/modules/gallery/tags/0.2.2?old_path=/&filename=/modules/gallery/tags/0.2.2&format=zip)
(Latest Release)

*  [Daily
Build](http://open.silverstripe.com/changeset/latest/modules/gallery/trunk?old_path=/&filename=/modules/gallery/trunk&format=zip)
("trunk")

##   Demo

*  http://demo.silverstripe.com/gallery/

## Creating a new Flickr Gallery

*  Download and install [FlickrService](FlickrService) module.

*  In the CMS create a new FlickrGallery page.

*  Give a suitable title and a content paragraph to the page.

*  Then switch into Photos tab.

*  Select which section of photos you want to display (Photos taken by, Photos tagged with and Photos from photoset)

*  Following fields are required to be filled based on what you selected above :
     * Photos taken by => Flickr User (this should be Flickr public name *not* a flickr ID) and Tags(optional)
     * Photos tagged with => Tags(separated by commas)
     * Photos from photoset => Flickr User (owner of the photoset, again the public name) and Photoset Id (a unique
number found at last in flickr photoset URL)

*  Give number of photos to display

*  Select Sort order - Most Interesting or Most Recent

## Screenshots

{{:modules:flickr-service-admin.png|:modules:flickr-service-admin.png}}
{{:modules:flickr-service-site-demo.png|:modules:flickr-service-site-demo.png}}
