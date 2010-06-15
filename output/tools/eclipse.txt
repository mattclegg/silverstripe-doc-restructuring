# Tools: Eclipse



## Installation
*  Download a customized package (with all dependencies etc.) from http://ondemand.yoxos.com/geteclipse/start

## Workspace Setup
*  get the PHPeclipse plugin by going to help/software updates/find and install/new remote site: http://phpeclipse.sourceforge.net/update/releases

## Useful Plugins
Many of these Plugins provide overlapping functionality, so be sure to set the right default editor for each content type in Preferences->General->Editors->File Associations

### EcSplorer
!EcSplorer (Eclipse Simplified Explorer) is an eclipse plug-in which facilitates the management of data in the local file system without quitting the eclipse IDE. In earlier releases EcSplorer was just a tool that supports simple navigation in the file system. With each release EcSplorer is getting more and more features.

http://ecsplorer.si-technologies.de/

### Aptana
 * Syntax Highlighting for XHTML, Javascript, CSS
 * Cool: HTML- and CSS code assisting (browser-incompatibilites)
 * Bad: Javascript-Outline does not recognize pseudo-classes
 * [http://www.aptana.com/screenshots.html Screenshots]
 * http://www.aptana.com/

### JSEclipse
 * Very good Javascript-Editor
 * Free for non-commercial use
 * [http://www.interaktonline.com/Products/Eclipse/JSEclipse/Screenshots/ Screenshots]
 * http://www.interaktonline.com/Products/Eclipse/JSEclipse/Overview/

### EclipseTidy
 * Mod of HTMLTidy, cleans up HTML-documents (e.g. lowercase-conversion, only valid tags, ...)
 * Good for HTML-only templates
 * Does not work with mixed PHP/HTML-templates
 * [http://sourceforge.net/project/screenshots.php?group_id=68009 Screenshots]
 * http://sourceforge.net/projects/eclipsetidy/

### Web Tools Project
 * XHTML, XSLT, CSS, JSP Editor
 * Visual XML-Editor
 * Quite large plugin, mostly aimed towards Java Webdevs
 * http://www.eclipse.org/webtools/

### PHP IDE from the Eclipse project
 * PHP syntax colouring, debugger, excellent hover behaviour, method completion, etc.
 * more stable than PHPeclipse
 * http://download.eclipse.org/tools/php/downloads/index.php?release=I20060911-023
    

### Azzurri Clay database modelling plugin
 * visual db modelling plugin (free!)
 * Reverse engineer databases straight from a live db connection
 * SQL generation in a bunch of db flavours
 * some error-checkinng on schema, too
 * http://www.azzurri.jp/en/software/clay/index.jsp

### QuickRex
 * Regular Expression Library for HTML, Text, Dates, Numbers, ...
 * Live-Evaluation of Regex with Test-Text
 * http://www.bastian-bergerhoff.com/eclipse/features/web/QuickREx/toc.html
    

## Useful Key Combinations
 * alt-uparrow Move a line (or highlighted lines) up
 * alt-downarrow Move a line (or highlighted lines) down
 * alt-Apple-uparrow duplicate a line (or highlighted lines) up
 * alt-Apple-downarrow duplicate a line (or highlighted lines) down
 * ctrl-hover shows source-level documentation of the selected element, can eliminate need for ctrl in preferences/phpeclipse/pgp/hovers/source
 * ctrl-shift-r  --  very useful dynamic resource (filename in your workspace) search 


## Troubleshooting
 * (This tip is only useful if you're using phpeclipse from sourceforge) If you can't get code completion or method completion popups, your .profile probably needs work. Look into file .project in your PHP project's directory level

Make sure your .project file looks like:
~~~ {php}
<?xml version="1.0" encoding="UTF-8"?>
<projectDescription>
        <name>your-project-name</name>
        <comment></comment>
        <projects>
        </projects>
        <buildSpec>
                <buildCommand>
                        <name>net.sourceforge.phpeclipse.parserbuilder</name>
                        <arguments>
                        </arguments>
                </buildCommand>
        </buildSpec>
        <natures>
                <nature>net.sourceforge.phpeclipse.phpnature</nature>
        </natures>
</projectDescription>
~~~

 * For a more in-depth-view on restoring workspaces, check http://www.eclipsezone.com/eclipse/forums/t61566.html

 * Mac-users: If you have a workspace on manu (like Brian does) and you have a OS crash, you may lose the ability to write your eclipse state to the network drive before a complete OS beach-ball meltdown. If you lose the network drive and eclipse is still up, eclipse will create a new directory at the root of your local  filesystem and store your metadata there. On reboot, you'll need to remove the local metadata dir which will be something like
~~~ {php}
/Volumes/bcalhoun/dev.totallydigital.co.nz/sites/bcalhoun/perweek/.metadata
~~~

 * Running Eclipse with the workspace on a mounted samba-share (Error-Message: ''Can't open workspace''): You need to add a flag which allows workspaces on non-locking filesystems. Do "Show Package Contents" on your Eclipse.app and insert the following line into Ressources/MacOS/eclipse.ini
~~~ {php}
-Dosgi.locking=none
~~~

 * If you're running phpeclipse with Eclipse 3.2 and having trouble, see: http://www.phpeclipse.de/tiki-view_forum_thread.php?forumId=3&comments_parentId=3014 for some tips on making phpeclipse work with Eclipse 3.2

## Code Templates
 * Insert these into Preferences->PHPEclipse->PHP->Templates (Context "php") to get silverstripe-specific code-templates. They can be triggered by typing the identifier (e.g. "dataclass") and pressing the code completion key-combination (default: ctrl+space).

 * Silverstripe Dataclass (Identifier: "dataclass")
~~~ {php}
#!php
<?php
class ${class_name} extends ${baseclass_name} {
	static $$db = array(
		"${cursor}" => ""
	);
}
?>
~~~

 * Silverstripe Dataclass + Controller (Identifier: "class")
~~~ {php}
#!php
<?php
class ${class_name} extends ${baseclass_name} {
	static $$db = array(
	);
	${cursor}
}

class ${class_name}_Controller extends ${baseclass_name}_Controller {
	function init(){
		parent::init();
	}
}
?>
~~~

 * Silverstripe Debug::show (Identifier: "ds")
~~~ {php}
#!php
Debug::show(${var});
~~~

 * var_dump() (Identifier: "vd")
~~~ {php}
#!php
var_dump(${cursor});
~~~

 * $_REQUEST['showqueries'] = 1; (Identifier: "showqueries")
~~~ {php}
#!php
$$_REQUEST['showqueries'] = 1;
~~~


## Links
http://www.eclipse.org/articles/Article-CVS-branching/eclipse_branch.html
