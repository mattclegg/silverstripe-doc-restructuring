For SEO and esthetical reasons, you may want the language parameter in a multilanguage content environment not as a
simple GET parameter. Here is a hack that does that. It works against version 2.2.2 of Silverstripe - mileages may vary.
The following recipe will create URL segments that look like /en/news or /de/neuigkeiten instead of /news/?lang=en or
/news/?lang=de

**First** step is adding i18n support to the system as a whole. Change **/mysite/_config.php**, add the following lines
and rebuild your database.`<code php>`
i18n::enable();

global $allowed_i18n;
$allowed_i18n = array('en' => "en_GB", 'es' => "es_ES", 'fr' => "fr_FR"); // these are the allowed language codes and
the associated locales
`</code>`


**Second**: Load **/sapphire/main.php** and find the place that starts with `<code php>`
// Default director
Director::addRules(10, array(
`</code>`

Add __before__ that the following code `<code php>`
$baseURL = dirname(dirname($_SERVER['SCRIPT_NAME']));
if(substr($url,0,strlen($baseURL)) == $baseURL) $url = substr($url,strlen($baseURL));

global $allowed_i18n;
if(sizeof($allowed_i18n) > 0) {
    $tmp_url = preg_replace( array( '/\/+/','/^\//', '/\/$/'),array('/','',''),$url);
    $tmp_urlParts = split('/+', $tmp_url);
    $lng = array_shift($tmp_urlParts);
    $bSetLng = false;
    if(isset($allowed_i18n[strtolower($lng)])) {
    i18n::set_locale($allowed_i18n[strtolower($lng)]); // SS locale.
    setlocale(LC_ALL, $allowed_i18n[strtolower($lng)]); // For l10n of dates, for example. The locale must be installed
in the PHP environment.
    $url = "/".join('/', $tmp_urlParts);
    $_REQUEST['url']  = $url;
    $bSetLng = true;
    }
    // allow GET to overwrite the URL language selection
    if(isset($_GET['lang']) && in_array(strtolower($_GET['lang']), $allowed_i18n)) {
    $lng = $_GET['lang'];
    $bSetLng = true;
    }
    if($bSetLng) {
    $_GET['lang'] = $lng;
    }
    unset($lng, $bSetLng, $tmp_url, $tmp_urlParts);
}
`</code>`

This code basically splits up the url, looks for the first component and checks if this is a known language code from
your _config.php change. If so it sets the GET parameter, reconstructs the URL and continues.


**Third**: In the same file, you find later on lines that read like that `<code php>`
// Get the request URL
$baseURL = dirname(dirname($_SERVER['SCRIPT_NAME']));

if(substr($url,0,strlen($baseURL)) == $baseURL) $url = substr($url,strlen($baseURL));
`</code>`
Delete these lines (or comment them out) to not to overwrite the changed (fixed) URL.


**Fourth**: Your /mysite/code/Page.php needs some code to know about current languages and translation names to help
your templates. The minimum is `<code php>`
<?php

class Page extends SiteTree {
    static $db = array(
    );
    static $has_one = array(
    );
    function CurrentLang() {
        return (Translatable::current_lang()) ? Translatable::current_lang() : 'en';
    }
}

class Page_Controller extends ContentController {
    function init() {
        parent::init();

        Requirements::themedCSS("layout");
        Requirements::themedCSS("typography");
        Requirements::themedCSS("form");
    }
    function LanguageSwitcher() {
        if($this->URLSegment == "Security") return "";
        $langs = i18n::get_existing_content_languages();
        $data = new DataObjectSet();
        foreach(array_keys($langs) as $code) {
                if($code == Translatable::current_lang()) {
                        continue;
                }
                $page = Translatable::get_one_by_lang("SiteTree", $code, "`SiteTree`.ID = " . Controller::curr()->ID);
                $data->push(new ArrayData(array('name' => i18n::get_language_name($code, true),
                                                'link' => "/$code/" . $page->URLSegment,
                                                'code' => $code)));
        }
        return $data;
    }
}
?>
`</code>`


**Fifth**: Add a language switcher. Mine is called LanguageSwitcher.ss and lives in /themes/YOURS/templates/Includes/
and looks like that: `<code php>`
`<link rel="stylesheet" href="/themes/sans/css/language.css" type="text/css" media="screen" />`
`<div id="languagecontainer">`
    `<ul id="language">`
    `<li>``<p>`$CurrentLang`</p>``</li>`
    `<% control LanguageSwitcher %>`
      `<li>``<a href="$link">`$code`</a>``</li>`
    `<% end_control %>`
    `</ul>`
`</div>`
`</code>`
That way you can throw in a `<% include LanguageSwitcher %>` in your templates.

**Caveats** : From what I observed, you need to have distinct page names for all languages. /en/news and /fr/news will
give you the news page from the default language. SS does not honor language/page combinations, it.seems
