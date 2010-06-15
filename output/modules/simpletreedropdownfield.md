### Introduction

The SimpleTreeDropdownField comes with the [DataObjectManager](DataObjectManager) package in order to allow hierarchical select fields in popup windows. It is a non-javascript, lightweight alternative to the [TreeDropdownField](TreeDropdownField).

### Usage

The SimpleTreeDropdownField takes the arguments $Name, $Title, and $sourceClass (defaults to "SiteTree").
~~~ {php}
new SimpleTreeDropdownField('Page','Select a Page')

// Returns a hierarchical dropdown of the SiteTree

new SimpleTreeDropdownField('Folder','Select a Folder', 'Folder')

// Returns a hierarchical dropdown of the folders in assets.


~~~

### Screenshot
{{:simpletreedropdownfield.gif|:simpletreedropdownfield.gif}}
