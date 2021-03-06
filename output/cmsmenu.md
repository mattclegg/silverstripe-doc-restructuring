# cmsmenu

## Introduction

Introduced in 2.3.0, CMSMenu controls the menu items in the top portion of the page within the CMS.

## Default Behaviour

The menu will be automatically populated with menu items for subclasses of
[LeftAndMain](http://api.silverstripe.org/trunk/cms/core/LeftAndMain.html). That is, for each class in the CMS that
creates an administration panel, a CMS menu item will be created. The default configuration will also include a 'help'
link to the SilverStripe user documentation.

## Modifying the Menu

## Adding a Controller

Usually, a valid administration page is a subclass of
[LeftAndMain](http://api.silverstripe.org/trunk/cms/core/LeftAndMain.html) or [ModelAdmin](ModelAdmin) (itself a
subclass of [LeftAndMain](http://api.silverstripe.org/trunk/cms/core/LeftAndMain.html)), so it is added automatically.





## Adding a Link

Additional links can be added to the menu with the call:

	:::php
	CMSMenu::add_link($code, $menuTitle, $url, $priority = -1)


$code is a unique name that you can use later to refer to the menu item.

$menuTitle (string) is the title as it appears in the menu. You should apply any translations at this point.

$url (string) is where you want the menu item to link to

$priority is the order in which the menu item appears, with a lower number pushing the item to the left.

## Removing an Item

You can remove an item using the call:

	:::php
	CMSMenu::remove_menu_item($code)


$code is a unique name of the menu item - usually the admin controller class, or a arbitrary name given to a link when
it is added.



