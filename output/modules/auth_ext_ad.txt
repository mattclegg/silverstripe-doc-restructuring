# Introduction

## How to set up for Active Directory Authentication
**Note:** Using encryption is only tested on Linux.
**Note:** The SilverStripe server does not need to be part of the Domain

You can use any AD server (W2K or W2K3) for authentication with SilverStripe. Though the AD is not a LDAP server, it has a LDAD connector, which we can use for authentication purposes.

One of the most important things to know is how the AD is represented in a LDAP query and most important, how the users are represented. The image below shows the W2K3 management console on the left and the result of an ldapsearch -h [windows server] -x -D "cn=Roel R.B.. Gloudemans,cn=Users,dc=gloudemans,dc=info" -W

{{:modules:adtoldap.jpg|:modules:adtoldap.jpg}}

The configuration file below gives an example of howto configure against an AD. Say that our domain name is silverstripe.com. For the authentication to work, SilverStripe must be able to search through the AD. This is disabled by default. You can enable it by changing the security policy on the AD (not recommended, for details see [novell.com](http://www.novell.com/coolsolutions/appnote/15120.html)), or by creating a special account for it.

Open "Active Directory Users and Computers" and go to the "Users" folder. Create a new object in this folder of type "User"

{{:modules:createuser.jpg|:modules:createuser.jpg}}

You might want to change some properties of this user. Right click on the silverstripe user and change the following settings on the following tabs:

{{:modules:disablerc.jpg|:modules:disablerc.jpg}} {{:modules:disablets.jpg|:modules:disablets.jpg}}

The primary group of this user should also be changed. I added them to the "Domain Guests" group, but you might also create a special group for this user. Don't forget to set the newly added group as primary, or you can't remove the "Domain Users" group.

{{:modules:setgroup.jpg|:modules:setgroup.jpg}}


Here is what your _config.php should look like, if you created a silverstripe user according tho the instructions above:

~~~ {php}
/**
 * External Authentication server definitions
 * Change the parameters below to suit your authentication server, or disable 
 * this authentication method altogether
 */
Authenticator::register_authenticator("ExternalAuthenticator");

/**
 * Create your authentication source
 * The first parameter is the Source ID. Set this to something you deem
 *     approriate to this source. It must be unique among all authentication
 *     sources, may not contain special characters or spaces and must be
 *     shorter that 50 characters
 * The second parameters is the type of server.
 *     At the moment LDAP, FTP, IMAP and HTTP are supported
 * The third parameter is a nice name for this source, to be showed in
 *     drop-down form fields to choose the source
 *
 * You can create multiple sources with different of same types
 **/
ExternalAuthenticator::createSource('corp_ad','LDAP','Corporate Directory');
//ExternalAuthenticator::createSource('ispmail','IMAP','ISP mail server');
	
/**
 * On login, users can choose the authentication source they want, or all
 * sources can be checked in sequence till success (or failure)
 * In this is set to true, the source selection box on the login page
 * disappears. So you might want to set this to true if you have only one
 * source.
 *
 * WARNING: If you set this to true, accounts from the different sources can
 *          eclipse eachother. The process stops at the first success.
 *
 * NOTE:    The order in which accounts are checked depends on the order of the
 *          createSource statements
 **/
ExternalAuthenticator::setAuthSequential(false);

/**
 * How do we call a user ID?
 * This string is informational and will appear on the login page
 */
ExternalAuthenticator::setIdDesc('User ID');

/**
 * Hostname of the authentication server
 * you can specify it like a normal hostname or IP number.
 * If you use SSL or TLS, use the name matching the server certificate here  
 */
ExternalAuthenticator::setAuthServer('corp_ad','silverstripe.gloudemans.info'); 

/**
 * The DN where your users reside. Be as specific as possible
 * to prevent unexpected guests in the CMS, so typically your
 * directory's base dn (o=.... or dc=....,dc=....) augmented with
 * the ou where the accounts are
 * WARNING: AD trick here. In the Unix world chances are that the users are on an OU
 * not so on AD.
 **/
ExternalAuthenticator::setOption('corp_ad', 'basedn', 'cn=Users,dc=gloudemans,dc=info');

/**
 * LDAP protocol version to use
 * If you have TLS enabled, the version must be 3. The default is 3
 **/
//ExternalAuthenticator::setOption('corp_ad', 'ldapversion', 3); 

/**
 * You can use any unique attribute to authenticate as, this
 * mail, or uid, or any other unique attribute. 
 *
 * SilverStripe will search the ldap for this attribute set to the ID entered
 * on the basedn and below 
 **/
ExternalAuthenticator::setOption('corp_ad', 'attribute', 'sAMAccountName');

/**
 * You have to possibility to auto create non existing users that do exists
 * within the LDAP database. Set the option below to the group name you want
 * to add the user to (case sensitive) or to false if users should not be
 * created automatically
 *
 * WARNING WARNING WARNING
 * If you do not have control over the external authentication source, you no
 * longer control who can log in. USE WITH CARE
 **/
ExternalAuthenticator::setAutoAdd('corp_ad', false);

/**
 * If your directory doesn't support anonymous searches you can
 * specify an account below that will be used to search for the
 * attribute containing the user ID as (dn, passwd)
 **/
ExternalAuthenticator::setOption('corp_ad', 'bind_as','cn="silverstripe,cn=Users,dc=silverstripe,dc=com"'); 
ExternalAuthenticator::setOption('corp_ad', 'bind_pw', 'secret'); 

/**
 * If you want account auto creation, you should also set the following
 **/
ExternalAuthenticator::setOption('corp_ad', 'firstname_attr', 'givenName');
ExternalAuthenticator::setOption('corp_ad', 'surname_attr', 'sn');
ExternalAuthenticator::setOption('corp_ad', 'email_attr', 'userPrincipalName');
~~~

If you don't know your AD structure, you can use ADSI Edit (optional component) - either add it from the installation CD or download it at [microsoft.com](http://www.microsoft.com/downloads/details.aspx?FamilyID=96a35011-fd83-419d-939b-9a772ea2df90&DisplayLang=en). Open it with Start -> Run -> adsiedit.msc.

The above example is for W2K3 standard server. For Windows Small Business Server 2003, it looks slightly different due to a different AD layout. It is assumed that the domain is silverstripe.com, the domain controller is domaincontroller.silverstripe.com, the username (**not** the login name, instead use the "Name" column displayed in "Active Directory Users and Computers") is //SS Test//, and the password for it is //ss_test//. All users from the AD are able to login as part of the "Administrators" account (only use for testing, otherwise use appropriate group).
~~~ {php}
Authenticator::register_authenticator("ExternalAuthenticator");
ExternalAuthenticator::createSource('corp_ad','LDAP','Corporate Directory');
ExternalAuthenticator::setAuthSequential(false);
ExternalAuthenticator::setIdDesc('User ID');
ExternalAuthenticator::setAuthServer('corp_ad','domaincontroller.silverstripe.com'); 
ExternalAuthenticator::setOption('corp_ad',"basedn", "OU=SBSUsers,OU=Users,OU=MyBusiness,DC=silverstripe,DC=com");
ExternalAuthenticator::setOption('corp_ad','ldapversion',3); 
ExternalAuthenticator::setOption('corp_ad','attribute', 'sAMAccountName');
ExternalAuthenticator::setAutoAdd('corp_ad','Administrators');
ExternalAuthenticator::setOption('corp_ad','bind_as','CN=SS Test,OU=SBSUsers,OU=Users,OU=MyBusiness,DC=silverstripe,DC=com'); 
ExternalAuthenticator::setOption('corp_ad','bind_pw','ss_test');
ExternalAuthenticator::setOption('corp_ad','firstname_attr', "givenName");
ExternalAuthenticator::setOption('corp_ad','surname_attr', "sn");
ExternalAuthenticator::setOption('corp_ad','email_attr', "userPrincipalName");
~~~


# Using AD with SSL
Now you'd probably also want SSL encryption. For that you'd need the certificate of the AD that signed the certificate. If the certificate was provided by a well known CA, there is no problem. If it is not, you'll need to import the certificate from the CA. Often you can get the certificate by pointing your browser at the domain controller and go to the URL http://[domaincontroller]/certsrv. You can download the root certificate in DER format there. There is also a chance to find the CA root certificate in the root directory of your Windows Server.

Small problem is, is that the format is in der and your ldap library expects pem. Use the openssl command to convert your certificate:

~~~
openssl x509 -inform DER -in [CA certificate in DER format] -out [CA certificate in PEM format]
~~~

You can verify the certificate with:

~~~
openssl x509 -in [CA certificate in PEM format] -text -noout
~~~

Now open up your openldap config file, often located in /etc/openldap/ldap.conf or /usr/local/etc/openldap.conf (or even possibly /etc/ldap etc.)

Check for the TLS_CACERTDIR directive. If it does not exist add it and point it to e.g. /etc/openldap/cacerts. Also add the TLS_REQCERT directive. My ldap.conf looks like:

~~~
#
# LDAP Defaults
#

# See ldap.conf(5) for details
# This file should be world readable but not world writable.

#BASE   dc=example, dc=com
#URI    ldap://ldap.example.com ldap://ldap-master.example.com:666

#SIZELIMIT      12
#TIMELIMIT      15
#DEREF          never
URI ldaps://silverstripe.gloudemans.info
BASE dc=gloudemans,dc=info
TLS_REQCERT never
TLS_CACERTDIR /etc/openldap/cacerts
~~~

Now put your PEM certificate file in the directory pointed to by TLS_CACERTDIR. And go (cd) to that directory now do:

~~~
openssl x509 -hash -noout -in [CA certificate in PEM format]
[Some Hash key]    <--- Result of previous command
ln -s /etc/openldap/cacerts/[CA certificate in PEM format] /etc/openldap/cacerts/[Some Hash key].0
~~~

Now put the certificate in your local certificate directory (/etc/ssl/certs?) and point your ldap.conf (often /etc/openldap/ldap.conf) at it with:


At this point you should be able to query the AD with ldapsearch like:
ldapsearch -x -D "cn=silverstripe,cn=Users,dc=gloudemans,dc=info" -W -H ldaps://silverstripe.gloudemans.info

Now you can add the following config to your _config.php

~~~ {php}
/**
 * You can use TLS or SSL for encryption, for the methods that support it.
 * Don't set it, or set it to TLS or SSL. AD only supports SSL
 */
ExternalAuthenticator::setAuthEnc("ssl");
~~~

I had to restart my apache before it worked, but work it did.

# An alternative
Many organizations that use AD also use MS-Exchange to handle the mail. MS-Exchange supports POP3 and IMAP amoung other protocols. The External Authentication plugin supports these protocols as well. Using these protocols has some advantages:
*  Simpler configuration
*  No extra security risks

And one disadvantage:
*  If you use user autocreation, first, last and e-mail fields cannot be set to the proper values automatically.

