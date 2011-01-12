# Introduction

Most Silverstripe objects (anything that can be placed in a template) inherit from ViewableData.

## Casting as objects

Every scalar (string, int, etc) value that comes from the database or a method call can be "casted" to an appropriate
object.  The primary use for this facility is in templates.

*  $OrderDate will call Date::value(), returning 2005-06-12

*  $OrderDate.[NZDate](NZDate) will call Date::NZDate(), returning 12/06/2005

However, you can also by calling $myObject->obj("OrderDate") instead of $myObject->OrderDate.

The class that it uses is found in either ParentClass:$db or ParentClass:$casting.  This is an array of field names to
class definitions:

	:::php
	static $db = array(
	  "Title" => "Varchar(255)",
	  "Price" => "Currency(5,3)",
	);
	
	static $casting = array(
	  "CalculatedField" => "Date",
	  "OtherPrice" => "Currency",
	);



## Casting as values

You can also cast an object to a value by calling $myObject->val("OrderDate").

*  If $myObject->OrderDate or $myObject->OrderDate() is a value already, it just returns that value

*  If $myObject->OrderDate or $myObject->OrderDate() is an object, it will return $myObject->OrderDate->value().

Note that for stable performance, $myObject->obj("OrderDate")->value() should return the same thing as
$myObject->OrderDate.


*  If you want to cast a single value without a specific object-relation use the following code. Consider using
[DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html)->castedUpdate() instead when saving back
casted values to a DataObject.

	:::php
	DBField::create('Date', $_REQUEST['DateEntered'])->RAW()



## Caching

The results of method calls can be cached for efficiency.

*  If you define a method as _Name() instead of Name(), that is, you prefix it with an underscore, the value of the
function will be cached.  You should call it as $obj->Name().  $obj->_Name() will be called the first time but not any
subsequent times.

*  If you call $obj->flush("Name,arg1,arg2"), the value of the method call will be uncached.

*  If you call $obj->flush(), the value of all method calls will be uncached.

## Failover

When you have a PageController, any methods that are not defined in PageController will be given to a Page object for
processing.  In effect, the controller "fails over" to the data object.  This idea of failover is useful in other places
- for example, the OrderItem object fails over to the linked Product object.


*  If you override the failover() method, and make it return an object, any unhandled method calls or field references
will be handled by the object returned.

	:::php
	function failover() {
	    return $this->data;
	}

