# CsvBulkLoader

## Introduction

Utility class to facilitate complex CSV-imports by defining column-mappings and custom converters. Uses the fgetcsv()
function to process CSV input. Accepts a file-handler as input 

## Features

*  Custom column mapping

*  Auto-detection of CSV-header rows

*  Duplicate detection based on custom criteria

*  Automatic generation of relations based on one or more columns in the CSV-Data

*  Definition of custom import methods (e.g. for date conversion or combining multiple columns)

*  Optional deletion of existing records if they're not present in the CSV-file

*  Results grouped by "imported", "updated" and "deleted"

## Requirements


*  *SilverStripe 2.3*
## Usage

Simple upload form (creates new ''MyDataObject'' instances). You can access it through 
*/MyController/?flush=all*.

	:::php
	<?php
	class MyController extends Controller {
		protected $template = "BlankPage";
		
		function Link($action = null) {
			return Controller::join_links('MyController', $action);
		}
		
		function Form() {
			$form = new Form(
				$this,
				'Form',
				new FieldSet(
					new FileField('CsvFile', false)
				),
				new FieldSet(
					new FormAction('doUpload', 'Upload')
				),
				new RequiredFields()
			);
			return $form;
		}
		
		function doUpload($data, $form) {
			$loader = new CsvBulkLoader('MyDataObject');
			$results = $loader->load($_FILES['CsvFile']['tmp_name']);
			$messages = array();
			if($results->CreatedCount()) $messages[] = sprintf('Imported %d items', $results->CreatedCount());
			if($results->UpdatedCount()) $messages[] = sprintf('Updated %d items', $results->UpdatedCount());
			if($results->DeletedCount()) $messages[] = sprintf('Deleted %d items', $results->DeletedCount());
			if(!$messages) $messages[] = 'No changes';
			$form->sessionMessage(implode(', ', $messages), 'good');
	
			return $this->redirectBack();
		}
	}

## Example

Sample CSV Content

	
	"SpielerNummer","Name","Geburtsdatum","Gruppe"
	11,"John Doe",1982-05-12,"FC Bayern"
	12,"Jane Johnson", 1982-05-12,"FC Bayern"
	13,"Jimmy Dole",,"Schalke 04"


Datamodel for TeamMember

	:::php
	<?php
	class Player extends DataObject {
	   static $db = array(
	      'PlayerNumber' => 'Int',
	      'FirstName' => 'Text', 
	      'LastName' => 'Text', 
	      'Birthday' => 'Date', 
	   );
	   static $has_one = array(
	      'Team' => 'FootballTeam'
	   );
	}
	?>


Datamodel for FootballTeam:

	:::php
	<?php
	class FootballTeam extends DataObject {
	   static $db = array(
	      'Title' => 'Text', 
	   );
	   static $has_many = array(
	      'Players' => 'Player'
	   );
	}
	?>


Sample implementation of a custom loader. Assumes a CSV-file in a certain format (see below).

*  Converts property names

*  Splits a combined "Name" fields from the CSV-data into ''FirstName'' and ''Lastname'' by a custom importer method

*  Avoids duplicate imports by a custom ''$duplicateChecks'' definition

*  Creates ''Team'' relations automatically based on the ''Gruppe'' colum in the CSV data

	:::php
	<?php
	class PlayerCsvBulkLoader extends CsvBulkLoader {
	   public $columnMap = array(
	      'Number' => 'PlayerNumber', 
	      'Name' => '->importFirstAndLastName', 
	      'Geburtsdatum' => 'Birthday', 
	      'Gruppe' => 'Team.Title', 
	   );
	   public $duplicateChecks = array(
	      'SpielerNummer' => 'PlayerNumber'
	   );
	   public $relationCallbacks = array(
	      'Team.Title' => array(
	         'relationname' => 'Team',
	         'callback' => 'getTeamByTitle'
	      )
	   );
	   static function importFirstAndLastName(&$obj, $val, $record) {
	      $parts = explode(' ', $val);
	      if(count($parts) != 2) return false;
	      $obj->FirstName = $parts[0];
	      $obj->LastName = $parts[1];
	   }
	   static function getTeamByTitle(&$obj, $val, $record) {
	      $SQL_val = Convert::raw2sql($val);
	      return DataObject::get_one(
	         'FootballTeam', "Title = '{$SQL_val}'"
	      );
	   }
	}
	?>


Integration into a new [ModelAdmin](ModelAdmin) instance to get an upload form out of the box (accessible through
*/admin/players*):

	:::php
	<?php
	class PlayerAdmin extends ModelAdmin {
	   static $managed_models = array(
	      'Player'
	   );
	   static $model_importers = array(
	      'Player' => 'PlayerCsvBulkLoader', 
	   );
	   static $url_segment = 'players';
	}
	?>


## API Documentation

[Click here for the API documentation](http://doc.silverstripe.com/assets/classes/cms/bulkloading/CsvBulkLoader.html).

## Related


*  [CsvParser](CsvParser)

*  [ModelAdmin](ModelAdmin)
