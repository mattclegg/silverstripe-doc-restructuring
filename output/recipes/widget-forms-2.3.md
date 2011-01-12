# Recipe: How do I add a form to my widget?

**Note: This recipe applies to SilverStripe 2.3 and earlier. See [:widgets](/widgets) for a more generic solution for
SilverStripe 2.4 or newer.**

It's not immediately obvious how you would add a form to your widget, because they don't have a URL to call their own.

To solve this, you have to create a corresponding controller for your widget, and put the meat of the form on that.  The
form will have to include the Widget ID in the URL, so you'll also need a subclass of form that overrides the
FormAction() method.

Here is a code template to get you started.

	:::php
	<?php
	
	/**

	 * A widget showing a subscribe form for a newsletter
	 */
	class YourWidget extends Widget {
		// ... do your other normal widget stuff ...
		
		
		function Form() {
			$controller = new YourWidget_Controller($this);
			return $controller->Form();
		}
	}
	
	/**

	 * Controller supporting forms on widgets
	 * Note: the widgets shouldn't be used on secure pages for private forms - that kind of security isn't implemented
	 */
	class YourWidget_Controller extends Controller {
		protected $widget;
		
		function __construct($widget = null) {
			if($widget) $this->widget = $widget;
			parent::__construct();
		}
		function widget() {
			if($this->widget) return $this->widget;
			else if(is_numeric($this->urlParams['ID'])) return $this->widget = DataObject::get_by_id('Widget', $this->urlParams['ID']);
			else user_error('No widget selected', E_USER_ERROR);
		}
		function Link() {
			return $this->class;
		}
		
		function Form() {
			// ... This can be whatever form you like ...
			$widgetform = new WidgetForm($this, 'Form', new FieldSet(
				// ... Put your fields in here ...
			), new FieldSet(
				new FormAction('doAction', 'Submit')
			));
			$widgetform->setWidget($this->widget);
			return $widgetform;
		}
		function doAction($data, $form) {
			// ... Do your thing, just like a normal SilverStripe form
	
			// ... This is a good way of giving feedback to the user about the submission.  A message will be shown above the form.
	
			$this->Form()->sessionMessage("Thanks for submitting my form", "good");
			Director::redirectBack();
		}
	}

Here is the WidgetForm subclass

	:::php
	<?php
	class WidgetForm extends Form {
		protected $widget;
		
		static $url_handlers = array(
			'POST $WidgetID' => 'httpSubmission',
			'GET $WidgetID' => 'httpSubmission',
		);
		
		function FormAction(){
			if($this->widget){
				return parent::FormAction()."/".$this->widget->ID;
			}
			return parent::FormAction();
		}
		
		function setWidget($wgt){
			if($wgt != null){
				$this->widget = $wgt;
			}
		}
		
		function getWidget(){
			return $this->widget;
		}
		
	}

