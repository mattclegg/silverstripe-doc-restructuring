Below, anyone is welcome to add ideas for a //Silvestripe Cheat Sheet//.  If you dont want to add anything directly, but you suggest we remove / change / rethink something then please add a comment at the bottom. Please do not delete or alter anything substantial that has been added by someone else so that we can hear all voices before making a final cheat sheet.

For now, dont worry too much about the formatting and sorting of this page.  At some stage, we will go through the whole page and standardise formats and group, sort, and merge items.

Having said that, the key is brevity.  Dont explain things, just give people keywords for quick reference.




=====retrieving DataObjects=====
##### using DataObject

*  **many:** DataObject::get($callerClass, $filter = "", $sort = "", $join = "", $limit = "", $containerClass = "DataObjectSet");
*  **one:** DataObject::get_one($callerClass, $filter = "", $cache = true, $orderby = "");
*  **one using ID:** DataObject::get_by_id($callerClass, $id);
*  **children:** $this->getDescendantIDList();

#####  using SQLQuery
<code  php>
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
</code>




##### Fields
~~~ {php}
$myUsefullField = DBField::create($className = "Currency", $value = 1111.11);
$formattedField = $myUsefullField->Nice();
~~~


## saving DataObjects
*  ''function onBeforeWrite:'' dont forget to run parent onBeforeWrite(), if this function returns true, it does not save the dataobject [to do CHECK THIS]
*  ''function onAfterWrite''  
*  ''function requireDefaultRecords:'': do not forget to call parent::requireDefaultRecords()
*  ''function populateDefaults:'': do not forget to call parent::populateDefaults()




## adding relations
~~~ {php}
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
~~~


## saving and deleting pages
save: 
~~~ {php}
$page->writeToStage('Stage');
$page->Publish('Stage', 'Live');
$page->Status = "Published";
$page->flushCache();
~~~

delete:
~~~ {php}
$id = $page->ID;
$stageRecord = Versioned::get_one_by_stage('SiteTree', 'Stage', "SiteTree.ID = $id");
if ($stageRecord) $stageRecord->delete();
$liveRecord = Versioned::get_one_by_stage('SiteTree', 'Live', "SiteTree_Live.ID = $id");
if ($liveRecord) $liveRecord->delete();
$page->flushCache();
~~~















=====ModelAdmin Example=====
The DataObject:
~~~ {php}
class Carrot extends DataObject {
	//database
	public static $db = array("Name" => "Varchar(255)");
	public static $has_one = array();
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
	public static $summary_fields = array("Name" => "Name", "Page.Title"); //note no => for relational fields
	public static $singular_name = "Carrot";
	public static $plural_name = "Carrots";
	//CRUD settings
	static $can_create = Boolean;
	public function canCreate() {return false;}
	public function canView() {return false;}
	public function canEdit() {return false;}
	public function canDelete() {return false;}
	//defaults
	public static $default_sort = "Sort ASC, Name ASC";
	public static $defaults = array();//use fieldName => Default Value
	public function populateDefaults() {
		parent::populateDefaults();
	}
}


~~~

The manager:

~~~ {php}
class MyModelAdmin extends ModelAdmin {
	public static $managed_models = array("Carrot");
	public static $url_segment = 'carrots';
	public static $menu_title = 'Your Carrots';	
	public static $collection_controller_class = 'MyModelAdmin_CollectionController';
	public static $record_controller_class = 'MyModelAdmin_RecordController';
}
class MyModelAdmin_CollectionControllerextends ModelAdmin_CollectionController{
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

~~~








=====DataObject and SiteTree settings=====
~~~ {php}
//appearance
static $icon = "mymodule/images/treeicons/ClassName-file.gif";
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
//database related settings
static $indexes = array(
	"SearchFields" => "fulltext (Title, MenuTitle, Content, MetaTitle, MetaDescription, MetaKeywords)",
	"TitleSearchFields" => "fulltext (Title)",
	"Sort" => true,
	"Uniques" => "Unique('URLSegment')",
);
static $default_sort = "Sort ASC, Name ASC";
static $casting = array(); //adds computed fields that can also have a type (e.g. Currency)
static $defaults = array();//use fieldName => Default Value
function getCMSFields() {
	$fields = parent::getCMSFields();
	return $fields;
}
~~~
 








### retrieving fields from a DataObject
*  as value: $this->getField($fieldName);
*  as object: $this->dbObject($fieldName); OR $this->obj($fieldName);

##### retrieving data from many-many relationships
~~~ {php}
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

~~~












=====DataObjectDecorator=====
*  **DB statics**:
~~~ {php}
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
~~~

Other useful functions: 
~~~ {php}
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
~~~

To check if an extension exists, use $object->hasExtension (e.g. $MyPage->hasExtension("MyObjectDecorator"); 

## images, files and folders

getting a dropdown of assets folders:
~~~ {php}
$folder = new TreeDropdownField( 'FieldWithIDHere', 'Title here', 'Folder' );
$folder->setFilterFunction( create_function( '$obj', 'return $obj->class == "Folder";' ) );
~~~



## conversions
usage: `$newValue = Convert::$functionName($oldValue);`{php}, examples are: raw2att, raw2xml, raw2json, raw2sql, json2obj,  json2array, linkIfMatch

=====director=====
*  **Redirect back**: Director::redirectBack();
*  **Redirect elsewhere**:
      * Director::redirect($url);
      * Director::redirect($this->Link());
*  **in ajax call**: if (Director::is_ajax()) ...




=====security/member=====
*  **Get logged in member**:
      * **as object**: Member::currentUser()
      * **as ID**: Member::currentUserID()
*  **Permission check/fail**: if (!$object->canEdit()) return Security::permissionFailure($this);
#### examples
granting permission

checking permission
~~~ {php}
public function canView() {
	if ($member = Member::currentUser())
		if($member->isAdmin() || Permission::checkMember($member, self::$permission_code)) {
			return true;
		}
	}
	return false;
}

public function runupdate() {
	if(Permission::check('ADMIN')) {
		$this->updateEntries()
	}
	else {
		Security::permissionFailure($this, 'You must login before you can update these entries');
	}
}
~~~














=====customising Sapphire=====
Common sapphire related options for your mysite/_config.php file:
~~~ {php}
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
~~~

=====Sending emails=====

~~~ {php}
$e = new Email($from, $to, $subject, $body, $bounceHandlerURL, $cc, $bcc);
$e->send();
//OR
$e->sendPlain();
~~~


=====customising the CMS=====
Main buttons: 
*  **add** CMSMenu::add_link($code, $menuTitle, $url, $priority = -1)'
*  **replace** CMSMenu::replace_menu_item($code, $menuTitle, $url, $controllerClass = null, $priority = -1)
*  **remove**: CMSMenu::remove_menu_item($code);

Adding CMS fields
*  **in page: ** 
~~~ {php}
public function getCMSFields() {
 $fields = parent::getCMSFields();
 $fields->addFieldToTab('Root.Content.News', new TextField("NewsHeading", "News Heading"));
 return $fields
}
~~~
*  **from dataObjectDecorator:** 
~~~ {php}
function updateCMSFields(FieldSet &$fields) {
 $fields->addFieldToTab('Root.Content.News', new TextField("NewsHeading", "News Heading"));
 return $fields;
}
~~~
#### Customising Page Comments
Copy template files from /cms/templates/ to /themes/mytheme_cms/templates and change as needed.












=====forms=====
*  basic form:
~~~ {php}
function MyCustomForm() {
	$fields = new FieldSet(
		new EmailField("Email"),
		new EncryptField("Password")
	);
	$actions = new FieldSet(new FormAction("login", "Log in"));
	return new Form($this, "MyCustomForm", $fields, $actions);
}
~~~
*  data Object to dropdown: 
<code php>new DropdownField(
 'DataObjectID',
 '-- select --',
 Dataobject::get("DataObject")->toDropdownMap("ID", "Title")
); </code>


#### ComplexTableField Example
~~~ {php}

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

~~~


### manipulating forms
##### add
*  $form->fields->addFieldToTab
##### reset and replace
*  **reset**`$this->resetField("Country", self::$fixed_country_code);`{php}
*  **replace** `$this->fields->replaceField("OldFieldName", New TextField("NewField"));`{php}

##### remove
*  **removing an action**, name should be action_originalName, which can be very confusing! `$form->unsetActionByName($name); `{php}


## Complex Table Fields
add thumbnail to DataObject:
~~~ {php}
public function Thumbnail() {
 if($this->ImageID) return $this->Image()->CMSThumbnail();
}
~~~




## widgets
adding widgets to non-blog pages:

## saving pages
   * save and publish: `$page->writeToStage('Stage');$page->publish('Stage', 'Live');$page->flushCache();`{php}





=====themes, templates and requirements=====






### Basics

*  $LinkingMode, $LinkOrCurrent, $FirstLast, $EvenOdd, $First, $Last, etc...

### Handy Things to use in your templates
*  $MetaTags(includeTitle) - adds standard Metatags, includesTitle should be true or false
*  $Now.Year - the current year (nice for Copyright notices)
*  $EvenOdd, shows whether an object in a dataobjectset is even or odd... nice for li lists where you want to have two in a row.
*  separating items with commas and a full-stop at the end.<% control DataObjectSet %><a href=”$Link”>$Name</a><% if Last %>.<% else %>,<% end_if %><% end_control %>



### requirements in PHP

*  **javascript**: Requirements::javascript('mysite/javascript/foo.js');
*  **vanilla css**: Requirements::css('mysite/css/foo.css');
*  **themed css**: Requirements::themedCSS('layout');
*  **custome JS**: Requirements::customScript($js, $importantUniqueCode);

### requirements in templates
~~~ {asp}
<% require css(cms/css/TreeSelector.css) %>
<% require themedCSS(TreeSelector) %>
<% require javascript(cms/javascript/LeftAndMain.js) %>
~~~

### templates in PHP


*  **basic renderWith**: return $object->renderWith(array('//Layout//', '//Page//'));
*  **with customised object**: return $this->customise(array('//TemplateVar//'=>//value//))->renderWith(array('//Layout//', '//Page//'));

=====translations=====





=====debugging=====
*  if(Director::isLive()) Debug::send_errors_to('test@example.com');
*  Debug::show($myVariable): performs a kind of print_r($myVariable), but shows it in a more useful format.
*  Debug::message("Wow, that’s great"): prints a short debugging message.
*  Debug::backtrace(): prints a calls-stack
*  Debug::sendLiveErrorsTo("whynot@silverstripe.com"): On the live site, all errors will get sent to this address.
*  Email::send_all_emails_to("developer@silverstripbuilders.org");

=====!@#$%^&*( weird errors=====
*  insert statement for $dataobject->write() contains `0` = '0': could be that static $defaults declaration is like this: array("myfield"); i.e. a value only and not value/key pair.
