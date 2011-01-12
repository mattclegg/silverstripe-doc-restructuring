# ModelAdmin

*Replaces GenericDataAdmin in Silverstripe 2.3*

The ModelAdmin provides a simple way to utilize the SilverStripe CMS UI with your own custom data models.  The
ModelAdmin uses the [DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html)'s Scaffolding to
create the search fields, forms, and displayed data within the CMS. 

In order to customize the ModelAdmin CMS interface you will need to understand how 
[DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html) works.

#### Requirements


*  *Requires Silverstripe 2.3*

## Usage

1. Extend ModelAdmin with a custom class for your admin area, and edit the ''$managed_models'' property with the list of
data objects you want to scaffold an interface for:

	:::php
	class MyCatalogAdmin extends ModelAdmin {
	   
	  public static $managed_models = array(   //since 2.3.2
	      'Product',
	      'Category'
	   );
	
	  static $url_segment = 'products'; // will be linked as /admin/products
	  static $menu_title = 'My Product Admin';
	
	}


To add the ModelAdmin to your CMS menu, you simply need to define a couple of statics on your ModelAdmin subclass. See
[LeftAndMain](http://api.silverstripe.org/trunk/cms/core/LeftAndMain.html) on how to make your menu title translatable.


2. Add a ''$searchable_fields'' (See [ModelAdmin#searchable_fields](ModelAdmin#searchable_fields)) property to your data
models, to define the fields and filters for the search interface:

Datamodel ''Product'':

	:::php
	class Product extends DataObject {
	
	   static $db = array(
	      'Name' => 'Varchar',
	      'ProductCode' => 'Varchar',
	      'Description' => 'Text',
	      'Price' => 'Currency'
	   );
	
	   static $has_one = array(
	      'Category' => 'Category'
	   );
	
	   static $searchable_fields = array(
	      'Name',
	      'ProductCode' 
	   );
	
	}


Datamodel ''Category'':

	:::php
	<?php
	class Category extends DataObject {
	   static $db = array(
	      'Title' => 'Text'
	   );
	}
	?>


3. You can now log in to the main CMS admin and manage your data objects, with no extra implementation required.

{{:modeladmin_edit.png|:modeladmin_edit.png}}

{{:modeladmin_results.png|:modeladmin_results.png}}
### Note about has_one

Scaffolding **has_one** relationships in your ModelAdmin relies on a column in the related model to be named **Title**
or **Name** of a string type (varchar, char, etc).  These will be pulled in to the dropdown when creating a new object.

If you are seeing a list of ID#s when creating new objects, ensure you have one of those two in the related model.

### Searchable Fields

You can customize the fields which are searchable for each managed DataObject class, as well as the ways in which the
fields are searched (e.g. "partial match", "fulltext", etc.) using ''$searchable_fields''.

   * See [DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html)

{{:modeladmin_search.png|:modeladmin_search.png}}

### Summary Fields

Summary Fields are the columns which are shown in the
[TableListField](http://api.silverstripe.org/trunk/forms/fields-relational/TableListField.html) when viewing
DataObjects.  These can be customized for each DataObject's search results using ''$summary_fields''.

   * See [DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html)

## Related

*  [SearchContext](SearchContext)

*  [genericviews Module](modules/genericviews)

*  [Presentation about ModelAdmin at SupperHappyDevHouse
Wellington](http://www.slideshare.net/chillu/modeladmin-in-silverstripe-23)
