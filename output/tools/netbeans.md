# NetBeans

[NetBeans](ttp///www.netbeans.org/) is a mature open source IDE developed in Java that works on all major platforms.  It
now boasts a PHP specific version that is tailored to PHP5 and web development. Integrated features include:


*  Full code scanning
    * Auto-Hint with arugment data pulled from PHP doc blocks (works nicely with SS)
    * Member/method autocomplete
    * Ctrl+Click Class following

*  MySQL query browser/data editor/schema tools

*  Source Code Control (SVN, CVS, Hg, others)

*  Remote Debugger (xdebug)

*  Web Service code builders

*  Issue Tracker integration (Bugzilla)

*  HTML element click-to-code creation

*  Visual CSS Editor

*  PHPUnit test creator

*  ...plenty more

The above are built-in, as opposed to [other IDEs](tools/eclipse) that require multiple plugins for each feature.  More
information is available at http://www.netbeans.org/

## Download

Get the PHP version from below:

*  http://www.netbeans.org/downloads/index.html

## Environment Setup

It is very helpful to add highlighting to your **.ss** files:

 1.  Open **Tools** > **Options** (**Netbeans** > **Preferences** for Mac users)
 2.  Go to the **Miscellaneous** Tab, **Files** subtab
 3.  Under **File Extension** click **New...**
 4.  Enter *ss* as the file extension
 5.  Choose **HTML Files (text/html)** as the Associated File Type

## Tips and Tricks

User contributed items.

### Using rsync to move files automatically

Moving files in bulk to remote servers is greatly simplified with the use of **rsync**.  Its very fast and only pushes
changed files.  On linux you can set a bash script to run when you build your project (F6) to push files where you need
them.

First create a script that moves your file.  This is using rsync on Linux, but you could also use a batch file on
Windows.

**/path/to/ssproject/pushfiles.sh**

	:::sh
	#!/bin/sh
	rsync -avpc --delete /path/to/ssproject/ remotehost.com:/path/to/server/public_html/`</code>`
 *Don't forget to chmod +x, also you may want to tweak the above to your needs.  Especially the --delete with regards to
the assets folder.*
	
	  - Right click on your project and choose **Properties**
	  - Go to the **Run Configuration** and change **Run As** to **Script**
	  - In **PHP Interpreter** enter **/bin/sh**
	  - Select the file you created above as your **Index File**
	  - Save changes
	
	Now whenever you want to push your files to your remote server, just build the project with **F6** or the button up top.  The Output window will pop up and show you files and progress.
	