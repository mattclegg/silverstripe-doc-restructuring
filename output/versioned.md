# Versioned

The Versioned class is a [DataObject](http://api.silverstripe.org/trunk/sapphire/model/DataObject.html) that adds
versioning and staging capabilities to the objects.

See the API documentation: http://api.silverstripe.org/trunk/sapphire/model/Versioned.html

### Trapping the publication event

Sometimes, you'll want to do something whenever a particular kind of page is published.  This example sends an email
whenever a blog entry has been published.

*SilverStripe 2.3*

	:::php
	class Page extends SiteTree {
	  // ...
	  function publish($fromStage, $toStage, $createNewVersion = false) {
	    mail("sam@silverstripe.com", "Blog published", "The blog has been published");
	    return $this->extension_instances['Versioned']->publish($fromStage, $toStage, $createNewVersion);
	  }
	}


*SilverStripe 2.4*

	:::php
	class Page extends SiteTree {
	  // ...
	  function onAfterPublish() {
	    mail("sam@silverstripe.com", "Blog published", "The blog has been published");
	    parent::onAfterPublish();
	  }
	}


