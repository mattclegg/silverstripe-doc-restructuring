## Introduction
The external authentication module makes it possible to authenticate against authentication sources outside of SilverStripe. This might be a LDAP server, a mailserver etc. The main purpose of the module is to allow for single source authentication. 

The module is designed in such a way that it should easily be expandable with new authentication sources. At the moment LDAP, IMAP, POP3, FTP, HTTP and SilverStripe are supported, in encrypted and non encrypted variants. If the LDAP schema is set up for POSIX type authentication, account expiry is supported.

For sources that do not support locking of accounts after a login has failed too many times, the module can also use SilverStripes built-in account locking mechanism, which locks an account for 20 minutes after a set number of failures.

It is possible to define multiple authentication backends. A user can then choose his source, or sources can be checked sequentially (transparent to users). Use this feature with care, though. Especially in combination with the automatic creation of users.

SilverStripe keeps its own user database. By default, if a username does not exists within SilverStripe, access to the CMS is denied, even if the user authenticated successfully against the external source. However, by changing a setting users could be automatically added to the SilverStripe user database if they successfully authenticate.

**WARNING** You should use this functionality only if you have the external authentication source under your control.

Users that are automatically added are member of a preset group which you must create and configure yourself. The name of this group is also configurable.

If you use LDAP for authentication, you can set it up to automatically determine the users name and e-mail address.

The configuration of an authentication source can be troublesome, especially if you are using an LDAP directory. The module provides a debug log mechanism to help you troubleshoot problems. There are also 2 possibilities for audit logging, to file or use Silverstripe's internal mechanism (database table)


## Download
*  [0.2](http://open.silverstripe.com/changeset/latest/modules/auth_external/tags/0.2?old_path=/&filename=/modules/auth_external/tags/0.2&format=zip) (Latest Release)
*  [0.3-rc1](http://open.silverstripe.com/changeset/latest/modules/auth_external/tags/rc/0.3.0-rc1?old_path=/&filename=/modules/auth_external/tags/rc/0.3.0-rc1&format=zip) (Latest Unstable Release)
*  [Daily Build](http://open.silverstripe.com/changeset/latest/modules/auth_external/trunk?old_path=/&filename=/modules/auth_external/trunk&format=zip) ("trunk")







## Installation/Configuring
**Requirements**
*  SilverStripe 2.2.x for module version 0.2
*  Silverstripe 2.3.x for module version 0.3

Installation of the module is real easy
*  First determine which authentication source(s) you want to use. If you have multiple, think about where your website will be running. This could be on the local network, but also for the Internet. If you are building an Internet site, it could be wise to use a data source which is already exposed to the Internet, such as your local mail server. This way, you won't create an extra security risk to the infrastructure from this perspective. Then determine if the source supports encryption. If you do not use SSL/TLS, the user password will be transmitted in clear text to the  authentication server.
*  Determine if this module has a source for that driver. At the moment we have LDAP/IMAP/POP3/FTP/HTTPBASIC/SSTRIPE. If you have a data source that is not supported (yet), write your own driver and submit it to trac, or create a ticket in trac, requesting a driver for the source. If the driver is potentially beneficial for a considerable amount of SilverStripe users, there is a chance that it will be added. 
*  First get the code (as a tar ball/zip file/svn checkout) from the SilverStripe site. The name of the module is auth_external.
*  Unpack the archive containing the code and put the auth_external directory into your main SilverStripe directory
*  Create a _config.php file in the auth_external directory. You can start out from the annotated examples in the doc directory. There should be an example for each driver. These examples list all possible options and capabilities for each driver.
*  run /db/build  (like http://www.yourdomain.com/db/build)

You should now have an "External Account" tab on the admin page.\\ 
{{:modules:loginscreen-02.jpg|:modules:loginscreen.jpg}}

Log in as the administrative user (using the normal e-mail/password authentication) and add the external source and account names to their SilverStripe accounts. From that moment on, users will be able to logon to SilverStripe, with their external authentication source accountname and password.

{{:modules:authdialog2-03.jpg|:modules:authdialog2-03.jpg}}

You might want to set the SilverStripe password of the user to an empty string. This prevents the user from logging on without using the External Authentication source.

#### Disabling other authentication sources
If you do not use other authentication sources you can disable them.

Disabling OpenID: Open auth_openid/_config.php and comment out 
~~~ {php}
Authenticator::register_authenticator('OpenIDAuthenticator');
~~~

Disabling SilverStripes built-in mechanism: auth_external/_config.php and add 
~~~ {php}
Authenticator::unregister('MemberAuthenticator');
~~~
to the top.

If you only want to set External Authentication as the default you can add "                
~~~ {php}
Authenticator::set_default_authenticator('ExternalAuthenticator');
~~~
in this modules _config.php (after the "Authenticator::register" line)


=== Raising bugs or discussing this module ==
*  Bugs go to (register first) http://open.silverstripe.com/newticket?component=Modules%20-%20auth_external
*  Discuss at http://silverstripe.org/all-other-modules/

## TODO/Future versions
*  Adding more drivers
    * GMail/Yahoo/etc.
    * phpBB/Horde/etc.
*  Blocking IP's with too many logon failures

## Reference
**How to:**
*  [Use the LDAP driver to authenticate against a Microsoft Active Directory](auth_ext_ad)
*  [Setup a LDAP for local Unix account administration and SilverStripe](auth_ext_ldap)
*  [How to add new authentication drivers](auth_ext_drivers)


## User Maintained Modules
This module can be extended by adding new drivers. Some generic drivers are already included with the module. If users create their own, more specific, drivers they can be published on this wiki page.

Each driver archive consists of a php file which goes in the code/drivers directory and a configuration template named _config.[driver name]. This file can be used in the module root (renamed as _config.php). Instructions may vary on a driver by driver basis. See documentation in the driver archive.

Drop me an e-mail (address in the module README) if you want your driver reviewed or want to keep informed on any changes in the module that have an impact on the driver code.

#### Drivers
{{:modules:SMF.zip|Simple Machines Forum driver}} by Matt Hardwick


