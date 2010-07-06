#!/bin/bash

# Renames markdown files according to preliminary restructuring detailed on 
# http://doc.silverstripe.org/tmp:documentation-restructuring
# All removed files will remain on the wiki (no conversion to markdown necessary).
# Enables the repeated generation of these markdown files from the current wiki
# source, although there will be limits once we start to change file names
# and copy content around.
# 
# Author: Ingo Schommer (ingo at silverstripe dot com)

cd ../output/

mkdir -p ../master/cms/docs/{tutorials,guides,reference}
mkdir -p ../master/sapphire/docs/{tutorials,guides,reference}

# Content staying on the wiki (remove)
rm *.lock
git rm modules.md
git rm -r module
git rm -r modules
git rm -r private
git rm -r tmp
git rm -r tools
git rm -r wiki
git rm -r gsoc
git rm tools.md
git rm installation-into-subversion.md
git rm recipes/adding_metatags.md
git rm recipes/alternative_sorting_order.md
git rm recipes/bookmarklets.md
git rm recipes/building_a_nice_tree_for_selected_pages.md
git rm recipes/change_site_name_and_tagline.md
git rm recipes/cheat_sheet.md
git rm recipes/customising_image.md
git rm recipes/customising_meta_tags.md
git rm recipes/displaying_five_latest_pages_from_multiple_pagetypes.md
git rm recipes/example_of_data_object.md
git rm recipes/example_of_quotes_on_a_page.md
git rm recipes/final_parent.md
git rm recipes/gallery.md
git rm recipes/grouping_fields_from_your_data_object.md
git rm recipes/loopthroughassets.md
git rm recipes/menus_with_different_colour_buttons.md
git rm recipes/multilingual_content.md
git rm recipes/overriding-loginform.md
git rm recipes/page_selection_for_special_menu.md
git rm recipes/pretty_i18n_urls.md
git rm recipes/rebranding-the-cms.md
git rm recipes/removingassetsfromsearch.md
git rm recipes/retrieving_image_from_your_page.md
git rm recipes/selecting_pages_with_the_same_grandparent.md
git rm recipes/setting_menu_width_dynamically.md
git rm recipes/siblings.md
git rm recipes/start.md
git rm recipes/syntax-highlighting.md
git rm recipes/typography_overview.md
git rm recipes/update_records_for_a_class_using_code.md
git rm suggested-web-hosts.md
git rm changelog.md
git rm contentdeliverynetworkissues.md
git rm contributing.md
git rm contributors.md
git rm daily-builds.md
git rm deprecation.md
git rm documentation-guidelines.md
git rm module-maintainers.md
git rm module-releases.md
git rm releases.md
git rm submitting-patches.md
git rm subversion.md
git rm third-party-packages.md
git rm translation-offers.md
git rm translation.md
git rm videotours.md
git rm buildbot-try-server.md
git rm gsoc.md
git rm community_run_third_party_websites.md
git rm checkoutpagetest.md
git rm coding-conventions.md
git rm complextablefieldexamples.md
git rm ecommercerole.md
git rm flickrservice.md
git rm hide-ancestor.md
git rm redirectorpagetest.md
git rm security-statement.md
git rm silverstripe-on-mamp.md
git rm silverstripe-book-errata.md
git rm windmill-testing.md
git rm test-page.md

# Moves to ../master/cms/
git mv upgrading ../master/cms/docs/guides/upgrading
git mv tutorial/* ../master/cms/docs/tutorials/
git mv installation.md ../master/cms/docs/
git mv installation-*.md ../master/cms/docs/guides/
git mv arraydata.md ../master/cms/docs/reference/
git mv autocompletefield.md ../master/cms/docs/reference/
git mv autocompletetextfield.md ../master/cms/docs/reference/
git mv bbcode.md ../master/cms/docs/reference/
git mv building-for-modularity.md ../master/cms/docs/guides/
git mv built-in-page-controls.md ../master/cms/docs/reference/
git mv cache-control.md ../master/cms/docs/reference/
git mv casting.md ../master/cms/docs/guides/
git mv checkboxfield.md ../master/cms/docs/reference/
git mv checkboxsetfield.md ../master/cms/docs/reference/
git mv cmsmain.md ../master/cms/docs/guides/
git mv cmsmenu.md ../master/cms/docs/reference/
git mv common-problems.md ../master/cms/docs/guides/
git mv complextablefield.md ../master/cms/docs/reference/
git mv compositefield.md ../master/cms/docs/reference/
git mv configuration.md ../master/cms/docs/guides/
git mv confirmedpasswordfield.md ../master/cms/docs/reference/
git mv controller.md ../master/cms/docs/guides/
git mv controllers.md ../master/cms/docs/guides/
git mv creating-modules.md ../master/cms/docs/guides/
git mv css.md ../master/cms/docs/reference/
git mv csvbulkloader.md ../master/cms/docs/reference/
git mv currencyfield.md ../master/cms/docs/reference/
git mv customrequiredfields.md ../master/cms/docs/reference/
git mv data-types.md ../master/cms/docs/guides/
git mv database-abstraction.md ../master/cms/docs/reference/
git mv database-structure.md ../master/cms/docs/reference/
git mv database-troubleshooting.md ../master/cms/docs/reference/
git mv datamodel.md ../master/cms/docs/guides/
git mv dataobject.md ../master/cms/docs/reference/
git mv dataobjectdecorator.md ../master/cms/docs/reference/
git mv dataobjectset.md ../master/cms/docs/reference/
git mv datefield.md ../master/cms/docs/reference/
git mv datepickerfield.md ../master/cms/docs/reference/
git mv db-build.md ../master/cms/docs/reference/
git mv debugging.md ../master/cms/docs/guides/
git mv director.md ../master/cms/docs/reference/
git mv directory-structure.md ../master/cms/docs/guides/
git mv dropdownfield.md ../master/cms/docs/reference/
git mv email.md ../master/cms/docs/guides/
git mv emailfield.md ../master/cms/docs/reference/
git mv environment-management.md ../master/cms/docs/guides/
git mv error-handling.md ../master/cms/docs/guides/
git mv escape-types.md ../master/cms/docs/reference/
git mv execution-pipeline.md ../master/cms/docs/reference/
git mv fieldgroup.md ../master/cms/docs/reference/
git mv filefield.md ../master/cms/docs/reference/
git mv form-field-types.md ../master/cms/docs/reference/
git mv form-validation.md ../master/cms/docs/guides/
git mv form.md ../master/cms/docs/guides/
git mv formaction.md ../master/cms/docs/reference/
git mv formresponse.md ../master/cms/docs/reference/
git mv functionaltest.md ../master/cms/docs/reference/
git mv getcmsfields.md ../master/cms/docs/reference/
git mv groupeddropdownfield.md ../master/cms/docs/reference/
git mv hasmanycomplextablefield.md ../master/cms/docs/reference/
git mv hasonecomplextablefield.md ../master/cms/docs/reference/
git mv headerfield.md ../master/cms/docs/reference/
git mv hiddenfield.md ../master/cms/docs/reference/
git mv hierarchy.md ../master/cms/docs/reference/
git mv how-page-security-works.md ../master/cms/docs/guides/
git mv html.md ../master/cms/docs/reference/
git mv htmleditorconfig.md ../master/cms/docs/reference/
git mv htmleditorfield.md ../master/cms/docs/reference/
git mv i18n.md ../master/cms/docs/guides/
git mv image.md ../master/cms/docs/reference/
git mv imagefield.md ../master/cms/docs/reference/
git mv inlineformaction.md ../master/cms/docs/reference/
git mv installing-modules.md ../master/cms/docs/guides/
git mv javascript.md ../master/cms/docs/reference/
git mv labelfield.md ../master/cms/docs/reference/
git mv languagedropdownfield.md ../master/cms/docs/reference/
git mv leftandmain.md ../master/cms/docs/reference/
git mv listboxfield.md ../master/cms/docs/reference/
git mv literalfield.md ../master/cms/docs/reference/
git mv manifestbuilder.md ../master/cms/docs/reference/
git mv manymanycomplextablefield.md ../master/cms/docs/reference/
git mv mathspamprotection.md ../master/cms/docs/reference/
git mv member.md ../master/cms/docs/reference/
git mv member_groupset.md ../master/cms/docs/reference/
git mv membertablefield.md ../master/cms/docs/reference/
git mv migrationtask.md ../master/cms/docs/reference/
git mv modeladmin.md ../master/cms/docs/reference/
git mv multilingualcontent.md ../master/cms/docs/guides/
git mv numericfield.md ../master/cms/docs/reference/
git mv object.md ../master/cms/docs/reference/
git mv objectmodel.md ../master/cms/docs/guides/
git mv optionsetfield.md ../master/cms/docs/reference/
git mv page-types.md ../master/cms/docs/guides/
git mv page.md ../master/cms/docs/reference/
git mv pagecomment.md ../master/cms/docs/reference/
git mv pageless-controller.md ../master/cms/docs/reference/
git mv partial-caching.md ../master/cms/docs/reference/
git mv passwordfield.md ../master/cms/docs/reference/
git mv permission.md ../master/cms/docs/reference/
git mv postgres.md ../master/cms/docs/reference/
git mv profiler.md ../master/cms/docs/reference/
git mv publishing-to-web-server.md ../master/cms/docs/reference/
git mv readonlyfield.md ../master/cms/docs/reference/
git mv recovering_password.md ../master/cms/docs/reference/
git mv requirements.md ../master/cms/docs/reference/
git mv restfulserver.md ../master/cms/docs/reference/
git mv restfulservice.md ../master/cms/docs/reference/
git mv rssfeed.md ../master/cms/docs/reference/
git mv rsyncmultihostpublisher.md ../master/cms/docs/reference/
git mv sake.md ../master/cms/docs/reference/
git mv scheduledtask.md ../master/cms/docs/reference/
git mv searchcontext.md ../master/cms/docs/reference/
git mv searchform.md ../master/cms/docs/reference/
git mv secure-development.md ../master/cms/docs/reference/
git mv security.md ../master/cms/docs/reference/
git mv selectiongroup.md ../master/cms/docs/reference/
git mv server-requirements.md ../master/cms/docs/
git mv sessions.md ../master/cms/docs/reference/
git mv shortcodes.md ../master/cms/docs/reference/
git mv simpleimagefield.md ../master/cms/docs/reference/
git mv site-reports.md ../master/cms/docs/reference/
git mv siteconfig.md ../master/cms/docs/reference/
git mv sitetree.md ../master/cms/docs/reference/
git mv soapmodelaccess.md ../master/cms/docs/reference/
git mv sqlquery.md ../master/cms/docs/reference/
git mv ssl.md ../master/cms/docs/reference/
git mv start.md ../master/cms/docs/index.md
git mv staticexporter.md ../master/cms/docs/reference/
git mv staticpublisher.md ../master/cms/docs/reference/
git mv tab.md ../master/cms/docs/reference/
git mv tablefield.md ../master/cms/docs/reference/
git mv tablelistfield.md ../master/cms/docs/reference/
git mv tabset.md ../master/cms/docs/reference/
git mv template-encoding.md ../master/cms/docs/reference/
git mv templates.md ../master/cms/docs/reference/
git mv testing-guide-glossary.md ../master/cms/docs/guides/
git mv testing-guide-intro.md ../master/cms/docs/guides/
git mv testing-guide-troubleshooting.md ../master/cms/docs/guides/
git mv testing-guide.md ../master/cms/docs/guides/
git mv testing-howto/create-functional-test.md ../master/cms/docs/guides/
git mv testing-howto/create-sapphire-test.md ../master/cms/docs/guides/
git mv testing-howto/test-email-sending.md ../master/cms/docs/guides/
git mv textareafield.md ../master/cms/docs/reference/
git mv textfield.md ../master/cms/docs/reference/
git mv themes.md ../master/cms/docs/guides/
git mv translatable.md ../master/cms/docs/reference/
git mv treedropdownfield.md ../master/cms/docs/reference/
git mv treemultiselectfield.md ../master/cms/docs/reference/
git mv tutorials.md ../master/cms/docs/tutorials/index.md
git mv typography.md ../master/cms/docs/reference/
git mv uniquerestrictedtextfield.md ../master/cms/docs/reference/
git mv upgrading.md ../master/cms/docs/
git mv urlvariabletools.md ../master/cms/docs/reference/
git mv validator.md ../master/cms/docs/reference/
git mv versioned.md ../master/cms/docs/reference/
git mv virtualpage.md ../master/cms/docs/reference/
git mv widgets.md ../master/cms/docs/reference/
git mv themes/developing.md ../master/cms/docs/guides/theme-development.md

# Cleanup afterwards
rm -rf tutorial/
rm -rf themes/
rm -rf testing-howto/