## Database set up

Create data-object types, NewsArticle and NewsSection. Give NewsArticle fields called Date and Abstract.  Abstract could be generated from a content summary, if preferred.

	:::php
	class NewsSection extends Page {
	  static $allowed_children = array("NewsSection", "NewsArticle");
	  static $default_child = "NewsArticle";
	}

	class NewsSection_Controller extends Page_Controller {
	}


	:::php
	class NewsArticle extends Page {
	  static $db = array(
	    "Date" => "Date",
	    "Abstract" => "Text",
	  );
	  static $allowed_children = 'none';
  
	  function getCMSFields() {
	    $fields = parent::getCMSFields();
   
	    $fields->addFieldToTab("Root.Content.Main", new DateField("Date","Date"), "Content");
	    $fields->addFieldToTab("Root.Content.Main", new TextareaField("Abstract","Abstract",4), "Content");
    
	    return $fields;
	  }
	}

	class NewsArticle_Controller extends Page_Controller {
	}

### News feed on the homepage

Set the class to 'latest-news'

A few examples:

Date / Title list:

	:::ss
	<% if LatestNews %>
	<h2>Latest news</h2>
	<ul class="latest-news">
	  <% control LatestNews %>
	  <li><a href="$Link"><span>$Date.Nice</span> - $Title</a></li>
	  <% end_control %>
	</ul>
	<% end_if %>

	:::ss
	<% if LatestNews %>
	<h2>Latest news</h2>
	<ul class="latest-news">
	  <% control LatestNews %>
	  <li>
	    <a href="$Link">$Date.Nice - $Title</a>
	    <div class="description">$Description</a
	   </li>
	  <% end_control %>
	</ul>
	<% end_if %>

	:::ss
	<ul class="latest-news">
	  <% control LatestNews %>
	  <li><a href="$Link">$Date.Nice - $Title</a></li>
	  <% end_control %>
	</ul>