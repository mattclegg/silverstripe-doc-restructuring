There maybe times when you want to equally distribute your main menu items on a page, e.g.
 | menu item 1 | menu item 2 | menu item 1 | menu item 3 | 
 | ----------- | ----------- | ----------- | ----------- | 

However, you also want the publisher to be able to add/delete menu items.  The code below can help in this case (note that you can achieve the same thing using Javascript).


In the /mysite/_config.php file you put

~~~ {php}
global $pageWidth; $pageWidth = 750;
~~~

In the /mysite/code/page.php file you put:

~~~ {php}

class Page_Controller extends ContentController {
 
 function init() {
  parent::init();
 } 
 function totalPageWidth() {
  global $pageWidth;
  return $pageWidth; //defined in _config file
 }

 function numberOfMenuColumns () {
  $object = DataObject::get("SiteTree", "ParentId = 0 AND ShowInMenus = 1");
  return $object->count();
 }
 
 function standardMenuColumWidth() {
  return floor($this->totalPageWidth() / $this->numberOfMenuColumns());
 }
 function firstMenuColumnWidth() {
  return $this->totalPageWidth() - (($this->numberOfMenuColumns() - 1) * $this->standardMenuColumWidth());
 }


~~~


Then in the /template/Page.ss you put:
<head>
...
~~~ {html}
 <style type="text/css">
  #menu div {width: {$standardMenuColumWidth}px;}
  #menu div.current {width: {$firstMenuColumnWidth}px;
 </style>
...
</head>
<body>
 <ul id="menu">
<% control Menu(1) %>
  <li class="$LinkingMode" style="width: <% if First %> $firstMenuColumnWidth <% else %> $standardMenuColumWidth <% end_if %>px;">
   <a href="$Link" class="$LinkOrSection">$MenuTitle</a>
  </li>
<% end_control %>
 </ul>
...
~~~


