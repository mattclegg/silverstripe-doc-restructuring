To *loop through* a folder from the Assets, you can use something like this in your php:

	:::php
	$object = DataObject::get('File', "Filename LIKE 'assets/myFolder%'");
	foreach($object as $file) {
	 $list .= $file->Title;
	}

