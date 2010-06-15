# TreeMultiselectField

{{:treemultiselectfield.jpg|:treemultiselectfield.jpg}}

This form class allows you to represent Many-Many Joins in a handy single field. The field has javascript which generates a AJAX tree of the site structure allowing you to save selected options to a component set on a given [DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html). 

#### Saving Behavior
This field saves a [ComponentSet](http://api.silverstripe.org/trunk/sapphire/model/ComponentSet.html) object which is present on the [DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html) passed by the form, returned by calling a function with the same name as the field. The Join is updated by running setByIDList on the [ComponentSet](http://api.silverstripe.org/trunk/sapphire/model/ComponentSet.html)

#### Modifying Save Behavior
Before the data is saved, you can modify the ID list sent to the [ComponentSet](http://api.silverstripe.org/trunk/sapphire/model/ComponentSet.html) by specifying a function on the [DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html) called "onChange[fieldname](&items)". This will be passed by reference the IDlist (an array of ID's) from the Treefield to be saved to the component set. 
Returning false on this method will prevent treemultiselect from saving to the [ComponentSet](http://api.silverstripe.org/trunk/sapphire/model/ComponentSet.html) of the given [DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html).

~~~ {php}
/**
 * Called when we try and set the Parents() component set
 * by Tree Multiselect Field in the administration.
 */
function onChangeParents(&$items) {
 // This ensures this DataObject can never be a parent of itself
	if($items){
		foreach($items as $k => $id){
			if($id == $this->ID){
				unset($items[$k]);
			}
		}
	}	
	return true;
}
~~~

For constructors, methods, variables, please consult the API documentation

### API documentation
[Click here for the API documentation](http://api.silverstripe.org/trunk/forms/fields-relational/TreeMultiselectField.html).
