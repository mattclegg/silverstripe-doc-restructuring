# Sphinx Search

Sphinx Search is an advanced full text search indexer daemon. This module (fairly) seamlessly integrates Sphinx Search with SilverStripe to offer an alternative to the built in full-text search

### Advantages over full-text search

*  Faster
*  More accurate, more relevant results
*  Understands language - gives results containing jumped when searching for jumping
*  Able to search any DataObject, including a specific subclass, not just SiteTree and Files
*  Able to filter results during search on other fields and relations

### Disadvantages over regular full-text search

*  Requires external binaries to be installed (not suitable for shared hosting)
*  Extra daemon means extra memory and harddisk space requirements
*  Sphinx Search is distributed under the GPL, not a BSD derivative like SilverStripe

### Licensing

The file sphinxapi.php is the official php client for Sphinx, and is distributed under the GPL. We have email confirmation from the Sphinx developers that we can include sphinxapi.php in SilverStripe under a license similar to Sun's MySQL FOSS exception - that is, the file itself remains under GPL, but distribution within SilverStripe is OK without SilverStripe needing to be distributed under the GPL.  

Thanks to Andrew Aksyonoff and everyone involved in Sphinx

### Quick Usage Overview

Install sphinx. This module currently required Sphinx 0.9.9-rc2 or better with 64bit document identifiers enabled.

Add the SphinxSearchable decorator to any DataObjects you want to search (for example, SiteTree and File)

Use SphinxSearchForm instead of SearchForm

For more complex searching use SphinxSearch::search directly

### API

Six parts to this module

Sphinx - manages the searchd and indexer binaries, generating configuration files for them, starting and stopping them as needed. Use as both a controller and a singleton

SphinxSearch - handles performing actual searches

SphinxSearchable - decorator that handles introspection of DataObjects, and adds a couple of utility functions to DataObjects

SphinxVariants - handles altering index building and searching to account for things like Versioned and Subsites adjusting the access semantics

SphinxSearchForm - provides a SearchForm-a-like, using Sphinx instead of database specific full-text search

PSpell - pure php spellchecker to provide 'Did you mean?' functionality

