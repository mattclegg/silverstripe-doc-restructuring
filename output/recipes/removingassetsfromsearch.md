Below is a small variation on the standard search (see [Tutorial 4: Site Search](tutorial/4-site-search) for an implementation of this search form)

~~~ {php}

 function results($data, $form){
  $data = array(
   'Results' => $form->getResults(),
   'Query' => $form->getSearchQuery(),
   'Title' => 'Search Results'
  );
  foreach($data["Results"] as $page) {
   if($page->Filename) {
    $data["Results"]->remove($page);
   }
  }
  return $this->customise($data)->renderWith(array('SearchResults', 'Page'));
 }

~~~
