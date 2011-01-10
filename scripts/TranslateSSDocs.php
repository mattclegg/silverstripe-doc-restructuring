<?php
/**
 * php TranslateSSDocs.php <inputfile|inputdir> <outputdir>
 * 
 * If no <outputdir> is given, writes to stdout.
 * 
 * Converts a file or folder (incl. subdirs) to markdown,
 * and writes files to a new output location.
 * 
 * @author Mark Stephens, Ingo Schommer
 */

$args = @$_SERVER['argv'];
$inputDir = (isset($args[1])) ? realpath($args[1]) : "../input/";
$outputDir = (isset($args[2])) ? realpath($args[2]) : false;

require_once("DocuwikiToMarkdownExtra.php");

$converter = new DocuwikiToMarkdownExtra();

$path = realpath($inputDir);

// Process either directory or file
if(is_dir($inputDir)) {
	$objects = new RecursiveIteratorIterator(
		new RecursiveDirectoryIterator($path), 
		RecursiveIteratorIterator::SELF_FIRST
	);
} else {
	$objects = array(new SplFileInfo($inputDir));
}


foreach($objects as $name => $object) {
	$filename = $object->getFilename();

	if ($filename == "." || $filename == "..") continue;
	
	$inputDir = $object->getPath();
	if (is_dir($object->getPathname())) continue;

	if($outputDir) {
		// Create output subfolder (optional)
		$outputDir = str_replace($path, substr($path, 0, -5) . "output", $inputDir);
		if (!file_exists($outputDir)) mkdir($outputDir, 0777, true);
		$outFilename = preg_replace('/\.txt$/', '.md', $filename);
		$converter->convertFile(
			"{$inputDir}/{$filename}",
			"{$outputDir}/{$outFilename}"
		);
	} else {
		echo $converter->convertFile(
			"{$inputDir}/{$filename}"
		);
	}
	
}

?>
