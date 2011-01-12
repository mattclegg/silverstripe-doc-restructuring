If you have a group of fields in your dataobject (e.g. $shout1, $shout2, $shout3) and you would like to group them so
that you can loop through them in your template then this code may help (add to controller for the page):

	:::php
	function MyShouts() {
	  $doSet = new DataObjectSet();
	  for($i = 1; $i < 3; $i++) {
	    $field = "shout".$i;
	    if($this->$field) {
	      $record = array(
	        'ShoutTitle' => $this->field,
	        'Number' => $i
	        'RandomNumber' => Rand(0, 3000)
	      );
	      $doSet->push(new ArrayData($record));
	    }
	    else {
	      break;
	    }
	  }
	  return $doSet;
	}


To access this in a template, use: 

	:::html
	`<ul>`
	  `<% control MyShouts %>`
	    `<li>`$Number: shout: $ShoutTitle ($RandomNumber) `</li>`
	  `<%  end_control %>`
	`</ul>`


This should display:

 1.  1. YES! (1342)
 2.  2. NO! (1332)
 3.  3. SOME OTHER SHOUT! (38)


Similarly, if you have fields in your dataobject (page) like $image1, $image2, $image3 (i.e. images, which are
dataobjects in their own right), you can group into a new dataobject to access them as a group in your template.  Here
is an example (Add to controller for the page):

	:::php
	function MyImages() {
	  $doSet = new DataObjectSet();
	  for($i = 1; $i < 3; $i++) {
	    $field = "Banner".$i."ID";
	    $imageID = intval($this->$field + 0);
	    if($imageID) {
	      $imageObject = DataObject::get_by_id("Image", $imageID);
	      $fileName = Convert::raw2js($imageObject->Filename);
	      $title = Convert::raw2js($imageObject->Title);
	      $record = array(
	        'FileName' => $fileName, //which is a standard field in the image dataobject
	        'Title' => $title, //which is a standard field in the image dataobject
	        'Number' => $i,
	      );
	      $doSet->push(new ArrayData($record));
	    }
	    else {
	      break;
	    }
	  }
	  return $doSet;
	}
	


To access this in your template, you can use:

	:::html
	`<ul>`
	  `<% control MyImages %>`
	    `<li>``<img src="$FileName" alt="$Title" id="imageNumber{$Number}" />``</li>`
	  `<%  end_control %>`
	`</ul>`


Hope this helps.




