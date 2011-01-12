# creating a *special* menu


Imagine you want to make something like a "commonly requested pages" menu on your site, but these pages are all over
your site. The solution below shows you an elegant way to do this that also allows the website admin to change this
menu.

Add the following to **/mysite/code/Page.php**

	:::php
	
	class Page extends SiteTree {
	 static $db = array(
	  "ShowInTabMenu" => "Boolean"
	 );
	
	 function getCMSFields() {
	  $fields = parent::getCMSFields();
	  $fields->addFieldToTab("Root.Behaviour", new CheckboxField("ShowInTabMenu", "Show special menu "));
	  return $fields;
	 }  
	   
	}
	
	class Page_Controller extends ContentController {
	 function init() {
	  parent::init();
	 }
	 
	 function topTabbers() {
	  $whereStatement = "ShowInTabMenu = 1 AND ShowInMenus = 1";
	  return DataObject::get("Page", $whereStatement); 
	 }
	}
	


and add the following to your **/mysite/templates/Page.ss** file

	:::html
	`<% control topTabbers %>`
	   `<li class="$FirstLast $LinkingMode">``<a href="$Link" title="Go to the $Title.XML page">``<span>`$MenuTitle.XML`</span>``</a>``</li>`
	`<% end_control %>`

