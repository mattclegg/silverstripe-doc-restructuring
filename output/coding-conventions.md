# Coding Conventions

The following page should be used to outline the best practices to use while your developing using SilverStripe. They
should be followed as close as possible for modules and your core patches

## PHP Code

### Naming

Class and File Names Are in UpperCamelCase

	:::php
	class MyNewSilverStripeClass { 
	// ...
	}


Static methods should be in lowercase_with_underscores() format.

	:::php
	static function find_my_test_method() { 
	// ..
	}


Action handlers on controllers should be in $this->completelylowercase() format without spaces or underscore  This is
because they go into the controller URL in the same format (eg, home/successfullyinstalled).

	:::php
	function displayformresults() {
	//...
	}


Methods that will be callable from templates should be in $this->UpperCamelCase() format.  This is because they go into
the templates in the same format. If its retrieving a value you can append a get to the function in PHP. For example
both the following work

	:::php
	$MyPieceOfData
	
	// either have
	function MyPieceOfData() { 
	// ..
	}
	
	// or this will work as well
	function getMyPieceOfData() {
	// ..
	}


Other object methods should be in $this->lowerCamelCase() format

	:::php
	function doSomethingToThis() {
	// ..
	}


Classes need to be in a file of the same name. If a class name has an underscore, then the file name has to be the text
before the underscore.  For example Foo and Foo_Helper will both need to be placed into **Foo.php**.

** mysite/code/Foo.php **

	:::php
	<?php
	
	class Foo {
	// ..
	}
	
	class Foo_Controller {
	// ..
	}
	
	class Foo_OtherRelatedClass {
	// ..
	}
	


To help with namespacing common class names (like Database) it is recommended to use the convention **SS_ClassName** but
the filename will remain ClassName.php. Eg SS_Database is in Database.php

** mysite/code/MyCommonClassName.php **

	:::php
	<?php
	
	class SS_MyCommonClassName {
	//..
	}
	
	class SS_MyCommonClassName_OtherClass {
	//...
	}
	


### Indentation

Always use hard tabs rather then spaces for indentation. 1 hard tab per nesting level.

	:::php
	class CorrectIndentationExample {
	
		function foo() {
			return true;
		}
	}


### Coding

Start all your php script files with <?php.  Don't use <?.

	:::php
	<?php 
		// good

	:::php
	<? 
		// bad


Don't end your PHP file with ?>. Leave it blank. This prevents any whitespace which can generate errors in your code

	:::php
		// good
		}
	}


	:::php
		// bad
		}
	}
	?>


Keep the opening brace on the same line as the statement. 

	:::php
	function foo() {
		// good
	}
	
	function bar() 
	{
		// bad
	}


Try to avoid using PHP's ability to mix HTML into the code.

	:::php
	function getTitle() {
		return "<h2>Bad Example</h2>"; 
	}
	
	$Title


	:::php
	function getTitle() {
		return "Better Example";
	}
	
	`<h2>`$Title`</h2>`



Check for value before stepping into a foreach-loop

	:::php
	if($A_authors) {
	  foreach($A_authors as $author) {}
	}


### Class File Organization

Put code into the classes in the following order.  Obviously, if one of these isn't used by a class then leave it out.

*  Other static variables (don't put these just before the method where they're used)

*  Object variables

*  Static methods

*  Data-model definition static variables.  ($db, $has_one, $many_many, etc)

*  Commonly used methods like getCMSFields

*  Accessor methods (getFieldname and setFieldname)

*  Controller action methods

*  Template data-access methods (methods that will be called by a $MethodName or `<% control MethodName %>` construct in
a template somewhere)

*  Object methods

	:::php
	<?php
	
	class MySilverStripeClass {
	
		/**

		 * @var String My Variable
		 */
		static $foo = "Foo";
	
		/**

		 * Field Definitions
		 */
		static $db = array(
			'Bar' => 'Varchar'
		);
	
		static $has_one = array(
			'Baz' => 'Page'
		);
	
		static $has_many = array(
			// ...
		);
	
		// $many_many, $belongs_many_many, $defaults, $field_labels ...
	
	
		function getCMSFields() {
			// ..
		}
	
		function getFoo() {
			return self::$foo;
		}
	}

### Variables

*  Static variables should be ''self::$lowercase_with_underscores''

*  Object variables should be ''$this->lowerCamelCase''

*  Globals should be ''$_UPPERCASE_WITH_UNDERSCORES''.  Note the preceding underscore.

*  Use the same [escape-formats](escape-formats)listed above.

*  Defines should be UPPERCASE_WITH_UNDERSCORES (no preceding underscore required). Use defines wherever possible:
Numbers shouldn't be hard-coded into the code.

	:::php
	define('INTEREST_RATE', 0.1995);


*  wherever possible, set up static variables like this:

	:::php
		protected static $amount = 50;
	
		protected static $title = 'default title';
	
		static function set_amount($amount) {
			self::$amount = $amount;
		}
		
		static function get_amount() {
			return self::$amount;
		}
	
		static function set_title($title) {
			self::$title = $title;
		}
	
		static function get_title() {
			return self::$title;
		}
		 ....
	}


### Comments

*  Use the docblock syntax before class and each method. For class's have a description and what package they are
contained in. Include (@todo, @see as needed). Methods include @param, @return and @see as appropriate.  Include a blank
line after the description. 

	:::php
	/** 

	 * My Custom Class
	 * This class is a demo class for testing
	 * 
	 * @package custom
	 */
	 class MyClass extends Class {}
	
	/**

	 * My Method.
	 * This method returns something cool. @see MyParentMethod has other cool stuff in it.
	 * 
	 * @param string $colour The colour of cool things that you want
	 * @return DataObjectSet A list of everything cool
	 */
	public function myMethod($foo) { }
	


## SQL

### Escaping Values


*  Always convert values you get from the user before you do SQL queries.

	:::php
	$value = Convert::raw2sql($value);


### Writing Queries for Database Abstraction

*  To make sure your code works across databases make sure you escape your queries like below, with the column or table
name escaped with double quotes and values with single quotes.

	:::php
	DataObject::get("MyClass", "\"Title\" = 'my title'");


##  Security 

See [secure-development](secure-development) for conventions related to handing security permissions.
## HTML / CSS / JS


*  See [html](html)

*  See [css](css)

*  See [javascript](javascript)

## Links


*  **http://www.perforce.com/perforce/papers/prettycode.html**

*  **http://www.joelonsoftware.com/articles/Wrong.html**

*  http://en.wikipedia.org/wiki/Coding_standards

*  Zend Standards, better: http://framework.zend.com/manual/en/coding-standard.html

*  Mozilla, good mix of inline/newline-brackets: http://www.mozilla.org/hacking/mozilla-style-guide.html#Visual

*  http://en.wikipedia.org/wiki/Programming_style

*  Java: http://java.sun.com/docs/codeconv/html/CodeConvTOC.doc.html
