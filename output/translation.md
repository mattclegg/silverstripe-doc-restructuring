# Introduction


## How can I help?

We are always looking for new translators. Even if a specific language already is translated and has an official
maintainer, we can use helping hands in reviewing and updating translations.
Important: It is perfectly fine if you only have time for a partial translation or quick review work - our system
accomodates many people collaborating on the same language.


*  You can apply [here](http://translate.silverstripe.com/apply/)

*  Announce and discuss translations on the forum
([here](http://silverstripe.com/extending-hacking-silverstripe-forum/flat/292))

*  Make your modules translatable (see [i18n](i18n))

*  Make your themes translatable (see [i18n](i18n))



## How do I start translating?

We have a translation server with an interface to facilitate community-driven translations. Once you have offered to
translate, we'll get in touch with you by email and provide you with an account.

Once you have your account details, you can go [here](http://translate.silverstripe.com/) and choose a language you want
to translate. You'll then need to login with the details provided.

Please [contact us](http://translate.silverstripe.com/contact/) if you have any specific questions about
translate.silverstripe.com.

## How do I translate substituted strings? (e.g. '%s')

You don't have to - if the english master-string reads *'Hello %s'*, your german translation would be *'Hallo %s'*.
Strings prefixed by a percentage-sign are automatically replaced by silverstripe with dynamic content. See
http://php.net/sprintf for details.

## Do I need to convert special characters (e.g. HTML-entities)?

Special characters (such as german umlauts) need to be entered in their native form. Please don't use HTML-entities
("ä" instead of "&auml;"). Silverstripe stores and renders most strings in UTF8 (Unicode) format.

## How can I check out my translation in the interface?

Currently translated entities are not directly factored into code (for security reasons and release/review-control), so
you can't see them straight away. You can download automatically generated php-files for your language on the
translation-server for each module (e.g. cms, sapphire, forum, ...) - and place those files in the appropriate
directories on a local silverstripe installation. Please use our [daily-builds](daily-builds) for your local
installation.

Example for downloading french files from the translation-server:

	
	downloaded fr_FR.php for cms => `<yoursilverstripe>`/cms/lang/fr_FR.php
	downloaded fr_FR.php for sapphire => `<yoursilverstripe>`/sapphire/lang/fr_FR.php
	(repeat for all modules)


**It is strongly encouraged that you check your translation this way, as its a good way to doublecheck your translation
works in the right context**

## How do I change my interface language?

Once you've logged into the CMS, you should see a "profile"-link on the lower right corner (direct link:
http://www.site.com/admin/myprofile). You can set the "interface language" from a dropdown which automatically includes
all found translations (based on the php-files in the /lang-folders).
## I've found a piece of untranslatable text

It is entirely possible that we missed certain strings in preparing Silverstripe for translation-support. If you're
technically minded, please read [i18n](i18n) on how to make it translatable. Otherwise just post your findings to the
[forum](http://silverstripe.com/silverstripe-forum/). 

Note: JavaScript strings can't be translated through translate.silverstripe.org, you'll need to edit the file locally
(e.g. *cms/javascript/de_DE.js*), and [submit a patch](http://open.silverstripe.org). See [i18n: JavaScript
Usage](i18n#javascript_usage) for details.

## How do I add my own module to the translation server

Once you've built a translation-enabled module, you can run the "[textcollector](i18n#collecting_text)" on your local
installation for this specific module (see [i18n](i18n)). This should find all calls to _t() in php/ss-files, and
generate a new lang-file with the default locale (path: `<mymodule>`/lang/en_US.php). Upload this file to the
translation-server, wait for approval by Silverstripe, and wait for the translators to do their magic!

## What about right-to-left (RTL) languages (e.g. Arabic)?

Silverstripe doesn't have built-in support for attribute-based RTL-modifications (<html dir="rtl"). We are currently
investigating the available options, and are eager to get [feedback](http://silverstripe.com/contact/) on your
experiences with translating silverstripe RTL.

## Can I translate/edit the language files in my favourite text editor (on my local installation)

**No**, as it causes us a lot of work in merging these files back to the database, and doesn't denote you as the author
of a particular translation. Please use [http://translate.silverstripe.com](http://translate.silverstripe.com) for all
new and existing translations.

## How does my translation get into a SilverStripe release?

Currently this is a manual process of a core team member downloading approved translations from
[http://translate.silverstripe.com](http://translate.silverstripe.com) and committing them into our source tree.

##  How does my translation get approved? 

We require every translation to have at least two active contributors before approving a language, to avoid misuse and
have some quality control. A translation has to be mostly complete to get approved for a specific module.

## I'm seeing lots of duplicated translations, what should I do?

For now, please translate all duplications - sometimes they might be intentional, but mostly the developer just didn't
know his phrase was already translated. Please [contact us](http://translate.silverstripe.com/contact/) about any
duplicates that might be worth merging.

# Related

*  [i18n](i18n): Developer-level documentation of Silverstripe's i18n capabilities

*  [modules:translation](modules/translation): The module powering our translation server

*  [translatable](translatable): DataObject-interface powering the website-content translations

*  [multilingualcontent](multilingualcontent): Developer-level documentation for translating website content

*  [translation-offers](translation-offers)
