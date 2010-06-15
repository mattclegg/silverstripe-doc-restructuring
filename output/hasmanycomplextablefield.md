

## Introduction
This [RelationTable](RelationTable) allows you to show a **1-to-many** relation with a group of DataObjects as a (readonly) tabular list (similiar to [ComplexTableField](ComplexTableField)). Its most useful when you want to manage the relationship itself thanks the **check boxes** present on each line of the table.

Moreover, you can not do any mistake anymore in the relation by checking a DataObject already linked with another of the parent class.

See [ComplexTableField](ComplexTableField) for more documentation on the base-class.

## Construction
It works exactly in the same way than [ComplexTableField](ComplexTableField) :
~~~ {php}
$tablefield = new HasManyComplexTableField(
    $this,
    'MyFruits',
    'Fruit',
    array(
	'Name' => 'Name',
	'Color' => 'Color'
    ),
    'getCMSFields_forPopup'
);
~~~

**Notice** : You still have different ways to customize the popup window as in the parent-class [ComplexTableField](ComplexTableField).

{{:hasmany.png|:hasmany.png}}


## Customizing The Add Title
You can change the add title value by using this code :
~~~ {php}
$tablefield->setAddTitle( 'A Fruit' );
~~~


## Example
To see an example of the //HasManyComplexTableField// table, follow this [tutorial](tutorial/5-dataobject-relationship-management).

## API Documentation
[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-relational/HasManyComplexTableField.html).
