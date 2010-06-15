# ArrayData

Lets you wrap a bunch of array data into a ViewableData object.
 
For an example of ArrayData in use, see [tutorial:3-forms: Showing the poll results](tutorial/3-forms#showing_the_poll_results)

Here is an example of simply turning an Array into a ViewableData object so that it can displayed in a template:
~~~ {php}
// Create new data object set containing the subscribers who have not been sent this newsletter:
$unsent_subscribers = new DataObjectSet();
foreach($unsent_subscribers_array as $key => $data) {
	$unsent_subscribers->push(new ArrayData($data));
}
return $unsent_subscribers;	
~~~
Above code taken from cms/code/Newsletter/Newsletter.php gsoc branch r38859.

## API Documentation
[Click here for the API documentation](http://api.silverstripe.org/trunk/sapphire/ArrayData.html).


