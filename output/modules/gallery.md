## Introduction

The gallery module has been done to show a list of **every kind of file** stored in the [:assets](/assets).
The user can also manage easily the content of the gallery (extensions allowed) and its layout.

To see each file present in a gallery, the last version of the LightWindow Javascript program has been added and
customised for the module.

## Requirements

You need to use the version **2.2.0** of SilverStripe.

## Download

* 
[0.2.2](http://open.silverstripe.com/changeset/latest/modules/gallery/tags/0.2.2?old_path=/&filename=/modules/gallery/tags/0.2.2&format=zip)
(Latest Release)

*  [Daily
Build](http://open.silverstripe.com/changeset/latest/modules/gallery/trunk?old_path=/&filename=/modules/gallery/trunk&format=zip)
("trunk")


## Module Installation

 1.  Download the [gallery](http://www.silverstripe.com/assets/downloads/modules/gallery-0.2.1.tar.gz) module
 2.  After extraction, place this directory in the root of your SilverStripe installation
 3.  Run db/build
 4.  The CMS should now have a "GalleryPage" page type












## GalleryPage Creation

When you create a new GalleryPage, a folder will be automatically created in a new *galleries* folder in the Files and
Images (Assets) area of the SilverStripe Admin area.

By default, it's from this folder that the files will be loaded in the gallery. Although you can change the folder by
going in the tab panel *File*.

The *Images* extensions is also auto selected for every new gallery created. However, you can select what kind of file
you want to see in your gallery (see Extensions Management chapter below).

For the **versions before 0.2.2**, you have to include a piece of code by two different ways :
 1.  Create a GalleryPage.ss file inside themes/your_themes/templates/Layout/ and adding the code (in some versions of
the Gallery module, the file GalleryPage.ss has already been created for you) `<code html>`
    `<% include GalleryPageContent %>` 
`</code>`
 1.  Add `<% include GalleryPageContent %>` into themes/your_themes/templates/Layout/Page.ss so the templates will look
similar to this: `<code html>`
`<div class="typography">`
`<% if Menu(2) %>`
`<% include SideBar %>`
    `<div id="Content">`
`<% end_if %>`

`<% if Level(2) %>`
    `<% include BreadCrumbs %>`
`<% end_if %>`

    `<h2>`$Title`</h2>`

    $Content
    `<% include GalleryPageContent %>`
    $Form
    $PageComments

`<% if Menu(2) %>`
    `</div>`
`<% end_if %>`
`</div>`
`</code>`




## Extensions Management

To select what kind of file or group of files, you want to show in your gallery, you have to go in the tab panel
*Extensions*.

Everything is managed thanks to a [relationtable](relationtable) which deals with a many many relation between the
galleries and the extensions groups.

Thanks to it, you can select zero, one or more groups of extensions that you want to load in your gallery.
Moreover, you can add, edit, and delete extensions groups.

Each extensions group has the attributes :


*  Title : Title of the group

*  Extensions : List of the extensions (separated by comas)

*  Type : This attribute is used for the popup window

*  Limit Dimensions : If the files are documents or web pages, you have to specify if you want to limit the dimensions
of the popup window or not

*  Icon : Image which will be used to represent the files involved in the group in the gallery







## Gallery Content

To manage the gallery layout, you have to go in the tab panel *Gallery*.

You can limit the number of files per page and per line. If necessary, a navigation bar will appear automatically.

The files loaded are reprensented by images which have been created by the resizing method selected with the width and
height specified.
Under each images, you can show the title, the size and sometimes the dimensions of the file (depending on its
extension).

As for the image used to represent the file, it is selected depending its extension and the group which it belongs to.

If the file extension is among **png, jpg, jpeg** and **gif**, it will be represented by its own resized image.
Otherwise, it's the group image which will be used.
If the group image of the file has not been set, it's the default image of the gallery which will be used.
If the gallery doesn't have a default image, the program will auto load a default one for it.

In the **version 0.2.2**, the sort functionality has been added. To use it, go in the tab panel *Files* and select the
way you want the media files to appear.

## Popup Window Content

To see each file in the gallery, the [LightWindow](http://stickmanlabs.com/lightwindow) Javascript program has been
added and customised to the module.

The popup window also has its own navigation system.

For every file, you can specify a caption text which will appear at the bottom of the popup window by going in the
[assets](assets), selecting the file and going in the tab panel *Gallery Options*.




### Images

To manage the popup window layout, you have to go in the tab panel *Popup*.

There, you can select the width, the height and the resizing method which will be used only for the files which
extension is among **png, jpg, jpeg** and **gif**.

**__Notice__ :**
As for the resizing methods available, there are the same than in the *Gallery* tab panel. In addition to it, you can
select the **Original Resize** method to show the file in its orginal dimensions.

#### Bitmap

The files which extension is **bmp** will always be shown in their original size.

#### Tagged Image File Format

As for the files which extension is **tiff**, a width and a height are needed.
Either you specify them by going in the [assets](assets), selecting the file and going in the tab panel *Gallery
Options* or it's the width and the height specified in the *Popup* tab panel of the gallery which will be used.

### Sounds & Videos

You need to specify a width and a height.
Either you specify them by going in the [assets](assets), selecting the file and going in the tab panel *Gallery
Options* or it's the width and the height specified in the *Popup* tab panel of the gallery which will be used.

#### ShockWave Flash

The files which extension is **swf** can be simple videos or a documents like **pdf** files.
To be able to see them as documents, you have to go in the [assets](assets) and check the option **Is A Flash
Document**.
If this option is checked :
 1.  Your file will used just like a **pdf** document (see details below)
 2.  You can specify if you want to limit the dimensions of the popup window

### Documents & Web Pages

The files which belong to groups which type are **Documents** or **Web Pages** will not be part of the navigation system
of the popup window, however they will normally appear in the Light Window when you will select them from the gallery.

If you have not checked in the group settings to limit the dimensions, the window will appear on the all screen,
otherwise you will need to specify a width and a height.
Either you specify them by going in the [assets](assets), selecting the file and going in the tab panel *Gallery
Options* or it's the width and the height specified in the *Popup* tab panel of the gallery which will be used.





## LightWindow Compatibility

{{:lightwindowcompatibility.png|:lightwindowcompatibility.png}}


## Safari 3 Problem

The ligntwindow doesn't work with Safari 3. The SilverStripe team is working to solve this problem for the next version
of the Gallery module.

## Comments

Please raise issues, bugs, contributions in the silverstripe.com forum...


## Future extensions

*  Allow to load files from the web and not only from the [assets](assets).

## Trouble-shooting and common mistakes

If you've installed the gallery module and you're unable to see images on a GalleryPage, please check the following:

 1.  Gallery directory is residing in the Silverstripe root
 2.  Rebuild the Silverstripe database with /db/build?flush=1
 3.  Append the `<% include GalleryPageContent %>` in either Page.ss or GalleryPage.ss
 4.  Flush the templates with ?flush=1
 5.  Check to ensure that you've ENABLED extensions in the extensions tab of a gallery page. You need to select the
check box and publish the site
