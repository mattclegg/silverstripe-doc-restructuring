<?php

$inputDirectory = "../input/";
$outputDirectory = "../output/";

require_once("DocuwikiToMarkdownExtra.php");

$converter = new DocuwikiToMarkdownExtra();

$path = realpath($inputDirectory);

$objects = new RecursiveIteratorIterator(
               new RecursiveDirectoryIterator($path), 
               RecursiveIteratorIterator::SELF_FIRST);

foreach($objects as $name => $object) {
	$filename = $object->getFilename();
	if ($filename == "." || $filename == "..") continue;
	
	$inputDir = $object->getPath();
	if (is_dir($object->getPathname())) continue;

	$outputDir = str_replace($path, substr($path, 0, -5) . "output", $inputDir);

	if (!file_exists($outputDir)) mkdir($outputDir, 0777, true);

	$converter->convertFile(
		"{$inputDir}/{$filename}",
		"{$outputDir}/{$filename}"
	);
}

?>
