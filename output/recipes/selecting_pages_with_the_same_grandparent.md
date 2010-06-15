To get pages with the same grandparent, you can use the following code:

~~~ {php}
function SiblingsCousins() {
 return DataObject::get(
 $className = "SiteTree",
 $where = "Parent.ParentID = ".$this->Parent()->ParentID,
 $orderBy = "Parent.Sort, Sort",
 $join = "
   LEFT JOIN `SiteTree_Live` as Parent On `Parent`.`ID` = `SiteTree_Live`.`ParentID`
  "
);
~~~

To get pages with the same great-grandparent, you can use the following code:

~~~ {php}
function SiblingsAndCousinsAndFirstCousins() {
 return DataObject::get(
 $className = "SiteTree",
 $where = "GrandParent.ParentID = ".$this->Parent()->Parent()->ParentID,
 $orderBy = "GrandParent.Sort, Parent.Sort, Sort",
 $join = "
   LEFT JOIN `SiteTree_Live` as Parent On `Parent`.`ID` = `SiteTree_Live`.`ParentID`
   LEFT JOIN `SiteTree_Live` as GrandParent ON  `GrandParent`.`ID` = `Parent`.`ParentID`
 "
);
~~~


