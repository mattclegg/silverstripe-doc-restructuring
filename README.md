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
	
## Contributing

### Requirements

You'll need to [install git](http://help.github.com/git-installation-redirect), which is quite straightforward on most operating systems.

To edit the files, you just need a text editor. They're written in [Markdown](http://daringfireball.net/projects/markdown/), which many editors have syntax highlighting for (e.g. through the [Textmate plugin](http://github.com/textmate/markdown.tmbundle)).

### Folders

 * `master`: The new markdown files - please edit in here
 * `scripts`: Helper scripts for conversion and file management
 * `input`: Original DokuWiki files
 * `output`: First draft of automated conversion files (now empty)

### Forking the project

You can **fork** this project within github, as described on [help.github.com](http://help.github.com/forking/).
This fork will show up on your own github profile, and can be checked out to your local machine.
You don't need a webserver on there, or run any project-specific scripts.

### Documentation Guidelines

Its important to read the [documentation guidelines](http://doc.silverstripe.org/contributing#writing_documentation), in order to keep a consistent
writing and formatting style (TODO: Adjust to Markdown). We use a customized version of [Markdown](http://daringfireball.net/projects/markdown/syntax) and [Markdown Extra](http://michelf.com/projects/php-markdown/extra/).

### Previewing your changes

Github allows you to preview some of the Markdown formatting straight on the website 
(in [github flavoured markdown](http://github.github.com/github-flavored-markdown/)). 
It is less powerful than our version of Markdown, but will give you a good idea.

You can also [preview Markdown Extra online](http://michelf.com/projects/php-markdown/dingus/).

**We're still working on the actual parser and test website, so currently the only way to accurately preview
your changes is to send us a pull request**

### Contributing your changes

After **pushing your changes** to your own github fork, you can send us **pull requests**.

test
test