**NOTE:** The try server is experimental and this information may not be up to date.  Talk to Sam Minnée if you want more information.

Buildbot, our continuous integration server, has a facility called the "try server".  This will let you test your changes before they are committed.

#### How to set up your machine

1.  First, install buildbot.
    * Windows users: http://buildbot.net/trac/wiki/RunningBuildbotOnWindows
    * OSX / linux users: http://buildbot.net/trac#DownloadInstall
2.  Go to your svn-based working copy that contains changes.
3.  Create an empty file called .buildbot-top
4.  Run the following command
~~~
buildbot try --wait --connect=pb --master=buildbot.silverstripe.com:8031 \
--username=(username) --passwd=(password) --vc=svn \
--builder=osx-alltrunkmodules --branch phpinstaller/trunk
~~~

Alternatively, you can remove the ''--wait'' option and just watch progress at http://buildbot.silverstripe.com/waterfall

#### How to get a username and password

To access the try server, you will need a username and password.  Because the try server is still experimental, we're limiting access to currently active developers.
