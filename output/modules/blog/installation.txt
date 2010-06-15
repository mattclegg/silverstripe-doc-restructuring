<note important> The blog module requires SilverStripe 2.1 to work</note>

#### Installation - Existing SilverStripe Website
*  [Upgrade to 2.1](http://www.silverstripe.com/silverstripe-web-application-framework/) if you don't already have it
*  Download the blog tar.gz and uncompress to a /blog/ directory in your SilverStripe site root
*  Run run the database rebuild script by appending /db/build?flush=1 to the end of your site's url. Eg: http://www.yoursite.com/db/build?flush=1 

#### Installation - New Website
*  Download SilverStripe core package (2.1 or later)
*  Download the blog module and unzip the blog into a /blog/ directory in your SilverStripe site root
*  Visit your SilverStripe installation and fill out your database etc credentials.
    * Choose "Default BlackCandy" as theme when installing.
*  That's it. A blog will be automatically created as part of the new website.
    * To prevent comment spam, we suggest [setting up Akismet](ssakismet)

#### Installation from SVN
*  mkdir <folder>
*  cd <folder>
*  Checkout the blog module into your SilverStripe installation root:
    * svn co http://svn.silverstripe.com/open/modules/blog/tags/0.1 blog

*  Visit your silverstripe installation and fill out your database etc credentials.
*  Login to CMS,
    * Create a "blog holder" (choose it from the drop-down list and click GO)
      * Save and Publish it.
    * Create a "blog entry" inside the "blog holder"
      * Save and publish
    * Log out of the CMS
      * View the blog on the public site
      * Post a blog using the link on the "post blog" link on the left


