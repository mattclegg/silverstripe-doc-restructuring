here is an example of how to build a sitetree for pages with a selected parameter.  In your PHP you will need to
functions in the Page class:

	:::php
	 function HasChildrenWithInterestingStuff() {
		function HasChildrenWithInterestingStuff ($page = null) {
			if(!$page) {
				$page = $this;
			}
			if($children = $page->Children()) {
				foreach($children as $child) {
					if($child->HasInterestingStuff()) {
						return true;
					}
					else {
						if($child->Children()) {
							return $this->HasChildrenWithInterestingStuff ($child);
						}
					}
				}
			}
		}
	 }
	 function HasInterestingStuff () {
	   //return true if this or that - you can change this in the different extensions of Page
	 }


Here is the template stuff

	:::html
	
	`<ul id="InterestingList">`
		<% control Menu(1) %><% if ClassName = StaySeeDoIntroPage %>
		<li><a class="Level1 $LinkOrSection" href="$SuperLink" title="Go to the $SuperTitle.ATT page">$SuperTitle</a>
			<% if Children %>
			<ul><% control Children %>
				<li>
					<% if HasChildrenWithInterestingStuff %><a href="#" class="expand" title="see more specific options">+</a><% end_if %>
					<% if HasInterestingStuff %><a class="Level2 $LinkOrSection" href="$Link" title="Go to the $MenuTitle.ATT page">$MenuTitle</a>
					<% else %><% if Children %>$Title<% end_if %>
					<% end_if %><% if HasChildrenWithInterestingStuff %>
					<ul><% control Children %>
						<li>
							<% if HasChildrenWithInterestingStuff %><a href="#" class="expand" title="see more specific options">+</a><% end_if %>
							<% if HasInterestingStuff %><a class="Level3 $LinkOrSection" href="$Link" title="Go to the $MenuTitle.ATT page">$MenuTitle</a>
							<% else %><% if Children %>$Title<% end_if %>
							<% end_if %><% if HasChildrenWithInterestingStuff %>
							<ul><% control Children %>
								<li>
									<% if HasChildrenWithInterestingStuff %><a href="#" class="expand" title="see more specific options">+</a><% end_if %>
									<% if HasInterestingStuff %><a class="Level4 $LinkOrSection" href="$Link" title="Go to the $MenuTitle.ATT page">$MenuTitle</a>
									<% else %><% if Children %>$Title<% end_if %>
									<% end_if %><% if HasChildrenWithInterestingStuff %>
									<ul><% control Children %>
										<li><% if HasInterestingStuff %><a class="Level5 $LinkOrSection" href="$Link" title="Go to the $MenuTitle.ATT page">$MenuTitle</a><% end_if %></li>
										<% end_control %>
									</ul><% end_if %>
								<% if HasInterestingStuff %></li><% else %><% if Children %></li><% end_if %><% end_if %><% end_control %>
							</ul><% end_if %>
						<% if HasInterestingStuff %></li><% else %><% if Children %></li><% end_if %><% end_if %><% end_control %>
					</ul><% end_if %>
				<% if HasInterestingStuff %></li><% else %><% if Children %></li><% end_if %><% end_if %><% end_control %>
			</ul><% end_if %>
		</li>
		<% end_if %><% end_control %>
	`</ul>`


The javascript that you can use with this

`</code>`


and here is the Javascript stuff (assumes you have jQuery loaded):

	:::javascript
	jQuery('body').ready(function() {InterestingList.init();});
	
	InterestingList= {
	
		parentID: "InterestingList",
	
		init: function() {
			jQuery("#" + InterestingList.parentID + " ul li ul").each(
				function(i) {
					jQuery(this).hide();
				}
			);
			jQuery("#" + InterestingList.parentID + " a.expand").click(
				function() {
					var a = this;
					jQuery(this).parent().children("ul").slideToggle(
						function() {
							if(jQuery(this).is(":hidden")) {
								jQuery(a).text("+").addClass("childrenClosed").removeClass("childrenOpen");
							}
							else {
								jQuery(a).text("-").addClass("childrenOpen").removeClass("childrenClosed");
							}
						}
					);
				}
			);
		}
	
	}


