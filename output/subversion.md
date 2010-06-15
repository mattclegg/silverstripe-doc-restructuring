# Introduction
Subversion ([website](http://subversion.tigris.org)) is our preferred **version control system** which is used for all code produced by SilverStripe and its community. You can browse our current "code repository" on [http://open.silverstripe.com/browser](http://open.silverstripe.com/browser).

This page only describes SilverStripe-specific information on how to handle subversion. For a general introduction, please read the [Official Subversion Book](http://svnbook.red-bean.com/) (available free online). Start with the ["Basic Usage" chapter](http://svnbook.red-bean.com/en/1.5/svn.tour.html).

## Clients
Make sure you have an updated [subversion client](http://subversion.tigris.org/links.html#clients) installed.  Subversion 1.5 or higher is required for features such as relative externals and merge tracking.
## Checkout / Download
See [http://silverstripe.org/download](http://silverstripe.org/download) and the ["Update your working copy" chapter](http://svnbook.red-bean.com/en/1.5/svn.tour.cycle.html#svn.tour.cycle.update).

## Committing
The SilverStripe core and modules require permission to commit code. Please have a look at our [contributors guidelines](contributors) to find out how you can gain access.

For technical information how to use the ''svn commit'' command, read the ["How to commit" chapter](http://svnbook.red-bean.com/en/1.5/svn.tour.cycle.html#svn.tour.cycle.commit) online.

### Tagging your messages

We try to maintain a consistent record of descriptive commit messages. As we automatically generate changelogs from them, we need a way to categorize and filter. Please prefix **all** commit messages with one of the following tags: API CHANGE, ENHANCEMENT, BUGFIX, or MINOR.

The first three are relatively self explanatory:

*  ''API CHANGE'': You've added or modified the functions available to developers writing custom PHP.
*  ''ENHANCEMENT'': You've added something to the user-visible aspects of SilverStripe.
*  ''BUGFIX'': You've fixed something that was broken.

But MINOR deserves a little more explanation.  The purpose of the MINOR message was to mark things that are so trivial they're not even worth telling users about; specifically, to prevent adding clutter to our automatically generated changelogs.

Some examples:

*  a subsequent commit to a bugfix/feature that you committed earlier that day
*  adding unit tests (that are more interesting to developers of SilverStripe than users of it)
*  subversion/codebase plumbing (changing externals, blocking revisions, moving files around, etc)

However, MINOR is not used to mark a minor bugfix or feature.  That should be marked as BUGFIX or ENHANCEMENT.  And it should certainly not be used to mark a minor API change.  That should be API CHANGE.

In summary: if it's worth including in the changelog, it's not MINOR.

### Further guidelines
*  Each commit should form a logical unit - if you fix two unrelated bugs, commit each one separately
*  If you are fixing a ticket from our [bugtracker](http://open.silverstripe.com), please reference it with ''#<ticketnumber>''
*  If your change is related to another changeset, reference it with ''r<revisionnumber>''. 
*  Please mention the changed classes and methods in your comment - the message should be understandable on its own without browsing any sourcecode

### Example: Bad commit message
~~~
finally fixed this dumb rendering bug that Joe talked about ... LOL
also added another form field for password validation
~~~

### Example: Good commit message
~~~
ENHANCEMENT Added prepValueForDB() which is called on DBField->writeToManipulation() to ensure formatting of value before insertion to DB on a per-DBField type basis (see #1234)
MINOR Added documentation for DBField->writeToManipulation() (see r55555)
~~~

### Configuring subversion for correct newline handling

You should configure your subversion client to set the ''svn:eol-style'' property to ''native'' on all text files checked into the system.  This will ensure that we don't run into troubles, getting non-unix newlines inside our repository.

To do this, edit your ''~/.subversion/config'' file on your development machine, and add the following settings.  Note that if you already have ''[miscellany]'' and ''[auto-props]'' sections, you should combine these settings with the existing sections, rather than doing a blind copy & paste to the end of the file.

~~~
[miscellany]
enable-auto-props = yes

### Section for configuring automatic properties.
[auto-props]
*.js = svn:eol-style=native
*.html = svn:eol-style=native
*.inc = svn:eol-style=native
*.css = svn:eol-style=native
*.php = svn:eol-style=native
*.xml = svn:eol-style=native
*.csv = svn:eol-style=native
*.htm = svn:eol-style=native
*.ini = svn:eol-style=native
*.json = svn:eol-style=native
*.php5 = svn:eol-style=native
*.py = svn:eol-style=native
*.ss = svn:eol-style=native
*.yml = svn:eol-style=native
*.yaml = svn:eol-style=native
*.xhtml = svn:eol-style=native
~~~

Note that if the repository gets out of whack, the following commands run on a linux box will correct things in the current working copy:

~~~
find | grep -v \._ | \
grep "\.\(js\|php\|css\|inc\|html\|html\|php5\|py\|json\|ini\|xml\|csv\)"\$ | \
xargs svn propset svn:eol-style native

find | grep -v \._ | \
grep "\.\(js\|php\|css\|inc\|html\|html\|php5\|py\|json\|ini\|xml\|csv\)"\$ | \
xargs dos2unix
~~~

## Patches
If you have fixed a bug in the SilverStripe core or a module on your local installation, you can submit this bugfix as a "patch"-file. The core team will then review your patch and most likely include it in further releases. See [submitting-patches](submitting-patches) for more information about this process.

You can create a patch file through the //svn diff//-command on the command-line. More info in the [svn redbook](http://svnbook.red-bean.com/en/1.1/ch03s05.html#svn-ch-3-sect-5.3.2). Note: Your code-editor might have a GUI for creating patches, (e.g. [Subclipse](http://subclipse.tigris.org/) provides "Team->Create Patch")

~~~
# in a working copy folder (e.g /myproject)
svn diff sapphire/ > ~/patch.diff
~~~

## Feature Branches
For more complicated bugfixes or longer-term development, submitting a patch might not cut it. For example, you might want to add support for other rich-text-editors within the CMS - a complex task which can't be contained in a single patch. Feature branches are a copy of our current ''trunk'', and usually have a short lifetime in which active development happens. **The feature branch maintainer is responsible for keeping his branch in sync with trunk and reintegrate when development is complete.**

More information about ["Feature Branches"](http://svnbook.red-bean.com/en/1.5/svn.branchmerge.commonpatterns.html#svn.branchmerge.commonpatterns.feature), [merging changes](http://svnbook.red-bean.com/en/1.5/svn.branchmerge.html) and [resolving conflicts](http://svnbook.red-bean.com/en/1.5/svn.tour.cycle.html#svn.tour.cycle.resolve).

You can contact the [core team](contributors) if you need us to set up a feature branch.

### Example: The 'nestedurls' branch
Example for a feature branch for the ''sapphire'' module called ''nestedurls''.

Creating the branch is a simple matter of running the ''svn cp'' command (this will most likely be done by the [core team](contributors) (see [SVN Book: "Creating a Branch"](http://svnbook.red-bean.com/en/1.5/svn.branchmerge.using.html#svn.branchmerge.using.create)).
~~~
svn cp http://svn.silverstripe.com/open/modules/sapphire/trunk http://svn.silverstripe.com/open/modules/sapphire/branches/nestedurls
~~~

After creating a feature branch, you commit your changes as usual, but also merge in any new changes from trunk (see [SVN Book: "Keeping your Branch in Sync"](http://svnbook.red-bean.com/en/1.5/svn.branchmerge.basicmerging.html#svn.branchemerge.basicmerging.stayinsync)).
~~~
cd /your/nestedurls/working/copy
svn merge http://svn.silverstripe.com/open/modules/sapphire/trunk
~~~

Once you've finished your feature development (usually a timeframe around 4-8 weeks), you "reintegrate" your branch with the trunk repository. This activity happens only once, and the feature branch has to be removed afterwards.
~~~
cd /your/trunk/working/copy
svn merge --reintegrate http://svn.silverstripe.com/open/modules/sapphire/branches/nestedurls
~~~

You can get information about the merge process (see [SVN Book: "Mergeinfo and Previews"](http://svnbook.red-bean.com/en/1.5/svn.branchmerge.basicmerging.html#svn.branchmerge.basicmerging.mergeinfo)).
~~~
cd /your/nestedurls/working/copy
# revisions which are you still have to merge from trunk to your branch
svn mergeinfo http://svn.silverstripe.com/open/modules/sapphire/trunk --show-revs eligible
# revisions which are already merged from trunk to your branch
svn mergeinfo http://svn.silverstripe.com/open/modules/sapphire/trunk
~~~

## Troubleshooting

## Related
*  [download](download)
*  [contributing](contributing)
*  [module-maintainers](module-maintainers)
*  [module-releases](module-releases)
