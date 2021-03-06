# How to generate a smart list of alphabetically categorised items from a DataObjectSet

Let's say you've got a class called Film (which extends DataObject) and you want to output a list of films in
alphabetical order in a clean fashion with individual letter headings.

Something like this:
----


A:\\
Alien\\
Aliens\\
Animal House\\
B:\\
Back to the Future\\
Batman\\
...

----


The solution has 2 components, a function we've called Letters that looks like this:

----

	:::php
	function Letters() { 
	      $set = new DataObjectSet(); 
	      $letters = range('A','Z');
	      foreach($letters as $letter) { 
	         $filter = "Title Like '$letter%'"; 
	         $set->push(new ArrayData(array( 
	            'Letter' => $letter, 
	            'Listings' => $this->Films($filter,"Title ASC") 
	            )) 
	         ); 
	      } 
	      return $set; 
	}

----


And a corresponding template that looks like this:

----
`<html>`
`<% control Letters %>`
`<% if Listings %>`
`<h3>`$Letter`</h3>`
`<% control Listings %>`
`<p>`$Title`</p>`
`<% end_control %>`
`<% end_if %>`
`<% end_control %>`
`</html>`
----

Note: if you don't have a relationship available to grab films using $this->Films() you can always do it the old
fashioned way using this instead

	:::php
	'Listings' => DataObject::get('Films',$filter,'Title ASC');


