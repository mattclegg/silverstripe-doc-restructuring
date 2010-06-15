# SQL Server Database Module

Allows SilverStripe to run on a SQL Server 2008 or SQL Server 2008 R2 database.
## Requirements

*  SilverStripe 2.4
*  PHP with mssql extension or [sqlsrv](http://sqlsrvphp.codeplex.com/) 1.1 extension (see below for more information)
*  SQL Server 2008 with Service Pack 1 or SQL Server 2008 R2

Note: [SQL Server 2008 R2 Express](http://www.microsoft.com/express/database/), a free version, is also compatible.

### Windows

For the most part, connecting to a SQL Server database on Windows is easy. Make sure you have installed
[SQL Server Native Client](http://www.microsoft.com/downloads/details.aspx?familyid=B33D2C78-1059-4CE2-B80D-2343C099BCB4&displaylang=en) on the website server if the database is hosted on another server, as well as the [SQL Server Driver for PHP](http://sqlsrvphp.codeplex.com) "sqlsrv".

*  [SQL Server Native Client](http://www.microsoft.com/downloads/details.aspx?familyid=B33D2C78-1059-4CE2-B80D-2343C099BCB4&displaylang=en)
*  [SQL Server Driver for PHP](http://sqlsrvphp.codeplex.com) "sqlsrv"
*  [Non-thread safe version of PHP 5.3](http://windows.php.net) or newer

More information on [setting up the Microsoft Platform for PHP](http://learn.iis.net/page.aspx/770/install-the-microsoft-web-platform-for-php/) is available.
### Linux and Mac OS X

Connecting to a SQL Server database on Linux or Mac OS X can be achieved using the third-party library [FreeTDS](http://freetds.org).

The following assumes that you installed PHP using the default package manager of the operating system.

#### Fedora, CentOS and RedHat

##### Install software

~~~
yum install php-mssql
~~~

##### Edit the FreeTDS configuration

Open **/etc/freetds.conf** with an editor, and find "tds version = 4.2". Replace 4.2 with **8.0**

#### Debian and Ubuntu

##### Install software

~~~
apt-get install php5-mssql
~~~

##### Edit the FreeTDS configuration

Open **/etc/freetds/freetds.conf** with an editor, and find "tds version = 4.2". Replace 4.2 with **8.0**

#### Mac OS X (MacPorts)

##### Install software

~~~
port install php5-mssql
~~~

##### Edit the FreeTDS configuration

Open **/opt/local/etc/freetds/freetds.conf** with an editor, and find "tds version = 4.2". Replace 4.2 with **8.0**


These packages will install the mssql extension for PHP, as well as FreeTDS, which will let you connect to SQL Server from Linux and Mac OS X.

## Installation

You have three options to install SQL Server 2008 support with SilverStripe.

### Option 1 - Installer

The first option is to use the installer. This is the recommended option.

1.  Set up SilverStripe somewhere where you can start the installer - you should only see one database "MySQL" to install with
2.  Download a copy of the "mssql" module from here: http://www.silverstripe.org/microsoft-sql-server-database-module/
3.  Extract the archive you downloaded. Rename the directory from "mssql-trunk-rxxxx" to "mssql" and copy it into the SilverStripe directory you just set up
4.  Open the installer once again, and a new option "SQL Server 2008" should appear. You can now proceed through the installation without having to change any code



### Option 2 - Manual

The second option is to setup SQL Server 2008 support manually. This can be achieved by following these instructions:

1.  Set up a fresh working copy of SilverStripe
2.  Download a copy of the "mssql" module from here: http://www.silverstripe.org/microsoft-sql-server-database-module/
3.  Extract the archive you downloaded. Rename the directory from "mssql-trunk-rxxxx" to "mssql" and copy it into the SilverStripe directory you just set up
4.  Open up your mysite/_config.php file and add (or update) the $databaseConfig array like so:

~~~
$databaseConfig = array(
	'type' => 'MSSQLDatabase',
	'server' => '[FreeTDS connection name OR Windows server name]',
	'username' => 'sa',
	'password' => 'mypassword',
	'database' => 'SS_mysite'
);
~~~

Finally, visit dev/build so that SilverStripe can build the database schema and default records.





### Option 3 - Environment file

Finally, the third option is to change your environment to point to MSSQLDatabase as a database class. Do this if you're currently using an _ss_environment.php file.
1.  Download a copy of the "mssql" module from here: http://www.silverstripe.org/microsoft-sql-server-database-module/
2.  Extract the archive you downloaded. Rename the directory from "mssql-trunk-rxxxx" to "mssql" and copy it into your SS directory
3.  Add the following to your existing _ss_environment.php file:

~~~
define('SS_DATABASE_CLASS', 'MSSQLDatabase');
~~~

Last steps:

1.  Ensure your SS_DATABASE_USERNAME and SS_DATABASE_PASSWORD defines in _ss_environment.php are correct to the SQL Server database server
2.  Ensure that your mysite/_config.php file has a database name defined, such as "SS_mysite"
3.  Visit dev/build so that SilverStripe can build the database schema and default records

## Connecting


### TCP Access to SQL Server

By default, you can only access a MS SQL Server over named pipes.  To enable TCP access, see the following:

*  Configure firewall to allow TCP access: http://msdn.microsoft.com/en-us/library/ms175043.aspx
*  Fix SQL Server to use TCP/IP connections under the SQL Server Configuration Manager

### Enabling Firewall access on Windows

SQL Server 2008 is not accessible on Windows without opening certain ports on Windows Firewall.

Only do this if you require other computers access to the database. If the local machine is the only one using the database, this is not required.

[This page](http://msdn.microsoft.com/en-us/library/ms175043.aspx) has information on configuring your firewall to allow remote access to SQL Server.

## Search functionality

So far, we're using the built-in Fulltext Search functionality provided by SQL Server.  It's not perfect, since it can only search on some data types, but it's a good start. Please see [tutorial 4](tutorial/4-site-search) for information how to enable fulltext search and the necessary controller hooks.

## Known issues / gotchas

*  LIMIT / OFFSET in it's standard form is NOT supported by SQL Server. A sub-select is done instead to achieve the same result as a LIMIT clause. 
## Troubleshooting
*  **Q**: I just installed an instance of SQL Server that isn't the default, but it says that it cannot connect.
*  **A**: Make sure that your server name is made in this format: "(local)\SQLExpress". The first part before the slash indicates the server host, or IP address. In this case, (local) indicates localhost, which is the same server PHP is running on. The second part is the SQL Server instance name to connect to, which is useful for multiple instances. One example of a non-default instance os "SQLExpress".

*  **Q**: I'm getting unicode SQL Server errors connecting to SQL Server database using FreeTDS
*  **A**: Make sure you're using TDS version 8.0 in /etc/freetds/freetds.conf (or wherever it's installed)

*  **Q**: I can't connect to my SQL Server database from FreeTDS, a message says the server doesn't exist
*  **A**: Make sure you've got an entry in /etc/freetds/freetds.conf (or wheverever it's installed) that points to your server. For example:
 
~~~
[myserver]
   host = myserver.mydomain.com
   port = 1433
   tds version = 8.0
~~~

Then, you can use "myserver" as the server name when installing SilverStripe, so your port and tds version settings are applied.

If this doesn't work for you, you can try putting the tds version parameter in the global section:

~~~
[global]
   ...

   tds version = 8.0
~~~

:!: [Fedora](http://fedoraproject.org) Linux uses [SELinux](http://fedoraproject.org/wiki/SELinux) (Security Enhanced Linux) which could block httpd network traffic. Please check that this does not interfere with httpd being able to access SQL Server through the network.

:!: Use tabs (not spaces) when editing the freetds.conf file!
