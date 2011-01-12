# Database Structure

SilverStripe is currently hard-coded to use a fix mapping between data-objects and the underlying database structure -
opting for "convention over configuration".  This page details what that database structure is. 

## Base tables

Each direct sub-class of DataObject will have its own table.

The following fields are always created.

*  ID: Primary Key
*  ClassName: An enumeration listing this data-class and all of its subclasses.
*  Created: A date/time field set to the creation date of this record
*  LastEdited: A date/time field set to the date this record was last edited

Every object of this class **or any of its subclasses** will have an entry in this table

### Extra Fields

*  Every field listed in the data object's **$db** array will be included in this table.
*  For every relationship listed in the data object's **$has_one** array, there will be an integer field included in the
table.  This will contain the ID of the data-object being linked to.  The database field name will be of the form
"(relationship-name)ID", for example, ParentID.

### ID Generation

When a new record is created, we don't use the database's built-in auto-numbering system.  Instead, we generate a new ID
by adding 1 to the current maximum ID.

##  Subclass tables

At SilverStripe's heart is an object-relational model.  And a component of object-oriented data is **inheritance**. 
Unfortunately, there is no native way of representing inheritance in a relational database.  What we do is store the
data sub-classed objects across **multiple tables**.

For example, suppose we have the following set of classes:

*  Class SiteTree extends DataObject: Title, Content fields
*  Class Page extends SiteTree: Abstract field
*  Class NewsSection extends SiteTree: *No special fields*
*  Class NewsArticle extend Page: ArticleDate field

The data for the following classes would be stored across the following tables:

*  SiteTree
    * ID: Int
    * ClassName: Enum('SiteTree', 'Page', 'NewsArticle')
    * Created: Datetime
    * LastEdited: Datetime
    * Title: Varchar
    * Content: Text
*  Page
    * ID: Int
    * Abstract: Text
*  NewsArticle
    * ID: Int
    * ArticleDate: Date

The way it works is this:

*  "Base classes" are direct sub-classes of DataObject.  They are always given a table, whether or not they have special
fields.  This is called the "base table"
*  The base table's ClassName field is set to class of the given record.  It's an enumeration of all possible
sub-classes of the base class (including the base class itself)
*  Each sub-class of the base object will also be given its own table, *as long as it has custom fields*.  In the
example above, NewsSection didn't have its own data and so an extra table would be redundant.
*  In all the tables, ID is the primary key.  A matching ID number is used for all parts of a particular record: 
record #2 in Page refers to the same object as record #2 in SiteTree.

To retrieve a news article, SilverStripe joins the SiteTree, Page and NewsArticle tables by their ID fields.  We use a
left-join for robustness; if there is no matching record in Page, we can return a record with a blank Article field.

## Staging and versioning

[todo]

## Schema auto-generation

Visiting the URL (your-site)/dev/build will run a script that automatically builds the database manifest.


## Related code

The information documented in this page is reflected in a few places in the code:

*  `[api:DataObject]`
    * requireTable() is responsible for specifying the required database schema
    * instance_get() and instance_get_one() are responsible for generating the database queries for selecting data.
    * write() is responsible for generating the database queries for writing data.
*  `[api:Versioned]`
    * augmentWrite() is responsible for altering the normal database writing operation to handle versions.
    * augmentQuery() is responsible for altering the normal data selection queries to support versions.
    * augmentDatabase() is responsible for specifying the altered database schema to support versions.
*  `[api:MySQLDatabase]`: getNextID() is used when creating new objects; it also handles the mechanics of
updating the database to have the required schema.


## Common Problems

See [database-troubleshooting](/howto/database-troubleshooting) for common issues that happen with our database structure.

## Future work

*  We realise that a fixed mapping between the database and object-model isn't appropriate in all cases.  In particular,
it could be beneficial to set up a SilverStripe data-object as an interface layer to the databases of other
applications.  This kind of configuration support is on the cards for development once we start looking more seriously
at providing avenues for clean integration between systems.
*  Some developers have commented that the the database layer could be used to maintain the relational integrity of this
database structure.  I don't know whether MySQL supports this or not, but in any case, this stuff would be available in
other database platforms if we chose to support them.
*  We'd like to support more than just MySQL, however, there needs to be a pretty good reason for doing so since it will
become something that needs to be supported for the rest of SilverStripe's life and could easily become an albatross. 
On the cards are MS SQL, PostgreSQL and SQLite.
*  It could be desireable to implement a non-repeating auto-numbering system.
