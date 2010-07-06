## Introduction
Basic SOAP Server to access and modify DataObject instances.

## Requirements

SilverStripe 2.3

## Usage

Usage - Getting a record:
~~~ {php}
$c = new SoapClient('http://mysite.com/soap/v1/wsdl');
echo $c->getXML("MyClassName", 99); // gets record #99 as xml
~~~

Usage - Updating a record:
~~~ {php}
$c = new SoapClient('http://mysite.com/soap/v1/wsdl');
$data = array('MyProperty' => 'MyUpdatedValue');
echo $c->putXML("MyClassName", 99, null, $data);
~~~

Usage - Creating a record:
~~~ {php}
$c = new SoapClient('http://mysite.com/soap/v1/wsdl');
$data = array('MyProperty' => 'MyValue');
echo $c->putXML("MyClassName", null, null, $data);
~~~

Usage - Creating a record:
~~~ {php}
$c = new SoapClient('http://mysite.com/soap/v1/wsdl');
echo $c->deleteXML("MyClassName");
~~~

## Related
*  [RESTful API](restfulserver)

## API Documentation
[Click here for the API documentation](http://doc.silverstripe.com/assets/classes/sapphire/api/SOAPModelAccess.html).
