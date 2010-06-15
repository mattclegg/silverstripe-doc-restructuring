**Please Note: This is a //temporary page//. It will be integrated within a tutorial shortly. It may not be entirely accurate. Please report any problems with this page in [this forum post.](http://www.silverstripe.com/general-discussion/flat/339/)**
----
The information at the bottom of the Wiki page [built-in-page-controls ](built-in-page-controls#properties_of_a_datafeed_itself_rather_than_one_of_its_items) should help you here. The following code assumes you've built the site from the first and second tutorials (So you should have ArticleHolder and ArticlePage page types).

Firstly, we'll need to change how we get the article pages from the database. While **<% control Children %>** is useful for simple listing of items, it's not terribly useful when you have lots of children of the current page.

First off, your current ArticleHolder.ss template, you should have this text currently:
`<% control Children %>`{html}

Change this with:
`<% control NewsArticles %>`{html}

Now what we need to do is get a limited DataObjectSet of the pages that you want to show on one page, so add this to the ArticleHolder_Controller class:
~~~ {php}
/**
 * Get the latest 2 news articles, allowing us to get more
 *
 * @return DataObjectSet|false The DataObjectSet of the news articles you're looking at or boolean false if there aren't any news articles
 */
function NewsArticles() {
  if(!isset($_GET['start']) || !is_numeric($_GET['start']) || (int)$_GET['start'] < 1) $_GET['start'] = 0;
  $SQL_start = (int)$_GET['start'];
  $doSet = DataObject::get(
    $callerClass = "ArticlePage",
    $filter = "`ParentID` = '".$this->ID."'",
    $sort = "",
    $join = "",
    $limit = "{$SQL_start},2"
  );

  return $doSet ? $doSet : false;
}
~~~

Now that you've added that, you can use the template variables on the page I linked above. Note that they should go outside of the **<% control NewsArticles %>**, because they're all methods and properties of the DataObjectSet, not the DataObjects inside it.

As an example, you could now use the following template, inserted directly after the **<% end_control %>** line:

~~~ {html}
<% if NewsArticles.MoreThanOnePage %>
  <p>
  <% if NewsArticles.PrevLink %>
    <a href="$NewsArticles.PrevLink">&lt;&lt; Prev</a> | 
  <% end_if %>

  <% control NewsArticles.Pages %>
    <% if CurrentBool %>
      <strong>$PageNum</strong> 
    <% else %>
      <a href="$Link" title="Go to page $PageNum">$PageNum</a> 
    <% end_if %>
  <% end_control %>

  <% if NewsArticles.NextLink %>
    | <a href="$NewsArticles.NextLink">Next &gt;&gt;</a>
  <% end_if %>
  </p>
<% end_if %>
~~~

This would generate a fairly simple list, similar to this:
`Prev | 1 2 3 4 | Next`

(Of course, the 'Prev' and 'Next' links would only appear if there is a previous or next page to go to, and it would only show as many page numbers as required).
