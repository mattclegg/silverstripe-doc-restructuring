# Introduction

These webhosts all run PHP5 and have had various levels of confirmation that SilverStripe runs on them. Please update
this page based on your experiences, for the benefit of others! 


*  Only include hosts that meet SilverStripe [server requirements](server-requirements)

*  Use the provided submission template

*  Don't include pricing information

*  Write a concise description (no essays!) and stay objective

# Template

	

	 * [[`<URL to hosting package>`|`<provider name>`: `<package name>`]]
	`<comma-separated list of specifications>`

	   * Comment by `<author name>` (`<optional email address>`): `<silverstripe specific information, installation experiences>`
	   * Comment by `<author name>`: `<comment>`



# Working webhosts

**The views expressed here do not reflect the views of Silverstripe Ltd.. We do not guarantee the accuracy of
information on pricing or service conditions. Any statements on functionality and availability of services are
individual experiences - if you want to be sure about a host, please test yourself!**


##### International

*  [SilverStripe Club Hosting](http://www.silverstripeclub.com/silverstripe-services/) The SilverStripe Club hosting
service has been specifically engineered for SilverStripe CMS. Host 25 SilverStripe sites on a single account for less
than $1 (USD) per site per month. Also includes free $9.95 Enom domain name reseller account valued at $1495 (USD).

*  [Easy Serve Web Hosting](http://www.easyserve.co.nz/) SilverStripe specialists, we host lots of silverstripe sites,
free installation and advice.

*  [godaddy.com](http://godaddy.com), requires use of their automated installer.

*  [MyIRCShells.com](http://myircshells.com), Standard Plan - 500MB Disk Space, 5GB Bandwidth, PHP 5.2.x ($10 per month
plan). Works great! Talk to Koneko (the owner) via IRC for questions or to signup. Server: saber.myircshells.com  Room:
#myircshells

*  [LittleMonkey Hosting](http://littlemonkeyhosting.com), Business plan (medium sized) - 15gb space, 300gb traffic, PHP
5.2.x, 128MB memory limit so no php.ini changes required.  SilverStripe installs with no problems at all.  Other size
plans also available with the same script and database support.

*  [OpenSourceHost.com](http://www.opensourcehost.com) , Basic plan - 2gb space, 20gb traffic, PHP 5.2.x. Not only does
silverstripe install no problem, the host will actually install it for you. I tried asmallorange and 2mhost and could
not get either to work, but these guys got it going for me. 

*  [2mhost.com](http://www.2mhost.com) , PHP 5 Developer plan - 500mb space, 25gb traffic, PHP 5.24. Silverstripe
installs no problem. 
    *//Did not work for me (Matthew Mathis)//

*  [a2hosting.com](http://a2hosting.com), 10GB space, 100 GB transfer, PHP 5.2.1, MySQL5, SVN, Ruby etc, USD7 month.

*  [Westhost.com](http://www.westhost.com/), Virtual Private Servers from USD4 a month, for 250MB disk/10GB traffic.
''(Requires activating PHP,MySQL in control panel)''

*  [asmallorange.com](http://www.asmallorange.com), various plans - starting from $25 a year to $30 per month. Linux
2.6, Apache 1.3, PHP 4.4 with Zend Optimizer, PHP 5.2, MySQL 5.0, Ruby on Rails 1.2, Perl 5.8, Python 2.4. Read here if
you want to use SilverStripe on this host, before installing: http://wiki.asmallorange.com/HOWTOPhpFastCGI (you need to
increase the PHP memory limit using your own php.ini file and FastCGI). Confirmed to have SilverStripe (rc5) working
*(7/4/07 - Sean/SS)*

*  [dreamhost.com](http://www.dreamhost.com), Highly recommended. Really easy to setup, supports PHP5 and unlimited
MySQL. Has PHP memory of 90mb and SSH support, as well as RoR and Subversion! :-). Monthly price is USD 7.95 (or USD 190
for 2 years pre-paid, no setup fee). Use promo code SILVERSTRIPEROCK to waive setup fee on monthly billing plan.
*Before* installing, ensure you have set PHP 5 in the 'Manage Domains' portion of the DreamHost control panel, otherwise
you'll get a bucketload of errors during the install.
    * *Confirmed by Andy (aoneil), Matt (mpeel), Will (willr), Sean (sharvey) who all host with DH.*
    * // Everything works fine except they are slow, slow, slow. Some SS installations of mine on dreamhost servers
sometimes seem to take 40 seconds or more to load, or just don't load at all during american daytime. I would definitely
not recommend them for professional use in combination with SS as I suspect the cpu is shared with too many other
users.(dio5) //
    * ** See http://www.silverstripe.com/site-builders-forum/flat/21034?showPost=53803#post53803 ** to address speed
issues on dreamhost.
    * // Installed easily (Nov 2009) and seems pretty fast to me. 90MB php memory makes big difference. No problems at
all so far.(kinkykoder)//

*  [navigatoris.net](http://navigatoris.net/), has a unlimited domains, 500mb space, 10gb bandwidth plan for $5/month.  
     
    * Note: To get SilverStripe running, increase the maximum PHP memory by adding this to sapphire/main.php *(6/17/07 -
Elijah Lofgren)* `ini_set('memory_limit','32M');`{php}
    * Example website running on navigatoris.net:
[elijahlofgren.com/silverstripe/](http://www.elijahlofgren.com/silverstripe/)


*  [http://www.bluehost.com/](http://www.bluehost.com/), 1500 Gigabyte Hosting Space,500 POP/Imap Email Accounts,15000
GIGS of Transfer (NEW!),SSH (Secure Shell), SSL, FTP, Stats,CGI, Ruby (RoR), Perl, PHP, MySQL,2000/2002/2003 Front Page
Extensions,24/7 Superb/Responsive Sales/Support, for $6.95 per month.

*  Note: To get SilverStripe running on BlueHost, log into the bluehost control panel (//frontend//) and select the
**(php config)** option. Select **"PHP5(FastCGI)"** and save changes. Now select **"INSTALL PHP.INI MASTER FILE"**. Now
delete the old php.ini file in your silverstripe directory and rename *php.ini.default* to *php.ini*. Finally, change
**"memory_limit = 32M"** to **"memory_limit = 64M"** in your new *php.ini*. Silverstripe should now install.


*  [Servage.net](http://www.servage.net/), 360GB space, 3600 GB transfer, PHP 5.2.1, MySQL5, Ruby, free domain,
unlimited domains, unlimited email accounts, Python, Cron, etc, GBP $6.45 month. Use this link for an extra 25gb.

*  [Joyent](http://www.joyent.com/), very professional hosting provider, no problems installing, it just works, they
have shared hosting as well, recommended -SilverRay, using v2.2.0 at the moment.
     *//Templates in modeladmin don't fully render (fredc)//

*  [000webhost.com ($0.00 webhost)](http://www.000webhost.com), 1500MB space, 100GB traffic, Free Web Hosting,
memory_limit set at 32M, unlimited DB size.
    *//Just installed, easy install, just had to chmod a few files/folders first (Paul Dekker)//


*  [http://www.site5.com/](http://www.site5.com/), very comprehensive hosting, with excellent customersuppport, I've
gone of the hostPro + Turbo package, installed version 2.3.3 straight off with no problems what so ever

*  [SiteGround.com: SilverStripe Hosting](http://www.siteground.com/silverstripe-hosting.htm) Unlimited space and
traffic, Free domain name, Professional SilverStripe installation, 7 different PHP versions, MySQL, FTP, SSL, 24/7
Expert Support, for $3.95/mo

##### Australia

*  [activIT Systems](http://aitsys.com.au/online/hosting/), Perth-based IT company with very flexible and reasonably
priced plans. Shell access, PHP 5.2.9, MySQL 5.0.67. Full details of the server hardware and prices by following the
link. Excellent customer service. *(Confirmed SS 2.1-2.4 working - DesignCity)*


*  [Quadra Hosting](http://www.quadrahosting.com.au/hosting/unix.html), Gold Coast based organisation that manages
FreeBSD based servers in Sydney and the United States. Quadra will provide shell access on request. Support for PHP5
5.2.4 and MySQL5 on all new accounts. All php.ini variables can be overwritten with .htaccess. You'll need to [disable
mod_security](https///support.quadrahosting.com/index.php?_m=knowledgebase&_a=viewarticle&kbarticleid=125) for
SilverStripe function correctly. *(Confirmed compatibility with SS 2.2.1 by Tatey)*

Paste the following in to your .htaccess file

	:::php
	#### START Override default PHP.ini values
	php_value allow_call_time_pass_reference on
	
	# Disable mod_security to prevent restrictive calls between the server and client
	`<IfModule mod_security.c>`
	SecFilterEngine off
	`</IfModule>`
	
	# PHP Memory Limit
	php_value memory_limit 64M
	
	#### END Override



*  [Adam Internet](http://www.adam.com.au/product_work_hosting_gen_host.php), Adelaide based ISP, Good Support.
.//(webhost-18.adam.com.au, webhost-19.adam.com.au - comfirmed SS 2.2.2 working - CodeGuerrilla)//


*  [Jumba](http://www.jumba.com.au/hosting/business), Canberra based ISP, // Set memory_limit @see
[http://wiki.jumba.com.au/wiki/Php.ini](http://wiki.jumba.com.au/wiki/Php.ini) // .//(Comfirmed SS 2.3.4 working -
CodeGuerrilla)//


*  [Internode: Business Web Hosting -
Database](http://www.internode.on.net/business/hosting_and_content/business_web_hosting/)//

    ** Comment by CodeGuerrilla:* PHP HTTP Extension conflicts had to rename sapphire/core/control/HTTPRequest.php and
HTTPResponse.php and all references to SSHTTPRequest and SSHTTPResponse, use find and replace on your SS directory I
suggest doing them one at a time @see [Forum
Post](http://silverstripe.org/installing-silverstripe/show/255177?start=0#post255921), Can get _SESSION is undefined
errors or a Server 500 errors if any of your custom code has blank lines beneath the closing PHP tag (you can leave
these off or remove spaces to fix)//

##### France

*  [Online.net: package M](http://online.net/), works out of the box (you only have to activate PHP5, as explained in
their support pages).

##### Germany

*  [Allinkl.com](http://www.allinkl.com/), No problem running current Silver Stripe Version 2.2.1. Successfully running
on shared hosting package. Older packages require transition to php 5 but it's done really quick by allinkl.com support.
*Note: You can change the ownership of the /assets folder to PHP(wwwrun) in the control panel, so no 777 permissions are
needed*

*  [1&1 Internet AG](http://www.einsundeins.de//), big German provider with no problems at all

*  [Strato AG](http://www.strato.de//), big German provider, mod_rewrite works meanwhile, be sure to turn the option
"SiteGuard" off and to activate PHP5 for the SilverStripe directory.[Bug 2660](http://open.silverstripe.com/ticket/2660)
was helpful as well. *(Confirmed compatibility with SS 2.2.3 by samuelle)* *(adiwidjaja: Works, but is not recommended.
Strato seems to set severe limits on processor time so rendering is *very* slow)*

*  [Hetzner](http://www.hetzner.de//), did not cause any problems at all. You can use their
[webtool](http://konsole-h.de/ ) to configure webserver, mysql, and php. Make sure to add a user with write permissions
to your root dir. Otherwise, .htaccess is reported not writeable during installation.

*  [w3w](http://www.w3w.de//), no problems here.   

##### The Netherlands

*  [http://www.keenondots.com/](http://www.keenondots.com/), Silverstripe works out of the box, Good knowledge about
Silverstripe.
*(Confirmed compatibility with SS 2.2 by Lemon8)*

*  [Internet Today ISP: all packages](http://www.internettoday.nl), from SS 2.2.3 works perfectly, server mods can be
requested, great support!




##### New Zealand

*  [Easy Serve Web Hosting](http://www.easyserve.co.nz/) SilverStripe specialists, we host lots of silverstripe sites.
Quick Auckland based servers, free installation and advice.

*  [Open Host](http://www.openhost.co.nz/) Quick Simple and reasonably priced! Do NOT support it.  Cant guarantee
performance....Only run it on VPS! - Works on Linux packages - Ronan 04/05/09

*  [24/7 Hosting](http://www.247hosting.co.nz/) Managed hosting solution, CHCH Based Servers.

*  [Nucleus](http://www.nucleus.co.nz/linuxhosting.html) (colocation, whole boxes, single domain 
accounts). Start at NZD29. 

*  http://www.digiweb.co.nz - confirmed by Nicolaas on 10 October 2007. Fast in NZ.
    

*  Unconfirmed but mention PHP5 on their website
    * http://www.unleash.co.nz (but you need to fix SafeMode support)
    * http://www.spiritconnect.co.nz/new-zealand-web-hosting/
    * http://www.webfarm.co.nz
    * http://www.kiwihosting.net.nz
    * http://www.net24.co.nz

##### Poland

*  [Hostec](http://hostec.pl), dedicated servers, colocation, single accounts. No problems with SilverStripe
installation, the servers quality is alright. If you experiance any problems with the installation you can increase the
php memory limit by adding
`php_value memory_limit "64M"`{php}
to .htaccess - it will help with all of the known issues.
*(Confirmed compatibility with SS 2.2 by Wojtek)*


*  [Nazwa](http://nazwa.pl), dedicated servers, colocation, single accounts. You must change the PHP  files support by
adding the following to .htaccess:
`AddType application/x-httpd-php5 .php`{php}
Besides, everything works great.
*(Confirmed compatibility with SS 2.2 by Wojtek)*


*  [Prohost](http://prohost.pl), dedicated servers, colocation, single accounts. Everything works fine! Despite the
installator missing the mod_rewrite, it works!
*(Confirmed compatibility with SS 2.2 by Wojtek)*

##### Switzerland

*  [cyon](http://www.cyon.ch), shared hosting with lots of features at a good price. You can configure your php.ini from
the control panel and increase the php memory limit up to 99mb. Works very well with SilverStripe. Good tech support.

##### UK

*  [http://www.gpmd.co.uk/](http://www.gpmd.co.uk/), Secure Managed SilverStripe Hosting. Shared hosting from £50pm.
Dedicated hosting from £300pm. 


*  [http://www.zen.co.uk/](http://www.zen.co.uk/),Installed OK on their Linux CPanel shared hosting. Use a local php.ini
to up the memory limit to 64M. Note that their older servers run PHP 4, so check that you are on a new one.
    * *I enquired at Zen Nov 2009 about php memory and they said it's limited to 32MB on shared hosting. So best to
check first. They do have great support though. (kinkykoder)*


*  [http://www.webfusion.co.uk/](http://www.webfusion.co.uk/) Fusion Professional Linux - Installed fine, but 32MB php
limit. Very slow response times with frequent script time-outs. I found it unusable, especially when uploading and
embedding images. I also found their support extremely unhelpful for basic questions. (kinkykoder)

# Problematic Webhosts

This is a list of web hosts known **not to work with SilverStripe**

*  *http:*www.silverstripe.com/general-discussion/flat/1924?showPost=2056 (not sure which host...)//

*  *http:*www.powweb.com/ ("Security Problems")
(http://www.silverstripe.com/general-discussion/flat/1924?showPost=2165)//

*  *http:*www.omnis.com/ Omnis// - have 'onPHP' enabled which conflicts with abstract class "Query". You'll need to
rename two files first (see *http:*silverstripe.com/site-builders-forum/flat/169752 this forum thread). Max 2 minutes
work!//

##### Australia

*  [Internode](http://www.internode.on.net) - Silverstripe does not work on Internode at all as they have disabled fopen
due to 'security holes'. *(Confirmed after painful troubleshooting - DesignCity)*


*  [Net Registry](http://netregistry.com.au/) - Zeus HTTP server is incompatible with Apache's mod_rewrite. Thus, it's
not possible to utilise Silverstripe in such a configuration. In addition, no shell access is provided. 


*  [Net Logistics](http://netlog.com.au) - PHP script memory limit restricted to 15MB on all shared servers (VPS and
Dedicated is exempted).

##### Poland


*  http://active24.pl - the installator doesn't indicate the problem, butthe mod_rewrite doesn't work right


*  http://cba.pl/ - errors during installation


*  http://lua.pl/ - errors during installation


*  http://superhost.pl/ - errors during installation, very slow server response times


*  http://jatsu.pl/ - the mod_rewrite doesn't work right


*  http://home.pl/ - the mod_rewrite doesn't work right


*  http://yoyo.pl/ - the mod_rewrite doesn't work right


*  http://ddl2.pl/ - missing PHP 5 support!


*  http://www.haa.pl/ - missing PHP 5 support!


*  http://www.hosting.osemka.pl/ - missing PHP 5 support!


*  http://www.hosting.yellowpages.pl/  - missing PHP 5 support!


*  http://www.freehost.pl/ - missing PHP 5 support!


*  http://ncse.pl/  - missing PHP 5 support!

##### Others

*  http://xtreemhost.com/ - truoble with mod_rewrite/AllowOverride

*  http://www.nativespace.com/ - trouble with PHP / cPanel

##### Spain

*  http://tripod.lycos.es/ - problems with requirements

##### Germany

*  http://www.t-online.de/ - missing mod_rewrite and .htaccess support
