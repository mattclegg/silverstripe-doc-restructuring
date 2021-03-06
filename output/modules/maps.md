# Introduction

This modules makes it easy to add maps to SilverStripe websites developed as part of the
[:gsoc07googlemaps](/gsoc07googlemaps) project.

## Download

* 
[0.1.1](http://open.silverstripe.com/changeset/latest/modules/maps/tags/0.1.1?old_path=/&filename=/modules/maps/tags/0.1.1&format=zip)
(Latest Release)

*  [Daily
Build](http://open.silverstripe.com/changeset/latest/modules/maps/trunk?old_path=/&filename=/modules/maps/trunk&format=zip)
("trunk")

#### Demo

*  http://www.silverstripe.com/google-summer-of-code-fruit-7-google-maps/

####  To Do 

*  [:gsoc07googlemaps](/gsoc07googlemaps)

#### Installation

1. Rename the extracted directory to "maps" and place in the root of your silverstripe installation.
Your directory structure should like this now:

assets
mysite
cms
jsparty
maps


2. In order to use the Google Maps module you require an API-key from Google.
You can easily obtain one from the following URL : http://code.google.com/apis/maps/signup.html
Place your API key in the file "maps/_config.php" 
    
    $GMaps_API_Key = 'ABQIAAAA15yRnC3laEBteiFmGHGwlBT2yXp_ZAY8_ufC3CFXhHIE1NvwkxSoRGI9YhLOfvLYGE3U8oDVf-Esgw';


3. Run /db/build/


You're now able to use the SilverStripe mapping API, to see an example of how it is used,
check out the latest version of the forums module, which includes support for mapping members
locations.

Please raise issues, bugs, contributions in the forum - see http://www.silverstripe.com/google-summer-of-code-forum/

Developer documentation coming up soon:
http://doc.silverstripe.com/doku.php?id=gsoc07googlemaps


Send comments to: ofir@silverstripe.com or hayden@silverstripe.com

##### Google Maps / Forum

If the maps module is installed as above, and the forum (v0.11 or higher) is installed, the forums will automatically
have Google Maps support, as demonstrated at http://www.silverstripe.com/google-summer-of-code-fruit-8-google-maps/
