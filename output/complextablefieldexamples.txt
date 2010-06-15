# Complex Table Field Examples

Below is an example implementation of a ComplexTablefield. As these can get quite confusing when the specification for getCMSFields() gets quite large, I try to break of large specifications for these sorts of things into private functions which makes debugging easier.

Note: getCMSFields_forPopup() is the method called on the RSVP class for the fieldset required for the popup's Fields.

~~~ {php}
/** 
 * Returns a complextablefield for use within the CMS.
 * Should not be accessed outside the CMS.
 */

private function getCMSRSVPReport(){
	$rsvp = Object::create("RSVP");
	$tablefield = new ComplexTableField(
		$controller = $this,
		$name = "RSVPReport", 
		$sourceClass = $rsvp->class,
		$fieldList = array(
			"ID" => "ID",
			"MemberName" => "Name",
			"Places" => "Places",
			"TotalCost" => "Cost"
		), 
		$callThisFunctionForPopupFields = "getCMSFields_forPopup",
		$sourceFilter = "`EventID` = '$this->ID'",
		$sourceSort = "ID ASC"
	);
	$tablefield->setPermissions(
		array(
			"show",
			"edit"	
		)
	);
return $tablefield;		
}
~~~
