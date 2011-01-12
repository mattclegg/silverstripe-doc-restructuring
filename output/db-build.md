SilverStripe has a powerful tool for automatically building database schemas.  We've designed it so that you should
never have to build them manually.

To access it, visit (site-root)/dev/build?flush=1.  This script will analyze the existing schema, compare it to what's
required by your data classes, and alter the schema as required.  

Put the ?flush=1 on the end if you've added PHP files, so that the rest of the system will find these new classes.

It will perform the following changes:


*  Create any missing tables

*  Create any missing fields

*  Create any missing indexes

*  Alter the field type of any existing fields

*  Rename any obsolete tables that it previously created to _obsolete_(tablename)

It **won't** do any of the following


*  Deleting tables

*  Deleting fields

*  Rename any tables that it doesn't recognize - so other applications can co-exist in the same database, as long as
their table names don't match a SilverStripe data class.
