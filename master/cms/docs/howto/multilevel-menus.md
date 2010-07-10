Below is a good example of a menu. It can be used for two levels of nesting. Beyond that, you'll probably need to create functionality to recursively generate templating based on the level your pages are in.

What's special about this? We're using `<% if LinkingMode = current %>` to find out what the current page you're on in the menu is. We then make that item in the menu a `<span>` element, so it isn't clickable (since you shouldn't be able to click on the page you're currently on).

Menu items are also abstracted, so you're not relying on a certain element to be there, like a `<span>` or `<a>`. The abstracted item has a class name of `.item`, so you style menu items using the class instead of the element.

	:::html
	<% if Menu(2) %>
		<ul id="Menu2">
			<% control Menu(2) %>
			<li class="$LinkingMode<% if FirstLast %> $FirstLast<% end_if %>">
				<% if LinkingMode = current %>
					<span class="item selected">$MenuTitle</span>
				<% else %>				
					<a class="item" href="$Link" title="View more on $Title">$MenuTitle</a>
				<% end_if %>
				<% if Children %>
					<% if LinkingMode = section %>
						<ul id="Menu3">
							<% control Children %>
							<li class="$LinkingMode<% if FirstLast %> $FirstLast<% end_if %>">
								<% if LinkingMode = current %>
									<span class="item selected">$MenuTitle</span>
								<% else %>
									<a class="item" href="$Link" title="View more on $Title">$MenuTitle</a>
								<% end_if %>
							</li>
							<% end_control %>
						</ul>
					<% end_if %>
				<% end_if %>
			</li>
			<% end_control %>
		</ul>
	<% end_if %>