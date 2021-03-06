## Introduction

SimpleWysiwygField is a lightweight alternative to TinyMCE that uses the
[HTMLBox](http://remiya.com/cms/projects/jquery-plugins/htmlbox/) jQuery plugin.  It is mostly used in popup windows for
[DataObjectManager](modules/dataobjectmanager) instances. 

## Configuration

Use SimpleWysiwygField::set_default_configuration() for a global config (seen below) or use $object->configure(); for an
instance-level config.

*_config.php*

	:::php
	  SimpleWysiwygField::set_default_configuration(array(
	    array('cut','copy','paste','|','bold','italic','underline','|','left','center','right'),
	    array('ol','ul','|','hyperlink','unlink','image','|','formats')
	  ));


*YourPage.php*

	:::php
	$fieldset->push($wysiwyg = new SimpleWysiwygField('SomeField'));
	$wysiwyg->configure(
	array(
	    array('cut','copy','paste','|','bold','italic','underline','|','left','center','right'),
	    array('ol','ul','|','hyperlink','unlink','image','|','formats')
	  )
	)


## Usage

Each nested array in the configuration starts a new row. To group buttons, use a pipe '|' for a dotted separator.

## Available Buttons

 | **Button Name** | **Function**                                                                                       
          | 
 | --------------- | ------------                                                                                       
          | 
 | cut             | Cuts the selected text from the editor and places it in the clipboard.                             
          | 
 | copy            | Copies the selected text in the editor and places it in the clipboard.                             
          | 
 | paste           | Pastes the text from the clipboard in the editor at the place of the cursor                        
          | 
 | bold            | Makes bold the selected text in the editor.                                                        
          | 
 | italic          | Makes italic the selected text in the editor                                                       
          | 
 | underline       | Makes underlined the selected text in the editor.                                                  
          | 
 | strike          | Makes striked the selected text in the editor.                                                     
          | 
 | sup             | Makes supersript the selected text in the editor                                                   
          | 
 | sub             | Makes subscript  the selected text in the editor.                                                  
          | 
 | left            | Aligns the selected text in the editor to the left.                                                
          | 
 | center          | Aligns the selected text in the editor to the center.                                              
          | 
 | right           | Aligns the selected text in the editor to the right.                                               
          | 
 | justify         | Aligns the selected text in the editor justified to the right.                                     
          | 
 | ol              | Places selected lines in the editor in an ordered list.                                            
          | 
 | ul              | Places selected lines in the editor in an unordered list.                                          
          | 
 | indent          | Indents the selected text in the editor                                                            
          | 
 | outdent         | Outdents the selected text in the editor.                                                          
          | 
 | hyperlink       | Creates a hyperlink from the selected text in the editor, after the user is prompted to insert a
web address. | 
 | image           | Creates an image in the editor, after the user is prompted to insert a the path to the image.      
          | 
 | code            | Shows the HTML code of the editor. The generated HTML differs in the different browsers.           
          | 
 | fontsize        | Changes the font size of the selected text in the editor                                           
          | 
 | fontfamily      | Changes the font family of the selected text in the editor                                         
          | 
 | fontcolor       | Changes the font color of the selected text in the editor                                          
          | 
 | highlight       | Highlights the selected text in the editor                                                         
          | 



