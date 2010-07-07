# Howto: Redirect to first child page

If you want to make a page redirect to the first child page, below is a simple recipe to do so. index() is called automatically when the page is viewed - so you can do your redirection here.

~~~ {php}
class PageName_Controller extends Page_Controller {

   function index() {
      if($children = $this->Children()) {
         if($firstChild = $children->First()) {
            Director::redirect($firstChild->Link());	
         }
      }
   }

}
~~~

It's very simple. It takes the first child - ''$this->Children()->First()'' if there are children of this page and redirects to that given first child page.