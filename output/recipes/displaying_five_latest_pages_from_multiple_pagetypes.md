# Overview

[tutorial:2-extending-a-basic-site](http://doc.silverstripe.com/doku.php?id=tutorial:2-extending-a-basic-site) gives us
a great method for [showing the latest news on the
homepage](tutorial/2-extending-a-basic-site#showing_the_latest_news_on_the_homepage). But what if you have a Latest News
section and a Client News section, and you want to display 5 of the latest of EITHER kind of news?

Well, here's what you'd use:

	:::php
	function LatestNews() {
		$articles = DataObject::get("Page", "`ClassName` IN ('ArticlePage', 'ClientArticlePage')");
		$articles->sort("Date", "DESC");
		$returnarticles = $articles->getRange(0, 5);
		
		return $returnarticles;
	}

# What's happening here?

Let's go through it line by line: 

*  The first line creates a new DataObject called $articles that gets all the pages with a ClassName of either
ArticlePage or ClientArticlePage. This differs from the original method used in Tutorial 2 because it will pickup ANY of
these page types, irrespective of the Parent page.

*  The next line then sorts the DataObject (from largest to smallest; newest to oldest) by the field called 'Date' (This
assumes you have added a Date field to the above pagetypes. If you haven't, you can use something like "Created" instead
of "Date" which is available on all pagetypes). 

*  The third line uses getRange to limit the DataObject, to in this instance 5 pages, before saving it as
$returnarticles. 

*  Finally we return $returnarticles so that we can use `<% control LatestNews %>` in the template to control the
DataObject.

# Other uses


*  Combining the children of multiple pages into a feed that can be displayed on a separate page.

*  Merging two DataObjects, Combining two DataObjects (layman's terms for searching).
