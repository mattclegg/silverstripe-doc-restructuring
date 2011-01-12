This page details the processes by which we (should) make APIs deprecated.

#### Update the deprecated API (e.g., a deprecated class or method)


*  Add a @deprecated item to the docblock tag, with a {@link } item pointing to the new API to use.

*  Update the deprecated code to throw an E_USER_NOTICE error, with a message starting with the string 'DEPRECATED:'. 
In time, we may use that string to identify deprecation errors, so please ensure that you add this string to the notice
level error.

*  Make sure that the old deprecated function works by calling the new function - don't have duplicated code!

*  Mark in which release the function was deprecated (find out next release in the
[roadmap](http://open.silverstripe.com/roadmap)), so we can determine when to finally remove it.

We can put that into an example, here we are showing a theoretical replacement of Director::isDev() with Env::is_dev().

	:::php
	
	/**

	 * Returns true if your are in development mode
	 * @deprecated (since 2.2.2) Use {@link Env::is_dev()} instead.
	 */
	function isDev() {
		user_error("DEPRECATED: Use Env::is_dev() instead.", E_USER_NOTICE);
		return Env::is_dev();
	}


#### When to remove the code

The deprecated API won't be in there forever.  However, it should be left in for a while, to give site developers a
chance to discover their error and correct their code.

There are a few rules of thumb:


*  Leave the code with the deprecation warning in for at least 3 releases.

*  Only remove deprecated code on a 2.X.0 release.

For example:

 * Deprecated as of in 2.2.2
 * Still deprecated in 2.2.3
 * Still deprecated in 2.2.4
 * Removed from 2.3.0

