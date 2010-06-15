# SilverStripe Documentation Planning


This document helps to plan a restructuring effort of the doc.ss.org documentation. See this [blog post](http://silverstripe.org/calling-for-help-in-documentation/) for an introduction, and [discuss on the documentation mailinglist](http://groups.google.com/group/silverstripe-documentation).

The highlevel goals are to move API-style documentation closer to the source code (into api.ss.org), as well as consolidate the existing wiki documentation into fewer coherent “topics” in addition to the existing tutorials (e.g. a “forms” topic, rather than a dozen pages describing form types, which should be in the API). As a medium term goal, we want to move most “core” documentation from the wiki into version control through Markdown formatting.

You can file tickets on [open.silverstripe.org](http://open.silverstripe.org/query?status=inprogress&status=new&status=replyneeded&status=reviewed&component=Documentation&order=priority&col=id&col=summary&col=status&col=type&col=priority&col=milestone&col=component) for requesting new documentation, but please use this page for any restructuring efforts.



## Sapphire Documentation

The Sapphire framework will have its own documentation, stored in the repository at sapphire/docs,
and make accessible through a dev/docs handler.  The documentation will mostly consist of Markdown
files.

### Index

   * [:start](/start)

### Installation / Upgrading

#### Existing Pages
   * [:installation-on-lighttpd](/installation-on-lighttpd)
   * [:installation-on-mac-osx](/installation-on-mac-osx)
   * [:installation-on-nginx](/installation-on-nginx)
   * [:installation-on-webserver](/installation-on-webserver)
   * [:installation-on-windows-manual-iis](/installation-on-windows-manual-iis)
   * [:installation-on-windows](/installation-on-windows)
   * [:installation](/installation)
   * [:server-requirements](/server-requirements)
   * [:silverstripe-on-mamp](/silverstripe-on-mamp)
   * [:upgrading:2.1.0](/upgrading/2.1.0)
   * [:upgrading:2.2.0](/upgrading/2.2.0)
   * [:upgrading:2.3.0](/upgrading/2.3.0)
   * [:upgrading:2.3.2](/upgrading/2.3.2)
   * [:upgrading:trunk](/upgrading/trunk)
   * [:upgrading](/upgrading)




### Getting Started

#### Existing Pages
   * [:common-problems](/common-problems)
   * [:developer-guide](/developer-guide)
   * [:directory-structure](/directory-structure)
   * [:manifestbuilder](/manifestbuilder)
   * [:recipes:example_config_file](/recipes/example_config_file)
   * [:recipes:structural-guidelines](/recipes/structural-guidelines)



### Controllers

#### Existing Pages

   * [:cache-control](/cache-control)
   * [:controllers](/controllers)
   * [:controller](/controller)
   * [:execution-pipeline](/execution-pipeline)
   * [:objectmodel](/objectmodel)
   * [:recipes:what_to_return_from_a_function](/recipes/what_to_return_from_a_function)

#### TODO

   * New topic: Nested Controllers


### Database /ORM

#### Existing Pages

   * [:data-types](/data-types) - generate the types list
   * [:database-abstraction](/database-abstraction)
   * [:database-structure](/database-structure)
   * [:database-troubleshooting](/database-troubleshooting)
   * [:datamodel](/datamodel)
   * [:dataobjectdecorator](/dataobjectdecorator)
   * [:dataobject](/dataobject)
   * [:db-build](/db-build)
   * [:image](/image)
   * [:page](/page) - merge with datamodel
   * [:recipes:many_many-example](/recipes/many_many-example)
   * [:sitetree](/sitetree)] - merge with datamodel


### Templates & Themes

#### Existing Pages
   * [:recipes:customising-content-in-your-templates](/recipes/customising-content-in-your-templates)
   * [:template-encoding](/template-encoding) - merge into [:templates](/templates)
   * [:templates](/templates)
   * [:themes:developing](/themes/developing)
   * [:themes](/themes)

#### TODO

   * New topic: Subthemes (e.g. "blackcandy_blog")



### Forms

#### Existing Pages

   * [:form-field-types](/form-field-types) - auto generate?
   * [:form-validation](/form-validation) - merge into form (perhaps with a new advanced page)
   * [:form](/form)
   * [:recipes:forms](/recipes/forms)
   * [:recipes:imageupload](/recipes/imageupload)
   * [:recipes:widget-forms-2.3](/recipes/widget-forms-2.3)




### Security

#### Existing Pages
   * [:member](/member) - needs cleanup
   * [:permissions:codes](/permissions/codes) - autogenerate?
   * [:permission](/permission)
   * [:recovering_password](/recovering_password) - recipe?
   * [:secure-development](/secure-development)
   * [:security-statement](/security-statement) - merge into [:secure-development](/secure-development)
   * [:security](/security)
   * [:ssl](/ssl)



### Frontend development

#### Existing Pages

   * [:html](/html)
   * [:css](/css)
   * [:javascript](/javascript)
   * [:recipes:combining_files](/recipes/combining_files)
   * [:requirements](/requirements)

	 

### Testing

#### Existing Pages

   * [:testing-guide-glossary](/testing-guide-glossary)
   * [:testing-guide-howto:test-email-sending](/testing-guide-howto/test-email-sending)
   * [:testing-guide-intro](/testing-guide-intro)
   * [:testing-guide-troubleshooting](/testing-guide-troubleshooting)
   * [:testing-guide](/testing-guide)
   * [:testing-howto:create-functional-test](/testing-howto/create-functional-test)
   * [:testing-howto:create-sapphire-test](/testing-howto/create-sapphire-test)



### Modules

#### Existing Pages
   * [:installing-modules](/installing-modules) - merge with [:modules](/modules)
   * [:modules](/modules)
   * [:private:tutorial:creating-a-module](/private/tutorial/creating-a-module)



### Development Tools

#### Existing Pages

   * [:debugging](/debugging)
   * [:error-handling](/error-handling)
   * [:migrationtask](/migrationtask)
   * [:profiler](/profiler)
   * [:publishing-to-web-server](/publishing-to-web-server)
   * [:sake](/sake)
   * [:urlvariabletools](/urlvariabletools)

### Advanced Development

#### Existing Pages

   * [:coding-conventions](/coding-conventions)
   * [:creating-modules](/creating-modules)
   * [:csvbulkloader](/csvbulkloader)
   * [:email](/email)
   * [:environment-management](/environment-management)
   * [:escape-types](/escape-types) - needs to be earlier, this is a basic topic
   * [:i18n](/i18n)
   * [:restfulserver](/restfulserver)
   * [:translatable](/translatable)


It's not clear whether these should be part of API docs or not:

*  [:restfulservice](/restfulservice)
*  [:bbcode](/bbcode)
*  [:tablelistfield](/tablelistfield)
*  [:complextablefield](/complextablefield)

## CMS Documentation


The SilverStripe CMS will also have its own documentation, stored in the repository at cms/docs.
The dev/docs handler, mentioned under Sapphire Documentation, will need to be smart enough to
collate the documentation from Sapphire, CMS, and all the modules in a useful way.

*  [:built-in-page-controls](/built-in-page-controls) - autogenerate more of this
*  [:cmsmain](/cmsmain)
*  [:configuration](/configuration) - autogenerate?
*  [:getcmsfields](/getcmsfields)
*  [:how-page-security-works](/how-page-security-works)
*  [:leftandmain](/leftandmain)
*  [:modeladmin](/modeladmin)
*  [:multilingualcontent](/multilingualcontent)
*  [:page-types](/page-types)
*  [:pageless-controller](/pageless-controller)
*  [:private:custom-page-controls](/private/custom-page-controls)
*  [:private:recipes:pagination](/private/recipes/pagination)
*  [:recipes:changingfields](/recipes/changingfields)
*  [:recipes:controllers](/recipes/controllers)
*  [:recipes:dataobjectsearch](/recipes/dataobjectsearch) - modeladmin
*  [:recipes:examples_of_creating_and_saving_pages](/recipes/examples_of_creating_and_saving_pages)
*  [:searchform](/searchform)
*  [:staticexporter](/staticexporter)
*  [:staticpublisher](/staticpublisher)
*  [:tutorial:1-building-a-basic-site](/tutorial/1-building-a-basic-site)
*  [:tutorial:2-extending-a-basic-site](/tutorial/2-extending-a-basic-site)
*  [:tutorial:3-forms](/tutorial/3-forms)
*  [:tutorial:4-site-search](/tutorial/4-site-search)
*  [:tutorial:5-dataobject-relationship-management](/tutorial/5-dataobject-relationship-management)
*  [:tutorial:adapting-a-theme](/tutorial/adapting-a-theme)
*  [:tutorial:creating-a-theme](/tutorial/creating-a-theme)
*  [:tutorial:site-map](/tutorial/site-map)
*  [:tutorials](/tutorials)
*  [:typography](/typography)
*  [:widgets](/widgets)



## API documentation

Much of the content should be merged into the codebase and turned into accessible documentation via
a documentation generator such as phpDocumentor.  Note, however, that an alternative to phpDocumentor
would be nice, as it is still difficult to access information from phpDocumentor's documentation.


*  [:arraydata](/arraydata)
*  [:authenticator](/authenticator)
*  [:cmsmenu](/cmsmenu)
*  [:contentnegotiator](/contentnegotiator)
*  [:dataobjectset](/dataobjectset)
*  [:director](/director)
*  [:fieldgroup](/fieldgroup)
*  [:formresponse](/formresponse)
*  [:formtransformation](/formtransformation)
*  [:hide-ancestor](/hide-ancestor)
*  [:hierarchy](/hierarchy)
*  [:htmleditorconfig](/htmleditorconfig)
*  [:manipulation-arrays](/manipulation-arrays)
*  [:mathspamprotection](/mathspamprotection)
*  [:object](/object)
*  [:rssfeed](/rssfeed)
*  [:scheduledtask](/scheduledtask)
*  [:searchcontext](/searchcontext)
*  [:session](/session)
*  [:site-reports](/site-reports) - move to CMSReport API docs
*  [:soapmodelaccess](/soapmodelaccess)
*  [:timefield](/timefield)
*  [:versioned](/versioned)
*  [:virtualpage](/virtualpage)
*  [:xml](/xml)


FormField types

*  [:ajaxformaction](/ajaxformaction)
*  [:autocompletetextfield](/autocompletetextfield)
*  [:bankaccountfield](/bankaccountfield)
*  [:calendardatefield](/calendardatefield)
*  [:checkboxfield](/checkboxfield)
*  [:checkboxsetfield](/checkboxsetfield)
*  [:complextablefieldexamples](/complextablefieldexamples) - into complextablefield
*  [:compositedatefield](/compositedatefield)
*  [:compositefield](/compositefield)
*  [:confirmedformaction](/confirmedformaction)
*  [:confirmedpasswordfield](/confirmedpasswordfield)
*  [:countrydropdownfield](/countrydropdownfield)
*  [:creditcardfield](/creditcardfield)
*  [:currencyfield](/currencyfield)
*  [:datefield](/datefield)
*  [:dmycalendardatefield](/dmycalendardatefield)
*  [:dropdownfield](/dropdownfield)
*  [:emailfield](/emailfield)
*  [:filefield](/filefield)
*  [:formaction](/formaction)
*  [:groupeddropdownfield](/groupeddropdownfield)
*  [:gstnumberfield](/gstnumberfield)
*  [:hasmanycomplextablefield](/hasmanycomplextablefield)
*  [:hasonecomplextablefield](/hasonecomplextablefield)
*  [:headerfield](/headerfield)
*  [:hiddenfield](/hiddenfield)
*  [:htmleditorfield](/htmleditorfield)
*  [:imagefield](/imagefield)
*  [:inlineformaction](/inlineformaction)
*  [:labelfield](/labelfield)
*  [:labelledliteralfield](/labelledliteralfield)
*  [:languagedropdownfield](/languagedropdownfield)
*  [:listboxfield](/listboxfield)
*  [:literalfield](/literalfield)
*  [:manymanycomplextablefield](/manymanycomplextablefield)
*  [:membertablefield](/membertablefield)
*  [:numericfield](/numericfield)
*  [:optionsetfield](/optionsetfield)
*  [:passwordfield](/passwordfield)
*  [:readonlyfield](/readonlyfield)
*  [:recipes:dropdownoptions](/recipes/dropdownoptions)
*  [:relateddatafield](/relateddatafield)
*  [:relationtable](/relationtable)
*  [:simpleimagefield](/simpleimagefield)
*  [:tablefield](/tablefield)
*  [:tabset](/tabset)
*  [:tab](/tab)
*  [:textareafield](/textareafield)
*  [:textfield](/textfield)
*  [:treedropdownfield](/treedropdownfield)
*  [:treemultiselectfield](/treemultiselectfield)
*  [:uniquerestrictedtextfield](/uniquerestrictedtextfield) - will need an image include


Validators

*  [:customrequiredfields](/customrequiredfields)
*  [:recipes:requiredfieldsclass](/recipes/requiredfieldsclass)
*  [:requiredfields](/requiredfields)
*  [:validator](/validator)


DBField types

*  [:boolean](/boolean)
*  [:currency](/currency)
*  [:date](/date)
*  [:dbfield](/dbfield)
*  [:decimal](/decimal)
*  [:enum](/enum)
*  [:htmltext](/htmltext)
*  [:htmlvarchar](/htmlvarchar)
*  [:int](/int)
*  [:percentage](/percentage)
*  [:ssdatetime](/ssdatetime)
*  [:text](/text)
*  [:time](/time)
*  [:varchar](/varchar)


## Module Documentation

Each module should have its down documentation, stored in a README.md file, or in a docs/ subfolder.

DataObjectManager

*  [:datepickerfield](/datepickerfield)
*  [:simplehtmleditorfield](/simplehtmleditorfield)
*  [:simpletreedropdownfield](/simpletreedropdownfield)
*  [:simplewysiwygfield](/simplewysiwygfield)

Page Comment (make a module)

*  [:pagecomment](/pagecomment)

Newsletter

*  [:member_groupset](/member_groupset)
*  [:newslettersytemhelp](/newslettersytemhelp)
*  [:recipes:simplesignupform](/recipes/simplesignupform)

User Forms

*  [:fieldeditor](/fieldeditor) - into API docs

Ecommerce

*  [:ecommerce-changelog](/ecommerce-changelog)

Flickrservice

* [:flickrservice](/flickrservice)


Others

*  [:modules:auth_ext_ad](/modules/auth_ext_ad)
*  [:modules:auth_ext_drivers](/modules/auth_ext_drivers)
*  [:modules:auth_ext_ldap](/modules/auth_ext_ldap)
*  [:modules:blog:installation](/modules/blog/installation)
*  [:modules:blog](/modules/blog)
*  [:modules:blog](/modules/blog)
*  [:modules:bulkuploaderfield](/modules/bulkuploaderfield)
*  [:modules:calendar](/modules/calendar)
*  [:modules:cmsworkflow](/modules/cmsworkflow)
*  [:modules:dataobjectmanager](/modules/dataobjectmanager)
*  [:modules:diary](/modules/diary)
*  [:modules:ecommerce](/modules/ecommerce)
*  [:modules:embargoexpiry](/modules/embargoexpiry)
*  [:modules:events](/modules/events)
*  [:modules:event_calendar](/modules/event_calendar)
*  [:modules:external-authentication](/modules/external-authentication)
*  [:modules:flickrgallery](/modules/flickrgallery)
*  [:modules:flickrservice](/modules/flickrservice)
*  [:modules:forum](/modules/forum)
*  [:modules:gallery](/modules/gallery)
*  [:modules:genericdataadmin](/modules/genericdataadmin)
*  [:modules:genericviews](/modules/genericviews)
*  [:modules:geocoderfield](/modules/geocoderfield)
*  [:modules:gis](/modules/gis)
*  [:modules:googleanalytics](/modules/googleanalytics)
*  [:modules:googlesitemaps](/modules/googlesitemaps)
*  [:modules:hasmanyfilemanager](/modules/hasmanyfilemanager)
*  [:modules:image_gallery](/modules/image_gallery)
*  [:modules:intranet](/modules/intranet)
*  [:modules:maps](/modules/maps)
*  [:modules:mollom](/modules/mollom)
*  [:modules:mssql](/modules/mssql)
*  [:modules:multiform](/modules/multiform)
*  [:modules:newsletter](/modules/newsletter)
*  [:modules:polls](/modules/polls)
*  [:modules:securefiles](/modules/securefiles)
*  [:modules:sharethis](/modules/sharethis)
*  [:modules:sitetreeimporter](/modules/sitetreeimporter)
*  [:modules:sortabledataobject](/modules/sortabledataobject)
*  [:modules:spamprotection](/modules/spamprotection)
*  [:modules:sphinx](/modules/sphinx)
*  [:modules:staticimporter](/modules/staticimporter)
*  [:modules:subsites](/modules/subsites)
*  [:modules:swfuploadfield](/modules/swfuploadfield)
*  [:modules:tagfield](/modules/tagfield)
*  [:modules:technoratiservice](/modules/technoratiservice)
*  [:modules:translation](/modules/translation)
*  [:modules:userforms](/modules/userforms)
*  [:modules:youtubeservice](/modules/youtubeservice)
*  [:ssakismet](/ssakismet)



## Existing wiki conteont

Some content will continue to live in the wiki, as its not considered "core".

*  [:amazing_looking_forms_using_silverstripe_form_default_rendering](/amazing_looking_forms_using_silverstripe_form_default_rendering)
*  [:installation-into-subversion](/installation-into-subversion)
*  [:recipes:adding_metatags](/recipes/adding_metatags)
*  [:recipes:alternative_sorting_order](/recipes/alternative_sorting_order)
*  [:recipes:bookmarklets](/recipes/bookmarklets)
*  [:recipes:building_a_nice_tree_for_selected_pages](/recipes/building_a_nice_tree_for_selected_pages)
*  [:recipes:change_site_name_and_tagline](/recipes/change_site_name_and_tagline)
*  [:recipes:cheat_sheet](/recipes/cheat_sheet)
*  [:recipes:customising-the-hierarchy](/recipes/customising-the-hierarchy)
*  [:recipes:customising_image](/recipes/customising_image)
*  [:recipes:customising_meta_tags](/recipes/customising_meta_tags)
*  [:recipes:displaying_five_latest_pages_from_multiple_pagetypes](/recipes/displaying_five_latest_pages_from_multiple_pagetypes)
*  [:recipes:example_of_data_object](/recipes/example_of_data_object)
*  [:recipes:example_of_quotes_on_a_page](/recipes/example_of_quotes_on_a_page)
*  [:recipes:final_parent](/recipes/final_parent)
*  [:recipes:gallery](/recipes/gallery)
*  [:recipes:grouping_fields_from_your_data_object](/recipes/grouping_fields_from_your_data_object)
*  [:recipes:loopthroughassets](/recipes/loopthroughassets)
*  [:recipes:menus_with_different_colour_buttons](/recipes/menus_with_different_colour_buttons)
*  [:recipes:multilingual_content](/recipes/multilingual_content)
*  [:recipes:overriding-loginform](/recipes/overriding-loginform)
*  [:recipes:page_selection_for_special_menu](/recipes/page_selection_for_special_menu)
*  [:recipes:pretty_i18n_urls](/recipes/pretty_i18n_urls)
*  [:recipes:previousornext](/recipes/previousornext)
*  [:recipes:rebranding-the-cms](/recipes/rebranding-the-cms)
*  [:recipes:removingassetsfromsearch](/recipes/removingassetsfromsearch)
*  [:recipes:retrieving_image_from_your_page](/recipes/retrieving_image_from_your_page)
*  [:recipes:selecting_pages_with_the_same_grandparent](/recipes/selecting_pages_with_the_same_grandparent)
*  [:recipes:setting_menu_width_dynamically](/recipes/setting_menu_width_dynamically)
*  [:recipes:siblings](/recipes/siblings)
*  [:recipes:simplesearch](/recipes/simplesearch)
*  [:recipes:start](/recipes/start)
*  [:recipes:syntax-highlighting](/recipes/syntax-highlighting)
*  [:recipes:typography_overview](/recipes/typography_overview)
*  [:recipes:update_records_for_a_class_using_code](/recipes/update_records_for_a_class_using_code)
*  [:suggested-web-hosts](/suggested-web-hosts)


This is other interesting information not directly related to SilverStripe. Drop?

*  [:contentdeliverynetworkissues](/contentdeliverynetworkissues)
*  [:tools:dreamweaver](/tools/dreamweaver)
*  [:tools:eclipse](/tools/eclipse)
*  [:tools:gedit](/tools/gedit)
*  [:tools:netbeans](/tools/netbeans)
*  [:tools:textmate](/tools/textmate)
*  [:tools](/tools)

## Move to open.silverstripe.org

Documentation about the process by which we develop SilverStripe, as well as material to support
discussions going on in the development team, should move to the Trac wiki at
http://open.silvestripe.org

*  [:buildbot-try-server](/buildbot-try-server)
*  [:building-for-modularity](/building-for-modularity)
*  [:changelog](/changelog)
*  [:contributing](/contributing)
*  [:contributors](/contributors)
*  [:daily-builds](/daily-builds)
*  [:deprecation](/deprecation)
*  [:documentation-guidelines](/documentation-guidelines)
*  [:google-summer-of-code](/google-summer-of-code)
*  [:module-maintainers](/module-maintainers)
*  [:module-releases](/module-releases)
*  [:releases](/releases)
*  [:submitting-patches](/submitting-patches)
*  [:subversion](/subversion)
*  [:third-party-packages](/third-party-packages)
*  [:translation](/translation)
*  [:videotours](/videotours)
*  [:windmill-testing](/windmill-testing)



## Obsolete content to be deleted

?
