# Enabling Comments for Pages

All SilverStripe pages can have a simple comment interface added to them, simply by checking the checkbox in the CMS.
Technically, comments are managed through the [PageComment](api:PageComment) and [PageCommentInterface](api:PageCommentInterface) classes.

## Administration

Comments can either be reviewed in-place (when logged in with the correct permissions), or through a dedicated 
interface at `admin/comments`. Comments in the CMS interface are seperated into three tables - "Approved", "Awaiting Moderation", and "Spam". The table allow mass deletion and reclassification of comments. By default all comments not detected as spam go into the "Approved" folder. 

You can add `PageComment::enableModeration()` into your `mysite/_config.php` to enable moderation, which means all new comments go into the Awaiting Moderation folder. Comments awaiting moderation will not be shown on the front end page unless the user is an administrator.


## Spam Protection

The comment form (as well as any other form in SilverStripe) can be protected against spam,
usually caused by automated scripts. There are different ways to approach this problem,
all with varying success rates as well as impacts on user experiences.

### Math Question

Adding `MathSpamProtection::setEnabled()` to your `mysite/_config.php` enables the spam protection question for creating comments within SilverStripe. An example question is "What is four plus five?". The question automatically updates if the question is answered right or wrong.

### Akismet

The SSAkismet class provides spam detection for comments using [http://akismet.com/](http://akismet.com/). In order to use it, you must get an API key, which you can get free for non-commercial use by signing up for a [WordPress](http://www.wordpress.com) account. Commercial keys can be bought [here](http://akismet.com/commercial/).

To enable spam detection, set your API key in `mysite/_config.php`. 

	:::php
	SSAkismet::setAPIKey('insertkeyhere');

If you want to save spam into the database so you can review them later, enable it in _config.php like so:

	:::php
	SSAkismet::setSaveSpam(true);

You can then view spam for a page by appending `?showspam=1` to the url.

Additional resources:

 * [Demo of SSAkismet in action](http://demo.silverstripe.com/blog)
 * Forum discussion: [Comments - additions and spam protection](http://www.silverstripe.com/feature-requests/flat/534)


### Mollom

[Mollom](http://mollom.com/) is a third-party hosted service for spam detection and CAPTCHA services. It is implemented through the [mollom module](http://silverstripe.org/mollom-module).

### Recaptcha

[Recatpcha](http://recaptcha.net) does not directly detect spam, but provides high-quality CAPTCHA challenges to the user. It is implemented through the [recatpcha module](http://silverstripe.org/recaptcha-module),