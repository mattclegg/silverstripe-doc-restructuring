# SilverStripe Testing Guide

The Sapphire core contains various features designed to simplify the process of creating and managing automated tests.

## Introduction

If you are familiar with PHP coding but new to unit testing, you should read the [Introduction](testing-guide-intro) and
check out Mark's presentation [Getting to Grips with SilverStripe
Testing](http://www.slideshare.net/maetl/getting-to-grips-with-silverstripe-testing).

You should also read over [the PHPUnit manual](http://www.phpunit.de/pocket_guide/3.2/). It provides a lot of
fundamental concepts that we build on in this documentation.

If you're more familiar with unit testing, but want a refresher of some of the concepts and terminology, you can browse
the [Testing Glossary](testing-guide-glossary).

To get started now, follow the installation instructions below, and check
[Troubleshooting](testing-guide-troubleshooting) in case you run into any problems.

## Installation and Setup

The framework has a required dependency on [PHPUnit](http://www.phpunit.de/) and an optional dependency on
[SimpleTest](http://simpletest.org/), the two premiere PHP testing frameworks.


### Install PHPUnit

To run Sapphire tests, you'll need to be able to access PHPUnit on your include path. First, you'll need to make sure
that you have the PEAR command line client installed. To test this out, type ''pear help'' at your prompt. You should
see a bunch of generic PEAR info. If it's not installed, you'll need to set it up first (see: [Getting Started with
PEAR](http://www.sitepoint.com/article/getting-started-with-pear/)) or else manually install PHPUnit (see: [Installation
instructions](http://www.phpunit.de/pocket_guide/3.3/en/installation.html)).

The PHPUnit installation via PEAR is very straightforward.
You might have to perform the following commands as root or super user (sudo).
We need a specific version of PHPUnit (3.3.x), as 3.4 or higher breaks our test runner (see
[#4573](http://open.silverstripe.com/ticket/4573))

At your prompt, type the following commands:

	
	pear channel-discover pear.phpunit.de 
	pear channel-discover pear.symfony-project.com
	pear install phpunit/PHPUnit






## Running Tests

### Via Web Browser

Go to the main test URL which will give you options for running various available test suites or individual tests on
their own:

	
	 http://mysite.com/dev/tests



### Via Command Line

''cd'' to the root level of your project and run [sake](sake) (Sapphire Make) to execute the tests:

	
	/path/to/project$ sake dev/tests/all



### Partial Test Runs


Run specific tests (Minimum requirement: SilverStripe 2.4)

	
	dev/tests/MyTest,MyOtherTest



Run all tests in a module folder, e.g. "sapphire" (Minimum requirement: SilverStripe 2.4)

	
	dev/tests/module/<modulename>


Skip tests (Minimum requirement: SilverStripe 2.4)

	
	dev/tests/all SkipTests=MySkippedTest


## Writing Tests

Tests are written by creating subclasses of ''SapphireTest''.  You should put tests for your site in the
''mysite/tests'' directory.  If you are writing tests for a module, put them in the ''(modulename)/tests'' directory.

Generally speaking, there should be one test class for each application class.  The name of the test class should be the
application class, with "Test" as a suffix.  For instance, we have all the tests for ''SiteTree'' in
''sapphire/tests/SiteTreeTest.php''

You will generally write two different kinds of test classes.

*  **Unit Test:** Test the behaviour of one of your DataObjects.
*  **Functional Test:** Test the behaviour of one of your controllers.

Some people may note that we have used the same naming convention as Ruby on Rails.
## How To

Tutorials and recipes for creating tests using the Sapphire framework:

*  **[Create a Sapphire Test](testing-howto/create-sapphire-test)**
*  **Load Test Fixtures**
*  **[Create a Functional Test](testing-howto/create-functional-test)**
*  **[Test Outgoing Email Sending](testing-howto/test-email-sending)**
