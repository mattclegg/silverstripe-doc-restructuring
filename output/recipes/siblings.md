In templates, you can use `<% control Children %>` - but you can not use `<% Siblings %>`.  Below is a little function
that you can add as shown:

	:::php
	class Page_Controller extends ContentController {
	 
	 function Siblings() {
	  $whereStatement = "ParentID = ".$this->ParentID;
	  return DataObject::get("Page", $whereStatement);
	 }
	}


You can change the $whereStatement as follows:

	:::php
	  $whereStatement = "ParentID = ".$this->ParentID." AND ID `<>` ".$this->ID;


Using the filter above means that the current page is excluded from the siblings. In your templates (Page.ss), you can
use the Siblings as follow (just an example):

	:::html
	 `<% control Siblings %>`
	     `<li>`
	      `<a href="$Link" class="$FirstLast $LinkingMode">`$MenuTitle.XML`</a>`
	     `</li>`
	 `<% end_control %>`


