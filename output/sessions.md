# Sessions

SilverStripe provides a wrapper around PHP Session management. Sessions consist of a way to preserve certain data across
subsequent accesses to your website. This is useful for saving data for a user between page loads for example forms.

## Usage

### Saving Data

You can write a value to a users session from your PHP code using the static function Session::set(). You can add this
line in any function or file you wish to save the value.

	:::php
	function foo() {
		Session::set('MyValue', 6);
	}


Saves the value of "6" to the MyValue session data. You can also save arrays or serialized objects in session (but note
there may be size restrictions as to how much you can save)

	:::php
	function foo() {
		// save a variable
		$var = 1;
		Session::set('MyVar', $var);
	
		// saves an array
		Session::set('MyArrayOfValues', array('1','2','3'));
	
		// saves an object (you'll have to unserialize it back)
		$object = new Object();
	
		Session::set('MyObject', serialize($object));
	}


### Accessing Data

Once you have saved a value to the Session you can access it by using the Session::get() function. Like the
Session::set() function you can use this anywhere in your PHP files.

The values in the comments are the values stored from the previous example.

	:::php
	function bar() {
		$value = Session::get('MyValue'); // $value = 6
		$var   = Session::get('MyVar'); // $var = 1 
		$array = Session::get('MyArrayOfValues'); // $array = array(1,2,3)
		$object = Session::get('MyObject', unserialize($object)); // $object = Object()
	}


You can also get all the values in the session at once. This is useful for debugging.

	:::php
	function bar() {
		$session = Session::get_all(); // returns an array of all the session values.
	}

### Clearing Data

Once you have accessed a value from the Session it doesn't automatically wipe the value from the Session, you have to
specifically remove it. To clear a value you can either delete 1 session value by the name that you saved it

	:::php
	function baz() {
		Session::clear('MyValue'); // myvalue is no longer 6.
	}


Or you can clear every single value in the session at once. Note SilverStripe stores some of its own session data
including form and page comment information. None of this is vital but clear_all will clear everything.

	:::php
	function baz() {
		Session::clear_all();
	}


##  Related 

See [Cookies](cookies)

## API Documentation

http://api.silverstripe.org/2.4/sapphire/control/Session.html 
