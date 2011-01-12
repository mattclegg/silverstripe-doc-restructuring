# Formatting Syntax

[wiki:DokuWiki](wiki/DokuWiki) supports some simple markup language, which tries to make the datafiles to be as readable
as possible. This page contains all possible syntax you may use when editing the pages. Simply have a look at the source
of this page by pressing the *Edit this page* button at the top or bottom of the page. If you want to try something,
just use the [playground](playground/playground) page. The simpler markup is easily accessible via
[quickbuttons](doku>wiki/quickbuttons), too.

## Basic text formatting

DokuWiki supports **bold**, *italic*, __underlined__ and ''monospaced'' texts. Of course you can **__//''combine''//__**
all these.

    DokuWiki supports **bold**, *italic*, __underlined__ and ''monospaced'' texts.
    Of course you can **__//''combine''//__** all these.

You can use `<sub>`subscript`</sub>` and `<sup>`superscript`</sup>`, too.

    You can use `<sub>`subscript`</sub>` and `<sup>`superscript`</sup>`, too.

You can mark something as `<del>`deleted`</del>` as well.

    You can mark something as `<del>`deleted`</del>` as well.

**Paragraphs** are created from blank lines. If you want to **force a newline** without a paragraph, you can use two
backslashes followed by a whitespace or the end of line.

This is some text with some linebreaks\\ Note that the
two backslashes are only recognized at the end of a line\\
or followed by\\ a whitespace \\this happens without it.

    This is some text with some linebreaks\\ Note that the
    two backslashes are only recognized at the end of a line\\
    or followed by\\ a whitespace \\this happens without it.

You should use forced newlines only if really needed.

## Links

DokuWiki supports multiple ways of creating links.

### External

External links are recognized automagically: [poker en ligne](http://pokerenfrancais.eu/) or simply www.google.com - You
can set Linknames, too: [This Link points to google](http://www.google.com). Email addresses like this one:
`<andi@splitbrain.org>` are recognized, too.

    DokuWiki supports multiple ways of creating links. External links are recognized
    automagically: http://www.google.com or simply www.google.com - You can set
    Linknames, too: [This Link points to google](http://www.google.com). Email
    addresses like this one: `<andi@splitbrain.org>` are recognized, too. 
    

### Internal

Internal links are created by using square brackets. You can either just give a [doku>wiki:pagename](doku>wiki/pagename)
or use an additional [Title Text](doku>wiki/pagename). Wiki pagenames are converted to lowercase automatically, special
characters are not allowed. 

    Internal links are created by using square brackets. You can either just give
    a [pagename](pagename) or use an additional [Title Text](pagename). Wiki pagenames
    are converted to lowercase automatically, special chars are not allowed.

You can use [wiki:namespaces](wiki/namespaces) by using a colon in the pagename.

    You can use [wiki:namespaces](wiki/namespaces) by using a colon in the pagename.

For details about namespaces see [doku>wiki:namespaces](doku>wiki/namespaces).

Linking to a specific section is possible, too. Just add the sectionname behind a hash character as known from HTML.
This links to [this Section](syntax#internal).

    This links to [this Section](syntax#internal).

Notes:


*  Links to [existing pages](wiki/syntax) are shown in a different style from [wiki:nonexisting](wiki/nonexisting) ones.

*  DokuWiki does not use [wp>CamelCase](wp>CamelCase) to automatically create links by default, but this behaviour can
be enabled in the [doku>config](doku>config) file. Hint: If DokuWiki is a link, then it's enabled.

*  When a section's heading is changed, its bookmark changes, too. So don't rely on section linking too much.

### Interwiki

DokuWiki supports [Interwiki](doku>wiki/interwiki) links. These are quick links to other Wikis. For example this is a
link to Wikipedia's page about Wikis: [wp>Wiki](wp>Wiki).

    DokuWiki supports [Interwiki](doku>wiki/interwiki) links. These are quick links to other Wikis.
    For example this is a link to Wikipedia's page about Wikis: [wp>Wiki](wp>Wiki).

### Windows Shares

Windows shares like [this](\\server\share) are recognized, too. Please note that these only make sense in a homogenous
user group like a corporate [wp>Intranet](wp>Intranet).

    Windows Shares like [this](\\server\share) are recognized, too.

Notes:


*  For security reasons direct browsing of windows shares only works in Microsoft Internet Explorer per default (and
only in the "local zone").

*  For Mozilla and Firefox it can be enabled through the config option
[security.checkloaduri](http://www.mozilla.org/quality/networking/docs/netprefs.html#file) but this is not recommended

*  See [bug>151](bug>151) for more info

### Image Links

You can also use an image to link to another internal or external page by combining the syntax for links and
[images](#images_and_other_files) (see below) like this:

    [{{wiki:dokuwiki-128.png}}](http://www.php.net)

[{{wiki:dokuwiki-128.png}}](http://www.php.net)

Please note: The image formatting is the only formatting syntax accepted in link names.

The whole [image](#images_and_other_files) and [link](#links) syntax is supported (including image resizing, internal
and external images and URLs and interwiki links).

## Footnotes

You can add footnotes ((This is a footnote)) by using double parentheses.

    You can add footnotes ((This is a footnote)) by using double parentheses.

## Sectioning

You can use up to five different levels of headlines to structure your content. If you have more than three headlines, a
table of contents is generated automatically -- this can be disabled by including the string
`<nowiki>`~~NOTOC~~`</nowiki>` in the document.

### Headline Level 3

#### Headline Level 4
##### Headline Level 5

    ==== Headline Level 3 ====
    === Headline Level 4 ===
    == Headline Level 5 ==

By using four or more dashes, you can make a horizontal line:

----

## Images and other files

You can include external and internal [doku>images](doku>images) with curly brackets. Optionally you can specify the
size of them.

Real size:                        {{wiki:dokuwiki-128.png}}

Resize to given width:            {{wiki:dokuwiki-128.png?50}}

Resize to given width and height: {{wiki:dokuwiki-128.png?200x50}}

Resized external image:           {{http://de3.php.net/images/php.gif?200x50}}

    Real size:                        {{wiki:dokuwiki-128.png}}
    Resize to given width:            {{wiki:dokuwiki-128.png?50}}
    Resize to given width and height: {{wiki:dokuwiki-128.png?200x50}}
    Resized external image:           {{http://de3.php.net/images/php.gif?200x50}}


By using left or right whitespaces you can choose the alignment

{{ wiki:dokuwiki-128.png}}

{{wiki:dokuwiki-128.png }}

{{ wiki:dokuwiki-128.png }}

    {{ wiki:dokuwiki-128.png}}
    {{wiki:dokuwiki-128.png }}
    {{ wiki:dokuwiki-128.png }}

Of course, you can add a title (displayed as a tooltip by most browsers), too.

{{ wiki:dokuwiki-128.png |This is the caption}}

    {{ wiki:dokuwiki-128.png |This is the caption}}

If you specify a filename (external or internal) that is not an image (''gif,jpeg,png''), then it will be displayed as a
link instead.

For linking an image to another page see [Image Links](Image Links) above.

## Lists

Dokuwiki supports ordered and unordered lists. To create a list item, indent your text by two spaces and use a ''*'' for
unordered lists or a ''-'' for ordered ones.


*  This is a list

*  The second item
    * You may have different levels

*  Another item

 1.  The same list but ordered
 2.  Another item
    - Just use indention for deeper levels
 3.  That's it

	

	  * This is a list
	  * The second item
	    * You may have different levels
	  * Another item
	
	  - The same list but ordered
	  - Another item
	    - Just use indention for deeper levels
	  - That's it


## Smileys

DokuWiki converts commonly used [wp>emoticon](wp>emoticon)s to their graphical equivalents. More smileys can be placed
in the ''smiley'' directory and configured in the ''conf/smileys.conf'' file. Here is an overview of Smileys included in
DokuWiki.


*  8-) %%  8-)  %%

*  8-O %%  8-O  %%

*  :-( %%  :-(  %%

*  :-) %%  :-)  %%

*  =)  %%  =)   %%

*  :-/ %%  :-/  %%

*  :-\ %%  :-\  %%

*  :-? %%  :-?  %%

*  :-D %%  :-D  %%

*  :-P %%  :-P  %%

*  :-O %%  :-O  %%

*  :-X %%  :-X  %%

*  :-| %%  :-|  %%

*  ;-) %%  ;-)  %%

*  ^_^ %%  ^_^  %%

*  :?: %%  :?:  %%

*  :!: %%  :!:  %%

*  LOL %%  LOL  %%

*  FIXME %%  FIXME %%

*  DELETEME %% DELETEME %%

## Typography

[DokuWiki](DokuWiki) can convert simple text characters to their typographically correct entities. Here is an example of
recognized characters.

-> `<- <->` => `<= <=>` >> << -- --- 640x480 (c) (tm) (r)
"He thought 'It's a man's world'..."

	
	-> `<- <->` => `<= <=>` >> << -- --- 640x480 (c) (tm) (r)
	"He thought 'It's a man's world'..."


Please note: These conversions can be turned off through a [config option](doku>wiki/config#typography) and a [pattern
file](doku>wiki/entities).

## Quoting

Some times you want to mark some text to show it's a reply or comment. You can use the following syntax:

    I think we should do it
    
    > No we shouldn't
    
    >> Well, I say we should
    
    > Really?
    
    >> Yes!
    
    >>> Then lets do it!

I think we should do it

> No we shouldn't

>> Well, I say we should

> Really?

>> Yes!

>>> Then lets do it!

## Tables

DokuWiki supports a simple syntax to create tables. 

 | Heading 1   | Heading 2                           | Heading 3   | 
 | ---------   | ---------                           | ---------   | 
 | Row 1 Col 1 | Row 1 Col 2                         | Row 1 Col 3 | 
 | Row 2 Col 1 | some colspan (note the double pipe) |             | 
 | Row 3 Col 1 | Row 2 Col 2                         | Row 2 Col 3 | 

Table rows have to start and end with a ''|'' for normal rows or a ''^'' for headers.

 | Heading 1   | Heading 2                           | Heading 3   | 
 | ---------   | ---------                           | ---------   | 
 | Row 1 Col 1 | Row 1 Col 2                         | Row 1 Col 3 | 
 | Row 2 Col 1 | some colspan (note the double pipe) |             | 
 | Row 3 Col 1 | Row 2 Col 2                         | Row 2 Col 3 | 

To connect cells horizontally, just make the next cell completely empty as shown above. Be sure to have always the same
amount of cell separators!

Vertical tableheaders are possible, too.

 | ^ Heading 1            ^ Heading 2          ^             
 | ---------------------------------------------             
 | Heading 3    | Row 1 Col 2          | Row 1 Col 3        |
 | Heading 4    | no colspan this time |                    |
 | Heading 5    | Row 2 Col 2          | Row 2 Col 3        |

As you can see, it's the cell separator before a cell which decides about the formatting:

 | ^ Heading 1            ^ Heading 2          ^             
 | ---------------------------------------------             
 | Heading 3    | Row 1 Col 2          | Row 1 Col 3        |
 | Heading 4    | no colspan this time |                    |
 | Heading 5    | Row 2 Col 2          | Row 2 Col 3        |

Note: Vertical spans (rowspan) are not possible.

You can align the table contents, too. Just add at least two whitespaces at the opposite end of your text: Add two
spaces on the left to align right, two spaces on the right to align left and two spaces at least at both ends for
centered text.

 | Table with alignment |              |              | 
 | -------------------- |              |              | 
 | right                | center       | left         | 
 | left                 | right        | center       | 
 | xxxxxxxxxxxx         | xxxxxxxxxxxx | xxxxxxxxxxxx | 

This is how it looks in the source:

 | Table with alignment |              |              | 
 | -------------------- |              |              | 
 | right                | center       | left         | 
 | left                 | right        | center       | 
 | xxxxxxxxxxxx         | xxxxxxxxxxxx | xxxxxxxxxxxx | 

## Nonparsed Blocks

You can include non parsed blocks into your documents by either indenting them by at least two spaces (like used for the
previous examples) or by using the tags ''code'' or ''file''.

	
	This is preformatted code all spaces are preserved: like              <-this


`<file>`
This is pretty much the same, but you could use it to show that you quoted a file.  
`</file>`

To let the parser ignore an area completely (ie. do no formatting on it), enclose the area either with ''nowiki'' tags
or even simpler, with double percent signs `<nowiki>`%%`</nowiki>`.

`<nowiki>`
This is some text which contains addresses like this: http://www.splitbrain.org and **formatting**, but nothing is done
with it.
`</nowiki>`

See the source of this page to see how to use these blocks.

## Syntax Highlighting

[DokuWiki](DokuWiki) can highlight sourcecode, which makes it easier to read. It uses the
[GeSHi](http://qbnz.com/highlighter/) Generic Syntax Highlighter -- so any language supported by GeSHi is supported. The
syntax is the same like in the code block in the previous section, but this time the name of the used language is
inserted inside the tag. Eg. `<nowiki>``<code java>``</nowiki>`.

	:::java
	/** 

	 * The HelloWorldApp class implements an application that
	 * simply displays "Hello World!" to the standard output.
	 */
	class HelloWorldApp {
	    public static void main(String[] args) {
	        System.out.println("Hello World!"); //Display the string.
	    }
	}


The following language strings are currently recognized: *actionscript, actionscript-french, ada, apache, applescript,
asm, asp, autoit, bash, blitzbasic, caddcl, cadlisp, c, c_mac, cfm, cpp, csharp, css, delphi, diff, d, div, dos, eiffel,
freebasic, gml, html4strict, ini, inno, java, java5, javascript, lisp, lua, matlab, mpasm, mysql, nsis, objc, ocaml,
ocaml-brief, oobas, oracle8, pascal, perl, php-brief, php, python, qbasic, scheme, sdlbasic, smarty, sql, tsql, robots,
ruby, vb, vbnet, vhdl, visualfoxpro, xml*

## Embedding HTML and PHP

You can embed raw HTML or PHP code into your documents by using the ''html'' or ''php'' tags like this:

	
	`<html>`
	This is some `<font color="red" size="+1">`HTML`</font>`
	`</html>`


`<html>`
This is some `<font color="red" size="+1">`HTML`</font>`
`</html>`

	
	`<php>`
	echo 'A logo generated by PHP:';
	echo `<img src="' . $_SERVER['PHP_SELF'] . '?=' . php_logo_guid() . '" alt="PHP Logo !" />`;
	`</php>`


`<php>`
echo 'A logo generated by PHP:';
echo `<img src="' . $_SERVER['PHP_SELF'] . '?=' . php_logo_guid() . '" alt="PHP Logo !" />`;
`</php>`

**Please Note**: HTML and PHP embedding is disabled by default in the configuration. If disabled, the code is displayed
instead of executed.

## Syntax Plugins

DokuWiki's syntax can be extended by [Plugins](doku>wiki/plugins). How the installed plugins are used is described on
their appropriate description pages. The following syntax plugins are available in this particular DokuWiki
installation:

~~INFO:syntaxplugins~~
