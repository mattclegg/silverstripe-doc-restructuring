# Multilingual Content - alternative to 'translatable'


**PLEASE NOTE: the translatable feature has been substantially rewritten as of silverstripe 2.3.2 so please refer to http://doc.silverstripe.org/doku.php?id=multilingualcontent instead of the hack described here**

## What it's about


As the current 'translatable' implementation (in 2.2.3) is troublesome concerning the UI as well as the caching behaviour (same urls for different languages), here is a rather simple alternative for building an i18n-capable site.

Note: Things are announced to get better in version 2.4, so the information here may be of no use then anymore.

This approach is inspired by an old thread in the forum (http://silverstripe.org/archive/show/543) although it overcomes some problems mentioned there.
It's also related to the solution 'fuzz10' posted in the forums (http://www.silverstripe.org/archive/show/59870), but using another way to build the urls.

In short, different fields are added in the CMS for translatable content, which is shown when a language prefix is present in the url (such as mysite.com/de/about)

Pros:\\ 
+ SEO-friendly, cacheable urls like 'mysite.com/about' and 'mysite.com/en/about'\\ 
+ no changes to the core, overriding related functions\\ 

Cons:\\ 
- Some additional code in different places\\ 
- No extra site-tree in the cms for different languages, just a new tab for all translatable fields\\ 

## How to get there

In this tutorial we'll set up a second language (english) for a site using german as it's default language.

### Step 1: fields for additional language content

We are going to hold our translated content in additional database fields. 
For each content item we wish to have translated, add a field to the 'db' array of your 'Page' class in your 'mysite' folder.
Add the language shortcut to the name of the field, for example 'Content_en'.
Do this for every field in every language you need to have translated.
To get things started we'll just have the 'Content' and 'MenuTitle' fields in english.
Your code should know look somewhat like this:
~~~ {php}
class Page extends SiteTree {
	static $db = array(	
		'MenuTitle_en' => 'Text',
		'Content_en' => 'HTMLText'	
	);
...
~~~
As we need to edit these fields in the CMS, we'll create a new tab called 'English' (add your own for multiple languages).
Again in you page class, add the following:
~~~ {php}
	function getCMSFields() {
		$fields = parent::getCMSFields();	
		$fields->addFieldToTab('Root.Content.English', new TextField('MenuTitle_en', 'Navigation Label'));
		$fields->addFieldToTab('Root.Content.English', new HtmlEditorField('Content_en', 'Content'));
		return $fields;
	} 
~~~
Log in to the CMS and rebuild your database (visit mysite.com/db/build?flush=1). 
You should now see a new tab 'English' containing the translatable fields.
Create a new page 'news' and add some english content.

We're done for the translation - but how to tell SilverStripe to show it?

==== Step 2: ==== 

First, set up a Director rule for you additional language.
Edit '_config.php' in your 'mysite' folder and add the following:
~~~ {php}
Director::addRules(100, array(
	'en/$URLSegment/$Action/$ID/$OtherID' => 'MultiLingual'
));
~~~
This will have requests to urls prefixed by your language shortcut handled by a class called 'Multilingual', which we are going to create next.
In case you want to add multiple languages, just duplicate the line 'en/$URLSegment...' and replace the language prefix. 

Now, let's create the 'MultiLingual' class extending the otherwise used 'ModelAsController' class.
Create a file named 'MultiLingual.php' in your 'mysite' folder with the following code:
~~~ {php}
class MultiLingual extends ModelAsController {	
	static $lang;	
	function init() {
		$baseUrl = Director::baseUrl();
		$requestUri = $_SERVER['REQUEST_URI'];
		$lang = substr($requestUri, strlen($baseUrl), 2);		
		self::$lang = $lang;
		//prevents default behaviour of redirecting to '/' for '/en/'
		if($this->URLParams['URLSegment'] == "" || $this->URLParams['URLSegment'] == 'home') {
			$urlparams = array('URLSegment' => 'home', 'Action' => ' ');
			$this->setURLParams($urlparams);
		}		
		parent::init();
	}
	static function currentLang() {
		return self::$lang;
	}	
} 
~~~
Our newly created class 'MultiLingual' will now filter the language shortcut out of the URL, 
providing it for further reference using the 'currentLang' function.
We'll use this function in our 'Page' class to determine which fields to show, overriding the 'getField' method.
For each field rendered in the template, we'll make SilverStripe search for a translated version; in case it doesn't find one, it uses the original field. 
So next, add the following to the 'Page' class:
~~~ {php}
	protected function getField($field) {		
		$lang = MultiLingual::currentLang();
		$langField = $field.'_'.$lang;
		if(isset($this->record[$langField])) {
			return $this->record[$langField];
		} else {
			return isset($this->record[$field]) ? $this->record[$field] : null;
		}
	}
~~~
If you point your browser to 'yoursite.com/en/about-us' now, the english content is shown. Nice!


### Step 3: Navigation and Linking

Navigation ist mostly implemented using the 'Menu()' controls in templates like so:
~~~ {html}
<ul>
<% control Menu(1) %>
<li><a href="$Link">$MenuTitle</a></li>
<% end_control %> 
</ul>
~~~
Thanks to our 'MenuTitle_en' field (and overriding the 'getField' method), using the 'Menu()' control will show a translated navigation.

Unfortunately, the navigation links are still pointing to the original URLs, not reflecting our current language.
This is due to the use of '$Link', which calls a method defined in class 'SiteTree'.
In order to make this function return the appropriate links, we have to overwrite it in our Page class like so:
~~~ {php}
	public function Link($action = null) {
		if($action == "index") {
			$action = "";
		}
		$lang = MultiLingual::currentLang();
		$langSegment = ($lang != "") ? "$lang/" : "";
		return Director::baseURL() . $langSegment . $this->URLSegment . "/$action";
	}
~~~
Be careful: This is only true for the use of $Link inside a control block! Using a plain $Link in your template (to render the link to the current page),
we also have to overwrite the Link() method defined in the 'ContentController' class.
Add the following to your 'Page_Controller' class:
~~~ {php}
	public function Link($action = null) {
		$lang = MultiLingual::currentLang();
		$langSegment = ($lang != "") ? "$lang/" : "";
		return Director::baseURL() . $langSegment . $this->RelativeLink($action);
	}
~~~
As presumably no one will just try using language prefixes in their URLs, you might also wish to include a language switcher. The simplest method is to have links to the home pages of all language version in the header, such as 'mysite.com/home' - in this case for the german version - and 'mysite.com/en/home' for the english.
