# Templates

## Syntax

TODO Show a good cross section of built-in-page-controls.md

## Structure and Inheritance

TODO Take abbreviated descriptions from the first tutorial

## Includes

TODO

## Bundling templates into Themes

TODO

## CSS and JavaScript files

TODO Using <% require %> vs Requirements class in Controller::init(), combine_files, different media types, typography.css

## Meta Tags

TODO Explain SiteTree properties and SiteTree->MetaTags() overloading

## Designing reuseable templates

Although SilverStripe is ultimately flexible in how you create your templates, there's a couple of best practices. These will help you to design templates for modules, and make it easier for other site developers to integrate them into their own base templates.

* Most of your templates should be Layout templates
* Build your templates as a [[theme]] so you can easily re-use and exchange them
* Your layout template should include a standard markup structure (`<div id="Layout">$Layout</div>`)
* Layout templates only include content that could be completely replaced by another module (e.g. a forum thread). It might be infeasible to do this 100%, but remember that every piece of navigation that needs to appear inside `$Layout` will mean that you have to customise templates when integrating the module.
*  Any CSS applied to layout templates should be flexible width. This means the surrounding root template can set its width independently.
*  Don't include any navigation elements in your Layout templates, they should be contained in the root template.
*  Break down your templates into groups of includes.  Site integrators would then have the power to override individual includes, rather than entire templates.