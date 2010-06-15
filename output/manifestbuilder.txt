# Introduction
The manifest builder is a support class that caches various bits of system information. It is basically what happens when you're calling a URL with //?flush=1//.

Most references to templates and classes in Sapphire are made without reference to the folder that they're in.  Sapphire is smart enough to look through all of the application's files and find the appropriate template.  However, this would be a bit slow if done for every class on every page request, and so a 'manifest' listing all of the files available is generated and then cached.  Additionally, information about the class hierachy and which classes have tables is generated and then cached.

Ordinarily, you wouldn't have to do **anything** with this script.

## Autoloader
Sapphire class autoloader.  Requires the ManifestBuilder to work.
$_CLASS_MANIFEST must have been loaded up by ManifestBuilder for this to successfully load classes.  Classes will be loaded from any PHP file within the application. If your class contains an underscore, for example, Page_Controller, then the filename is expected to be the stuff before the underscore.  In this case, Page.php.

# Related
*  [controller](controller)
*  [execution-pipeline](execution-pipeline)
*  [directory-structure](directory-structure)
*  [ClassInfo](ClassInfo)

# API Documentation
[Here is the method documentation](http://api.silverstripe.org/trunk/sapphire/core/ManifestBuilder.html).


