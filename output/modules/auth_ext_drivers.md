## Adding new authentication sources

Adding new authentication sources is easy. In the auth_external/code directory, there is a drivers directory. All
drivers are contained here.

To add a new driver:

*  create a file with the name ''[DRIVER NAME].php'' (the driver name is in caps)

*  This PHP file must contain the class ''[DRIVER NAME]_Authenticator''

*  This class must at least contain the public function ''Authenticate'', which must accept 2 parameters; name and
password

*  The function must either return
    * true or false, indicating authentication success or failure
    * false, or an array with at least the elements ''firstname, surname'' and ''email''. These array elements must be
filled with their respective values which were gotten from the authentication source. This data will be used for auto
account creation.

*  As a last step, you must add the file ''_config.[DRIVER NAME]'' (fully annotated) to the doc directory assisting
other in configuring your driver.


**The Authenticate function**

Within this function you can use the generic settings from the module and you may use driver specific settings. The
generic settings you can use are:

''ExternalAuthenticator::getAuthServer  -> string''

''ExternalAuthenticator::getAuthPort -> integer or null''

''ExternalAuthenticator::getAuthEnc -> ssl/tls or not set''

You can define your own driver options by using 

''ExternalAuthenticator::setOption("[OPTION NAME]","[OPTION VALUE]")''

in your ''_config.php'' file and

''ExternalAuthenticator::getOption("[OPTION NAME]")''

Inside your Authenticate function.

See the FTP driver for a simple example and the LDAP driver for a complex example.

