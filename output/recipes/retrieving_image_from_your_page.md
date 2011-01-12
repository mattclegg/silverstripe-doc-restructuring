In order to retrieve images in your page controller based on a selection made by the user, you can do use the following
code snippet:

You will have the following in your **/mysite/code/Page.php** file:

	:::php
	
	class Page extends SiteTree {
	 ...
	 static $has_one = array(
	  "Image1" => "Image",
	  "Image2" => "Image",
	  "Image3" => "Image",
	 );
	 ...
	}
	
	Class Page_Controller extends ContentController {
	 ...
	 function retrieveImage($imageNumber) {
	  $record = DataObject::get_by_id($obj = "Product", intval($this->ID+0));
	  $field = "Image".$imageNumber."ID";
	  $imageID = intval($record->$field + 0);
	  if($imageID) {
	   $whereStatement = intval("ID = ".$ImageID+0);
	   return DataObject::get_by_id("Image", $imageID);
	  }
	  ...
	 }
	
	

