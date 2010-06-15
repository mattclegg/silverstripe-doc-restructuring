# AutoCompleteField
## Introduction

AutoCompleteField is part of the [DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html) package that renders a live autocomplete textfield for returning results as the user types. It is useful for search forms that provide suggestions before a search is executed.

## Usage

The field constructs just like a text field, accepting the $name and $title arguments first. The third argument is for a URL, and the fourth is for a default value. The default value is nullified on focus by a Javascript inclusion.
### Setting the URL

By default, if no $url argument is passed, the AutoCompleteField will look for the function "autocomplete" on the current controller.

~~~ {php}
new AutoCompleteField('Search','Search');
~~~

The field will try to run a request on the current controller, using the action "autocomplete". For instance, if the current page is an "ArticleHolder", the field will try to access // /your-article-holder-page/autocomplete. //

You can also use a custom function name:

~~~ {php}
new AutoCompleteField('Search','Search','myautocomplete');
~~~

This will run // /your-article-holder-page/myautocomplete //

The most flexible way to get results is by passing a custom URL. This is especially useful when the AutoCompleteField is located on many different pages, and you cannot guarantee that any given controller will have the autocomplete() function available.

~~~ {php}
new AutoCompleteField('Search','Search', DataObject::get_one("HomePage")->Link('myautocomplete'));
~~~



### Writing the Callback Function

This is where all the magic happens, and for that reason, this is left fully customizable by the user. Let's look at an example function.

~~~ {php}
	public function autocompletesearch() {
		if(isset($_REQUEST['Search']) && !empty($_REQUEST['Search'])) {
                        $key = Convert::raw2sql($_REQUEST['Search']);
                        $result = DataObject::get("MyObject", "SomeField LIKE '%{$key}%'");
			return AutoCompleteField::render($result);
		}
	}

~~~

This is one of the most fundamental approaches to returning a result set to the AutoCompleteField. It accepts the request parameter containing the keywords. This is the same as the $name property assigned to the form field. Then, results are rendered using the shortcut AutoCompleteField::render() in lieu of a custom template. The render() function uses the native template // AutoComplete_default.ss //. 

In order to populate this default template, the object(s) in your the result set must have fields or functions defined for "Title" and "Summary."

For example:

~~~ {php}
class MyObject extends DataObject {
     static $db = array(
       'Title' => 'Text',
       'Description' => 'Text'
     );

      public function Summary() {
          return $this->obj('Description')->CharacterLimit(60);
      }
}

~~~

Results can also be rendered in a custom template using the standard renderWith() method.


~~~ {php}
	public function autocompletesearch() {
		if(isset($_REQUEST['Search']) && !empty($_REQUEST['Search'])) {
                        $key = Convert::raw2sql($_REQUEST['Search']);
                        $set = DataObject::get("MyObject", "SomeField LIKE '%{$key}%'");
			return $this->customise(array(
                          'Results' => $set
                        ))->renderWith('MyCustomTemplate');
		}
	}

~~~
