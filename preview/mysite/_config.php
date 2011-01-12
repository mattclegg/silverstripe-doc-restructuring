<?php

global $project;
$project = 'mysite';

global $database;
$database = 'SS_ssnewdocstest';

require_once('conf/ConfigureFromEnv.php');

MySQLDatabase::set_connection_charset('utf8');

// This line set's the current theme. More themes can be
// downloaded from http://www.silverstripe.org/themes/
SSViewer::set_theme('docs');

// enable nested URLs for this site (e.g. page/sub-page/)
SiteTree::enable_nested_urls();

// render the user documentation first
Director::addRules(20, array(
	'Security//$Action/$ID/$OtherID' => 'Security',
));
DocumentationViewer::set_link_base('');
DocumentationViewer::$check_permission = false;
Director::addRules(10, array(
	'$Action' => 'DocumentationViewer',
	'' => '->current/en/cms'
));
DocumentationService::set_automatic_registration(true);


$path = ".." . DIRECTORY_SEPARATOR . ".." . DIRECTORY_SEPARATOR . "master" . DIRECTORY_SEPARATOR;
$handle = opendir(realpath($path));
if($handle) {
	while( $file = readdir( $handle ) ){
		$fullPath = $path . $file;
		if(strpos($file, '.') === false && is_dir($fullPath)) {
			DocumentationService::register($file, realpath("../../master/{$file}/docs/"), '2.4');
		}
	}
	closedir($handle);
}


DocumentationService::register("cms", realpath("../../master/sapphire/docs/"), '2.4');


// We want this to be reviewed by the whole community
BasicAuth::protect_entire_site(false);

Security::setDefaultAdmin('user', 'pass');
