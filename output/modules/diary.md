# Introduction 

The Calendar module enables you to have an event calendars on your website. The features integrated in the module are as
follows.


*  To have **multiple calenders** on a website

*  **Easy navigation** with widgets and the calendars

*  To use the **same event in multiple calendars** 

*  **RSS enabled**

*  **i18n enabled**


# Requirements

Any SilverStripe 2.2.0 + version


# Downloading and Installing

 1.  Download the module from the module page,
[http://www.silverstripe.org/calendar/](http://www.silverstripe.org/calendar/)
 2.  Copy the module to your SilverStripe root directory and run the db/build
 3.  Flush the site ?flush=1
 4.  You will get a CalendarHolder page after this, and that is your calendar.


# Adding a calendar to your web site

You will just have to create a new page, select **CalendarHolder** from the list and click on the Create button

Not the **Number of items to display in the RSS reed** field, change this as you need, to set the number of events you
prefer to include in the RSS feeds.

## Adding new events to your calendar


Select the calendar page from your website back end. You will see a tab named Events, this is where you have to add all
the events to your calendar. Refer to the following image.

{{:add_event_calendar.gif|:add_event_calendar.gif}}

Fill the fields with relevant data, 

 1.  **Title of the event** - The title which will be displayed on the calendar
 2.  **Event Type** - The type or the category of the event, This will be used in the event types widget
 3.  **Starting Date** - the starting date of the event
 4.  **Ending Date** - the ending date of the event
 5.  **Start Time** - the starting time of the event
 6.  **End Time** - the ending time of the event
 7.  **Location** - the location of the event (eg: where the event is going to take place )
 8.  **About the Event** - This is the description of the event, here you can add HTML too,

## Ho do I register events with a calendar holder

After creating events, you have to register them with a calendar holder. To do this go to the calendar holder page from
the CMS Backend, go to the events tab and tick the events you need to register with the calendar holder, click on the
**Save & Publish** button.


## How do I localize my calendar?

This is fairly easy, first you will have to check that is the calendar has the relevant translation. If it is there just
add the following code to the /calendar/_config.php

	:::html
	<?php
	
		i18n::enable();
		i18n::set_locale('en_US');
	?>


**Replace your preferred language with the en_US** 

## Template Tags

There are some tags you will need to know when you customize the templates of the module.


*  `<% control getCalendar %>` - we can say that your calender is bundled in this controller, you will have to wrap all
other controllers with this. You can retrieve the month ($Month) and the year ($Year) inside this controller, which
calendar is displaying in this instance.

*  `<% control Days %>` - This must be always wrapped with the `<% control getCalendar %>`. This helps you to go through
each and every day of the month. The variables you have inside this controller are, $Day $Mon $Year and $Events, $Events
is the most important one, it shows all the events which are scheduled to a specif day.

*  `<% control Events %>` - This must be wrapped with the `<% control Days %>` controller. This controller returns you a
DataObjectSet of all the events which are scheduled for a specific day. 

*  **$RSSLink** - This returns a link to the RSS feed URL of your calendar.

*  `<% control getPreviousMonth %>` - This controller helps you to get a link for the previous month, you can use the
following variables there, $Link, $Name, $Title

*  `<% control getNextMonth %>` - This controller helps you to get a link for the next month and it very similar to the
`<% getPreviousMonth %>`, you can use the following variables there, $Link, $Name, $Title



**Following is a very simple example to show you how to use the above mentioned controllers.**

	:::html
	`<% control getCalendar %>`
		<h3>$Month $Year</h3>
		<ul id="Calendar">
			<% control Days %>	
				<li class="$oddeven">
					<div class="Day">
						$Date <br />
						<div class="more">
							$Day $Mon $Year
						</div>
					</div>
					<div class="Event">
						<% if Events %>
						<ul>
							<% control Events %>
								<li>
									<p class="Title">
										<a href="$ViewLink" title="View $Title Event">$Title</a> 
										| 
										<a href="$ViewTypeLink" title="View Events in $EventType">$EventType</a>
									</p>
									<p class="Duration">
										$Start.Nice till $End.Nice | From $StartTime.Nice to  $EndTime.Nice | at $Location
									</p>								
								</li>                            
							<% end_control %>
						</ul>
						<% end_if %>
					</div>				
				</li>
			<% end_control %>
		</ul>
	`<% end_control %>`


## Using widgets

There are two widgets bundled with the calendar module.

 1.  Calendar Widgets - A simple calendar which you can use in any of the page of you website. This widget can be used
in any web page just like any other widget.
 2.  Event Types Widget - A widget which displays all the event types. To use this widget other than the CalendarHolder
page you will have to add some code to your mysite/Page.php. Edit your Page.php like the following,

	:::html
	<?php
	
	class Page extends SiteTree {
		.......
	}
	
	class Page_Controller extends ContentController {
		function init() {
	             .......
		}
	
		function type(){
			Session::set("EventType",$_GET['name']);
			$cal = DataObject::get_one('CalendarHolder');
			Director::redirect($cal->URLSegment . "/");
		}
	
	        ........
	}
	
	?>
	



# To Do

 1.  Making the ADD popup more sophisticated, with a lite version of Tinymce, or something else which can do a better
job.
 2.  Introduce a collapse and expand option to the dates, as the page is too long now.
 3.  Translating the module, The module can be translated to any language
[http://nivanka.blogspot.com/](http://nivanka.blogspot.com/)
 4.  Enabling user subscribing facilities.



# Troubleshooting


*  If your calendar is not working properly, run the db/build?flush=1

*  If your changes to the templates are not working, flush the with ?flush=1

*  If you get and Errors, please see the de bugging tutorial. [[http://doc.silverstripe.com/doku.php?id=debugging
]]




