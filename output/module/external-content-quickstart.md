## External Content quick start guide

This article assumes that you have installed the "FileSystem Connector" module
(http://public.silverstripe.com.au/open/modules/filesystem-connector/), which provides access to content from a
filesystem path. 

## Configuration Options


*  FileSystemContentSource::$base_path - Set a filesystem path that is the root path for any connector created (eg
Folder Path is relative to the path entered here)

## Connecting to the content source


*  Browse to http://localhost/external-content/admin and login

*  Create a new FileSystemContentSource from the tree on the left menu. Set the 
following field values:

    * name - File System Content
    * Folder Path - The folder to retrieve content from (in the form /path/to/content)

*  Once saved, you will need to reload the External Content page for content to start coming through the connector

{{:modules:external-content-new-provider.png|:modules:external-content-new-provider.png}}


## Accessing content on the frontend


*  Navigate to the "Site Content" tab

*  Create a new 'External Content Page' in your site tree

*  Change the External Content Source value to the source created earlier

*  Save and view the page on the frontend; its url should look something like http://localhost/extcon/view?ID=1 or
similar

*  You can also link to external content directly in the WYSIWYG content areas by selecting "External Content" as the
"Link To" option when the Insert Link toolbar is displayed

{{:modules:external-content-page.png|:modules:external-content-page.png}}

And viewed on the frontend in a custom template

{{:modules:external-content-frontend-view.png|:modules:external-content-frontend-view.png}}




##  Importing content


*  First, make sure you have an empty folder called "Incoming" created in the "Files & Images" section

*  Navigate back to the External Content section, and expand the "File System Content" node created earlier. 

*  Navigate to a folder that contains some files and click on its name, then click on the Migrate tab.

*  Select the "Incoming" folder, then click the "Include Selected Item in Migration" option.

*  Click the Migrate button down the bottom. An alert box will shortly appear when the migrate is complete. 

*  Navigate to the "Files and Images" section and click the "Incoming" folder. 

*  The uploaded files should appear in the right hand listing when you select the imported folder

Select files to import

{{:modules:external-content-import-files.png|:modules:external-content-import-files.png}}


The imported files

{{:modules:external-content-imported-filelist.png|:modules:external-content-imported-filelist.png}}
