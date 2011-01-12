# Member GroupSet

This is a special kind of [#ComponentSet](#ComponentSet) which has special functions for managing subscription based
information and other membership -> newsletter based subscriptions.

### Saving Member Newsletter Relationships

You can automatically create and generate a way to save all membership types by using
DataObject::get("NewsletterTypes"); to generate the source for a [#CheckboxSetField](#CheckboxSetField)

	:::php
	$fields->push(
		new CheckboxSetField("NewsletterSubscriptions","Receive email notification of events in ",
			$source = DataObject::get("NewsletterTypes")->toDropDownMap();
			$member->Groups()->Map()
		)
	);



Then in the handler function you can get the field from the form data: 

	:::php
		/** Save the newsletter groups **/
		$groups = $member->Groups();
		$checkboxfield = $form->Fields()->fieldByName("NewsletterSubscriptions");
		$groups->setByCheckboxSetField($checkboxfield);


The function setByCheckboxSetField() takes the field and updates the appropriate groups (adds and removes) for you. 

This functionality is quite useful for managing subscriptions (which you have to provide by law - privacy act - in New
Zealand if your using Email as a marketing tool).


#### API documentation

[Click here for the API documentation](http://api.silverstripe.org/trunk/sapphire/Member_GroupSet.html).
