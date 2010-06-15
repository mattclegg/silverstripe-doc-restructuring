# Tools: Dreamweaver

## Compatibility
* OSX
* Windows

## Product Link
http://www.adobe.com/ap/products/dreamweaver/

## Adding Silverstripe extension to WYSIWYG mode
Edit:

Win: C:\Program Files\Adobe\Adobe Dreamweaver CS3\configuration\DocumentTypes\MMDocumentTypes.xml

Mac: /Applications/Adobe Dreamweaver CS3/Configuration/DocumentTypes/MMDocumentTypes.xml

Change Line 3 into:

~~~ {xml}
<documenttype id="HTML" internaltype="HTML" winfileextension="html,htm,shtml,shtm,stm,tpl,lasso,xhtml,ss" macfileextension="html,htm,shtml,shtm,tpl,lasso,xhtml,ssi,ss" file="Default.html" writebyteordermark="false">
~~~

## Adding Silverstripe Syntax Highlighting
Edit:

Win: C:\Documents and Settings\<username>\Application Data\Adobe\Dreamweaver 9\Configuration\CodeColoring\CodeColoring.xml

Mac: /Users/<username>/Library/Application Support/Adobe/Dreamweaver 9/Configuration/CodeColoring/CodeColoring.xml

Paste the following in Line 2 under the codeColoring tag:

~~~ {xml}
<scheme name="SilverStripe Template" id="SilverStripe_Template" priority="21">
	<ignoreCase>Yes</ignoreCase>
	<ignoreTags>Yes</ignoreTags>

	<blockStart name="Block Delimiter" id="CodeColor_PHPScriptBlock" doctypes="HTML" scheme="customText"><![CDATA[<%]]></blockStart>
	<blockEnd><![CDATA[%>]]></blockEnd>

	<brackets name="Bracket" id="CodeColor_JavaBracket"><![CDATA[([])]]></brackets>

	<commentStart name="Comment" id="CodeColor_PHPScriptComment"><![CDATA[*]]></commentStart>
	<commentEnd><![CDATA[*]]></commentEnd>

	<defaultText name="Text" id="CodeColor_PHPScriptVariables" />
	<defaultTag name="Other Tags" id="CodeColor_PHPScriptVariables" />
	<defaultAttribute />

	<stringStart name="String" id="CodeColor_PHPScriptString"><![CDATA["]]></stringStart>
	<stringEnd><![CDATA["]]></stringEnd>
	<stringStart><![CDATA[']]></stringStart>
	<stringEnd><![CDATA[']]></stringEnd>
	<stringEsc><![CDATA[\]]></stringEsc>

	<operators name="Operator" id="CodeColor_PHPScriptOperator"><![CDATA[+-*/%<>!?:=~^`.]]></operators>
	<numbers name="Number" id="CodeColor_PHPScriptNumber" />
	<idChar1>_$abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ</idChar1>
	<idCharRest name="Identifier" id="CodeColor_PHPScriptIdentifier">_$abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789</idCharRest>

<keywords name="Reserved Keywords" id="CodeColor_PHPScriptReserved">
	<keyword>if</keyword>
	<keyword>end_if</keyword>
	<keyword>else</keyword>
	<keyword>else_if</keyword>
	<keyword>control</keyword>
	<keyword>end_control</keyword>
	<keyword>base_tag</keyword>
</keywords>

<keywords name="Variables" id="CodeColor_PHPScriptVariables">
	<keyword>$Title</keyword>
	<keyword>$Link</keyword>
	<keyword>$XML</keyword>
	<keyword>$Parent</keyword>
	<keyword>$Form</keyword>
	<keyword>$Content</keyword>
	<keyword>$LinkingMode</keyword>
	<keyword>$LinkOrCurrent</keyword>
	<keyword>$LinkOrSection</keyword>
	<keyword>$MetaTags</keyword>
	<keyword>$URLSegment</keyword>
	<keyword>$Now</keyword>
	<keyword>$Created</keyword>
	<keyword>$LastEdited</keyword>
	<keyword>$Pos</keyword>
	<keyword>$TotalItems</keyword>
	<keyword>$Top</keyword>
	<keyword>$SeachResults</keyword>
	<keyword>$PageNum</keyword>
</keywords>

<keywords name="Functions" id="CodeColor_PHPScriptFunctionsKeywords">
	<keyword>Menu</keyword>
	<keyword>ChildrenOf</keyword>
	<keyword>Children</keyword>
	<keyword>AllChildren</keyword>
	<keyword>Parent</keyword>
	<keyword>Breadcrumbs</keyword>
	<keyword>CurrentMember</keyword>
	<keyword>PastMember</keyword>
	<keyword>PastVisitor</keyword>
	<keyword>Nice</keyword>
	<keyword>Year</keyword>
	<keyword>Ago</keyword>
	<keyword>Even</keyword>
	<keyword>Odd</keyword>
	<keyword>EvenOdd</keyword>
	<keyword>First</keyword>
	<keyword>Last</keyword>
	<keyword>Middle</keyword>
	<keyword>FirstLast</keyword>
	<keyword>ClassName</keyword>
	<keyword>SearchResults</keyword>
	<keyword>MoreThanOnePage</keyword>
	<keyword>Nextlink</keyword>
	<keyword>PrevLink</keyword>
	<keyword>CurrentPage</keyword>
	<keyword>TotalPages</keyword>
	<keyword>TotalItems</keyword>
	<keyword>Pages</keyword>
	<keyword>CurrentBool</keyword>
	<keyword>UL</keyword>
</keywords>

<sampleText doctypes="HTML,SS"><![CDATA[]]></sampleText>

</scheme>
~~~
The above rules are a work in progress and a probably not entirely correct.

If anyone improves on this please edit the examples. 
