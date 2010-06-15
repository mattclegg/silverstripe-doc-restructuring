# Windmill Integration Testing

Windmill is a testing system that uses the actual browser to run integration tests, JavaScript and all.  In practise, I (Sam) has found it easier to write integration tests using the normal PHP based framework, but where you are making heavy use of JavaScript, Windmill is an excellent choice!

### Setting up a development machine

Install Windmill as detailed on [the windmill site](http://windmill.osafoundation.org/trac/wiki/BookChapter-1-Install#InstallingWindmill). 

### Writing tests

*  Start windmill from the command line.

~~~
windmill firefox http://localhost/yoursite/dev/tests/startsession
~~~

*  You will be asked to enter a fixture filename.  Before you do, press the record button in Windmill.
*  Then enter the name of a fixture file to use, for example, cms/tests/CMSMainTest.yml.  Press the button.
*  Once it has set up a test database using that fixture, it will give you a few links to get started.  If you're going to test a part of admin you might want to click that link.  You will notice that all of the interaction up until this point has been dutifully recorded by windmill!

Now you have the CMS open with a test fixture and Windmill recording it - life is good!  Refer to the windmill manual for more information on how to use it: http://windmill.osafoundation.org/trac/wiki/WindmillBook

Once you have created your test, you should save it into (module)/test/test_windmill, as a python file.

...more to come...


### Setting up a buildbot slave

#### OS X

First, ensure that you are using a copy of python 2.5.  Modifying your PATH to point to the version of python in Python.framework is a good way of doing this.

~~~
easy_install windmill
easy_install zope.interface
~~~

Download http://tmrc.mit.edu/mirror/twisted/Twisted/2.5/Twisted-2.5.0.tar.bz2 

~~~
tar xjf Twisted-2.5.0.tar.bz2 
cd Twisted-2.5.0
python setup.py install
~~~

~~~
easy_install buildbot
~~~

Now that all the core software is installed, you can set up a buildbot slave environment

slave-id is the "username" of this build slave; slave-password is the password to go with it.  Once the slave has been set up, these values will need to be loaded into the open.silverstripe.com build master configuration.

~~~
mkdir ~/buildbot
cd ~/buildbot
buildbot create-slave . open.silverstripe.com:9989 (slave-id) (slave-password)
nano info/admin # Enter your name/email
nano info/host # Enter a description of where this box is
mv Makefile.sample Makefile
mkdir ~/buildbot/full
mkdir ~/buildbot/full/build
mkdir ~/buildbot/full/trunk
chmod -R +x,+r ~/buildbot/full
~~~

The slave now has its basic set-up working.  Next we need to link apache webserver: http://localhost/buildbot-full should point to ~/buildbot/full/build/trunk.

The easiest way of getting a server running is to use MAMP.  Download and install it from here: http://www.mamp.info/en/download.html

Reconfigure MAMP to host on port 80 and use MySQL port 3306.  Once MAMP is configured, symlink webroot/buildbot-full to ~/buildbot/full/build/trunk

~~~
cd /Applications/MAMP/htdocs
ln -s ~/buildbot/full/build/trunk buildbot-full
~~~


#### Build master configuration

This configuration step will need to be done by SilverStripe staff, preferable Sam or Matt.

*  ssh onto open.silverstripe.com and edit /fileshares/sites/buildbot.silverstripe.com/master.cfg
*  Find the c['slaves'] line and add a reference containing slave-id and slave-password from above
*  Find the osxbuilder definition, and add the slave-id to the slavenames section
*  Save the config file, and run "make reconfig" from within /fileshares/sites/buildbot.silverstripe.com



