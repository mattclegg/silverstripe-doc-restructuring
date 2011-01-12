# Access Control and Page Security

There is a fairly comprehensive security mechanism in place for Silverstripe. If you want to add premium content to your
site you have to figure this stuff out, and it's not entirely obvious. 

## Ways to restrict access

There are a number of ways to restrict access in Silverstripe.  In the security tab in the CMS you can create groups
that have access to certain parts.  The options can be found here:
[http://doc.silverstripe.com/doku.php?id=permissions:codes](http://doc.silverstripe.com/doku.php?id=permissions:codes). 

Once you have groups, you can set access for each page for a particular groups.  This can be:
- anyone
- any person who is logged in
- a specific group

It is unclear how this works for data-objects that are not pages.

## The Security Groups in Silverstripe

In the security tab you can make groups for security.  The way this was intended was as follows (this may be a counter
intuitive):
- employees
1.  marketing
    - marketing executive
Thus, the further up the hierarchy you go the MORE privileges you can get.  Similarly, you could have:
- members
1.  coordinators
    - admins
Where members have some privileges, coordinators slightly more and administrators the most; having each group inheriting
privileges from its parent group.     

## Permission checking is at class level

Silverstripe provides a security mechanism via the *Permission::check* method (see *LeftAndMain.php* for examples on how
the admin screens work)

(next step -- go from *Permission::checkMember*...

### Nuts and bolts -- figuring it out

Here are my notes trying to figure this stuff out. Not really useful unless you're VERY interested in how exactly SS
works.


### Loading the admin page: looking at security

If you go to [your site]/admin -- how does that work?
*Director.php* maps the 'admin' URL request through a *Director* rule to the CMSMain controller (see
[cmsmain](cmsmain), with no arguments. 

*CMSMain.init()* calls its parent which, of all things is called *LeftAndMain*. It's in *LeftAndMain* that the
important security checks are made by calling *Permission::check*. 

`[api:Security::permissionFailure]` is the next utility function you can use to redirect to the login form. 

### Customizing Access Checks in CMS Classes

see `[api:LeftAndMain]`
