# Introduction

These are the data-types that you can use when defining your data objects.  They are all subclasses of [DBField](http://api.silverstripe.org/current/sapphire/model/DBField.html). See also [form-field-types](form-field-types), which lists all fields you can use to put these data types in forms. See [tutorial:2-extending-a-basic-site](tutorial/2-extending-a-basic-site) for introducing their usage.
 

#  Types

*  [Varchar](http://api.silverstripe.org/current/sapphire/model/Varchar.html): A variable-length string of up to 255 characters, designed to store raw text
*  [Text](http://api.silverstripe.org/current/sapphire/model/Text.html): A variable-length string of up to 2 megabytes, designed to store raw text
*  [HTMLVarchar](http://api.silverstripe.org/current/sapphire/model/HTMLVarchar.html): A variable-length string of up to 255 characters, designed to store HTML
*  [HTMLText](http://api.silverstripe.org/current/sapphire/model/HTMLText.html): A variable-length string of up to 2 megabytes, designed to store HTML
*  [Enum](http://api.silverstripe.org/current/sapphire/model/Enum.html): An enumeration of a set of strings.

*  [Boolean](http://api.silverstripe.org/current/sapphire/model/Boolean.html): An boolean (true/false) field.
*  [Int](http://api.silverstripe.org/current/sapphire/model/Int.html): An integer field.
*  [Decimal](http://api.silverstripe.org/current/sapphire/model/Decimal.html)/[Float](http://api.silverstripe.org/current/sapphire/model/Float.html)/[Double](http://api.silverstripe.org/current/sapphire/model/Double.html): A decimal number.
*  [Currency](http://api.silverstripe.org/current/sapphire/model/Currency.html): A number with 2 decimal points of precision, designed to store currency values.
*  [Percentage](http://api.silverstripe.org/current/sapphire/model/Percentage.html): A decimal number between 0 and 1 that represents a percentage.

*  [Date](http://api.silverstripe.org/current/sapphire/model/Date.html): A date field
*  [SS_Datetime](http://api.silverstripe.org/current/sapphire/model/SS_Datetime.html): A date / time field
*  [Time](http://api.silverstripe.org/current/sapphire/model/Time.html): A time field

#### HTMLText vs. Text, and HTMLVarchar vs. Varchar

The database field types HTMLVarchar and Varchar are exactly the same in the database.  However, the templating engine knows to escape the Varchar field and not the HTMLVarchar field.  So, it's important you use the right field if you don't want to be putting $FieldType.XML everywhere.

If you're going to put HTML content into the field, please use the field type with the HTML prefix.  Otherwise, you're going to risk double-escaping your data, forgetting to escape your data, and generally creating a confusing situation.

# Usage

*  See [datamodel](datamodel) for information about **database schemas** implementing these types
*  See [objectmodel](objectmodel) for information about **casting** values to these types
