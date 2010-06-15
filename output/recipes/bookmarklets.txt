# Bookmarklets

Add these bookmarks to your bookmark toolbar for easy access to various SilverStripe functions.

**Flush cache**

~~~
javascript:location.href=location.href+(location.search?'&':'?')+'flush=1'
~~~

**Rebuild database**

~~~
javascript:location.href=document.getElementsByTagName('base')[0].baseURI+'db/build?flush=1'
~~~

**Go to admin page**

~~~
javascript:location.href=document.getElementsByTagName('base')[0].baseURI+'admin'
~~~

**Log out**

~~~
javascript:location.href=document.getElementsByTagName('base')[0].baseURI+'Security/logout'
~~~

