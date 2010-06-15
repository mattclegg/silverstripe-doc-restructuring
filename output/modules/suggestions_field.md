This page describes the way in which you can integrate the Suggestion Field on your forms. Basically the Suggestion Field is an extension of the TextField, yet it do AJAX calls to the server and preview suggestions for the user.

# How to use

The basic implementation of the Suggestion is this. By the following code you can add a form with a suggestion field  

	function Form(){
		$fields = new FieldSet(
			new SuggestionField("PageLinks", "Module Search Clickable", "", "Page" ,true),
			new SuggestionField("PageSelect", "Module Search Selectable", "", "Page" ,false)
		);
		$actions = new FieldSet(new FormAction("select", "Search"));
		return new Form($this, "MyCustomForm", $fields, $actions);
	
	}

If you look into the code carefully you will find there are two SuggestionFields added to the page, and one is for PageLinks, and the other is for PageSelect.

The Constructor has some customizations.

__construct($name, $title = null, $value = "", $source = null, $URLFlag = false , $maxLength = null, $form = null)

As new arguments beyond the text field you can find the following.

##### Source


This notifies the field which DataObjects you are seeking for on the SilverStripe Database, leave it as null if you are planning to get the suggestions from somewhere else.

##### URLFlag


This is a flag and you can make the suggestions links or just text items where users can select to fill up the text box.


# What we have to do with the back end to generate suggestions

this is the code which makes suggestions.

add this code to your ./mysite/code/Page.php

	function suggestions(){
		
		if($_GET['source']){
			$instance = singleton($_GET['source']);
			if($instance instanceof HiddenClass) return false;
			if( !$instance->canCreate() ) return false;
			
			$results = DataObject::get($_GET['source'], "Title LIKE '%" . Convert::raw2sql($_GET['query']) . "%' OR " . "Content LIKE '%" . Convert::raw2sql($_GET['query']) . "%' ");
			
			if($results){				
				$output = "{";
					$output .= "results : [";
						foreach($results as $result)
							$output .= "{ Title: '". $result->Title . "' , Link : '" . $result->Link() ."' , Value : '" . $result->Title ."', },";
							
					$output .= "]";
				$output .= "}";
				echo $output;
			}
		}
		else
			return false;
	}


The field calls to the pages suggestions action all the time. The thing you have to remember here is that you need to create a JSON object.

the object should be in this format

{
	results : [
			{ Title: 'Home' , Link : '/opensource/' , Value : 'Home', },
			{ Title: 'About Us' , Link : '/opensource/about-us/' , Value : 'About Us', },
			{ Title: 'Contact Us' , Link : '/opensource/contact-us/' , Value : 'Contact Us', }
		   ]
}


