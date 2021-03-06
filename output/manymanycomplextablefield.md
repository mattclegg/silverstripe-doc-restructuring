## Introduction

This [RelationTable](RelationTable) allows you to show a **many-to-many** relation with a group of DataObjects as a
(readonly) tabular list (similiar to [ComplexTableField](ComplexTableField)). Its most useful when you want to manage
the relationship itself thanks to the **check boxes** present on each line of the table.

See [ComplexTableField](ComplexTableField) for more documentation on the base-class.

See [HasManyComplexTableField](HasManyComplexTableField) for more documentation on the relation table base-class.

**Note:** This class relies on the fact that both sides of the relation have database tables. If you are only creating a
class as a logical extension (that is, it doesn't have any database fields), then you will need to create a dummy static
$db array because SilverStripe won't create a database table unless needed.

## Construction

It works exactly in the same way than [ComplexTableField](ComplexTableField) :

	:::php
	$tablefield = new ManyManyComplexTableField(
	    $this,
	    'MyFruits',
	    'Fruit',
	    array(
		'Name' => 'Name',
		'Color' => 'Color'
	    ),
	    'getCMSFields_forPopup'
	);


**Notice** : You still have different ways to customize the popup window as in the parent-class
[ComplexTableField](ComplexTableField).

{{:manymany.png|:manymany.png}}


## Customizing The Add Title

You can change the add title value by using this code :

	:::php
	$tablefield->setAddTitle( 'A Fruit' );


## Example

To see an example of the *ManyManyComplexTableField* table, follow this
[tutorial](tutorial/5-dataobject-relationship-management).

## API Documentation

[Click here for the API
documentation](http://api.silverstripe.org/trunk/forms/fields-relational/ManyManyComplexTableField.html).

## Todo

*  Manage also the **many_many_extraFields** option in the same table
