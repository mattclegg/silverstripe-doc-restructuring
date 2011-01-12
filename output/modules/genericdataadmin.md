# GenericDataAdmin Module

//This module is deprecated as of SilverStripe 2.3, use the [ModelAdmin](/modeladmin) instead.//

## Introduction

Generic Data Admin lets you manage any DataObject subclasses through a three-pane interface with integrated search,
record creation and edit forms. It is deprecated in favour of the new [ModelAdmin](/modeladmin) class which has nearly
the same interface, but requires a lot less custom coding to get you going. While you have to define your custom edit
forms and saving logic in GenericDataAdmin, the new ModelAdmin extracts most of this knowledge from your existing
datamodel-definitions.

## Requirements

*  SilverStripe 2.2

## Download

*  [0.1
RC1](http://open.silverstripe.com/changeset/latest/modules/genericdataadmin/tags/rc/0.1?old_path=/&filename=/modules/genericdataadmin/tags/rc/0.1&format=zip)
(Latest Release)

*  [Daily
Build](http://open.silverstripe.com/changeset/latest/modules/genericdataadmin/trunk?old_path=/&filename=/modules/genericdataadmin/trunk&format=zip)
("trunk")
## Customizing

Create  a static field called result_columns as a blank array:
`<code php>`  static $result_columns = array(
    );`</code>`

You need to create three abstract methods: Link(), getSearchFields() and performSearch():
`<code php>`  function Link() {
    return "admin/urlsegment";
    }

    function getSearchFields() {
    return new FieldSet(
			new DateField("From", "From"),
			new DateField("To", "To"),
			new TextField("Title", "Title")
    );
    }

    function performSearch() {
    return DataObject::get("Member");
    }`</code>`

Then modify these to do what you want. Some examples are Writework (nlou/writework) and Guano (hsmith/guano)

Now there are two generic functions added to genericDataAdmin: 

    * save() - deal with click save button on right-top
    * getEditForm(). deal with get the content in right panel and load data from database

Needed to make these generic functions work, you have two static data members in your subclass. Example from
WorkshopAdmin:

	:::php
	static $data_type = 'Workshop'; 
	static $data_type_extra = array('Client', 'ContactManager', 'ContactAdmin');

They are basically telling save() and getEditForm() that they need to deal with not only the DataObject of Workshops,
but also DataObjects of Client, ContactManger and ContactAdmin which related to each workshop.

When you make your getCMSField(), you need to give those fields related to $data_type_extra a special name like this:
'Client[Title]', 'Client[MainBusiness]', etc. In this way, the $_REQUEST is made up like this $_REQUEST[Client][Title],
$REQUEST[Client][MainBusiness].

If your fields don't have 'Client[ID]', add it as a hidden field. So that while saving the whole form, no new Client
record is added, the old client record will be overwriten.

If your subclass needs to make something special for their own save()-method, the generic save() and getEditForm() can
still be used, just call 

	:::php
	$ret=parent::save();
	`</code>` and then do you special stuff and then return $ret, because in ajax-context the generic save()-method returns some javascript-statements. 
	
	##  Customizing Search Results
	You can choose between a tabular view (one level with columns) or a nested list-view (multiple levels with custom formatting). Use the list-view if you want to show relations to the main DataObject, and/or trigger different views for these.
	`<code php>`
	// Format "table":
	array(
	    'FirstName' => 'First Name',
	    'Surname' => 'Surname'
	)
	 
	// Format "list" (use "Root" to specifiy the current level):
	// Example shows Members on the first level and their connected Groups on the second level
	array(
	    "Root" => "`<li>`\$FirstName \$Surname",
	    "Groups" => "`<li>`\$Title"
	)

See [DataObjectSet](DataObjectSet)->buildNestedUL for a more detailed description on list-formats.

## Best Practices

### More than one editing-interface
You might want to edit parts of the underlying DataObject (or related DataObjects) in a completely seperate EditForm.
To edit e.g. an Task associated to a Member-Object, you would write (shortened code):

	:::php
	function showtask() { // get your custom form here }
	function savetask() { // custom saving here }
	function deletetask() { // custom deleting here }
	function TaskEditForm() { // return the form }
	function EditForm() { // switch between actions here by evaluating $this->getAction() to determine which form to use }

