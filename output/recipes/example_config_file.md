# Config File Example

SilverStripe stores alot of its site developer tools in static methods and class's which you can control via a
_config.php file in your mysite/ folder (or tutorial/ folder if you installed with the tutorial)

## Basic _Config file

	:::php
	<?php
	/**

	 * SilverStripe CONFIG File
	 */
	
	global $project;
	$project = "mysite";
	
	// Defines your Database Details.
	$databaseConfig = array(
		"type" => "MySQLDatabase",
		"server" => "localhost", 
		"username" => "", 
		"password" => "", 
		"database" => "",
	);
	
	// SS has a 'Developer' mode. This will allow things like errors to be outputted 
	// to the browser and being able to call extra functions without logging in s
	
	Director::set_dev_servers(array(
		'localhost',
		'127.0.0.1',
	
	));
	
	// Sets the current theme.
	SSViewer::set_theme("blackcandy");
	?>


## Other Configuration Options

See http://doc.silverstripe.com/doku.php?id=configuration
