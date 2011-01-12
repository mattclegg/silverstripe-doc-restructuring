<?php
# Usage

## Theme's

### Download new themes

Download a second theme from http://www.silverstripe.com/themes/ and put it in your themes folder. Open admin/subsites and select one of your subsites from the menu on the bottom-left. You should see a Theme dropdown in the subsite details, and it should list both your original theme and the new theme. Select the new theme in the dropdown. Now, this subsite will use a different theme from the main site.

### Limit themes for a subsite

Not all themes might be suitable or adapted for all subsites. You can optionally limit usage of themes by adding in mysite/_config.php;

`Subsite::set_allowed_themes(array('blackcandy','mytheme'));`


##*_config.php* settings

**Set the domains for your subsites**  
You can list available domains for your subsites (Example: subdomain.domain.tld). The subsites are generally identified only by their subdomain part (Example: subdomain.domain.tld). This example would let you create subsites such as wellington.mycompany.com or london.mycompany.org  

`Subsite::set_allowed_domains(array(
   'mycompany.com',
   'mycompany.org'
));`

> If you would like to be able to choose any domain for your subsite, rather than subdomains off a common base, then list top-level domains in your set_allowed_domains() list.

In this example, your subsite name, eg, silverstripe, will be appended to a much shorter base domain, eg, co.nz, or org. This would let you create subsites with domains such as silverstripe.org or example.co.nz

`Subsite::set_allowed_domains(array(
   'com',
   'org',
   'co.nz',
   'org.nz',
));`

You can mix the two together, if you want to have some subsites hosted off subdomains of your mail site, and some subsites hosted off their own domains. In this example, you could set up subsites at wellington.example.com, othersite.co.nz, or thirdsite.org.

`Subsite::set_allowed_domains(array(
   'example.com',
   'com',
   'org',
   'co.nz',
   'org.nz',
));`

Note that every site also has a www.-prefixed version of the domain available. For example, if your subsite is accessible from wellington.example.org then it will also be accessible from _www.wellington.example.org_.

## Access created domains

Once you have created some subsites/domains in your admin, you can check the overall functionality of subsites by

http://your.primary-domain.com/subsite-metadata-url?SubsiteID=1
In some Browsers the SubsiteID is visible if you hover over the "Edit" link in the search results of Subsite admin.