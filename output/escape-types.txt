# Introduction

Method and variables names that deal with strings or arrays of strings should have one of the following 5 prefixes:


*  **RAW_** Raw plain text, as a user would like to see it, without any HTML tags
*  **XML_** Text suitable for insertion into an HTML or XML data-set.  This may contain HTML content, for example if the content came from a WYSIWYG editor.
*  **SQL_** Data that can safely be inserted into the database - all quotes escaped, etc.  This //may or may not// contain HTML, depending on the field type
*  **JS_** Data that can safely be inserted into JavaScript code.
*  **ATT_** Data that can safely be inserted into an XML or HTML attribute.

The same prefixes are used for both strings and arrays of strings.  We did this to keep things simple: passing a string with the wrong encoding is a far subtler a problem than passing an array instead of a string, and therefore much harder to debug.

### Conversion between formats

The [Convert](Convert) class has a number of methods of the form Convert::(prefix)2(prefix), that will be able to convert from one form to another.  They can take either strings or arrays and perform appropriate conversions.  When converting an array, only the values are converted, not the keys.

For example, Convert::raw2sql($RAW_input), will escape raw data.  This simple code fragment illustrates hwo this might be used.
~~~ {php}
$SQL_request = Convert::raw2sql($_REQUEST);
DB::query("INSERT INTO MyTable SET FirstName = '$SQL_request[FirstName]', Surname = $SQL_request[Surname]");
~~~

### Extraction of formats from data objects

The [ViewableData](ViewableData) class, parent to most objects you'll deal with in SilverStripe, has a number of methods of the form (prefix)_val.  These functions will convert the value of a field or result of a method call to the correct value for you.

~~~ {php}
$member->RAW_val("FirstName"); // Returns "Boris 'the blade' & Trudy"
$member->SQL_val("FirstName"); // Returns "Boris \'the blade\' & Trudy"
$member->XML_val("FirstName"); // Returns "Boris 'the blade' &amp; Trudy"
$member->JS_val("FirstName"); // Returns "Boris 'the blade' & Trudy"
$member->ATT_val("FirstName"); // Returns "Boris &#39;the blade&#39; &amp; Trudy"
~~~
