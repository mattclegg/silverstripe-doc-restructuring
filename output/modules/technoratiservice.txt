## Introduction
The main use of Technoratiservice is to create Metablogs by finding blog posts tagged under a given topic. For example if you are holding an event, you can ask all its participants to tag their blog posts about the event in a   common name (eg: FOSSCON06). So on the the event's site you can create a metablog by collecting all posts tagged under that name with the help of Technoratiservice.

By default you will get the following built in component with technorati service :

*  [MetaBlog](MetaBlog) page type -  used to create a Meta blog based on a given tag

## Download
*  [0.1](http://open.silverstripe.com/changeset/latest/modules/technoratiservice/tags/0.1?old_path=/&filename=/modules/technoratiservice/tags/0.1&format=zip) (Latest Release)
*  [Daily Build](http://open.silverstripe.com/changeset/latest/modules/technoratiservice/trunk?old_path=/&filename=/modules/technoratiservice/trunk&format=zip) ("trunk")

=====  Demo ===== 
*  http://demo.silverstripe.com/technorati-module-demo/

## Requirements
You need to use the version **2.2.0** of SilverStripe.

## Module Installation
1.  Download the [Technoratiservice](http://www.silverstripe.com/assets/downloads/modules/technoratiservice-0.1.tar.gz) module
2.  After extraction, place this directory in the root of your SilverStripe installation
3.  Run db/build
4.   Apply for an API key from http://www.technorati.com/developers/apikey.html and add the following line to file - mysite/_config.php; 
~~~ {php}
	MetablogService::setAPIKey('Your-API-KEY');
~~~
1.  The CMS should now have a "MetaBlog" page type


## Related
*  [ RestfulService](/restfulservice ) - the base class which enables 3rd party mashups
