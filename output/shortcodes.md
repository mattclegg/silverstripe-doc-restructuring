## The Shortcode API

The Shortcode API (new in 2.4) is a simple regex based parser that allows you to replace simple bbcode-like tags within
a HTMLText or HTMLVarchar field when rendered into a template. It is inspired by and very similar to the [Wordpress
implementation](http://codex.wordpress.org/Shortcode_API) of shortcodes. Examples of shortcode tags are:

    [shortcode]
    [shortcode /]
    [shortcode parameter="value"]
    [shortcode parameter="value"]Enclosed Content[/shortcode]

### Defining Custom Shortcodes

All you need to do to define a shortcode is to register a callback with the parser that will be called whenever a
shortcode is encountered. This callback will return a string to replace the shortcode with.

To register a shortcode you call:

    ShortcodeParser::get('default')->register('shortcode_tag_name', 'callback');

These parameters are passed to the callback:

*  Any parameters attached to the shortcode as an associative array (keys are lower-case).

*  Any content enclosed within the shortcode (if it is an enclosing shortcode). Note that any content within this will
not have been parsed, and can optionally be fed back into the parser.

*  The ShortcodeParser instance used to parse the content.

*  The shortcode tag name that was matched within the parsed content.

### Inbuilt Shortcodes

#### SiteTree Links

From 2.4 onwards links inserted via the CMS into a content field are in the form `<a href="[sitetree_link id=n]">`. At
runtime this is replaced by a plain link to the page with the ID in question.

### Limitations

Since the shortcode parser is based on a simple regular expression it cannot properly handle nested shortcodes. For
example the below code will not work as expected:

    [shortcode]
    [shortcode][/shortcode]
    [/shortcode]

The parser will recognise this as:

    [shortcode]
    [shortcode]
    [/shortcode]
