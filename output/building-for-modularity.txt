
This page discusses what we need to do to let us easily insert add-on modules into SilverStripe sites, without any fuss.  For example, the biggest piece of work when adding a forum to your site should be choosing the right colours ^_^


More information on actually building a module can be found [here](creating-modules).


#### Templates
*  Build them as a theme - [go here](themes) for more information.
*  Ensure that your template includes layout inside the following div: <div id="Layout">$Layout</div>
*  Ensure that your Layout templates only include content that could be totally replaced by a forum, event management system, or e-commerce engine.  It might be infeasible to do this 100%, but remember that every piece of navigation that needs to appear inside $Layout will mean that you have to customise templates when integrating the module, meaning more work for you.


#### CSS
*  Give div#Layout a defined width, so that modules can style themselves inside this. 


#### Module design

*  All of your templates should be Layout templates
*  You can assume that <div id="Layout"> will be created, and that it will have its width set appropriately.
*  Make all of your CSS flexible width - % based: The Layout div could be any width.
*  Don't include any navigation elements in your Layout templates, keep it focused on just the stuff for that module.
*  Break down your templates into groups of includes.  Site integrators would then have the power to override individual includes, rather than entire templates.
