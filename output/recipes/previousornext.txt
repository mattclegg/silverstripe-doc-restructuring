# Previous or Next Buttons

If you want people to go through your site, one page at the time, using previous and next buttons then you could consider the following code:

~~~ {php}
class Page_Controller extends ContentController {

 public function nextPager() {
  $where = "ParentID = ($this->ParentID + 0) AND Sort > ($this->Sort + 0 )";
  $pages = DataObject::get("SiteTree", $where, "Sort", "", 1);
  if($pages) {
   foreach($pages as $page) {
    return $page;
   }
  }
 }
 public function previousPager() {
  $where = "ParentID = ($this->ParentID + 0) AND Sort < ($this->Sort + 0)";
  $pages = DataObject::get("SiteTree", $where, "Sort DESC", "", 1);
  if($pages) {
   foreach($pages as $page) {
    return $page;
   }
  }
 }
}
~~~

In your template - this would work as follows:

~~~ {html}
 <% control previousPager %>
  <a href="$URLSegment">go to the previous page: $Title</a>
 <% end_control %>
 <% control nextPager %>
  <a href="$URLSegment">go to the next page: $Title</a>
 <% end_control %>

~~~

