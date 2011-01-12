Here is how to add a class to pages that are "members only".  Add the following to your Page Class:

	:::php
		function IsMembersOnlyPage() {
			if($this->CanViewType == 'Inherit') {
				if($this->ParentID) {
					return $this->Parent()->IsMembersOnlyPage();
				}
				else {
					return false;
				}
			}
			elseif('LoggedInUsers' == $this->CanViewType || "OnlyTheseUsers" == $this->CanViewType ) {
				return true;
			}
			else {
				return false;
			}
		}
	
	


now you can amend your Page.ss template in the following way:

	:::html
	`<body class=" <% if IsMembersOnlyPage %>` MembersOnlyPage `<% else %>` IsNOTMembersOnlyPage `<% end_if %>` ">

