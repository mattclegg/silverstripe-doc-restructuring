The code below provides you with the root parent of a page:

	:::php
	
		function FinalParent($page = null) {
			if(!$page){
				$page = $this;
			}
			if($page->ParentID > 0) {
				return $this->FinalParent($page->Parent());
			}
			else {
				return $page;
			}
		}
	

