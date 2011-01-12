The following code example shows how to sort your entries by month (in this example, a bunch of training pages, each
with its associated date):

Add the following code to your training holder (the parent page for your training pages):

	:::php
	
		function MonthlyCourses() {
			$results = new DataObjectSet();
	
			$stage = Versioned::current_stage();
			$suffix = (!$stage || $stage == 'Stage') ? "" : "_$stage";
	
			$sqlResults = DB::query("
				SELECT DISTINCT MONTH(`Date`) AS `Month`, YEAR(`Date`) AS `Year`
				FROM `SiteTree$suffix` NATURAL JOIN `TrainingPage$suffix`
				WHERE `ParentID` = ".$this->ID."
				ORDER BY `Year` DESC, `Month` DESC;"
			);
	
			if($sqlResults) foreach($sqlResults as $sqlResult) {
				$month = (isset($sqlResult['Month'])) ? (int) $sqlResult['Month'] : 1;
				$year = ($sqlResult['Year']) ? (int) $sqlResult['Year'] : date('Y');
	
				$date = DBField::create('Date', array(
					'Day' => 1,
					'Month' => $month,
					'Year' => $year
				));
	
	
				$results->push(new ArrayData(array(
					'Date' => $date,
					'Courses' => DataObject::get("TrainingPage", "`ShowInMenus` = 1 AND MONTH(`TrainingPage`.`Date`) = $month AND YEAR(`TrainingPage`.`Date`) = $year")
				)));
			}
			return $results;
		}
	


and then create add the following to your TrainingHolder.ss file:

	:::html
	
	`<% control MonthlyCourses %>`
	`<div class="MonthlyCoursesMonth">`
		$Date.Format(F) - $Date.Year
		<ul>
		<% control Courses  %>
			<li>$Title</li>
		<% end_control %>
		</ul>
	`</div>`
	`<% end_control %>`
	
	
	


NOTE: the key code for this example is stolen from The Blog module.

