# updating records in a class

The simple code below shows you how to update records in, for example, a page class:

Add the following code to the controller of your class.  To run it, all you need to do is to visit

www.yoursite.com/myDocumentPage/updateDatabase

	:::php
	 function updateDatabase() {
	  $obj = DataObject::get("DocumentPage");
	  foreach($obj as $page) {
	    
	    //add whatever record you want to change here
	    $page->Content = "a long story";
	    $page->MetaKeywords = "key,word, meta, data";
	    $page->Title = "New Title";
	    
	     // some debug information
	    echo "updating ".$page->URLSegment.'::::::::::::';
	    
	    //how to save and publish
	    $page->writeToStage("Stage");
	    $page->publish("Stage", "Live");
	    
	    //separate debug messages
	    echo `<hr />`;
	  }
	 }
	


