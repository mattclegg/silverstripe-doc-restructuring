


## Introduction

This [RelationTable](RelationTable) allows you to show a **1-to-1** or **1-to-many** relation with a group of
DataObjects as a (readonly) tabular list (similiar to [ComplexTableField](ComplexTableField)). Its most useful when you
want to manage the relationship itself thanks the **radio buttons** present on each line of the table.

Moreover, you have the possibility to uncheck a radio button in order to make the relation as null.

See [ComplexTableField](ComplexTableField) for more documentation on the base-class.

See [HasManyComplexTableField](HasManyComplexTableField) for more documentation on the relation table base-class.

## Construction

It works exactly in the same way than [ComplexTableField](ComplexTableField) :

	:::php
	$tablefield = new HasOneComplexTableField(
	    $this,
	    'MyOnlyFruit',
	    'Fruit',
	    array(
		'Name' => 'Name',
		'Color' => 'Color'
	    ),
	    'getCMSFields_forPopup'
	);


**Notice** : You still have different ways to customize the popup window as in the parent-class
[ComplexTableField](ComplexTableField).

{{:hasonescale.png|:hasonescale.png}}

This [RelationTable](RelationTable) is made to manage a **has_one** relation. In the SilverStripe [relation
system](datamodel) between DataObjects, you can use this relation for **1-to-1** and **1-to-many** relations.
By default, a *HasOneComplexTableField* manages a **1-to-many** relation. If you want to specify that the relation that
you manage is a **1-to-1** relation, add this code :

	:::php
	$tablefield->setOneToOne();


## Customizing The Add Title

You can change the add title value by using this code :

	:::php
	$tablefield->setAddTitle( 'A Fruit' );


## Example

To see an example of the *HasOneComplexTableField* table, follow this
[tutorial](tutorial/5-dataobject-relationship-management).

## API Documentation

[Click here for the API
documentation](http://api.silverstripe.org/trunk/forms/fields-relational/HasOneComplexTableField.html).

