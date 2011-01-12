# FlickrService

You can use FlickrService to create mashups based on Flickr's data API. This class comes with built-in ability to
retrieve photos based on tags, user or photoset. You can further extend it to suit your requirements. 

Refer [Flickr API](http://www.flickr.com/services/api) for more methods.

#### Setting the API key

*  First of all you have to set the API key for the flickr service (which is obtainable from
http://www.flickr.com/services/api/keys/) in the _config.php file in the mashups module directory. 

	
	    FlickrService::setAPIKey('c88164229499662e1497335950c61eeb'); 


#### Implementing to Flickr Service

*  First you have to create a new FlickrService object in your controller.

	
	    $flickr = new FlickrService();


#### Searching for photos

*  By using getPhotos method you could search for photos of a particular tag or user.

*  To find photos by tags pass the tag names separated by commas as the first argument.

	
	        $photos = $flickr->getPhotos("cricket,football");


*  If you want to find photos of a particular user you can pass the Flickr username of that user as a string.
 * To control the number of images per page use the 3rd argument, where you could pass in the number of images you need.

	
	    $photos = $flickr->getPhotos("", "username", 5);

 
#### Getting a Photoset

*  to retrieve a photoset use the following function.

	
	      	$photos = $flickr->getPhotoSet("photoset-id", "username", limit);


#### Displaying Flickr Photos

*  To display your photos you could have the following code in your template.

	
	      `<% control FlickrPhotos.PhotoItems %>`
		<a href="$page_url"><img src="http://farm1.static.flickr.com/{$image_path}_s.jpg"/></a>
	      `<% end_control %>`

 
 
