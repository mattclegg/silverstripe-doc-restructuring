# Introduction

This class represents a set of [database objects](dataobject), such as the results of a query. It is the base for all [datamodel](datamodel)-related querying. It implements the [Iterator interface](http://php.net/manual/en/language.oop5.iterations.php) introduced in PHP5.

Relations (has_many/many_many) are described in [ComponentSet](http://api.silverstripe.org/trunk/sapphire/model/ComponentSet.html), a subclass of DataObjectSet.

# Usage

## Getting the size

`$mySet->Count();`{php}

## Getting an single element

	:::php
	$myFirstDataObject = $mySet->First();
	$myLastDataObject = $mySet->Last();


## Getting multiple elements

	:::php
	$mySpecialDataObjects = $mySet->find('Status', 'special');
	$startingFromTen = $mySet->getOffset(10);
	$tenToTwenty = $mySet->getRange(10, 10);


## Getting one property

	:::php
	$myIDArray = $mySet->column('ID');



## Grouping

You can group a set by a specific column. Consider using [SQLQuery](SQLQuery) with a //GROUP BY// statement for enhanced performance.
`$groupedSet = $mySet->groupBy('Lastname');`{php}

## Sorting

Sort a set by a specific column. 
<code php>$mySet->sort('Lastname'); //ascending
$mySet->sort('Lastname', 'DESC'); //descending</code>

This works on the object itself, so do NOT do something like this:
`$sortedSet = $mySet->sort('Lastname'); //ascending`{php}

## Merge with other DataObjectSets

	:::php
	$myFirstSet->merge($mySecondSet);
	// $myFirstSet now contains all combined values


## Mapping for Dropdowns

When using [DropdownField](DropdownField) and its numerous subclasses to select a value from a set, you can easily map the records to a compatible array:

	:::php
	$map = $mySet->toDropDownMap('ID', 'Title');
	$dropdownField = new DropdownField('myField', 'my label', $map);


## Converting to array

`$myArray = $mySet->toArray();`{php}

## Output as HTML-list

Use [buildNestedUL](http://doc.silverstripe.com/assets/classes/default/DataObjectSet.html#buildNestedUL) to return a nested unordered list out of a "chain" of DataObject-relations.

## Checking for existence

It is good practice to check for empty sets before doing any iteration.

	:::php
	$mySet = DataObject::get('Players');
	if($mySet->exists()) foreach($mySet as $player)
	// ...



## Paging

DataObjects have native support for dealing with **pagination**.
See //setPageLimits//, //setPageLength//, etc.

FIXME Complete pagination documentation


# API Documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/sapphire/DataObjectSet.html).
