# Introduction

This is a highlevel overview of available FormFields. An automatically generated list is available through our [API
Documentation](http://api.silverstripe.org/2.4/forms/core/FormField.html). 

## Formatted Input

*  [AjaxUniqueTextField](AjaxUniqueTextField): Text field that automatically checks that the value entered is unique for
the given set of fields in a given set of tables
*  [AutocompleteTextField](AutocompleteTextField)
*  [ConfirmedPasswordField](ConfirmedPasswordField): Shows two password-fields, and checks for matching passwords.
*  [CreditCardField](CreditCardField)
*  [CurrencyField](CurrencyField)
*  [EmailField](EmailField)
*  [HTMLEditorField](HTMLEditorField): A WYSIWYG editor field, powered by tinymce.
*  [NumericField](NumericField): A Single Numeric field extending a typical TextField but with validation.
*  [PasswordField](PasswordField)
*  [UniqueRestrictedTextField](UniqueRestrictedTextField): Text field that automatically checks that the value entered
is unique for the given set of fields in a given set of tables
*  [UniqueTextField](UniqueTextField): Text field that automatically checks that the value entered is unique for the
given set of fields in a given set of tables

## Date/Time

*  [DateField](DateField): Represents a date in a textfield (New Zealand)
*  [DatetimeField](DatetimeField): Combined date- and time field
*  [TimeField](TimeField): Represents time in a textfield (New Zealand)

## Structure

*  [CompositeField](CompositeField): Base class for all fields that contain other fields. Uses `<div>` in template, but
doesn't necessarily have any visible styling.
*  [FieldGroup](FieldGroup): Same as CompositeField, but has default styling (indentation) attached in CMS-context.
*  `[api:FieldSet]`: Basic container for sequential fields, or nested fields through CompositeField. Does NOT render a
`<fieldgroup>`.
*  [TabSet](TabSet)
*  [Tab](Tab)


## Actions

*  `[api:Form]` for more info
*  [InlineFormAction](InlineFormAction):  Render a button that will act as If you want to add custom behaviour, please
set {inlcudeDefaultJS} to false and work with behaviour.js.
*  `[api:Image]`: Action that uses an image instead of a button
*  [InlineFormAction](InlineFormAction): Prevents placement of a button in the CMS-button-bar.

## Files

*  [FileField](FileField): Simple file upload dialog.
*  [FileIFrameField](FileIFrameField): File uploads through an iframe
*  `[api:Image]`: Image upload through an iframe, with thumbnails and file-selection from existing assets
*  [SimpleImageField](SimpleImageField):  SimpleImageField provides an easy way of uploading images to Image has_one
relationships. Unlike ImageField, it doesn't use an iframe.


## Relations

*  [ComplexTableField](ComplexTableField): Provides a tabuar list in your form with view/edit/add/delete links to modify
records with a "has-one"-relationship (in a lightbox-popup).
*  [HasManyComplexTableField](HasManyComplexTableField)
*  [HasOneComplexTableField](HasOneComplexTableField)
*  [LanguageDropdownField](LanguageDropdownField):  An extension to dropdown field, pre-configured to list languages.
Tied into i18n.
*  [ManyManyComplexTableField](ManyManyComplexTableField)
*  [TableField](TableField)
*  `[api:TableListField]`
*  [TreeDropdownField](TreeDropdownField)
*  [TreeMultiselectField](TreeMultiselectField): represents many-many joins using a tree selector shown in a
dropdown-like element
*  `[api:WidgetArea]`



## Dataless/Utility

*  [DatalessField](DatalessField) - Base class for fields which add some HTML to the form but don't submit any data or
save it to the database
*  [HeaderField](HeaderField): Renders a simple `<h1>`-`<h6>` header
*  [HiddenField](HiddenField)
*  [LabelField](LabelField)
*  [LiteralField](LiteralField): Renders arbitrary HTML into a form.

## CMS Field Editor

Please see [fieldeditor](fieldeditor) for in-depth documentation about custom forms created through a GUI in the CMS.
