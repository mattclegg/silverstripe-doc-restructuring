# Adding a dynamic default value to a field

If you wand to add a dynamic default value to a field you need to use populateDefaults(), not the defaults array (static $defaults).

Here's a simple example for a Date field to insert the current date by default:

~~~ {php}
/**
 * overload so that the default date is today.
 */
public function populateDefaults(){
	date_default_timezone_set('Australia/Sydney');
	parent::populateDefaults();
	$this->Date = date("Y-m-d");
}
~~~

If you need to retrieve a value from another object, you can do this:

~~~ {php}
/**
 * Our object is a City, we'd like to store the abbreviation of the state
 * with it, to make pretty names easier to produce
 */
   public function populateDefaults()
	{
		parent::populateDefaults();
		$parent_object = $this->getParent();
		if (is_object($parent_object))
			{
				$this->State = $parent_object->getField('Abbreviation');	
			}
		if ($this->Title != '')
			{
				$this->PrettyName = $this->Title . ", " . $this->State;
			}
	}
~~~
