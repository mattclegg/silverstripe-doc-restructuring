This tells you how to access the CMS when you've forgotten your password, and when you cannot use 'reset password
function.' (E.g. if your email is different/unknown.). It requires file-system/FTP access to the website.

You cannot actually retrieve your current password, only set it to something new.

 1.  Edit your mysite/_config.php
 2.  Add the following line, replacing 'username' and 'password' with something temporary.`<code>`
Security::setDefaultAdmin('username', 'password');
`</code>`
 1.  Log in to the CMS (http://www.yourwebsite.com/admin ) using the username and password above.
 2.  You are now logged in as one of the admin accounts stored in the system.
 3.  Visit the Security section of CMS.
 4.  Edit or add Administrator accounts as appropriate to set credentials you can then use. You cannot retrieve the
password; only set it to something new.
 5.  Test you've resolved the situation. Log out and then log in as an administrator account you've created/restored.
 6.  Remove the line from step 2 in _config.php. This removes the potential backdoor.
