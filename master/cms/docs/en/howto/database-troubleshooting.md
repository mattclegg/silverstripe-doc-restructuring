## Orphaned data in sub-tables

**Symptom:** You try and add a new record and when you have it you get a "Duplicate ID ### in table subtable" error. 
Occurs most frequently with SiteTree subclasses, due to their heavy use of the inheritance feature.

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
