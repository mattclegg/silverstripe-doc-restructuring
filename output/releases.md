# Current Release Plans
See our [roadmap on open.silverstripe.com](http://open.silverstripe.com/roadmap) for the most up-to-date release plans, and our [development plans](http://open.silverstripe.com/wiki/development) for ideas and further development directions.

## SilverStripe Core Release Process

### Trunk Development
The main development of new features is done on the ''trunk''.  We should always test code before we submit it to trunk, but we can allow more pervasive changes to the sysetm.

### Release Branch
Some time before the first release candidate is due to be released, we copy trunk into branches/(release-number).  After this point, we focus on rigorous testing, and only making bugfixes and changes with a very low chance of cross-upgrade issues.

### Release candidate cycle
Once the core team feel that the system is ready for the review of the wider community, we release the first release candidate ("RC").

We then have a cycle of:
*  Community raises bugs they find in http://open.silverstripe.com/
*  We triage and fix the bugs

### Production release
When we have fixed all of the bugs necessary for a production release, we make the production release.  The production release must be an identical copy of the latest RC.  If you need to fix something, no matter how small, then you have to do another RC.

### Testing
Testing is a vital part of the releases, how to they get tested?

*  To do: put together a more formal test plan.
*  Test upgrading on dev/test/live environment types.
*  Test related systems such as backups and publishsite.

### Publishing A Release

*  Publish them to http://www.silverstripe.com
    * .tar.gz containing self-installing PHP code
    * .exe containing specific WAMP-server
*  Announce on silverstripe-announce@groups.google.com
*  Major releases may be blogged about or announced in the monthly newsletter.

## Modules Release Process
If you want to know how to go about releasing a module, see [module-releases](module-releases).

# Related
*  [Roadmap on Trac](http://open.silverstripe.com/roadmap)
*  [Development Plans](http://open.silverstripe.com/wiki/development)
