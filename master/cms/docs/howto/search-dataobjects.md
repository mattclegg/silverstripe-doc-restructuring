In the recipe below, we manage a dataobject (table, piece of information) called House, which lists houses (name) and a type(small or large). We then list these houses in a housepage and allow them to be searched. This is a silly example, but you can use the same code for more meaningful purposes.

Also see: [http://doc.silverstripe.com/doku.php?id=searchcontext](http://doc.silverstripe.com/doku.php?id=searchcontext)

This is just an example (not necessarily the best way) on how to do this:


## DataObject

First of all, we create a dataobject:

~~~ {php}

class House extends DataObject {

	// Properties
	static $db = array(
		'House' => 'Varchar',
		'Type' => "Enum('small','large','small')"
	);
	
	// Relations
	// - Explictly defined to allow static access 
	//   from extensions
	static $has_one = array();
	
	static $has_many = array();
	
	static $many_many = array();

	static $belongs_many_many = array();

	static $casting = array();

	static $defaults = array();

	// Model Admin utilities
	static $searchable_fields = array(
		'House',
		'Type'
	);
	
	static $summary_fields = array(
		'House',
		'Type'
	);

	static $singular_name = 'House';

	static $plural_name = 'Houses';
	
	static $default_sort = 'House ASC';

	// Other Services
	static $api_access = false;

	// Methods
	function getCMSFields() {
		$fields = parent::getCMSFields();
		return $fields;
	}

}

~~~

## Managing the Data Object in the CMS


Next, we create a modeladmin (section in the CMS) to manage the House DataObject:

~~~ {php}

class HouseAdmin extends ModelAdmin {

	public static $managed_models = array(
		'House'
	);

	static $url_segment = 'Houses'; // will be linked as /admin/products
	static $menu_title = 'House Admin';

}

~~~

## The House Page

Next, we create a page that allows searching of these houses.

~~~ {php}
class HousePage extends Page {
 	static $db = array(
 		"HousesPerPage" => "Int"
 	);
	public function getCMSFields() {
		$fields = parent::getCMSFields();
		$fields->addFieldsToTab('Root.Content.DomainList',array(
			new NumericField('HousesPerPage','Houses Per Page'),
		));
		return $fields;
	}	
}
class HousesPage_Controller extends Page_Controller {

	static $number_per_page = 7;

	function index () {
		return $this->HouseSelection();
	}

	function HouseSelection($where = '1 = 1') {
		if(!isset($_GET["start"])) {
			$_GET["start"] = 0;
		}
		if(!$this->HousesPerPage) {
			$this->HousesPerPage = self::$number_per_page;
		}
		if(Session::get("HouseSearch.where")) {
			$where = Session::get("HouseSearch.where");
		}
		$obj = DataObject::get('House', $where, null, null, 	$limit = $_GET["start"].",".$this->HousesPerPage);
		if($obj) {
			$count = $obj->TotalItems();
			$obj->setPageLength($this->HousesPerPage);//$obj->setPageLimits($_GET["$this->HousesPerPage);
		}
		else {
			$count = 0;
		}
		if(is_object(Session::get("HouseSearch.humanQueryDefinition"))) {
			$HouseQuery = Session::get("HouseSearch.humanQueryDefinition");
		}
		else {
			$HouseQuery = null;
		}
		$_GET["start"]+$this->HousesPerPage > $count ? $end = $count :	$end = $_GET["start"]+$this->HousesPerPage;
		return array(
			"Houses" => $obj,
			"HouseCount" => $count,
			"HouseQuery" => $HouseQuery,
			"HouseStart" => $_GET["start"],
			"HouseStart" => $_GET["start"]+1,
			"HouseEnd" => $end
		);
	}

	function resetsearch() {
		Session::set("HouseSearch.where", "");
		Session::set("HouseSearch.House", "");
		Session::set("HouseSearch.type", "both");
		Session::set("HouseSearch.humanQueryDefinition", null);
		Director::redirect($this->Link());
	}


	function HouseSearchForm() {
		$request = $this->getRequest();
		if($House = $request->requestVar('House')) {
			Session::set("HouseSearch.House", $House);
		}
		else {
			$House = Session::get("HouseSearch.House");
		}
		if($type = $request->requestVar('Type')) {
			Session::set("HouseSearch.type", $type);
		}
		else {
			if(!Session::get("HouseSearch.type")) {
				Session::set("HouseSearch.type", "both");
			}
			$type = Session::get("HouseSearch.type");
		}
		//$category = $request->requestVar('Category') ? $request->requestVar('Category') : 'Both';

		$fields = new FieldSet();
		$fields->push(new TextField('House','Keyword (optional)',$House));
		$values = array('small'=>'small Houses','large'=>'large Houses','Both'=>'Both');
		$fields->push(new OptionsetField('Type','', $values,$type));

		$actions = new FieldSet(
			new FormAction('doSearch','Search')
		);

		return new Form($this, 'HouseSearchForm', $fields, $actions);
	}

	function doSearch ($data, $form, $request) {
		//Debug::show($data);

		$filter = array();
		$humanQueryDefinition = array();
		if (isset($data['House']) && $data['House'] != "") {

			$Houses = explode(' ', Convert::raw2sql($data['House']));
			foreach ($Houses as $d) {
				$filter[] = "(House LIKE '%$d%')";

			}
			$humanQueryDefinition["Keywords"] = $data['House'];
			Session::set("HouseSearch.House", $Houses);
		}

		if (isset($data['Type']) && $data['Type'] != 'Both') {

			$type = Convert::raw2sql($data['Type']);
			$filter[] = "(Type = '$type')";
			$humanQueryDefinition["Type"] = $type;
			Session::set("HouseSearch.type", $data['Type']);
		}
		if(count($filter)){
			$filter = implode(' AND ',$filter);
			Session::set("HouseSearch.where", $filter);
			Session::set("HouseSearch.humanQueryDefinition", new ArrayData($humanQueryDefinition));
		}
		else {
			$filter = '';
		}
		Director::redirect($this->Link());
	}
}
~~~

## Template

Now, we have all the PHP code in place, we create a template (add to your existing 

    themes/mythemes/templates/Layout/HousePage.ss 

file):

~~~ {html}

<div id="housesearchform">
	$HouseSearchForm
	<ul class="SearchDefinition">
		<% if HouseCount %><li>Total listed: $HouseCount <% if Houses.MoreThanOnePage %>(showing from $HouseStart to $HouseEnd)</li><% end_if %> <% end_if %>
		<% if HouseQuery %>
			<% control HouseQuery %>
				<% if Keywords %><li>Keyword(s): $Keywords</li><% end_if %>
				<% if Type %><li>Type: $Type</li><% end_if %>
			<% end_control %>
		<% if HouseCount %><li><a href="$Link/resetsearch">Reset search</a><% end_if %>
		<% end_if %>

	</ul>
		<% if Houses.MoreThanOnePage %>
			<div id="PageNumbers">
				<% if Houses.NotFirstPage %>
				<a class="prev" href="$Houses.PrevLink" title="View the previous page">Prev</a>
				<% end_if %>
				<span class="number">
					<% control Houses.PaginationSummary(5) %>
						<% if CurrentBool %>
							$PageNum
						<% else %>
							<a href="$Link" title="View page number $PageNum">$PageNum</a>
						<% end_if %>
					<% end_control %>
				</span>
				<% if Houses.NotLastPage %>
				<a class="next" href="$Houses.NextLink" title="View the next page">Next</a>
				<% end_if %>
			</div>
		<% end_if %>

	<% if Houses %>
		<ul class="HouseResults">
		<% control Houses %>
			<li>$House</li>
		<% end_control %>
		</ul>
	<% else %>
		<p id="NoResult">Sorry, your search did not return any results. <a href="$Link/resetsearch">Search Again?</a></p>
	<% end_if %>
</div>
~~~
