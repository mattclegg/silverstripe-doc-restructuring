# HTML Editor Config

To customize the default tinymce configuration you can use HTMLEditorConfig class. 

**Note this functionality is likely to be changed in future releases.** and should only be considered as a temporary way of modifying the editor.

## How to Use

You can customize the installation by adding the following examples to your  getCMSFields(). This will normally be found in /mysite/code/Page.php, chances are if it's not there, you know where to find it.

Or if you want to apply the TinyMCE changes over all the text area fields you can add the code to your mysite/_config.php file.

~~~ {php}
// mysite/code/Page.php
public function getCMSFields() {
		$fields = parent::getCMSFields();
		
		HtmlEditorConfig::get('cms')->setOption('verify_html', 'false');

 		return $fields;
	}

// or in your mysite/_config.php
HtmlEditorConfig::get('cms')->setOption('verify_html', 'false');
~~~


## Enabling a Custom Plugin
~~~ {php}
// mysite/_config.php
HtmlEditorConfig::get('cms')->enablePlugins('../../tinymce_ssmacron'); // enables plugin
HtmlEditorConfig::get('cms')->insertButtonsAfter('charmap', 'ssmacron'); // positions plugin
~~~

## Setting TinyMCE Options (eg valid elements)
You can customize any of the [TinyMCE](http://wiki.moxiecode.com/index.php/TinyMCE:Configuration) options by calling setOption('optionname', 'value').

### Customizing allowed HTML

If you want to extend the HTML that the textarea can support you can do so by adding the elements to the valid_elements or extended_valid_elements list. If the HTML you want to insert is not in one of these arrays it will be stripped out.

For example if you wanted to allow an html element <foo> you can add it to the list

~~~ {php}
// mysite/_config.php or in your specific form
HtmlEditorConfig::get('cms')->setOptions(array(
	'valid_elements' => "@[id|class|style|title],#a[id|rel|rev|dir|tabindex|accesskey|type|name|href|target|title|class],-strong/-b[class],-em/-i[class],-strike[class],-u[class],#p[id|dir|class|align|style],-ol[class],-ul[class],-li[class],br,img[id|dir|longdesc|usemap|class|src|border|alt=|title|width|height|align],-sub[class],-sup[class],-blockquote[dir|class],-table[border=0|cellspacing|cellpadding|width|height|class|align|summary|dir|id|style],-tr[id|dir|class|rowspan|width|height|align|valign|bgcolor|background|bordercolor|style],tbody[id|class|style],thead[id|class|style],tfoot[id|class|style],#td[id|dir|class|colspan|rowspan|width|height|align|valign|scope|style],-th[id|dir|class|colspan|rowspan|width|height|align|valign|scope|style],caption[id|dir|class],-div[id|dir|class|align|style],-span[class|align|style],-pre[class|align],address[class|align],-h1[id|dir|class|align|style],-h2[id|dir|class|align|style],-h3[id|dir|class|align|style],-h4[id|dir|class|align|style],-h5[id|dir|class|align|style],-h6[id|dir|class|align|style],hr[class],dd[id|class|title|dir],dl[id|class|title|dir],dt[id|class|title|dir],@[id,style,class]",
	'extended_valid_elements' => "foo,img[class|src|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name|usemap],iframe[src|name|width|height|align|frameborder|marginwidth|marginheight|scrolling],object[width|height|data|type],param[name|value],map[class|name|id],area[shape|coords|href|target|alt]"
));
~~~

The [ ] define what attributes you can add to <foo> for example <foo class="baz" title="Bar"> would be represented as foo[class|title]

### Allowing javascript in the content editor

A common situation is a page requires its own javascript to be added in the cms. You can extend the valid options to allow for javascript by adding this to your mysite/_config file

~~~ {php}
HtmlEditorConfig::get('cms')->setOption('extended_valid_elements', "script[type|src],img[class|src|alt|title|hspace|vspace|width|height|align|onmouseover|onmouseout|name|usemap],iframe[src|name|width|height|align|frameborder|marginwidth|marginheight|scrolling],object[width|height|data|type],param[name|value],map[class|name|id],area[shape|coords|href|target|alt]");
~~~
### Turning off all HTML Validation

By default TinyMCE provides a restrictive set of HTML which it deems as 'safe'. Please remember that malformed or malicious HTML is a very real threat so disabling HTML validation for fields which accept user contributed content is risky. You should only disable validation and extend valid elements as a last resort.

~~~ {php}
// mysite/_config.php
HtmlEditorConfig::get('cms')->setOption('verify_html', 'false'); // turn off html validation 
~~~
