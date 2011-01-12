## Creating a new page:

	:::php
	$page = new Page();
	$page->ParentID = 18; //if you want it to be a child of a certain other page...
	$page->Title = "Crazy page"; 
	$page->MetaTitle = "madness";
	$page->PageTitle = "Funny"; 
	$page->writeToStage('Stage'); 
	$page->publish('Stage', 'Live');


## updating a page:

	:::php
	$page = DataObject::get_one("Page", "ParentID = 18");
	$page->Title = "More Serious";
	$page->writeToStage('Stage');
	$page->Publish('Stage', 'Live');
	$page->Status = "Published";



## Deleting pages

	:::php
	$id = $page->ID;
	$stageRecord = Versioned::get_one_by_stage('SiteTree', 'Stage', "SiteTree.ID = $id");
	if ($stageRecord) $stageRecord->delete();
	$liveRecord = Versioned::get_one_by_stage('SiteTree', 'Live', "SiteTree_Live.ID = $id");
	if ($liveRecord) $liveRecord->delete();


In case you want to delete a couple of 100 pages of page class XPage, you do the following:
 1.  Delete pages in CMS using batch actions, you will now see that the pages are deleted, but that they are still on
the Live Site.
 2.  Empty the XPage_versions table in the database.  The pages are now gone for good.





