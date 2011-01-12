# Themes

Themes can be used to kick start your SilverStripe projects, and generally make you look good.

## Installing

#### Downloading A Prebuilt Theme

Head to the [ Themes ](http://www.silverstripe.org/themes ) area of the website to check out the wide range of themes
the community has built. Each theme has a page with links you can use to preview and download it. The theme is provided
as a .tar.gz file.

#### Install

 1.  Simply unpack the contents of the zip file into the /themes directory in your SilverStripe installation.
 2.  Change to the theme by putting the following line in your ./mysite/_config.php: `<code php>`
SSViewer::set_theme("themename");
`</code>`
 1.  Visit your homepage, ensuring you flush the cache (append ?flush=1 to the URL).

# Developing a Theme

See themes:[[themes:developing
]] to get an idea of how themes actually work and how you can develop your own. 


# Submitting your theme to SilverStripe

If you want to submit your theme to the silverstripe directory then check


*  You should ensure your templates are well structured, modular and commented so it's easy for other people to
customise them.

*  Templates should not contain text inside images and all images provided must be open source and not break any
copyright law. This includes any icons your template uses in the frontend or the backend CMS

*  A theme does not include any PHP files. Only 3 folders - css/, images/ and templates.

Your theme file must be in a .tar.gz format. A useful tool for this is - [7 Zip](http://www.7-zip.org/). Using 7Zip you
must select the your_theme folder and Add to archive, select TAR and create. Then after you have the TAR file right
click it -> Add to Archive (again) -> Then use the archive format GZIP.

## Discussing

Head over to the [ Themes Forum ](http://www.silverstripe.com/showcase-forum/ )
