# Building apps to work across databases

This page is intended to be a guide to SilverStripe developers wanting to make their applications database-agnostic.

#### SQL syntax

The following guidelines should be applied to the SQL that you generate, either directly or in your arguments to ''DataObject::get''.

*  Use " instead of ` to escape field and table names.
*  Escape all table and field names, not just reserved ones.  This is needed for PostgreSQL support.
*  Don't use ''INSERT INTO Table SET Field = 'value' '' syntax - it's not supported by all databases.
*  Use ''CASE WHEN (cond) THEN (true) ELSE (false) END'' instead of ''IF(cond,true,false)''.
*  Use ''LIMIT count OFFSET offset'' instead of ''LIMIT offset,count''.

[This document from Drupal's wiki is also helpful](http://drupal.org/node/555514)


#### Writing DataObject queries to be compatible with both SilverStripe 2.3 and 2.4

The database abstraction work in SilverStripe 2.4 mean that tables need to be escaped with ''"'' instead of ''`''.  However, this new escaping syntax isn't compatible with SilverStripe 2.3.  If you're trying to make a module that will run on both, this is a problem.

The only way around this is to introduce code into your module to switch between two different query syntaxes.  We can't introduce a method to do this check for us, because the method wouldn't exist in the older versions of SilverStripe.

Instead, we have introduced a class constant, ''Database::USE_ANSI_SQL'', that you can check for the presence of this to switch between the two query syntaxes

	:::php
	if(defined('DB::USE_ANSI_SQL')) $filter = '"BlogEntry"`.Date > NOW() - INTERVAL 3 MONTH';
	else $filter = '`BlogEntry`.Date > NOW() - INTERVAL 3 MONTH)';


If you are building up a query in a more complex manner, it might be clearer to use a custom string-replacement method for switching the query:

	:::php
	$filter = "(`BlogEntry`.Date > NOW() - INTERVAL 3 MONTH)";
	
	if(isset($_GET['AuthorID'] && is_numeric($_GET['AuthorID'])) {
	   $filter .= "AND (`BlogEntry`.AuthorID = '" . Convert::raw2sql($_GET['AuthorID') . "')";
	}
	
	if(defined('DB::USE_ANSI_SQL')) $filter = str_replace('`BlogEntry`', '"BlogEntry"', $filter);


#### See also

For more in-depth information on database compatability, see [sql-syntax-compatibility](sql-syntax-compatibility)
