# Coding Conventions

This document provides guidelines for code formatting and documentation
to developers contributing to SilverStripe. It applies to all PHP files
in the sapphire/ and cms/ modules, as well as any supported additional modules.

Coding standards are an important aspect for every software project,
and facilitate collaboration by making code more consistent and readable.

If you are unsure about a specific standard, imitate existing SilverStripe code.

## Indentation

Always use hard tabs rather then spaces for indentation, with one tab per nesting level.

	:::php
	class CorrectIndentationExample {

		function foo() {
			return true;
		}
		
	}

## Method Naming

Class and filenames are in `UpperCamelCase` format:

	:::php
	class MyClass {}


Static methods should be in `lowercase_with_underscores()` format:

	:::php
	static function my_static_method() {}

Action handlers on controllers should be in `completelylowercase()` format without spaces or underscore. 
This is because they go into the controller URL in the same format (eg, `home/successfullyinstalled`).

	:::php
	function mycontrolleraction() {}

Object methods that will be callable from templates should be in `$this->UpperCamelCase()` format.  
Alternatively, `$this->getUpperCamelCase()` will work the same way in templates -
you can access both coding styles as `$UpperCamelCase`.

Other instance methods should be in `$this->lowerCamelCase()` format:

	:::php
	function myInstanceMethod() {}

Classes need to be in a file of the same name. If a class name has an underscore, then the file name has to be the text before the underscore.  
For example `MyClass` and `MyClass_Controller` will both need to be placed into `MyClass.php`.

Example: `mysite/code/MyClass.php`

	:::php
	<?php

	class MyClass {}

	class MyClass_Controller {}

	class MyClass_OtherRelatedClass {}

To help with namespacing common class names (like Database) it is recommended to use a prefix convention `SS_ClassName` but the filename will remain `ClassName.php`. 

## Variable Naming

 *  Static variables should be `self::$lowercase_with_underscores`
 *  Object variables should be `$this->lowerCamelCase`
 *  Globals should be `$_UPPERCASE_WITH_UNDERSCORES`.  Note the preceding underscore.
 *  Use the same [escape-formats](escape-formats) listed above.
 *  Constants should be `UPPERCASE_WITH_UNDERSCORES`

## Coding

Start all your php script files with `<?php`.  Don't use `<?`.
Don't end your PHP file with `?>`. Leave it blank. This prevents any whitespace which can generate errors in your code

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
	// PHP code
	function getTitle() {
		return "<h2>Bad Example</h2>"; 
	}

	// Template code
	$Title

Better: Keep HTML in template files:

	:::php
	// PHP code
	function getTitle() {
		return "Better Example";
	}

	// Template code
	<h2>$Title</h2>


Check for value before stepping into a foreach-loop

	:::php
	if($A_authors) {
	  foreach($A_authors as $author) {}
	}

## Comments

Use the docblock syntax before class and each method. For class's have a description and what package they are contained in. 
Include (`@todo`, `@see` as needed). Methods include `@param`, `@return` and `@see` as appropriate.  Include a blank line after the description. 

	:::php
	/** 
	 * My Custom Class
	 * This class is a demo class for testing
	 * 
	 * @package custom
	 */
	class MyClass extends Class {
	
		/**
		 * My Method.
		 * This method returns something cool. @see MyParentMethod has other cool stuff in it.
		 * 
		 * @param string $colour The colour of cool things that you want
		 * @return DataObjectSet A list of everything cool
		 */
		public function myMethod($foo) {}
		
	}
	
## Class Member Ordering

Put code into the classes in the following order (where applicable).

 *  Static variables
 *  Object variables
 *  Static methods
 *  Data-model definition static variables.  (`$db`, `$has_one`, `$many_many`, etc)
 *  Commonly used methods like `getCMSFields()`
 *  Accessor methods (`getMyField()` and `setMyField()`)
 *  Controller action methods
 *  Template data-access methods (methods that will be called by a `$MethodName` or `<% control MethodName %>` construct in a template somewhere)
 *  Object methods
	

## SQL

### Escaping Values

Always convert values you get from the user before you do SQL queries.

	:::php
	$value = Convert::raw2sql($value);

### Writing Queries for Database Abstraction

To make sure your code works across databases make sure you escape your queries like below, 
with the column or table name escaped with double quotes and values with single quotes.

	:::php
	DataObject::get("MyClass", "\"Title\" = 'my title'");


##  Security 

See [secure-development](secure-development) for conventions related to handing security permissions.