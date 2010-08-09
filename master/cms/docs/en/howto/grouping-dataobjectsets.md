Grouping Data Object Sets
=========================

The [api:DataObjectSet] class has a number of methods useful for grouping objects by fields. Together with sorting this
can be used to break up long lists of data into more manageable sub-sections.

The [api:DataObjectSet->groupBy()] method takes a field name as the single argument, and breaks the set up into a number
of arrays, where each array contains only objects with the same value of that field. The [api:DataObjectSet->GroupedBy()]
method builds on this and returns the same data in a template-friendly format.

Grouping Sets By First Letter
-----------------------------

This example deals with breaking up a [api:DataObjectSet] into sub-headings by the first letter.

Let's say you have a set of Module objects, each representing a SilverStripe module, and you want to output a list of
these in alphabetical order, with each letter as a heading; something like the following list:

	*	B
		* Blog
	*	C
		* CMS Workflow
		* Custom Translations
	*	D
		* Database Plumber
		* ...

The first step is to set up the basic data model, along with a method that returns the first letter of the title. This
will be used both for grouping and for the title in the template.

	:::php
	class Module extends DataObject {
	
		public static $db = array(
			'Title' => 'Varchar(255)'
		);
	
		// ...
	
		/**
		 * Returns the first letter of the module title, used for grouping.
		 *
		 * @return string
		 */
		public function getFirstLetter() {
			return $this->Title[0];
		}
	
	}

The next step is to create a method or variable that will contain/return all the Module objects, sorted by title. For
this example this will be a method on the Page class.

	:::php
	class Page extends SiteTree {
	
		// ...
	
		/**
		 * Returns all modules, sorted by their title.
		 *
		 * @return DataObjectSet
		 */
		public function getModules() {
			return DataObject::get('Module', null, '"Title"');
		}
	
	}

The final step is to render this into a template. The [api:DataObjectSet->GroupedBy()] method breaks up the set into
a number of sets, grouped by the field that is passed as the parameter. In this case, the getFirstLetter method defined
earlier is used to break them up.

	:::ss
	<h2>Modules</h2>
	<% control Modules.GroupedBy(FirstLetter) %>
		<h3>$Children.First.FirstLetter</h3>
		<ul>
			<% control Children %>
				<li>$Title</li>
			<% end_control %>
		</ul>
	<% end_control %>

Grouping Sets By Month
----------------------

Grouping a set by month is a very similar process. The only difference would be to sort the records by month name, and
then create a method on the DataObject that returns the month name, and pass that to the GroupedBy call.