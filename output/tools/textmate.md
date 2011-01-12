# Tools: Textmate

## Compatibility

* OSX

## Download

http://macromates.com

## Silverstripe Bundle

You can enhance TextMate with a Silverstripe-specific "Bundle".

### Features

*  Code Highlighting for *.ss files 

*  Unordered List Item

*  Code folding for `<% %>` blocks 

*  Snippets for often used commands over tab-shortcuts (e.g. Debug::show() -> ds) 

*  Templates for new files (DataObject class, Page Class) 

*  Outlining for `<% %>` blocks 

*  Documentation lookup on selected word (ctrl+h) in api/doc.silverstripe.com 

*  Live function lookup in project folder (over shell grep commands) 

### Download over SVN

You can simply copy the files into your TextMate preferences directory.

	
	svn co http://svn.silverstripe.com/open/tools/textmatebundle/trunk "~/Library/Application Support/TextMate/Bundles"


## ACK Fulltext Search

ACK is the "better grep" for TextMate: Ignores hidden folders like *.svn* and binary files, has easier to understand
options like simple grouping of common extensions, and is overall faster.

[Download Ack as Textmate Bundle](http://clearcove.ca/blog/2008/08/better-textmate-search-ack-in-project/)

**ACK doesn't search SilverStripe templates (Extension: *.ss) by default, you'll need to add the following to
*~/.ackrc*:

	
	--type-set=silverstripe=.php,.php5,.js,.ss,.txt,.ini,.yml,.xml,.html,.xhtml,.htm,.css
	--silverstripe


## More Bundles

Textmate keeps all official Bundles in their Subversion repository.
Its easiest to check them out in the system-wide preferences directory (not your User folder) to avoid working copy
conflicts.

http://wiki.macromates.com/Main/SubversionCheckout
