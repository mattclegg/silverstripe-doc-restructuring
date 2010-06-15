# UniqueRestrictedTextField
Text field that automatically checks that the value entered is unique for the given set of fields in a given set of tables

{{:uniquerestrictedfield.png|uniquerestrictedfield.png}}

### Code Example
A good implementation example can be the URLSegment TextField from the CMS:

~~~ {php}
new UniqueRestrictedTextField(
   "URLSegment",
   "URLSegment",
   "SiteTree",
   "Another page is using that URL. URL must be unique for each page",
   "[^A-Za-z0-9-]+",
   "-",
   "URLs can only be made up of letters, digits and hyphens.",
   "",
   "",
   "",
   50
)
~~~
 
### API documentation
[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-formattedinput/UniqueRestrictedTextField.html).
