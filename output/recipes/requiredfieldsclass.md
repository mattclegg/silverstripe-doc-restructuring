Here is a way to add a class to the containers of the fields that are required:

	:::php
	function Form() {
		$reqFields = array(
			'a',
			'b'
		);
		$form = new Form($this, 'Form',
			new FieldSet(
				new TextField('a'),
				new TextField('b')
			),
			new FieldSet(
				new FormAction('submit', 'Submit')
			),
			new RequiredFields($reqFields)
		);
		foreach($reqFields as $field => $value) {
			$fieldObj = $form->dataFieldByName($value);
			$fieldObj->addExtraClass('required');
		}
		return $form;
	}
	

