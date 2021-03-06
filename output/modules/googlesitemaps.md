# Introduction

SilverStripe provides support for the Google Sitemaps XML system, enabling Google and other search engines to see all
pages on your site. This helps your SilverStripe website rank well in search engines, and to encourage the information
on your site to be discovered by Google quickly.

Therefore, all Silverstripe websites contain a special "file" which can be visited: sitemap.xml

(See http://en.wikipedia.org/wiki/Sitemaps for info on this format )

In addition, whenever you publish a new or republish an existing page, SilverStripe automatically informs Google of the
change, encouraging a Google to take notice. If you install the SilverStripe Google Analytics module, you can see if
Google has updated your page as a result.

By default, SilverStripe informs Google that the importance of a page depends on its position of in the sitemap. "Top
level" pages are most important, and the deeper a page is nested, the less important it is. (For each level, Importance
drops from 1.0, to 0.9, to 0.8, and so on, until 0.1 is reached).

In the CMS, in the "Content/GoogleSitemap" tab, you can set the page importance manually, including requesting to have
the page excluded from the google sitemap.

## Download

*  [Daily
Build](http://open.silverstripe.com/changeset/latest/modules/googlesitemaps/trunk?old_path=/&filename=/modules/blog/googlesitemaps&format=zip)
("trunk")


# API Documentation

[Click here for the API documentation](http://api.silverstripe.com/sapphire/core/Sitemap.html).
