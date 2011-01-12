# DropdownField

Created from a select tag.

{{:dropdownfield.png|:dropdownfield.png}}


### Examples

##### Setting a has_one relation
Using here an example of an art gallery, with Exhibition pages, each of which has a Gallery they belong to.  The Gallery
class is also user-defined.

	:::php
	...
		static $has_one = array(
			'Gallery' => 'Gallery',
		);
	
		public function getCMSFields() {
			$fields = parent::getCMSFields();
			$galleries = DataObject::get('Gallery');
			if ($galleries) {
				$galleries = $galleries->toDropdownMap('ID', 'Title', '(Select one)', true);
			}
			$fields->addFieldToTab('Root.Content.Main', new DropdownField('GalleryID', 'Gallery', $galleries), 'Content');
	....


As you see, you **need** to put GalleryID, rather than Gallery here.

##### Populate with Array

	:::php
	class MyObject extends DataObject {
	  static $db = array(
	    'Country' => "Varchar(100)"
	  );
	}			


	:::php
	$array = array(
	  'NZ' => 'New Zealand',
	  'US' => 'United States'
	  'GEM'=> 'Germany'
	);
	
	$field = new DropdownField(
	  'Country',
	  'Country',
	  $array
	);


##### Populate with Enum-Values

You can automatically create a map of possible values from an
[Enum](http://api.silverstripe.org/current/sapphire/model/Enum.html) database column.

	:::php
	class MyObject extends DataObject {
	  static $db = array(
	    'Country' => "Enum('New Zealand,United States,Germany','New Zealand')"
	  );
	}			


	:::php
	$field = new DropdownField(
	  'Country',
	  'Country',
	  singleton('MyObject')->dbObject('Country')->enumValues()
	);


### API documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-basic/DropdownField.html).

