# gedit

[gedit](http://www.gnome.org/projects/gedit/) is the official text editor of the GNOME desktop environment.

While gedit is very basic compared with the likes of [ NetBeans](tools/netbeans), it is extremely fast and has the huge
advantage of being able to load and save directly from an ftp folder opened in the file browser.

## Environment Setup

By default, GNOME does not recognise **.ss** files:

 1.  Right-click on the **.ss** file you want to open
 2.  Choose **Open with Other Application...**
 3.  Select **Text Editor**

Now gedit will open your **.ss** files, but it won't recognise them as html-based, so you get no syntax highlighting. To
fix this, follow these steps:

 1.  Open up your **Home Folder**
 2.  Make sure **Hidden files** are shown (**CTRL-H**)
 3.  Browse to **.local/share/mime/packages/** and open **user-extension-ss.xml** with **Text Editor**
 4.  Add `<sub-class-of type="text/html"/>`{xml} below `<glob pattern="*.ss"/>`{xml} so your file looks like this:
`<code xml>`
`<?xml version="1.0" encoding="UTF-8"?>`
`<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">`
 `<mime-type type="application/x-extension-ss">`
    `<comment>`ss document`</comment>`
    `<glob pattern="*.ss"/>`
    `<sub-class-of type="text/html"/>`
 `</mime-type>`
`</mime-info>`
`</code>`
   - Save and close **user-extension-ss.xml** and gedit
   - Open up Terminal and run `update-mime-database ~/.local/share/mime`{bash}
   - Now when you open up .ss files they'll be coloured like html!
