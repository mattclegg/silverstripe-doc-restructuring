# Introduction
Sometimes, you will want the content that appears in your template to be slightly different from the content entered into the CMS.

For example, you might want to let your author position a dynamic element, such as a paypal button, by entering a special token such as $Paypal into the content.

What we need to do then is to load the content. Look through it for the token ($Paypal) and replace it with something else. Luckily in PHP its simple

~~~ {php}
str_replace('$Paypal', $this->PaypalButton(), $this->Content);
~~~

How do we get the template to use this as the content, without affecting the CMS?   We define a method called Content() in the Page.php file in the Page_Controller class.

~~~ {php}
function Content() {
  return str_replace('$Paypal', $this->PaypalButton(), $this->Content);
}
// see the $this->PaypalButton() string up 2 lines? well that calls the Paypal() method below
function PaypalButton() {
  return "This could be HTML/Text/Images or PHP";
}
~~~


*  The Content field will be used by the CMS to populate the WYSIWYG editor - it ignores any Content() method that exists.
*  The Content() method will be used in preference to the Content field by the template processor.

This technique of creating a function the same name as a field can be used to set up special behaviour for a field when it is referenced within a template.

You can also extend this idea and include a whole separate template by using renderWith() 

~~~ {php}
function Content() {
  return str_replace('$Paypal', $this->PaypalButton(), $this->Content);
}
// see the $this->PaypalButton() string up 2 lines? well that calls the Paypal() method below
function PaypalButton() {
  return $this->renderWith("Paypal");
}
~~~
** themes/blackcandy/templates/Includes/Paypal.ss **
~~~ {html}
<p>This could be HTML/Text/Images or PHP</p>

~~~

# Related
*  See [:custom-page-controls](/custom-page-controls) for more copy/paste snippets to easily customize the data available to your templates.
