### Introduction

The SimpleHTMLEditorField is part of the [DataObjectManager](DataObjectManager) package. It allows WYSIWYG text editing
in a popup window using [jwygiwyg](http://projects.bundleweb.com.ar/jWYSIWYG/), a lightweight jQuery-based plugin.


### Usage

	:::php
	new SimpleHTMLEditorField('Content','Enter some content', array (
	  'css' => 'mysite/css/my_simple_stylesheet.css',
	  'insertUnorderedList' => true,
	  'copy' => true,
	  'justifyCenter' => false
	   
	   // See "Configuration" for a list of all configuration variables.
	));



### Configuration

The third argument of the SimpleHTMLEditor field is a configuration array of key/value pairs. Available configuration
settings are:


*  *css* : Path to a custom stylesheet for the HTML editor (used to match the styles of your website)


*  *insertOrderedList* : Allow the "unordered list" button in the toolbar (boolean)
    

*  *insertUnorderedList* : Allow the "ordered list" button in the toolbar (boolean)
    

*  *justifyLeft* : Allow the "justify left" button in the toolbar (boolean)
    

*  *justifyRight* : Allow the "justify right" button in the toolbar (boolean)
    

*  *justifyCenter* : Allow the "justify center" button in the toolbar (boolean)
    

*  *justifyFull* : Allow the "justify full" button in the toolbar (boolean)
    

*  *cut* : Allow the "cut" button in the toolbar (boolean)
    

*  *copy* : Allow the "copy" button in the toolbar (boolean)
    

*  *paste* : Allow the "paste" button in the toolbar (boolean)
    

*  *increaseFontSize* : Allow the "increase font size" button in the toolbar (boolean)
    

*  *decreaseFontSize* : Allow the "decrease font size" button in the toolbar (boolean)

### Screenshot

{{:simplehtmleditorfield.gif|:simplehtmleditorfield.gif}}

### Known Bugs

jwysiwyg has some issues with Firefox related to removing formatting from a block of text. As of this writing, it is in
the process of being patched by its developer.



