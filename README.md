# SilverStripe Documentation Restructuring Project

This is a temporary repository for developer documentation about the SilverStripe framework, currently located at [http://doc.silverstripe.org].

*Note: This repository is used for collaboration during the restructuring phase, and will move elsewhere afterwards*

 * [Mailinglist](http://groups.google.com/group/silverstripe-documentation)
 * [Planning wiki page](http://doc.silverstripe.org/tmp:documentation-restructuring)
 * [TODO list and bugtracker](http://open.silverstripe.org/query?status=inprogress&status=new&status=replyneeded&status=reviewed&component=Documentation&order=priority&col=id&col=summary&col=status&col=type&col=priority&col=milestone&col=component)

## Contact

 * Documentation questions: Ingo Schommer (ingo at silverstripe dot com)
 * Markdown Conversion: Mark Stephens (mark at silverstripe dot com)

## Usage

### Import DokuWiki files

Note: This is only possible by SilverStripe staff.

	scp -P 2222 -R <username>@doc.silverstripe.org:/sites/ss2doc/www/assets/data/pages/ input/

### Convert to Markdown files

	cd scripts
	php TranslateSSDocs.php