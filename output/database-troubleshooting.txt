## Orphaned data in sub-tables

**Symptom:** You try and add a new record and when you have it you get a "Duplicate ID ### in table subtable" error.  Occurs most frequently with SiteTree subclasses, due to their heavy use of the inheritance feature.

What's happened is that data has been deleted from the SiteTree table, but not from related tables, such as Page.

*  The highest ID in SiteTree is 31, so 32 is chosen as the next ID. 
*  ID #32 is inserted into SiteTree successfully.
*  ID #32 is inserted into Page, however, Page already contains ID #32.
*  We get an error "Can't insert duplicate ID 32 into Page".

**Solution:**

*  Remove the orphaned records from sub-tables such as Page manually.  Don't forget to remove them Page_Live as well.

**Long term solutions:**

*  We should stop the system from recycling ID #s.
*  We should enforce relational integrity.


## Zombie fields in tables

**Symptom:** You're trying to edit a field but the save just won't stick.  This most often affects fields that have been in the system for some time and it's broken after some changes you made.

What's happened is that a field, such as ImageID, was inserted into two subclasses of SiteTree.  As long as both data-objects have this field in their $db or $has_one list, the fields will be kept in sync.

If you remove one of these fields from the PHP definition, it will no longer be updated.  But db/build won't remove the field from the database (that would risk data-loss), and so it will be returned by the DataObject::get select queries - it's a Zombie field, that will never get updated, and in some cases will overwrite the living ImageID field, preventing any changes from being seen.

**Solution:**

*  Identify and remove Zombie fields from the database using phpMyAdmin.  Don't forget to remove them _Live tables as well.


**Long term solution:**

*  Don't let Dataobject::get return fields that aren't listed in $db and $has_one.  Zombie fields should be completely ignored by SilverStripe.
