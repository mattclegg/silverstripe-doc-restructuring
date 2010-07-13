<?php
/**
 * Fixes certain omissions from {@link DocuwikiToMarkdownExtra}.
 * 
 * @author Ingo Schommer
 */
class MarkdownCleanup {
	
	function process($content) {
		$content = $this->convertUnbalancedHeadlines($content);
		// $content = $this->convertCodeBlocks($content);
		// $content = $this->newlinesAfterHeadlines($content);
		// $content = $this->newlinesBeforeLists($content);
		// $content = $this->convertApiLinks($content);
		// $content = $this->convertEmphasis($content);
		
		return $content;
	}
	
	/**
	 * Convert "unbalanced" DokuWiki headlines (amount of equal signs at beginning and end not matching).
	 */
	protected function convertUnbalancedHeadlines($content) {
		$out = array();
		
		$inlineRules = array(
			'/^=([^=]*) [=\s]*/'			=>	array("rewrite" => '###### $1'),
			'/^==([^=]*) [=\s]*/'			=>	array("rewrite" => '##### $1'),
			'/^===([^=]*) [=\s]*/'			=>	array("rewrite" => '#### $1'),
			'/^====([^=]*) [=\s]*/'			=>	array("rewrite" => '### $1'),
			'/^=====([^=]*) [=\s]*/'		=>	array("rewrite" => '## $1'),
			'/^======([^=]*) [=\s]*/'		=>	array("rewrite" => '# $1'),
		);
		$lines = $this->getLines($content);
		foreach($lines as $i => $line) {
			foreach($inlineRules as $rule => $replace) {
				$line = preg_replace($rule, $replace['rewrite'], $line);
			}
			$out[] = $line;
		}
		
		return implode("\n", $out);
	}
	
	/**
	 * Replace emphasis in format "//emphasized//" to "*emphasized*", but avoid replacing it
	 * withing links. E.g. "[http://bla.com](http://bla.com)" shouldn't match, either should
	 * "Convert http:// to https://".
	 */
	protected function convertEmphasis($content) {
		$out = array();
		
		$lines = $this->getLines($content);
		foreach($lines as $i => $line) {
			$lines[$i] = preg_replace('/\s\/\/([^\s][^\]\)]*?)\/\//', ' *$1*', $lines[$i]);
			$out[] = $lines[$i];
		}
		
		return implode("\n", $out);
	}
	
	/**
	 * Exchange any links to api.ss.org with a new pseudo format "[api:<classname>]".
	 * Also wrap them in <pre> blocks.
	 * 
	 * Excludes composite structures with spaces etc, we can't be sure they're class names.
	 */
	protected function convertApiLinks($content) {
		$out = array();
		
		$lines = $this->getLines($content);
		foreach($lines as $i => $line) {
			preg_replace('/\[(\w*)\]\(http:\/\/api\.silverstripe.org.*\)/', '`[api:$1]`', $lines[$i]);
			$out[] = $lines[$i];
		}
		
		return implode("\n", $out);
	}
	
	/**
	 * Headlines should be followed by newlines in markdown, for easier readability.
	 */
	protected function newlinesBeforeLists($content) {
		$out = array();
		$re = '/^[\s\t]*\*/';
		
		$lines = $this->getLines($content);
		foreach($lines as $i => $line) {
			if(preg_match($re, $lines[$i]) && isset($lines[$i-1]) && !empty($lines[$i-1]) && !preg_match($re, $lines[$i-1])) {
				$lines[$i] = "\n" . $lines[$i];
			}
			
			$out[] = $line;
		}
		
		return implode("\n", $out);
	}
	
	/**
	 * Headlines should be followed by newlines in markdown, for easier readability.
	 */
	protected function newlinesAfterHeadlines($content) {
		$out = array();
		
		$lines = $this->getLines($content);
		foreach($lines as $i => $line) {
			if(preg_match('/^#/', $lines[$i]) && isset($lines[$i+1]) && !empty($lines[$i+1])) {
				$lines[$i+1] = "\n" . $lines[$i+1];
			}
			
			$out[] = $line;
		}
		
		return implode("\n", $out);
	}
	
	/**
	 * Convert Markdown Extra style code blocks with triple tildes
	 * into more standard tab-indented code blocks with CodeHilite convetions.
	 */
	protected function convertCodeBlocks($content) {
		$out = array();
		$linemode = 'text'; // 'text' or 'code'
		$extraPreNewline = false;
		
		$lines = $this->getLines($content);
		foreach($lines as $i => $line) {
			if(preg_match('/^~~~(\s{(.*)})?/', $line, $matches)) {
				// first line of code block
				if($linemode == 'text') {
					$linemode = 'code';

					// add code formatting bit
					$line = (isset($matches[2])) ? ":::" . $matches[2] : '';
					
					// if previous line is not empty, add a newline
					$extraPreNewline = (isset($lines[$i-1]) && !empty($lines[$i-1]));
				} else {
					// last line of code block
					$linemode = 'text';
					$line = ''; // remove line with closing tildes
				}
			} 
			
			// HACK Add tabs if starts with ':::' (shouldnt be necessary)
			if($linemode == 'code' || preg_match('/^\n?:::/msi', $line)) $line = "\t" . $line;
			
			if($extraPreNewline) $line = "\n" . $line;
			$extraPreNewline = false;
			
			$out []= $line . ($i < count($lines)-1) ? "\n" : '';
		}
		
		return implode("\n", $out);
	}
	
	protected function getLines($s) {
		// Ensure that we only have a single \n at the end of each line.
		$s = str_replace("\r\n", "\n", $s);
		$s = str_replace("\r", "\n", $s);
		return explode("\n", $s);
	}
	
}

$inputDirectory = "../master/";

$cleanup = new MarkdownCleanup();

$path = realpath($inputDirectory);

$objects = new RecursiveIteratorIterator(
               new RecursiveDirectoryIterator($path), 
               RecursiveIteratorIterator::SELF_FIRST);

foreach($objects as $name => $object) {
	$filename = $object->getFilename();
	$ext = pathinfo($filename, PATHINFO_EXTENSION);
	if ($filename == "." || $filename == ".." || $ext != 'md') continue;
	
	$inputDir = $object->getPath();
	if (is_dir($object->getPathname())) continue;

	$newContent = $cleanup->process(file_get_contents("{$inputDir}/{$filename}"));
	file_put_contents("{$inputDir}/{$filename}", $newContent);
}
