## Alfresco Connector

The Alfresco Connector provides an interface to work with content that exists in the [Alfresco](http://www.alfresco.com) content management system as though it is native content within SilverStripe. It also provides a mechanism to import this content into native SilverStripe content objects


### Dependencies

*  SilverStripe >= 2.4.x
*  The Alfresco Connector relies on the [External Content Module](module/external-content). 
*  An available Alfresco system. Alfresco is available with a free Community Download at the [Alfresco Wiki](http://wiki.alfresco.com/wiki/Download_Alfresco_Community_Network)
    * If you are just evaluating the Alfresco Connector, there is a publically accessible Alfresco system available at http://joomla.demo.alfresco.com/, but it was obviously set up for use for another purpose. Though I'm sure if you were to figure out the username and password (hint, check the URL...) and use that for the Username and Password during the configuration below, alfresco wouldn't hold it against you. 



### Configuration Options

*  SeaMist::getInstance()->registerImplementation('Alfresco', 'AlfrescoSeaMistRepository') - Tells the SeaMist  library which type to use for a particular repository type. You shouldn't need to change this, unless you're writing your own CMIS implementation for the Alfresco repository

### Version Information

Check the SILVERSTRIPE_VERSION file to see which version of silverstripe the module is compatible with



## Getting started

First, download the alfresco-connector.tar.gz package and extract it to your SilverStripe directory. Then, run /dev/build



### Create the connector

*  Browse to http://localhost/external-content/admin and login
*  Create a new AlfrescoContentSource from the tree on the left menu. Set the following field values:
    * name - Alfresco Content
    * Repository Information URL - The URL of the top level CMIS repository (for Alfresco, this is /alfresco/s/api/repository). Note this is a new field over 0.1.0-rc1, and is changed due to some CMIS refactorings
    * Root Node URL (Optional) - Optional, specify the CMIS URL of the node to which content should be rooted at
    * Username - The alfresco instance's username
    * Password - The alfresco instance's password
*  Once saved, you will need to reload the External Content page for content to start coming through

Be aware that the username and password provided should be a generic 'read-only' user of the system. Per-user access is on the TODO list.  

### Accessing content on the frontend

*  Navigate to the "Site Content" tab
*  Create a new 'External Content Page' in your site tree
*  Change the External Content Source value to the Alfresco Content source created earlier
*  Save and view the page on the frontend; its url should look something like http://path.to.silverstripe/extcon/view/1 or similar. Folders will display a browsable list, while files show a download link. 
*  You can also link to external content directly in the WYSIWYG content areas by selecting "External Content" as the "Link To" option when the Insert Link toolbar is displayed

==== Importing content ==== 

*  First, make sure you have an empty folder called "Incoming" created in the "Files & Images" section
*  Navigate back to the External Content section, and expand the "Alfresco Content" node created earlier. 
*  Navigate to a folder (eg Data Dictionary/Scripts) and click on its name, then click on the Migrate tab.
*  Select the "Incoming" folder, then click the "Include Selected Item in Migration" option.
*  Click the Migrate button down the bottom. An alert box will shortly appear when the migrate is complete. 
*  Navigate to the "Files and Images" section and click the "Incoming" folder. 



