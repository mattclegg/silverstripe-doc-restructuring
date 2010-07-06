 
[Click here for the API documentation](http://api.silverstripe.org/trunk/sapphire/CustomRequiredFields.html).


CustomRequiredFields allow you to create your own validation on forms, while still having the ability to have required fields (as used in [RequiredFields](http://api.silverstripe.org/current/sapphire/form/RequiredFields.html)).

The constructor of CustomRequiredFields takes an array. Each array element is one of two things - either the name of a field that is required, or an array containing two items, 'js' and 'php'. These items are functions called to validate in javascript or php respectively.

Some useful javascript: 
1.  _CURRENT_FORM is the current form
2.  _CURRENT_FORM.elements is an array of the fields
3.  validationError(element, message, type) will create a validation error
4.  clearErrorMessage(element) will clear the validation error
5.  require('FieldName') create a required field ($this->requireField('FieldName') is the php equivalent)

An example for creating required fields only if payment type is CreditCard:
~~~ {php}
new CustomRequiredFields(
	array(
	        "PaymentMethod",
	        array(
	                "js" => "
	                        for( var i = 0; i <= this.elements.PaymentMethod.length -1; i++){
	                                if(this.elements.PaymentMethod[i].value == 'CC' && this.elements.PaymentMethod[i].checked == true){
	                                        require('CardHolderName');
	                                        require('CreditCardNumber');
	                                        require('DateExpiry');
	                                }
	                        }
	                        
	                ",
	                "php" => 'if($data[PaymentMethod] == "CC") {
	                        $this->requireField($field,"$field is required","required");
	                        $this->requireField("CardHolderName", $data);
	                        $this->requireField("CreditCardNumber", $data);
	                        $this->requireField("DateExpiry", $data);
	                }',
	        )
	)
);
~~~

And example for confirming mobile number and email address:

~~~ {php}
$js = <<<JS
if(_CURRENT_FORM.elements["MobileNumberConfirm"].value == _CURRENT_FORM.elements["MobileNumber"].value) {
   clearErrorMessage(_CURRENT_FORM.elements["MobileNumberConfirm"].parentNode);
} else {
   validationError(_CURRENT_FORM.elements["MobileNumberConfirm"], "Mobile numbers do not match", "validation");
}
JS;

$js2 = <<<JS2
if(_CURRENT_FORM.elements["EmailConfirm"].value == _CURRENT_FORM.elements["Email"].value) {
   clearErrorMessage(_CURRENT_FORM.elements["EmailConfirm"].parentNode);
} else {
   validationError(_CURRENT_FORM.elements["EmailConfirm"], "Email addresses do not match", "validation");
}
JS2;

//create validator
$validator=new CustomRequiredFields(array('FirstName', 'Surname', 'Email', 'MobileNumber', array('js' => $js, 'php' => 'return true;'), array('js' => $js2, 'php'=>'return true;')));
~~~
