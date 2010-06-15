TODO - This page is in development


# What this MVC thing?

Many other CMS’s and templating system allow you to embed a lot of logic directly in your templates. That approach gives you a lot of power out of the box, however it means your templates get messy very quickly, with the mix of code and HTML layout information – this in turn makes it difficult for both designers and developers to work on the same site (from a partial level it’s easy for you to break each others code, and you can’t work on the same file at the same time)
In SilverStripe, we rely on a [MVC (Model View Controller) architecture](http://en.wikipedia.org/wiki/Model-view-controller). This requires us to separate things such as the content on your pages (the data model), from templates (the view), from the php code which defines how data is displayed in your template (the Controller).

This separation, leads to cleaner, better structured code, which makes your sites more maintainable in the future and it easier to work on with teams of people.

Changes are this approach is a bit different to what your use to but once you’ve got your head around it, you’ll never look back. To kick start you, here are a few examples of common things people want to achieve with their templates.

## Q) How can I create a list of all of those pages which a children of another page?

A) In your template files, you can use the just use the [built in page controls](http://doc.silverstripe.com/doku.php?built-in-page-controls), childrenOf(). This is one of the few instances where you don’t need to write your own controller.
To use

    <% control childrenOf(xxx) %>
    $Title
    <% end_control %>

Where “xxx” is the page URL of the page which you want to get the children of.

## Q) How can I create a custom title for my site. I don't like just 'Home'

A) If you want to write your own custom <title> tags then you need to open up the root Page.ss file . If you are using a theme it will be in themes/yourthemes/templates/Page.ss. Open this file in your text editor and near the top you should see a string $MetaTags.

This is normally the function the gets the title field of the page and renders the <title> tags automatically. But if you want custom ones you can pass 'false' to that and then underneath write your own <title>My Awesome Site</title> **Example**

   $MetaTags(false)
   <title>$Title | My Site Name</title> 


#### Things to write about ....

##### Q) How can I sort a list by a specific attribute?

A) By default pages are returned in the order which they are loaded into the CMS. If you want to sort them, based on a particular field you need to write a custom controller to do this. For example, if we wanted to sort based on the page title, we’d write a function like;
XXXX
And then we access that controller in our templates like so;
YYYY

##### Q) How can I limit the number of pages which is outputted by a controller?
A)

##### Q) How can I get pages based on their page type (as opposed to their relationship to another page)?
A)

##### Q) How can I filter a list based on a particular attribute?
A)

##### Q) I want to select all the pages which are on Level 2 in the site hierarchy
A)

##### Q) How can I create a nested menu?
A)

##### Q) I want to make the page look different when I pass it a get?x=y parameter?
 A) You don’t you create different page types

== Q) I want to show a some content to members of my site, only if they are part of a particular group == 
A)

##### Q) I want to show some content to members which who have the position CEO
A)

##### Q) I want to randomly show a some text on a page
A)
 
##### Q) I want to have the same content displayed on each page
A)
