{{:modules:sqlite.gif|:modules:sqlite.gif}}



# SQLite3 Database Module

The sqlite3 module enables you run Silverstripe entirely off a SQLite3 database.


## Special Features & Peculiarities

Unlike client-server DBMSs there is no server process running but the SQLite3 library is linked into PHP. As the SQLite3
extension is enabled by default as of PHP 5.3.0, sqlite3 is the only solution to run Silverstripe if you don't have
access to a database server.

By default the database file resides in a secured subfolder of the assets folder. So if you want to create a backup of
an entire project or deploy it (code, assets **AND database**) just zip it or upload it, done!

When sqlite3 is used for unit testing it makes use of the in memory feature which makes the execution of the test suite
2 - 10 times faster compared to other SS DB adapters. Sqlite3 can even coexist with another adapter, so you can use the
primary adapter for production and sqlite3 for testing.


## Requirements

SilverStripe 2.4.

Sqlite3 has been tested successfully on the following stacks:


*  OSX leopard, XAMPP with PHP 5.3.0, SQLite3.6.3

*  OSX leopard, MAMP with PHP 5.2.6, SQLite3.3.7

*  Ubuntu, PHP 5.2.4, SQLite3.4.2

*  WinXP, XAMPP with PHP 5.3.0, SQLite3.6.16

*  Win 7, IIS7.5, PHP5.3.2, SQLite3.6.22

Sqlite3 has been successfully tested with the following modules:


*  [subsites](subsites)

*  [genericdataadmin](genericdataadmin)

*  [forum](forum)

*  [cmsworkflow](cmsworkflow)

*  [multiform](multiform)

*  [events](events)

*  [blog](blog)

*  [gallery](gallery)

*  [rssaggregator](rssaggregator)

*  [sharethis](sharethis)

*  [userforms](userforms)



## Installation

http://doc.silverstripe.org/doku.php?id=installing-modules gives you a good induction on how to install modules in
general. If you are new to Silverstripe read this first.

### Option 1 - Installer

 1.  [download](http://www.silverstripe.org/sqlite-database/), unzip and copy the sqlite3 folder to your project root so
that it becomes a sibling of cms, sapphire and co.
 2.  Run http://www.mysite.com/install.php
 3.  Choose SQLite3 from the list of DB adapters.
 4.  Hit the install button.




### Option 2 - Manually

 1.  [download](http://www.silverstripe.org/sqlite-database/), unzip and copy the sqlite3 folder to your project root so
that it becomes a sibling of cms, sapphire and co.
 2.  Put the following snippet into your mysite/_config.php file`<code>`
global $databaseConfig;
$databaseConfig = array(
	"type" => "SQLiteDatabase",
	"database" => "SS_mysite",
);
`</code>`so that it looks something like this: (minimal configuration)`<code>`
<?php

global $project;
$project = 'mysite';

global $databaseConfig;
$databaseConfig = array(
	"type" => 'SQLiteDatabase',
	"database" => 'SS_mysite',
);

SSViewer::set_theme('blackcandy');`</code>`

 1.  Run http://localhost/dev/build

By default Silverstripe places the DB file into a secure subfolder of the assets. However you might want to change the
location of the file to a directory outside of the web root for security. Just add "path" to the above array and give it
an absolute path.

:!: Make sure that your path to the DB file is writable for the web server.


### Option 3 - Environment File

 1.  [download](http://www.silverstripe.org/sqlite-database/), unzip and copy the sqlite3 folder to your project root so
that it becomes a sibling of cms, sapphire and co.
 2.  add the following to your [_environment.php](http://doc.silverstripe.org/doku.php?id=environment-management) file:
`define('SS_DATABASE_CLASS', 'SQLiteDatabase');`
 3.  Run http://localhost/dev/build


:!: Ensure that your mysite/_config.php file has a database name defined, such as "SS_mysite"

## Debugging

If you get an error message like


*  Couldn't run query: VACUUM | not authorized

*  Couldn't run query: VACUUM | authorization required

*  Couldn't run query: VACUUM | authorization denied

turn off vacuuming by adding: `SQLite3Database::$vacuum = false;` anywhere in your mysite/_config.php.

If you want to get the queries displayed on the screen that get executed for a particular request, add "?showqueries" to
the end of the URL you are debugging, e.g. http://localhost/mysite/about-us?showqueries

If you are looking for a SQLite client for debugging your SS app,
[sqlite-manager](http://code.google.com/p/sqlite-manager/) plugin for firefox may be worth a try. Or try the
[dbplumber](dbplumber) module, a simple database manger for SilverStripe.
