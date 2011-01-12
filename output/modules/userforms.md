# User Defined Form

## Introduction

UserForms enables CMS users to create dynamic forms via a drag and drop interface and without getting involved in any
PHP code.

## Download


*  [Daily
Build](http://open.silverstripe.com/changeset/latest/modules/userforms/trunk?old_path=/&filename=/modules/userforms/trunk&format=zip)

## Features


*  Construct a form using all major form fields (text, email, dropdown, radio, checkbox..)

*  Ability to Extend userforms from other modules to provide extra fields. Such as Map Input Field

*  Ability to email multiple people the form submission

*  View submitted submissions and export them to CSV

*  Define custom error messages and validation settings

*  Optionally Display and Hide fields using javascript based on users input

## Usage

### Installation

 1.  Download the module from the link above. 
 2.  Extract the file (if you are on windows try 7-zip for extracting tar.gz files
 3.  Make sure the folder after being extracted is named 'userforms' 
 4.  Place this directory in your sites root directory. This is the one with sapphire/cms/jsparty in it. See [Installing
Modules](http://doc.silverstripe.com/doku.php?id=installing-modules) for an introduction to installing.

 5.  Run in your browser - http://www.yoursite.com/dev/build to rebuild the database. 
 6.  You should see a new PageType in the CMS 'User Defined Form'. This has a new 'Form' tab which has your form
builder.

### Upgrading

#### 0.1 to 0.2
We undertook some major API changes. To help you migrate from 0.1 to 0.2 we have included a build task which you can run
which will go through your installed forms and rebuilt them with the new 0.2 datamodel.

To run this build task you visit the url - http://www.yoursite.com/dev/tasks/UserFormsMigrationTask










