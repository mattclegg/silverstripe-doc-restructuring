# RESTfulServer

## Introduction
This class gives your application a RESTful API for free.  All you have to do is define static $api_access = true on the appropriate DataObjects.  You will need to ensure that all of your data manipulation and security is defined in your model layer (ie, the DataObject classes) and not in your Controllers.  This is the recommended design for Sapphire applications.

See [soapmodelaccess](soapmodelaccess) for a SOAP wrapper about RESTfulServer.

## Requirements
*  //SilverStripe 2.3//

## Usage


### Datamodel
Example DataObject with simple api access, giving full access to all object properties and relations,
unless explicitly controlled through model permissions. Methods are added to override access control methods defined with DataObject::canEdit(), DataObject::canView(), and DataObject::canCreate(). These methods may be customized for precise access control to the object, in general.

~~~ {php}
class Article extends DataObject {
	static $db = array('Title'=>'Text','Published'=>'Boolean');
	static $api_access = true;
	function canEdit() { return true; }
	function canView() { return true; }
	function canCreate() { return true; }
}
~~~

You can also set the $api_access property as an array to control API access on a specific set of attributes. Example DataObject with advanced api access, limiting viewing and editing to Title attribute only:
~~~ {php}
class Article extends DataObject {
	static $db = array('Title'=>'Text','Published'=>'Boolean');
	static $api_access = array(
		'view' => array('Title'),
		'edit' => array('Title'),
	);
}
~~~

### Supported operations

*  GET /api/v1/(ClassName)/(ID) - gets a database record
*  GET /api/v1/(ClassName)/(ID)/(Relation) - get all of the records linked to this database record by the given relation
*  GET /api/v1/(ClassName)?(Field)=(Val)&(Field)=(Val) - searches for matching database records
*  POST /api/v1/(ClassName) - create a new database record
*  PUT /api/v1/(ClassName)/(ID) - updates a database record
*  POST /api/v1/(ClassName)/(ID)/(MethodName) - executes a method on the given object (e.g, publish)

### Searching
You can trigger searches based on the fields specified on {@link DataObject::searchable_fields} and passed through {@link DataObject::getDefaultSearchContext()}. Just add a key-value pair with the search-term to the url, e.g. /api/v1/(ClassName)/?Title=mytitle.

### Other url-modifiers
*  &limit=<numeric>: Limit the result set
*  &relationdepth=<numeric>: Displays links to existing has-one and has-many relationships to a certain depth (Default: 1)
*  &fields=<string>: Comma-separated list of fields on the output object (defaults to all database-columns). Handy to limit output for bandwidth and performance reasons.
*  &sort=<myfield>&dir=<asc|desc>
*  &add_fields=<string>: Comma-separated list of additional fields, for example dynamic getters.

### Access control

Access control is implemented through the usual Member system with Basicauth authentication only.
By default, you have to bear the ADMIN permission to retrieve or send any data.

## Related
*  [SOAP wrapper around RESTfulServer](soapmodelaccess)

## API Documentation
[Click here for the API documentation](http://doc.silverstripe.com/assets/classes/sapphire/api/RestfulServer.html).
