The FileSystem Connector module is the default module for the External Content module, and is used as the example module
for how to create a new connector as decribed in the [External Connector
Tutorial](http://doc.silverstripe.org/doku.php?id=module:external-content-newconnector). 

This connector allows you to 


*  Browse a filesystem path for content

*  Import filesystem content into your SilverStripe installation

*  Make filesystem content available on your website

**WARNING** 

This module allows some CMS users to create connectors to places on your server filesystem, and for site users to browse
content from the filesystem. To restrict where content can be listed from, please set the
FileSystemContentSource::$base_path = '/home/username/okaycontent'; variable to ensure users can only create content
connections to a specific folder path. 


