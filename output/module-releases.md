# Module Release Procedures
If you are a [module maintainer](module-maintainers), you will be responsible for creating new releases of the module.
### Version Control
Each line of code you write should be version controlled. We provide free subversion hosting for SilverStripe-specific projects on [http://open.silverstripe.com](http://open.silverstripe.com), but you're free to host on other subversion infrastructure as well. You can contact the [core team](contributors) to get you started  (read more about [version control](http://producingoss.com/en/vc.html)).

### Release Branches
In order to ensure stability, the first thing we do when making a release is to create a release branch.  This branch will exist for the duration of the testing and release candidate phase.  The key is that **you should only commit bugfixes to this branch**.  This lets you focus on getting a stable version of module ready for release, and new features can still be added to trunk.

Creating a release branch is a simple "svn cp" command.  In the example below, (modulename) would be something like "ecommerce" or "flickrservice", and (releasenumber) would be something like "0.2.1" (see [Producing OSS: Release Numbering](http://producingoss.com/en/development-cycle.html#release-numbering))

~~~
svn cp http://svn.silverstripe.com/open/modules/(modulename)/trunk http://svn.silverstripe.com/open/modules/(modulename)/branches/(releasenumber)
~~~

Once you have created a release branch, you should do some testing of the module yourself.  Try installing it on a new site, and existing site, use the different features, and if possible, install on a couple of different servers.

See [SVN Book: "Release Branches"](http://svnbook.red-bean.com/en/1.5/svn.branchmerge.commonpatterns.html#svn.branchmerge.commonpatterns.release), [Producing OSS: "Release Branches"](http://producingoss.com/en/release-branches.html) and [Producing OSS: "Stabilizing a release"](http://producingoss.com/en/stabilizing-a-release.html) for more details.

### Release Candidates

Once you've done your own testing, it's time to create a release candidate (RC).  This is a copy of your module that will be sent to the developer community for testing and feedback. Creating a release candidate is a matter of executing a "svn cp" command.

Note: If you are the only developer on the module, and you aren't going to be creating any new features for the duration of the release cycle, then you can get away with creating your RCs directly from trunk instead of creating a release branch. For major modules, we advise against this, but for very simple modules, going through the whole release process might be overkill.

~~~
svn cp http://svn.silverstripe.com/open/modules/(modulename)/branches/(releasenumber) http://svn.silverstripe.com/open/modules/(modulename)/tags/rc/(releasenumber)-rc1
svn co http://svn.silverstripe.com/open/modules/(modulename)/tags/rc/(releasenumber)-rc1 (modulename)
tar czf (modulename)_(releasenumber)-rc1.tar.gz (modulename)
~~~

See ["ReleaseBranches" chapter]([[http///svnbook.red-bean.com/en/1.5/svn.branchmerge.commonpatterns.html#svn.branchmerge.commonpatterns.release) and ["Tags" chapter](http://svnbook.red-bean.com/en/1.5/svn.branchmerge.tags.html).

### Stabilizing A Release
After you have put a release candidate out for testing and no-one has found any bugs that would prevent a release, you can create the stable release! Please: **The stable release should always be a copy of a release candidate**.  Even if "there's just one tiny bug to fix", you shouldn't release that bug fix onto a stable release - there is always the risk that you inadvertently broke something! As you might guess, "svn cp" is used to create the final release, and then an export to a tar.gz.

~~~
svn cp http://svn.silverstripe.com/open/modules/(modulename)/tags/rc/(releasenumber)-rc2  http://svn.silverstripe.com/open/modules/(modulename)/tags/(releasenumber)
svn export http://svn.silverstripe.com/open/modules/(modulename)/tags/(releasenumber) (modulename)
tar czf (modulename)_(releasenumber).tar.gz (modulename)
~~~

### Announcing a Release or Release Candidate
*  See [Producing OSS: "Announcing Releases"](http://producingoss.com/en/testing-and-releasing.html#release-announcement)
*  Update your [documentation](#documentation) in the sourcecode, wiki and README
*  Notify the [core team](contributors) about the release
*  Create a tarball archive of your release, for example flickrservice_0.2.1-rc1.tar.gz.
*  Send this archive to the [core team](module-maintainers) and we will upload it to silverstripe.com
*  Announce the release on [silverstripe-announce](http://groups.google.com/group/silverstripe-announce).  Include a [changelog](#changelogs), the download link and instructions for filing bug reports.
*  If this release is a major release, our [marketing guys](http://silverstripe.com/contact/) will strive to announce it on the main [silverstripe.com blog](http://silverstripe.com/blog) as well


### Feedback and Bugtracking
Generally speaking, bug reports should be sent to open.silverstripe.com.  You should provide a link in the form of http://open.silverstripe.com/newticket?field_component=Modules+-+forum; this will automatically populate the "component" dropdown with your module name.

If the user community finds bugs that shouldn't be included in the next stable release, you will need to release another release candidate.  If your release candidate is found to be stable, then you can create the stable release.

### Documentation
You should have both ''developer documentation'' and ''user documentation'', and keep them updated with your releases. Feel free to use the "modules" namespace on our [documetation wiki](http://doc.silverstripe.com/doku.php?id=modules) for your module documentation. See [Producing OSS: "Documentation"](http://producingoss.com/en/getting-started.html#documentation).

### Readme
Each module should have a README.md file in the project root in [markdown format](http://daringfireball.net/projects/markdown/), roughly following this template:
~~~
# <MODULENAME> Module

## Maintainer Contact

 * <FULLNAME> (Nickname: <NICKNAME>)
   <EMAIL>

## Requirements

 * <Specific SilverStripe version, PHP, MySQL, ...>

## Documentation

<Links to the wiki, blog posts, etc>

## Installation Instructions

<Step by step instructions>

## Usage Overview

<Highlevel usage, refer to wiki documentation for details>

## Known issues

<Popular issues, how to solve them, and links to tickets in the bugtracker>
~~~

### Changelogs
Each release you make should contain CHANGELOG file in the project root with a highlevel overview of additions and bugfixes in this release. The ''svn log'' command gives you all commit messages for a specific project, and is a good start to build a changelog (see ["Examining historical changes" chapter](http://svnbook.red-bean.com/en/1.5/svn.tour.history.html)). Depending on the volume of changes, it is preferred that you summarize these messages in a more "digestible" form (see [[http://producingoss.com/en/packaging.html#changelog|Producing OSS: "Changes vs. Changelog").

A good CHANGELOG example from the subversion project itself:
~~~
Version 1.5.2
(29 Aug 2008, from /branches/1.5.x)
http://svn.collab.net/repos/svn/tags/1.5.2

 User-visible changes:
  * Set correct permissions on created fsfs shards (r32355, -7)
  * Pass client capabilities to start-commit hook (issue #3255)
  * Disallow creating nested repositories (issue #3269)

 Developer-visible changes:
  * make libsvn_ra_neon initialization thread-safe (r32497, r32510)

Version 1.5.1
(24 Jul 2008, from /branches/1.5.x)
http://svn.collab.net/repos/svn/tags/1.5.1

...
~~~


### Release Branch Maintenance
This is also the time to remove the release branch from the subversion tree - we don't want to have lots of branches on the source tree to confuse everyone.  However, before you do this, you will need to merge your changes back to the trunk.
