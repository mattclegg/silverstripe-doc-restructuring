# Integrate GeSHi in your Website
[GeSHi](http://qbnz.com/highlighter/) is a powerful syntax Highlighter written in PHP (it is also used for the code highlighting in this wiki by the way). With some small additions, it can be integrated easily into a existing SilverStripe Website. This is very useful if you're frequently posting code-snippets on your site.

## Requirements
This has been tested with SilverStripe 2.2.2 so far, but should work with other versions too (must support custom TextParser classes).


### Installing GeSHi
Other than a SilverStripe installation, you need to download and install the GeSHi Source-Code. I downloaded the most recent version (1.0.8) from [SourceForge](http://sourceforge.net/project/showfiles.php?group_id=114997). When you unpack the downloaded archive, you'll find the folders ''contrib'', ''docs'' and ''geshi'' and a file called ''geshi.php''. All you need is the ''geshi.php'' file and the ''geshi'' folder. The other folders should not be put on a live-server.

You can put the geshi files wherever you want on your server. I put them in the ''mysite/code'' directory. Here's a screenshot of my directory structure:\\
{{:recipes:codehighlight-structure-simplified.png|Directory structure used in this Tutorial}}

That concludes the installation of the GeSHi sources, now we need to integrate it into our website.



## Text-Parser
As you can see in the directory structure (screenshot above), there's a custom Parser Class, named ''CodeParser''. Here's the full code-listing for that class (you have to put it in a folder named **parsers**):
~~~ {php}
<?php
/**
 * SilverStripe Parser that uses the GeSHi Parser for Syntax highlighting.
 * Runs Blocks that are wrapped in <pre> Tags through the parser. The
 * default language is set to php, but can be set inside the <pre> block
 * by setting [<langcode>] as first element in the text
 * 
 * @requires GeSHi 1.0.8 (http://qbnz.com/highlighter/geshi-doc.html)
 */
include_once(dirname(__FILE__) . '/../geshi/geshi.php');

class CodeParser extends TextParser 
{
    static $defaultLang = 'php';
    static $wrapper = 'pre';
    static $tabWidth = 4;
    
    function parse(){
        $pattern = '|<' . self::$wrapper . '[^>]*?>(.*?)</' . self::$wrapper . '>|is';
        return preg_replace_callback($pattern, array(&$this, 'replace'), $this->content);
    }
    
    function replace(&$in){
        $code = preg_replace('{<br\s*/>}i', "\n", $in[1]);
        $code = strip_tags($code);
        $code = html_entity_decode($code, ENT_QUOTES, 'UTF-8');
        
        $matches;
        $lang = self::$defaultLang;
        // parse the code language to use
        if(preg_match('/^\s*\[(\w+)]\s*/is', $code, $matches)){
            $code = trim(substr($code, strlen($matches[0])));
            $lang = $matches[1];
        }
        
        $geshi = new GeSHi($code, $lang);
        $geshi->set_header_type(GESHI_HEADER_DIV);
        $geshi->set_tab_width(self::$tabWidth);
        $geshi->set_overall_class('codeblock');
        $geshi->enable_classes(false);
        
        return $geshi->parse_code();
    }
}
~~~

The static variables allow some minor tweaking of settings. You can alter the tab-width, the default wrapper element and the default syntax-highlight language. If you put the geshi sources somewhere else, please make sure to modify the **include statement** accordingly!

The ''replace'' method does the actual syntax highlighting using GeSHi. Feel free to change these options according to your needs (read the [geshi docs](http://qbnz.com/highlighter/geshi-doc.html) for pointers). I used a div wrapper for my code, that gets the class 'codeblock'. Setting ''$geshi->enable_classes(true);'' causes geshi to output css classes for the code elements. For that to work, you need a css stylesheet that defines the syntax coloring. In the code above it is set to **false**, because that will get you syntax highlighting without an additional stylesheet (using inline styles).

## Using Syntax-Highlighting in your Website
If you followed the previous steps, you now have all the required code for syntax-highlighting on your website. But there are still some things to do. First, let's enter a piece of code in the CMS:\\
{{:recipes:codehighlight-in-cms.png|Entering code in the CMS}}

On the screenshot you can see, that i entered code normally in the content-field and set it to "preformatted". That should wrap the code in a <pre> Element which is what we need for our CodeParser to work.

### Specify the code language
Most likely you don't just post code in PHP, but maybe HTML, CSS, SQL etc. GeSHi supports a lot of different languages, now you just need a way to tell the parser which language to use.
I implemented it as follows: The parser looks if there is a //language indicator// at the beginning of the code and then uses this language. If nothing is specified, the default is being used (in our case PHP). I highlighted the //language indicator// in the screenshot above. You basically just write ''[<languagename>]'' on the first line of your code and GeSHi will parse the source using ''<languagename>''.

### Using it in your template
This part is really simple. Instead of using 
~~~
$Content
~~~
you now simple use
~~~
$Content.Parse(CodeParser)
~~~

That's all. It's possibly a good idea to only apply this in templates where you **have** code snippets. Maybe you should create a custom Page Class (CodePage or similar) for that case.

If you placed above code in your Template, you should allready get highlighted code. But it will most likely appear in a sans font, instead of monospace. That's because we wrapped our code in a <div> element, remember? We can easily fix that by adding something like this to our typography.css file:
~~~ {css}
.codeblock {
	font-family:Courier, 'Courier New', monospace, fixed !important;
	overflow: auto;
	white-space:nowrap;
	padding:8px;
	border:1px solid #999;
}
~~~

That's all. Here's a screenshot how output would look like when you followed all previous steps (using the blackcandy theme here):\\
{{:recipes:codehighlight-output.png|Syntax-Highlighter output}}
