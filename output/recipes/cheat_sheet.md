Below, anyone is welcome to add ideas for a *Silvestripe Cheat Sheet*.  If you dont want to add anything directly, but
you suggest we remove / change / rethink something then please add a comment at the bottom. Please do not delete or
alter anything substantial that has been added by someone else so that we can hear all voices before making a final
cheat sheet.

For now, dont worry too much about the formatting and sorting of this page.  At some stage, we will go through the whole
page and standardise formats and group, sort, and merge items.

Having said that, the key is brevity.  Dont explain things, just give people keywords for quick reference.


# retrieving DataObjects

*  **many at once:** DataObject::get($callerClass, $filter = "", $sort = "", $join = "", $limit = "", $containerClass =
"DataObjectSet");

*  **one:** DataObject::get_one($callerClass, $filter = "", $cache = true, $orderby = "");

*  **one using ID:** DataObject::get_by_id($callerClass, $id);

*  **children:** $this->getDescendantIDList();

#### versioned data objects

to swith between Page and Page_Live and the like:

	:::php
		if(Versioned::current_stage() == "Live") {
			$extension = "_Live";
		}


#### many many relationships

	:::php
	class ClassA extends DataObject {
		static $many_many = array( 'ClassBs' => 'ClassB');
		function getMyClassBs() {
	 		return $this->getManyManyComponents('ClassBs');
		}
		function ManyIDs
			$components = $this->owner->getManyManyComponents('ClassBs');
			if($components && $components->count()) {
				return $components->column("ID");
			}
			else {
				return array();
			}
		}
	}
	class ClassB extends DataObject {
		static $belongs_many= array('ClassAs' => 'ClassA');
		function getClassAs() {
			return $this->ClassAs(); 
		}
	}

OR 

	:::php
	class MyObject extends DataObject {
		...		
		static $many_many = array(
			"Pages" => "SiteTree"
		);
		...
		function getActualPages() {
			$combos = $this->Pages();
			if($combos) {
				$idArray = array();
				foreach($combos as $combo) {
					$idArray[$combos->SiteTreeID] = $combos->SiteTreeID;
				}
				if(count($idArray)) {
					return DataObject::get("SiteTree", "`SiteTree`.`ID` IN (".implode(",", $idArray).")"));
				}
			}
		}
		...
	}
	


#### using SQLQuery

`<code  php>`
$sqlQuery = new SQLQuery(
 $select = "SiteTree.ParentID, Count(SiteTree.ID) ",
 $from = array('SiteTree INNER JOIN SiteTree AS ParentTable On ParentTable.ID =  SiteTree.ParentID'),
 $where = "SiteTree.ID > 10",
 $orderby = "Sort DESC",
 $groupby = "SiteTree.ParentID",
 $having = "",
 $limit = ""
);
$results = $sqlQuery->execute();
`</code>`


#### fields

*  as value: $this->getField($fieldName);

*  as object: $this->dbObject($fieldName); OR $this->obj($fieldName);



# fields

	:::php
	$myUsefullField = DBField::create($className = "Currency", $value = 1111.11);
	$formattedField = $myUsefullField->Nice();



# saving DataObjects 

The following functions can be added to a DataObject:

*  ''function validate:''  

	:::php
		function validate() {
			return new ValidationResult(false, "Dont you dare to change my dataObject");
		}


*  ''function onBeforeWrite:'' dont forget to run parent onBeforeWrite(), if this function returns true, it does not
save the dataobject [to do CHECK THIS]

*  ''function onAfterWrite''  

	:::php
	function onAfterWrite() {
	 parent::onAfterWrite();
	 $fields = $this->getChangedFields();
	 if (isset ($fields['MyField']['before'])) {
	  die("My field used to be: ".$fields['MyField']['before']);
	 }
	}


*  ''function requireDefaultRecords:'': do not forget to call parent::requireDefaultRecords()

*  ''function populateDefaults:'': do not forget to call parent::populateDefaults()

# adding relations 

	:::php
	class Team extends DataObject {
	  static $many_many = array("Categories" => "Category");
	
	  function addCategories($additionalCategories) {
	    $existingCategories = $this->Categories();
	    // method 1: Add many by iteration
	    foreach($additionalCategories as $category) {
	      $existingCategories->add($category);
	    }
	    // method 2: Add many by ID-List
	    $existingCategories->addMany(array(1,2,45,745));
	  }
	}



# saving and deleting pages 

save: 

	:::php
	$page->writeToStage('Stage');
	$page->Publish('Stage', 'Live');
	$page->Status = "Published";
	$page->flushCache();


delete:

	:::php
	$id = $page->ID;
	$stageRecord = Versioned::get_one_by_stage('SiteTree', 'Stage', "SiteTree.ID = $id");
	if ($stageRecord) $stageRecord->delete();
	$liveRecord = Versioned::get_one_by_stage('SiteTree', 'Live', "SiteTree_Live.ID = $id");
	if ($liveRecord) $liveRecord->delete();
	$page->flushCache();



change classname:

	:::php
	$dos = DataObject::get("OldClassName");
	if($dos) {
		foreach($dos as $page) {
			$page->setClassName("OldClassName"); //not sure if we need this...
			$page = $page->newClassInstance("NewClassName");
			$page->writeToStage("Stage");
			$page->publish("Stage", "Live");
			DB::alteration_message("Moving: ".$page->Title, "created");
		}
	}
	


# ModelAdmin

#### the DataObject

	:::php
	class Carrot extends DataObject {
		//database
		public static $db = array("Name" => "Varchar(255)");
		public static $has_one = array("Pixie" => "Image", "Parent" => "Page");
		public static $has_many = array();
		public static $many_many = array(); 
		public static $belongs_many_many = array(); 
		public static $many_many_extraFields = array();
		//database related settings
		static $indexes = array(
			"SearchFields" => "fulltext (Title, MenuTitle, Content, MetaTitle, MetaDescription, MetaKeywords)",
			"TitleSearchFields" => "fulltext (Title)",
			"Sort" => true,
			"Uniques" => "Unique('URLSegment')",
		);
		//formatting
		public static $casting = array(); //adds computed fields that can also have a type (e.g. 
		public static $searchable_fields = array("Name" => "PartialMatchFilter");
		public static $field_labels = array("Name" => "Carrot Name");
		public static $summary_fields = array("Name" => "Name", "Parent.Title", "TinyThumbPhoto" => "Pixie"); //note no => for relational fields
		public static $singular_name = "Carrot";
		public static $plural_name = "Carrots";
		//CRUD settings
		static $can_create = Boolean;
		public function canCreate($member = null) {return false;}
		public function canView($member = null) {return false;}
		public function canEdit($member = null) {return false;}
		public function canDelete($member = null) {return false;}
		//defaults
		public static $default_sort = "Sort ASC, Name ASC";
		public static $defaults = array();//use fieldName => Default Value
		public function populateDefaults() {
			parent::populateDefaults();
		}
		public function TinyThumbPhoto() {
			return $this->Pixie()->CroppedImage(100,100);
		} 
	}
	
	


#### the Manager:

	:::php
	class MyModelAdmin extends ModelAdmin {
		public static $managed_models = array("Carrot");
		public static $url_segment = 'carrots';
		public static $menu_title = 'Your Carrots';	
		public static $collection_controller_class = 'MyModelAdmin_CollectionController';
		public static $record_controller_class = 'MyModelAdmin_RecordController';
		public $showImportForm = false;
	}
	class MyModelAdmin_CollectionController extends ModelAdmin_CollectionController{
		//manages everything to do with overall control (e.g. search form, import, etc...)
		public function SearchForm() {
			$form = parent::SearchForm();
			return $form;
		}
	}
	class MyModelAdmin_RecordController extends ModelAdmin_RecordController {
		//manages everything to do with individual record
		public function EditForm() {
			$form = parent::EditForm();
			$form->Actions()->removeByName('Delete');
			return $form;
		}
	}
	



class MyPage extends Page {

# DataObject / SiteTree settings

	:::php
	class MyPage extends Page {
		
		//appearance
		static $icon = "mymodule/images/treeicons/MyPage";
		static $breadcrumbs_delimiter = "&raquo;";
		
		//parents and children in sitetree
		static $allowed_children = array("Blog"); //can also be "none"; 
		static $default_child = "Blog"; 
		static $default_parent = "blogs-and-more"; // *URLSegment* of default parent node.
		static $can_be_root = false; //default is true 
		//parents and children in classes
		static $hide_ancestor = "MyUselessPage"; // 
		
		//CRUD settings
		static $can_create = Boolean;
		public function canCreate() {return false;}
		public function canView() {return false;}
		public function canEdit() {return false;}
		public function canDelete() {return false;}
		
		//database - use "fieldName" => "FieldClass"
		static $db = array();
		static $has_one = array();
		static $has_many = array();
		static $many_many = array(); 
		static $belongs_many_many = array(); 
		static $many_many_extraFields = array();
		static $casting = array(); //adds computed fields that can also have a type (e.g. Currency)
		
		//database related settings
		static $indexes = array(
			"SearchFields" => "fulltext (Title, MenuTitle, Content, MetaTitle, MetaDescription, MetaKeywords)",
			"TitleSearchFields" => "fulltext (Title)",
			"Sort" => true,
			"Uniques" => "Unique('URLSegment')",
		);
		
		//defaults 
		static $default_sort = "Sort ASC, Name ASC";
		static $defaults = array();//use fieldName => Default Value
		
		//fields
		function getCMSFields() {
			$fields = parent::getCMSFields();
			return $fields;
		}
		
	}
	
	class MyPage extends Page_Controller{
		
		function init() {
			parent::init();
		}
	
	}




# DataObjectDecorator

*  **DB statics**:

	:::php
		public function extraStatics() {
			return array (
				'db' => array(
					'SomeField' => 'Varchar'
				),
				'has_many' => array(
					'MyProp' => 'RelatedClass'
				)
			);
		}


Other useful functions: 

	:::php
		function augmentSQL(SQLQuery &$query) {}
		function augmentDatabase() {}
		function augmentWrite(&$manipulation) {}
		function onBeforeWrite() {}
		function onAfterWrite() {}
		function onBeforeDelete() {}
		function onAfterDelete() {}
		function requireDefaultRecords() {}
		function populateDefaults() {}
		function can($member) {}
		function canEdit($member) {}
		function canDelete($member) {}
		function canCreate($member) {}
		function extraStatics() {}
		function updateCMSFields(FieldSet &$fields) {}
		function updateFrontEndFields(FieldSet &$fields) {}
		function updateCMSActions(FieldSet &$actions) {}
		function updateSummaryFields(&$fields){}
		function updateFieldLabels(&$lables){}
		function flushCache() {}


To check if an extension exists, use $object->hasExtension (e.g. $MyPage->hasExtension("MyObjectDecorator");  
# SiteConfig additions 

add to _config.php

	:::php
	Object::add_extension("SiteConfig", "SiteConfigExtras");


create a new file: SiteConfigExtras.php (here are some example tricks):

	:::php
	
	class SiteConfigExtras extends DataObjectDecorator {
	
		function extraStatics(){
			return array(
				'many_many' => array(
					"TopMenuItems" => "SiteTree",
				),
			);
		}
	
		function updateCMSFields(FieldSet &$fields) {
			$sourceObjectName = "SiteTree";
			$fields->addFieldToTab("Root.Menus", new TreeMultiselectField($name = "TopMenuItems", $title = "Top Menu Items", $sourceObjectName));
			return $fields;
		}
	}


add the following to Page.php

	:::php
	
	class Page_Controller extends ContentController {
	
		function TopMenuItems() {
			$siteConfig = $this->getSiteConfig();
			if($siteConfig){
				return $siteConfig->TopMenuItems();
			}
		}
	}
	


and add the following to your Template file (e.g. TopMenuItems.ss):

	:::html
	 `<ul>`
	 `<% control TopMenuItems %>`
		 <li>$Title , $Link</li>
	 `<% end_control %>`
	 `</ul>`
	
	



# images, files and folders 

getting a dropdown of assets folders:

	:::php
	$folder = new TreeDropdownField( 'FieldWithIDHere', 'Title here', 'Folder' );
	$folder->setFilterFunction( create_function( '$obj', 'return $obj->class == "Folder";' ) );




# conversions 

usage: `$newValue = Convert::$functionName($oldValue);`{php}, examples are: raw2att, raw2xml, raw2json, raw2sql,
json2obj,  json2array, linkIfMatch

# controller

#### director

*  **Redirect back**: Director::redirectBack();

*  **Redirect elsewhere**:
      * Director::redirect($url);
      * Director::redirect($this->Link());

*  **in ajax call**: if (Director::is_ajax()) ...



#### URL methods / actions 

*  make sure to add to controller class.

*  keep it all lowercase
Here are some examples

	:::php
		function dosomething(SS_HTTPRequest $request){
			$var = $request->getVars();
			$var = $request->postVars();
			$var = $request->requestVars();
			$var = $request->requestVar($name = "Inputter");
			$var = $request->getURL();
			$var = $request->allParams();
			$var = $request->param($name = "Test");
		}


# security/member

**Get logged in member:**
      * **as object**: Member::currentUser()
      * **as ID**: Member::currentUserID()
**Basic security concept:**

*  There is a list of permissions and associated groups.

*  One or more goups can have the same permission code.

*  One group can have zero to many permission codes.

*  In code, functions like "canCreate", "canView", "canEdit", "canDelete" check permissions 
**granting permissions**

	:::php
	class MyPage extends Page {	
		.............
		public function canView() {
			if(Permission::check("MY_SPECIAL_CODE_HERE")) {
				return true;
			}
			Security::permissionFailure($this, 'You must login before you can view these entries');
		}
	
		public function runupdate() {
			if(Permission::check('ADMIN')) {
				$this->updateEntries()
			}
			else {
				Security::permissionFailure($this, 'You must login before you can update these entries');
			}
		}	
		
		public function requireDefaultRecords() {
			parent::requireDefaultRecords();		
			$bt = defined('DB::USE_ANSI_SQL') ? "\"" : "`";
			$gp = DataObject::get_one("Group", "Code = '".self::$news_editor_group_code."'");
			if(!$gp) {
				$gp = new Group();
				$gp->Code ="MY_SPECIAL_GROUP";
				$gp->Title = "My Group";
				$gp->write();
			}
			if($gp) {
				if(DB::query("
					SELECT {$bt}ID{$bt}
					FROM Permission
					WHERE
						{$bt}GroupID{$bt} = '".$gp->ID."'
						AND {$bt}Code{$bt} = 'MY_SPECIAL_CODE_HERE'"
				)->numRecords() == 0 ) {
					Permission::grant($gp->ID, "MY_SPECIAL_CODE_HERE");
				}
			}
		}
	 	..............
	}
	


####  editor group insitetree=== 

	:::php
	
	class NewsPage extends Page {
	
		protected static $news_editor_group_name = "News Items Editor Group";
	
		protected static $news_editor_group_code = "NEWS_ITEMS_EDITORS";
	
		public static $news_editor_permission_code = "NEWS_ITEMS_EDITORS_PERMISSION";
	
		public function canEdit($member = null) {
			if(Permission::check(self::$news_editor_permission_code)) {
				return true;
			}
			Security::permissionFailure($this, 'You must login before you can view these entries');
		}
	
		public function canCreate($member = null) {
			return $this->canEdit($member);
		}
	
		public function canDelete($member = null) {
			return $this->canEdit($member);
		}
	
		public function requireDefaultRecords() {
			parent::requireDefaultRecords();
			$bt = defined('DB::USE_ANSI_SQL') ? "\"" : "`";
			$gp = DataObject::get_one("Group", "Code LIKE '".self::$news_editor_group_code."'");
			if(!$gp) {
				$gp = new Group();
				$gp->Code = self::$news_editor_group_code;
				$gp->Title = self::$news_editor_group_name;
				$gp->write();
			}
			if($gp) {
				if(DB::query("
					SELECT {$bt}ID{$bt}
					FROM Permission
					WHERE
						{$bt}GroupID{$bt} = '".$gp->ID."'
						AND {$bt}Code{$bt} LIKE  '".self::$news_editor_permission_code."'"
				)->numRecords() == 0 ) {
					Permission::grant($gp->ID, self::$news_editor_permission_code);
				}
				if(DB::query("
					SELECT {$bt}ID{$bt}
					FROM Permission
					WHERE
						{$bt}GroupID{$bt} = '".$gp->ID."'
						AND {$bt}Code{$bt} LIKE  'CMS_ACCESS_CMSMain'"
				)->numRecords() == 0 ) {
					Permission::grant($gp->ID, "CMS_ACCESS_CMSMain");
				}
			}
		}
	
	}
	
	class NewsPage_Controller extends Page_Controller implements PermissionProvider {
		
		function providePermissions() {
			$perms["NEWS_ITEMS_EDITORS_PERMISSION"] = array(
				'name' => "edit news items in CMS",
				'category' => "Content Editors",
				'help' => 'Editing news items in Pages section of CMS',
				'sort' => -100
			);
			return $perms;
		}
	
	
	}

HomePage.php

	:::php
	class HomePage extends Page {
		public function canAddChildren($member = null) {
			if(Permission::check(NewsPage::$news_editor_permission_code)) {
				return true;
			}
			Security::permissionFailure($this, 'You must login before you can view these entries');
		}
	}

Page.php

	:::php
	
	class Page extends SiteTree {
	
		public function canEdit($member = null) {
			if(parent::canEdit()) {
				return Permission::check("ADMIN");
			}
			return false;
		}
	
		public function canAddChildren($member = null) {
			return $this->canEdit($member);
		}
	
		public function canCreate($member = null) {
			return $this->canEdit($member);
		}
	
		public function canDelete($member = null) {
			return $this->canEdit($member);
		}
	}
	


# customising Sapphire

Common sapphire related options for your mysite/_config.php file:

	:::php
	SSViewer::set_theme('mytheme');
	
	Geoip::$default_country_code = "NZ";
	GD::set_default_quality(80);
	
	/* Setting email defaults */
	Email::setAdminEmail("example@best.com");
	Debug::sendLiveErrorsTo('example2@best.com');
	//debug option:
	Email::send_all_emails_to("example@best.com");
	
	/* Changing the breadcrumbs delimiter */
	SiteTree::$breadcrumbs_delimiter = " &#62; ";
	
	/* Enabling moderation for comments */
	PageComment::enableModeration();
	
	/* enables basic math anti spam question field on comments */
	MathSpamProtection::setEnabled()
	
	/* Manually setting default admin */
	Security::setDefaultAdmin('admin', 'password');
	
	/* Add wysiwyg (TinyMCE) editor to blog rather then default BBCode */
	BlogEntry::allow_wysiwyg_editing();
	
	/* ADD RULES */
	// double forward-slash: consumed by rule system // used by controller
	// The ! after a variable name means that the variable is required, and the rule wont match unless the variable is specified.
	Director::addRules(50, array(
		'processes//!$Action/$ID/$Batch' => 'BatchProcess_Controller',
	));


#### also see

[http://www.ssbits.com/a-config-php-cheatsheet/](http://www.ssbits.com/a-config-php-cheatsheet/)

# customising CMS

Main buttons: 

*  **add** CMSMenu::add_link($code, $menuTitle, $url, $priority = -1)'

*  **replace** CMSMenu::replace_menu_item($code, $menuTitle, $url, $controllerClass = null, $priority = -1)

*  **remove**: CMSMenu::remove_menu_item($code);

Adding CMS fields

*  **in page: ** 

	:::php
	public function getCMSFields() {
	 $fields = parent::getCMSFields();
	 $fields->addFieldToTab('Root.Content.News', new TextField("NewsHeading", "News Heading"));
	 return $fields
	}


*  **from dataObjectDecorator:** 

	:::php
	function updateCMSFields(FieldSet &$fields) {
	 $fields->addFieldToTab('Root.Content.News', new TextField("NewsHeading", "News Heading"));
	 return $fields;
	}

#### Customising Page Comments

Copy template files from /cms/templates/ to /themes/mytheme_cms/templates and change as needed.


# emails

	:::php
	$e = new Email($from, $to, $subject, $body, $bounceHandlerURL, $cc, $bcc);
	$e->send();
	//OR
	$e->sendPlain();




# forms

*  basic form:

	:::php
	function MyCustomForm() {
		$fields = new FieldSet(
			new EmailField("Email"),
			new EncryptField("Password")
		);
		$actions = new FieldSet(new FormAction("login", "Log in"));
		return new Form($this, "MyCustomForm", $fields, $actions);
	}


*  data Object to dropdown: 
`<code php>`new DropdownField(
    $name = 'DataObjectID',
    $title = 'do the dropdown',
    $source = Dataobject::get("DataObject")->toDropdownMap("ID", "Title",$emptyString = "--select--", $sortByTitle =
true),
    $value = 1,
); `</code>`


*  filtered multi select tree dropdown 

	:::php
	$treeField = new TreeMultiselectField("Parent", "Shown on the following pages", "SiteTree");
	$callback = create_function('$obj', 'return $obj->class == "HomePage";');
	$treeField->setFilterFunction ( $callback );
	$fields->addFieldToTab("Root.Main",$treeField);



*  enum to dropdown: 
`<code php>`new DropdownField('Method','Payment
Method',singleton($this->ClassName)->dbObject('MyEnumField')->enumValues());
`</code>`



*  make readonly: 

	:::php
	$fields->replaceField("EmailSent", $fields->dataFieldByName("EmailSent")->performReadonlyTransformation());



*  html editor field simplifications - add to _config.php

	:::php
	HtmlEditorConfig::get('cms')->setOption('theme_advanced_blockformats','p,h1');
	HtmlEditorConfig::get('cms')->setButtonsForLine(1,'undo, redo, separator, cut, copy, pastetext, separator, ssimage, sslink, unlink, separator, fullscreen, advcode, formatselect');
	HtmlEditorConfig::get('cms')->setButtonsForLine(2);
	HtmlEditorConfig::get('cms')->setButtonsForLine(3);



*  one folder image field

	:::php
	class OneFolderImageField extends ImageField {
	
		function __construct($name, $title, $value = null, $form = null, $rightTitle = null, $folderName = null) {
			$folder = Folder::findOrMake($folderName);
			$this->folderName = $folderName;
			parent::__construct($name, $title, $value = null, $form = null, $rightTitle = null, $folder->Name);
		}
	
		public function EditFileForm() {
			$filter = create_function(
				'$item', '
				$folder = Folder::findOrMake(\''.$this->folderName.'\');
					return
						(in_array("Image", ClassInfo::ancestry($item->ClassName)) && $item->ParentID == $folder->ID)
						||
						(in_array("Folder", ClassInfo::ancestry($item->ClassName)) && $item->ID == $folder->ID)
			;');
			$form = parent::EditFileForm();
			$form->dataFieldByName('ExistingFile')->setFilterFunction($filter);
			return $form;
		}
	
	}




*  ComplexTableField Example

	:::php
	$orders = DataObject::get('Order');
			$table = new ComplexTableField(
				$controller = $this,
				$name = 'PreviousOrders',
				$sourceClass = 'Order',
				$fieldList = array(
					"Total" => "Value",
					"Created" => "Created",
					"Link" => "Actions"
				),
				$detailFormFields = new FieldSet(),
				$sourceFilter = "StandingOrderID = ".$this->ID,
				$sourceSort = "Created DESC",
				$sourceJoin = ""
			);
			$table->setFieldCasting(array(
				'Created' => 'Date->Long',
				'Total' => 'Currency->Nice'
			));
			$table->setFieldFormatting(array(
				'Link' => '<a href=\"OrderReportWithLog_Popup/invoice/$ID\" class=\"makeIntoPopUp\">View</a>'
			));
			$table->setShowPagination(false);
			$table->setAddTitle('Example Table');
			$table->setPermissions(array("export"));
			return $table;

add thumbnail to DataObject:

	:::php
	public function Thumbnail() {
	 if($this->ImageID) return $this->Image()->CMSThumbnail();
	}



#### manipulating forms

##### add

*  $form->fields->addFieldToTab
##### reset and replace

*  **reset**`$this->resetField("Country", self::$fixed_country_code);`{php}

*  **replace** `$this->fields->replaceField("OldFieldName", New TextField("NewField"));`{php}

##### remove

*  **removing an action**, name should be action_originalName, which can be very confusing!
`$form->unsetActionByName($name); `{php}






# widgets 

adding widgets to non-blog pages:






# themes, templates and requirements






#### Basics 


*  $LinkingMode, $LinkOrCurrent, $FirstLast, $EvenOdd, $First, $Last, etc...

#### Handy Things to use in your templates 

*  $MetaTags(includeTitle) - adds standard Metatags, includesTitle should be true or false

*  $Now.Year - the current year (nice for Copyright notices)

*  $EvenOdd, shows whether an object in a dataobjectset is even or odd... nice for li lists where you want to have two
in a row.

*  separating items with commas and a full-stop at the end.`<% control DataObjectSet %>``<a
href=”$Link”>`$Name`</a>``<% if Last %>`.`<% else %>`,`<% end_if %>``<% end_control %>`



#### requirements in PHP 


*  **javascript**: Requirements::javascript('mysite/javascript/foo.js');

*  **vanilla css**: Requirements::css('mysite/css/foo.css');

*  **themed css**: Requirements::themedCSS('layout');

*  **custome JS**: Requirements::customScript($js, $importantUniqueCode);

#### requirements in templates 

	:::asp
	`<% require css(cms/css/TreeSelector.css) %>`
	`<% require themedCSS(TreeSelector) %>`
	`<% require javascript(cms/javascript/LeftAndMain.js) %>`


#### templates in PHP 



*  **basic renderWith**: return $object->renderWith(array('//Layout//', '//Page//'));

*  **with customised object**: return
$this->customise(array('//TemplateVar//'=>//value//))->renderWith(array('//Layout//', '//Page//'));

# geoip 

*  Geoip::visitor_country() returns code (e.g. NZ)

# translations





# debugging

*  if(Director::isLive()) Debug::send_errors_to('test@example.com');

*  Debug::show($myVariable): performs a kind of print_r($myVariable), but shows it in a more useful format.

*  Debug::message("Wow, that’s great"): prints a short debugging message.

*  Debug::backtrace(): prints a calls-stack

*  Debug::sendLiveErrorsTo("whynot@silverstripe.com"): On the live site, all errors will get sent to this address.

*  Email::send_all_emails_to("developer@silverstripbuilders.org");
##### useful get variables

*  debug_profile

*  ajax

*  showqueries 

*  showtemplate

*  flush=1 / flush=all

# !@#$%^&*( weird errors

*  IF insert SQL statement for $dataobject->write() contains `0` = '0' THEN this could be due to that static $defaults
declaration is like this: static $db = array("myfield"); i.e. a value only and not value/key pair.
