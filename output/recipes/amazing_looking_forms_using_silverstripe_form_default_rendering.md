# Introduction

Have you ever tryed to create an incredible complex and amazingly looking web form using Silverstripe?. 

The default output its really impressive for doing that, i can bet that Silverstripe guys have an excellent piece of
forms generating software for us.





## Creating the form

For this example we will create the following form:

{{:amazing-rendered-form.png|amazing form}}



## Where to start

To create such a form you will need to use a powerful css reset system in your website. im using yui-reset sitewide (not
using silverstripe css in the front-end at all)

i really like the elegance of using Page_Controller to add css requirements. And for the css reset using a CDN like
yahoo will assure that the file loads faster or even better loads directly for your cache if another site that you have
visited before uses the same file 

	:::javascript
	function init() {
		parent::init();
		Requirements::ThemedCSS("http://yui.yahooapis.com/2.7.0/build/reset-fonts-grids/reset-fonts-grids.css");
	}


for my designs I have selected reset-font-grids.css, a file that provides a powerful and easy way to create faster grid
based website designs.




## My forms CSS

Looking carefully at the generated code for Silverstripe forms you can notice that it gives you a lot of versatility for
the way it render the fields. Is not a very clean output but powerful enough to acchieve any kind of design you ever
wanted.

thats my generic forms.css


	:::css
	/* @group Forms */
	
	div.middleColumn div.fieldgroup div.fieldgroupField div.field.CompositeField{
		margin-left: 30%;
	}
	
	div.middleColumn div.fieldgroup div.fieldgroupField div.field.CompositeField label {
		margin-right: 10px;
		width: 80px;
		text-align: right;
		float: left;
	}
	div.middleColumn div.fieldgroup div.fieldgroupField div.field.CompositeField.nolabel select{
		float: left;
	}
	div.middleColumn div.fieldgroup div.fieldgroupField div.field.CompositeField input{
		float: left;
		width: 140px;
		margin-right: 10px;
	}
	
	fieldset label.FormHeading {
		font-size: 1.4em;
		font-family: "Warnock Pro", "Goudy Old Style","Palatino","Book Antiqua", Georgia, serif;
		color: #33649f;
		font-size: 1.7em;
		background: #bddef0;
		-moz-border-radius: 5px;
		-webkit-border-radius: 5px;	
		padding: 5px 10px;
		margin-bottom: 10px;
		margin-top: 10px;
	}
	
	
	/* @group cf */
	
	/*clearfix class*/
	div.field:after,fieldset label.FormHeading:after {
	    content: "."; 
	    display: block; 
	    height: 0; 
	    clear: both; 
	    visibility: hidden;
	}
	
	div.field,fieldset label.FormHeading {display: inline-block;}
	/* Hides from IE-mac \*/

	* html div.field,* html fieldset label.FormHeading {height: 1%;}
	div.field,fieldset label.FormHeading {display: block;}
	/* End hide from IE-mac */
	
	/* @end */
	
	ul.optionset {
		margin-left: 30%;
	}
	
	div.middleColumn span.fieldgroup p {
		float: left;
		margin-right: 10px;
		padding-left: 30%;
		margin-bottom: 0;
	}
	
	div.field{
		margin-bottom: 1em;
	}
	input.text {
		width: 55%;
	}
	input, textarea{
		border: 1px solid #888;
		padding: 2px;
	}
	span.message.validation,span.message.required {
		padding-left: 30%;
	}
	
	div.middleColumn div.fieldgroup div.fieldgroupField div.field.CompositeField.validationError span.message.required {
		padding: 0;
	}
	
	
	
	.field label.left {
		width: 27%;
		padding-left: 1%;
		margin-right: 2%;
		display: block;
		float: left;
		text-align: right;
		font-weight: bold;
	}
	
	div.middleColumn span.fieldgroup {
		margin-bottom: 0;
	}
	
	div.middleColumn span.fieldgroup label {
		float: left;	
		margin-right: 10px;
	}
	
	div.middleColumn span.fieldgroup div.field.CompositeField label {
		width: 80px;
		text-align: right;
	}
	
	div.middleColumn span.fieldgroup input {
		float: left;	
		width: 135px;
	}
	
	fieldset h3 {
		padding-bottom: 5px;
	}
	
	div.middleColumn span.fieldgroup div.field.CompositeField input{
		margin-right: 10px;
	}
	div.middleColumn span.fieldgroup div.field.CompositeField.nolabel select{
		width: 140px;
	}
	div.middleColumn span.fieldgroup div.field.CompositeField.nolabel {
		margin-left: 30%;
	}
	
	#Form_Form_CreditCardSecurityCode ,#CreditCard_Holder input {
		width: 50px;
	}
	
	
	div.middleColumn select{
		margin-top: 0;
	}
	
	div.middleColumn div.fieldgroup div.fieldgroupField p{
		padding-left: 30%;
		margin-right: 5px;
		float: left;
	}
	div.middleColumn textarea{
		width: 55%;
	}
	
	p.checkbox.checkbox label.right {
		vertical-align: middle;
	}
	ul.optionset li {
		list-style-type: none;
		display: block;
		margin-bottom: .4em;
	}
	
	div.calendardate img{
		padding: 0 !important;
		vertical-align: top;
	}
	div.Actions {
		padding-left: 30%;
		padding-top: 1em;
	}
	div.Actions p{
		padding-top: 6px;
	}
	fieldset p.tip {
		padding-left: 30%;
		margin-top: -10px;
	}
	
	div.middleColumn span.fieldgroup select{
		margin-top: 0;
	}
	
	#tripPlanstripPlans div.middleColumn span.fieldgroup p {
		padding-left: 30%;
		float: left;
		margin-right: 10px;
	}
	
	div.Actions input {
		padding: 5px 30px;
		-moz-border-radius: 6px;
		-webkit-border-radius: 6px;
		cursor: pointer;
		background-color: #ccc;
		float: left;
		margin-right: 20px;
	}
	
	p.field.checkbox {
		padding-left: 30%;
	}
	
	div.Actions input:hover {
		color: white;
		background: #18853b;
	}
	
	.validationError input{
		background-color: #ea8075;
	}
	
	/* @end */





## The form itself

This form needs to be created inside your PageClass_Controller, you could see that only Silverstripe fields are used in
the form and the result is really nice.

LiteralFields and FieldGroups are impresively useful when used with care.

	:::php
	function Form() {
	$fields = new FieldSet(
		new HeaderField ("Use this form to order DVD by credit card (for shipping expenses ONLY).","3"),
	       new TextField("FullName","Full name `<em>``</em>`"),
	       new EmailField("Email", "Email address `<em>``</em>`"),
	       new TextField("HowYouFindUs","How did you find us?"),
		new LiteralField("HowYouFindUs","<p class='tip'>Please be specific (i.e. Google, Yahoo, Magazine, Other Website, etc)</p>"),
		
		new CheckboxField("TripPlans", "Do you plan on climbing Aconcagua in the next 2 years?"),
	
	       new TextareaField("FitnessLevelAndExperience","Fitness level and experience?"),
		new LiteralField("FitnessLevelAndExperience","<p class='tip'>(please give us a brief description of your climbing experience and level of fitness)</p>"),
		new CheckboxField("Brochure","Check if you would like Aconcagua trip information and Brochure"),
	
		//payment base form
		new HeaderField ("Shipping Payment Information","3"),
		new LiteralField("ShippingInformation","<p>This will include the shipping of our DVD , Brochure, detailed Aconcagua Package with trip info, itineraries, map, equipment list and more</p>"),
		new HiddenField ("Local", null, $this->LocalDeliveryPrice),
		new HiddenField ("International", null, $this->InternationalDeliveryPrice),
	   	new OptionsetField("Destination","Destination `<em>``</em>`",array(
			"Local" => "US / Canada (\$US $this->LocalDeliveryPrice)",
	   		"International" => "International (\$US $this->InternationalDeliveryPrice)"					
		)),   				
		new LiteralField("Destination","<p class='tip'>note that All DVD's are shipped from the U.S.</p>"),
	       new DropdownField("CreditCardType","Credit Card type `<em>``</em>`",
			array(
				'visa' =>'VISA',
				'mastercard' => 'MasterCard',
				'amex' => 'Amex',
				'discover' => 'Discover'
			)),
		new FieldGroup(
			new LiteralField ("nameOnCard", "<label class='left'>Name on card <em>*</em></label>"),
			new FieldGroup(
	            new TextField("FirstName","First Name `<em>``</em>`"), 
	            new TextField("SurName","Last Name `<em>``</em>`")
			)
		),
		new FieldGroup(
			new LiteralField ("billingAddress","<label class='left'>Billing Address <em>*</em></label>"),
			new FieldGroup(
	            new TextField("Address","Street `<em>``</em>`"),
	            new TextField("City","City `<em>``</em>`")
			), 
			new FieldGroup(			
	    		new TextField("State","Street `<em>``</em>`"),
	            new TextField("ZipCode","Zip `<em>``</em>`")
			),
			new FieldGroup(			 			
	            new DropdownField("Country","Deliver to `<em>``</em>`",Geoip::getCountryDropDown(),Geoip::visitor_country())
			)
		),
	       new TextField("HomePhone","Phone `<em>``</em>`"),
		new CreditCardField("CreditCard","Enter your credit card number"),
		new FieldGroup(
			new LiteralField ("cardExpirationDate", "<label class='left'>Card expiration date <em>*</em></label>"),
			new FieldGroup(
				new DropdownField('Month', "Month <em>*</em>", array(
					'00'=>'--',
					'01'=>'January',
					'02'=>'February',
					'03'=>'March',
					'04'=>'April',
					'05'=>'May',
					'06'=>'June',
					'07'=>'July',
					'08'=>'August',
					'09'=>'September',
					'10'=>'October',
					'11'=>'November',
					'12'=>'December'
				)),
				new DropdownField('Year', "Year <em>*</em>", array(
					'00' => '--',
					'2009'=>'2009',
					'2010'=>'2010',
					'2011'=>'2011',
					'2012'=>'2012',
					'2013'=>'2013',
					'2014'=>'2014',
					'2015'=>'2015',
					'2016'=>'2016',
					'2017'=>'2017'
				))
			)
		),
		new TextareaField("SpecialShippingInstructions","Special shipping instructions"),
		new LiteralField("SpecialShippingInstructions","<p class='tip'>If shipping address is different that your billing address, please enter it here</p>")
	);
	$validator = new RequiredFields("Name", "Email","Amount","FirstName","SurName","Address","City","State","ZipCode","PhoneHome","CreditCardSecurityCode");
	$actions = new FieldSet(new FormAction("getFreeDVD", "get free DVD"));
	
	// Director::forceSSL();
	return new Form($this, "Form", $fields, $actions, $validator);
	}
	


I really hope that this code will be a help to silverstripe users for all ages. 8-O (really like this emoticon lol)

visit me at www.dospuntocero.cl and dropme a line or just findme in the irc!
