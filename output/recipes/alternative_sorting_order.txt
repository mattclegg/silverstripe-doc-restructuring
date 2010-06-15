# Building Alternative Sort Capacity for Pages

Here is a really simple way to add an alternative sort option for your pages. You can merge the following code with any page type you have and adjust to suit.

~~~ {php}

class AlternativeSortPage extends Page {

	static $db = array(
		"AlternativeSort" => "Int"
	);
	static $defaults = array(
		"AlternativeSort" => 100000 //just use a high number so that you dont end up going below zero for some reason
	);
	static $indexes = array(
		"AlternativeSort" => true
	);
	static $has_one = array(
		"ShowAfter" => "AlternativeSortPage"
	);

	protected static $_cached_pages = null;

	function getCMSFields() {
		$fields = parent::getCMSFields();
		$Dos = DataObject::get(
			"AlternativeSortPage",
			"`SiteTree`.`ID` <> ".$this->ID." AND (ShowBeforeTable.`ShowAfterID` <> ".$this->ID.")" ,
			"`AlternativeSortPage`.`AlternativeSort` ASC",
			"LEFT JOIN `AlternativeSortPage` AS ShowBeforeTable ON ShowBeforeTable.`ShowAfterID` = `AlternativeSortPage`.`ID`"
		);
		if($Dos) {
			$firstInLine = null;
			if(!DataObject::get("AlternativeSortPage", "`SiteTree`.`ID` <> ".$this->ID." AND `AlternativeSortPage`.`ShowAfterID` = 0")) {
				$firstInLine = "--- first in line ---";
			}
			$Array = $Dos->toDropDownMap('ID', 'Title', $firstInLine);
			$fields->addFieldToTab('Root.Content.sPages', new DropdownField("ShowAfterID", "ShowAfter", $Array));
		}


		return $fields;
	}

	public function onBeforeWrite() {
$beforePage = DataObject::get_one("AlternativeSortPage", "`SiteTree`.`ID` <> ".$this->ID." AND `SiteTree`.`ID` = ".(intval($this->ShowAfterID)+0));
		if($beforePage) {
			//snake biting itself
			if($beforePage->ShowAfterID == $this->ID) {
				$realBeforePage = DataObject::get_one(
					"AlternativeSortPage",
					"`SiteTree`.`ID` <> ".$this->ID." AND
						`SiteTree`.`ID` <> ".$beforePage->ID." AND
						`AlternativeSort` < ".$this->AlternativeSort ." AND
						`AlternativeSort` < ".$beforePage->AlternativeSort,
					"`AlternativeSort` DESC");
				if($realBeforePage) {
					$beforePage->ShowAfterID = $realBeforePage->ID;
					$beforePage->AlternativeSort = $realBeforePage->AlternativeSort + 1;
					$beforePage->writeToStage('Stage');
					$beforePage->publish('Stage', 'Live');
					$beforePage->flushCache();
				}
				else {
					$beforePage->ShowAfterID = self::$defaults["AlternativeSort"];
					$beforePage->AlternativeSort = self::$defaults["AlternativeSort"];
					$beforePage->writeToStage('Stage');
					$beforePage->publish('Stage', 'Live');
					$beforePage->flushCache();
				}
			}
			//current page sort number is the previous page sort number + 1
			$this->AlternativeSort = intval($beforePage->AlternativeSort) + 1;
			if($sharingPage = DataObject::get_one("AlternativeSortPage", "`SiteTree`.`ID` <> ".$this->ID." AND `AlternativeSortPage`.`ShowAfterID` = ".(intval($this->ShowAfterID)+0))){
				//sharing page is moved to be after this one.
				$sharingPage->ShowAfterID = $this->ID;
				$sharingPage->AlternativeSort = $this->AlternativeSort+1;
				$sharingPage->writeToStage('Stage');
				$sharingPage->publish('Stage', 'Live');
				$sharingPage->flushCache();
			}
		}
		else {
			$this->AlternativeSort = self::$defaults["AlternativeSort"];
			$this->ShowAfterID = self::$defaults["AlternativeSort"];
		}
		parent::onBeforeWrite();
	}

	function AlternativeSortedPages() {
		if(!self::$_cached_pages) {
			self::$_cached_pages = DataObject::get("AlternativeSortPage", "AlternativeSort");
		}
		return self::$_cached_pages;
	}

	function requireDefaultRecords() {
		parent::requireDefaultRecords();
		for($i = 0; $i < 3; $i++) {
			$pages = $this->AlternativeSortedPages();
			if($pages) {
				foreach($pages as $page) {
					$page->writeToStage('Stage');
					$page->publish('Stage', 'Live');
					$page->flushCache();
				}
			}
		}
	}

}


~~~
