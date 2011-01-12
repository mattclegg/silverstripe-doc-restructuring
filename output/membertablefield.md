## Introduction

Shows a group of [Member](Member) as a editable tabular list (similiar to [ComplexTableField](ComplexTableField)). It's
more useful when you want to display additional fields from a
[DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html). Moreover, you can add permissions to the
table such as show and export

You can also do a search in the table and use the popup window to navigate from Member to Member.

See [ForumRole](ForumRole) for an example of a
[DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html).

See [ComplexTableField](ComplexTableField) for more documentation on the base-class

## Source Input

See [Member](Member) for the defaults fields viewable in the table.

## Setting Additional Permissions

MemberTableField contains by default the add, edit and delete permissions.  You can add the other permissions from a
_config.php file :

	:::php
	MemberTableField::addPermissions( array( "show", "export" ) );


## Setting Additional Fields

MemberTableField contains some static functions which allows you to add decorator fields to your table. You can call the
functions from a _config.php file :

	:::php
	MemberTableField::addMembershipFields( array( 
		"Nickname" => "Nickname",
		"Occupation" => "Occupation",
		"Country" => "Country",
		"ForumRank" => "ForumRank"
		));


## Export As CSV

By default, if you don't specify a second array in the static function, the csv file will contain the same fields as the
table. In our previous example, if you don't want the ForumRank field in your csv file :

	:::php
	MemberTableField::addMembershipFields( array( 
		"Nickname" => "Nickname",
		"Occupation" => "Occupation",
		"Country" => "Country",
		"ForumRank" => "ForumRank"
		), array( 
		"Nickname" => "Nickname",
		"Occupation" => "Occupation",
		"Country" => "Country"
		));


## Using The Search Functionality

The search field is to do a research in the table content (and also the fields that have been added). If you want to
reload the full table content, just do an empty research.

NB : The export functionality exports the table content, so you can export a research result if you want. 
