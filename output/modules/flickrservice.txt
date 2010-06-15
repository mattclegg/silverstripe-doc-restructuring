## Introduction
Flickrservice provides you the ability to interact with the popular photo-sharing site [Flickr](http://www.flickr.com) from your SilverStripe based site. FlickrService class gives you access to the Flickr API via its RESTful interface, allowing you to play with Flickr photos. Based on FlickrService, we've included two ready made components under this module. Those are :
*  [FlickrGallery](FlickrGallery) page type -  create a image gallery based on Flickr photos (similar to SilverStripe's Gallery module)
*  FlickrWidget - show Flickr photos on your blog's sidebar

## Requirements
You need to use the version **2.2.0** of SilverStripe.

## Download
*  [0.2](http://open.silverstripe.com/changeset/latest/modules/flickrservice/tags/0.2?old_path=/&filename=/modules/flickrservice/tags/0.2&format=zip) (Latest Release)
*  [Daily Build](http://open.silverstripe.com/changeset/latest/modules/flickrservice/trunk?old_path=/&filename=/modules/flickrservice/trunk&format=zip) ("trunk")

## Module Installation
1.  Download (see above)
2.  After extraction, place this directory in the root of your SilverStripe installation
3.  Run db/build
4.  Apply for an API key from http://www.flickr.com/services/api/keys/apply/ and add the following line to file - mysite/_config.php; `FlickrService::setAPIKey('Your-API-KEY');`{php}
5.  The CMS should now have a "FlickrGallery" page type
6.  If you have blog module installed, you'll get FlickrWidget for blog module.


## Howto
*  [ Creating a FlickrGallery page](FlickrGallery ) 


## Related
*  [ FlickrService](/flickrservice) - documentation on flickr service class (how you can use it to create your own galleries)

*  [ FlickrGallery](FlickrGallery) - How to create a Flickr Gallery for your site

*  [ RestfulService](/restfulservice ) - the base class which enables 3rd party mashups
