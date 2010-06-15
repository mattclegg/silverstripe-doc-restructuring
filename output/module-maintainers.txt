## What does it mean to be a module maintainer?

One of the best ways that you can contribute to SilverStripe is by developing a module for SilverStripe.  If you do, we would love to host your module and have you become an official module maintainer on our site. Please read our ["Contributing to SilverStripe"](http://silverstripe.org/contributing-to-silverstripe/) overview.

Once you have created a module, login at silverstripe.org and submit it at http://silverstripe.org/modules/manage/add

## What do we expect?

It's very important to us that users of SilverStripe can come to expect a level of quality from the core product and any modules running on it. 
In order to provide this, we require certain things from module maintainers.
### Code

*  Put your code in version control (you can get a [subversion](http://subversion.trigris.org) or [git](http://git-scm.com/) repository for free at [code.google.com](http://code.google.com), [github.com](http://github.com) etc.)
*  Follow our [coding-conventions](coding-conventions)
*  Write unit tests and functional tests covering code bundled with the module - see [testing-guide](testing-guide)
*  Ensure your code is [localizable](i18n) and [translatable](translation)

### Documentation

*  Follow our [documentation-guidelines](documentation-guidelines)
*  Add your module to [silverstripe.org/modules](http://silverstripe.org/modules) (and keep the version compatibility information current)
*  Include a ''README'' file at the root level of your module with maintainer contact information, requirements, installation instructions, and a link to your module wiki page.
*  Include a well-maintained ''changelog'' which should be updated with every release
*  Optional: Add a wiki page on [doc.silverstripe.org](http://doc.silverstripe.org) with user- and developer documentation (see [modules:forum](modules/forum) for a good example)

### Maintenance

*  Prepare releases as detailed in [module-releases](module-releases) ([more info](http://producingoss.com/en/development-cycle.html))
*  Ensure that your module is patched to always work with the latest SilverStripe release, and note these compatibilities on your modules page on silverstripe.org
*  Be involved in our community 
    * Subscripe to our developer mailing list and be available to answer questions on the forum. 
    * Attend [irc:our weekly core discussions on IRC](irc/our weekly core discussions on IRC) as regularly as you can.
*  Create an ''issue tracker'' so your users can file bugs and feature requests, and keep track of their status (we can provide you with a new category on [http://open.silverstripe.org](http://open.silverstripe.org))
*  Create a ''roadmap'' and ''milestones'' outlining future release planning

### Principles

*  Strive for features you add to the CMS to be innovatively usable by a content editor rather than a web-developer. Think Wordpress and Apple.
*  Strive for the module to work merely by placing the code in your SilverStripe installation and running /dev/build. Provide a default set of configuration options that are easily changed in _config.php (For instance the ecommerce module works out of the box, and you can easily set up a payment provider), aiding a pleasant user experience.
    

## What do you get?

In return for all your hard work in putting a high-quality module on the site, we will give you the following:

*  Use of [trac](http://open.silverstripe.org) to keep your bugs and feature requests organised
*  Advertising of your module on the http://silverstripe.org/modules/ modules page once it has reached a beta stage and shown to meet our requirements above.
*  We might showcase your module on our blog and/or newsletter, when it's first released and/or when a major version with significant new features is released. We'll work with you to publicise it on other blogs too (it helps if you deliver screenshots and screencasts)
*  More influence in suggesting changes to the core product
*  Kudos on Ohloh ( See http://www.ohloh.net/projects/5034?p=SilverStripe+CMS )

## Related

*  [module-releases](module-releases)
*  [contributors](contributors)
