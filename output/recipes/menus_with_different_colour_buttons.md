# menu with fancy buttons

Sometimes you have a menu with different coloured buttons.  One way to identify the different buttons is to add do the
following:

	:::html
	`<li id="$URLSegment">`
	 `<a href="">`my menu link with button`</a>`
	`</li>`
	`<li id="$URLSegment">`
	 `<a href="">`my second menu link with button`</a>`
	`</li>`


This works nice (i.e. you can style the menu items in your css file using the ids provided) UNTIL.... your client
(inadvertently) changes the URL of the page or deletes the page.  Basically, if you use the strategy above, your CMS
comes with conditions attached. Not ideal.

Instead, you can add the following to your page_controller:

	:::php
	 function MainMenu() {
	  $i = 0;
	  $data = parent::Menu(1);
	  foreach($data as $page) {
	   if(!$page->ParentID) {
	    $i++;
	    $page->MenuCount = $i;
	   }
	  }
	  return $data;
	 }


Once added, you can create a menu like this:

	:::html
	 `<ul id="nav">`
	`<% control MainMenu %>`
	  `<li class="$FirstLast $LinkingMode" id="MenuItem{$MenuCount}">`
	   `<a href="$Link" title="Go to the $Title.XML page" class="$FirstLast $LinkingMode">`$MenuTitle.XML`</a>`
	  `<% if Children %>`
	   `<ul>`
	   `<% control Children %>`
	    `<li class=" $FirstLast  $LinkingMode">`
	     `<a href="$Link" title="Go to the $Title.XML page">`$MenuTitle`</a>`
	    `</li>`
	   `<% end_control %>`
	   `</ul>`
	  `<% end_if %>`  
	  `</li>`
	`<% end_control %>`
	 `</ul>`


You can now style this page using the following css:

	:::css
	 #MenuItem1 {background-image: url(myfancybutton.gif);} 
	 etc...



