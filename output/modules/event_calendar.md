See also: [ Extending the calendar](http://doc.silverstripe.com/doku.php?id=recipes:extending_the_event_calendar&s=recipes%20calendar )

### Introduction

The Event Calendar module was developed to facilitate the display and creation of date-based content in Silverstripe from simple calendar announcements to complex events. It features:

    * A **highly configurable view** that can display any date range fed through the URL
    * Robust **UI tools** including a dynamic calendar for browsing date ranges
    * **Event filter form** with an API
    * **Repeating events** for just about any regular pattern
    * Built-in **microformat** compliance
    * Built-in ICS generation for calendar readers including **iCal** and **Google Calendar**
    * Built-in **RSS feed** generation
    * An **expandable codebase** that allows event, calendar, and date models to be customized for specific needs

{{:modules:calendar10.gif|:modules:calendar10.gif}}

### Requirements

Requires a minimum of 2.2.0 version of Silverstripe.





### Download
Module Installation

1. Download the //Event Calendar// module

2. After extraction, place the //event_calendar// folder at the root of your Silverstripe installation.

3. Run db/build?flush=1

4. The CMS should now have //Calendar// and //Calendar Event// page types.

#### Core Components

##### Calendar.php

This is the principal class that manages the **Calendar** page type. It contains many functions for getting //CalendarEvents//, browsing the calendar, and rendering UI components. Its only allowed children are //CalendarEvent//.

##### CalendarEvent.php

The //CalendarEvent// object is a subclass of Page that lives under a //Calendar// in the SiteTree. //CalendarEvent// objects will show up on the main Calendar view, but also have their own detail pages with custom templates.

##### CalendarDateTime.php

Contains all the Date and Time information for a //CalendarEvent//. One //CalendarEvent// may have many //CalendarDateTime// objects associated with it. The //CalendarDateTime// class is also responsible for handling a lot of the display functions including //$_Dates//, //$_ICSLink//, and //Microformat//.

##### CalendarUI.php

Contains UI components //CalendarWidget// and //MonthNavigator//

##### CalendarUtil.php

A static class that handles a lot of the commonly used date parsing or formatting tasks.

##### CalendarFilterFieldSet.php

A subclass of [FieldSet](FieldSet) used to contain [FormFields](FormFields) that are part of the [CalendarFilterForm](CalendarFilterForm).

##### RecurringDayOfWeek.php, RecurringDayOfMonth.php

Objects associated with //CalendarEvents// that repeat.

##### sfDate.class.php, sfDateTime.class.php, sfTime.class.php

The [sfDate](http://www.symfony-project.org/plugins/sfDateTimePlugin) plugin for Symfony has been decoupled from the PHP framework to work with the EventCalendar module. It contains many robust methods for manipulating dates and touts a very user-friendly API.


### Usage

You can pass any custom date range into the URL of any Calendar page using the Y-M-D format (with or without dashes). If you leave out part of the date, the Calendar will automatically set the missing components for you. Examples:

    * // www.mysite.com/my-calendar/2008-09-10/2008-09-12 // – shows all events from September 10, 2008 to September 12, 2008
    * // www.mysite.com/my-calendar/2008-04/2008-09 // – shows all events from April 1, 2008 to September 30, 2009
    * // www.mysite.com/my-calendar/2007/2008 // – shows all events from Jan 1, 2007 – December 31, 2008
    * // www.mysite.com/my-calendar/2008-10/2008-11-15 // – shows all events from Oct 1, 2008 to Nov 15, 2008
    * // www.mysite.com/my-calendar/2008-06-26/2009 // – shows all events from Jun 26, 2008 to Dec 31, 2009


### Calendar Creation

After you create a Calendar page, you will notice two unique tabs.

#### Configuration

Here you can set the default number of events to display on the calendar landing page. This is a fixed number of events that is not bound by months or years. This way, the default view of your calendar will always show a generous list of events, rather than being constrained by a specific month view.

#### Event Description Behavior

Each calendar varies in the amount of content that is associated with each event. For that reason, calendars have configurable behaviors for handling event descriptions. Users can choose from:

    * **Link to new page** - Clicking on the title will redirect to a detail page of the event using //CalendarEvent.ss// or a subtemplate thereof.
    * **Blind down** - The content of the event is not displayed initially, but clicking the title will expose its content via a javascript "blind down" effect.
    * **Show entire event description** - There is no detail page for the events. Each entry on the calendar shows the entire event description. 

{{:modules:calendar1.gif|:modules:calendar1.gif}}

#### Announcements

Sometimes, an event is so sparse with content, it may not be necessary to include it in the site tree as a whole new page. Announcements are designed to fulfill the need for lightweight calendar insertions such as “Thanksgiving – CLOSED” or “John’s birthday.” These are calendar items that do not need their own pages or lengthy content blocks.

{{:modules:calendar2.gif|:modules:calendar2.gif}}


### Event Creation

#### Dates and Time

An event is just like any other page type, only it has a //Dates and Times// tab. There, you can add any number of dates, consecutive or non-consecutive, to associate with the event.


##### Multiple Times

If there is more than one time associated with your event, just add a duplicate date with a different time. For instance, for an event on 10/31/2008 (US Format) with times of 1:00PM and 3:00PM, create two rows for 10/31/2008, and set one start time to 1:00PM and one to 3:00PM. The calendar will automatically collapse the date into one entry when viewed on the frontend.

{{:modules:calendar3.gif|:modules:calendar3.gif}}

#### Repeating an Event

If your event only has one day, you’ll be able to click the “Repeat this event” checkbox. This will expose some configuration options that will allow you to repeat an event at just about any regular pattern imaginable.

{{:modules:calendar4.gif|:modules:calendar4.gif}}

If there are any exceptions to the pattern, enter those dates in the Exceptions table below. For instance, if you have an event that occurs every other Thursday, and you’re in the US, you might want to add the date of Thanksgiving as an exception.

{{:modules:calendar9.gif|:modules:calendar9.gif}}


### Modifying the Template

The template that comes with the Event Calendar module is a good resource for all the tools you’ll need to create a customized template for your website.

#### The “Events” Control

The //Events// control is the engine that drives the list of dates on all calendar views. While it may seem like a simple database query, it actually does a lot of legwork behind the scenes to account for announcements and repeating events, parse date ranges passed through the URL, handle the event search form, etc. The most counter-intuitive characteristic of the //Events// control is that it does not return //CalendarEvent// objects. Because the calendar is date-centric, it returns //CalendarDateTime// objects. These objects can be inserted by a repeating event, announcement, or one or many dates associated with a //CalendarEvent//. Therefore, to access the Page properties of an entry in the calendar it is necessary to refer first to the related event. For example, //$Event.Title// or //$Event.URLSegment//.

//Note: $Event.Link is not necessary because the CalendarDateTime object has its own $Link method.
Other Controls//

    * **<% control UpcomingEvents %>** – shows events occurring after today with a limit specified in the first argument. Default count is same as Default Event Display as configured in your Calendar.
    * **<% control Recent Events %>** – same as //UpcomingEvents//, only for events that happened before today.
    * **<% control Times %>** – If your event has multiple times, use this control to loop through them. Otherwise, $StartTime and //$EndTime// will return the single time associated with the event. For flexibility, however, the control makes the most sense, as it will handle single as well as multiple times.
    * **<% control OtherDates %>** – A smart method that retrieves all the dates associated with the event other than the one that is currently being viewed. If the event repeats, it will get the next number of events as specified in the //Calendar// configuration.
    * <% control CurrentDate %> – Returns the //CalendarDateTime// object of the date that is currently being viewed.

#### Display logic

There are a number of functions available for the proper display logic in the template. Because the event description behavior can be configured in the CMS, it is often necessary to evaluate which of those options was chosen. These functions include //Blind, LinkTo, ShowAll, BlindOrLink, BlindOrShowAll, and ShowAllOrLink//. It is important to remember that once in a control statement, these controls are only available through the //CurrentPage// property. Example:

~~~ {html}
<% control Events %>
   <% if Announcement %>
  $Title
 <% else_if CurrentPage.BlindOrLink %>
       <a rel="toggle" href="$Link" class="toggle-$ID">$Event.Title</a>
   <% else %>
 $Event.Title
   <% end_if %>
<% end_control %>
~~~

//Note: Because it is commonly used the above logic can all be handled transparently by the $_Title method. (see magic methods)//

Also valuable is the //Announcement// boolean which will allow you to handle announcements differently than standard events. For example, you do not want to give an announcement a hyperlink, since it is not a page.

~~~ {html}
<% if Announcement %>
   $Description
<% else %>
   $Event.Content
<% end_if %>
~~~


### UI Components

There are a few UI tools bundled with the //EventCalendar// module to give your calendar a heightened user experience.

#### $CalendarWidget
– Based on a simple jQuery date picker, this javascript calendar has been expanded to allow day, week, and month selection for the displayed date range. It is stateful, date aware, and makes browsing the calendar quite snappy.

{{:modules:calendar5.gif|:modules:calendar5.gif}}

#### $CalendarFilterForm
– Renders a search form for your calendar. By default, it provides fields for start date and end date, but can be expanded to hold additional fields, as well.

{{:modules:calendar6.gif|:modules:calendar6.gif}}

#### $MonthNavigator
– Provides a dropdown menu of months to jump to. Redundant if //CalendarFilterForm// is used.

{{:modules:calendar7.gif|:modules:calendar7.gif}}

#### <% include CollapseAndExpand %>
- A separate include file that gives a calendar the functionality to show or hide all the event descriptions.

{{:modules:calendar8.gif|:modules:calendar8.gif}}

#### Helpful Variables

    * **$RSSLink** – returns a link to the RSS feed for the calendar.
    * **$ICSLink** – returns a link to download the calendar listing in .ics format (e.g. for adding to iCal or Google Calendar)
    * **$CalendarBackLink** – links to the //Calendar// page from a //CalendarEvent// detail page and will preserve the state of the calendar as influenced by any date range parameters passed through the URL.

#### Microformats

//Microformats// are increasingly popular XML data formats on the web that make the syndication of content easy using widely adopted standards. For more information, visit [microformats.org](microformats.org).

For the purposes of the //EventCalendar// module, the bulk of microformatting tasks are handled by the Magic methods in the //CalendarDateTime// class, however there are a few things a developer should be aware of when creating a custom template for your calendar.

    * Every event must be wrapped in a DIV tag with class //vevent//
    * Event titles must be wrapped in a header tag with class //summary//
    * Event description must be wrapped in a DIV tag with class //description//

#### “Magic” Methods

There are several “magic” methods in the //CalendarDateTime// class that help streamline a lot of the common display logic on the template. Identified by the //$_// prefix, magic methods also write out some of the markup that has specific requirements, such as microformats and the blind-down effect.

    * **$_Dates** – Returns a concise human-readable date range (e.g. Sep. 14-16, 2008, May 30 – Jun 3, 2008, Dec 28, 2008 – Jan 2, 2009) with proper microformat markup.
    * **$_Times** – Works the same as //$_Dates,// only for times, (e.g. 1:00 – 2:00 PM, 11:00 AM – 1:00 PM)
    * **$_Content** – Handles proper display of content based on the chosen //Event Description Behavior//. If the listing is an announcement, it will display the announcement description, otherwise it will show the related //CalendarEvent// Content field.
    * **$_Link** – Returns a clickable //CalendarEvent// title with the proper markup for the blind-down effect.
    * **$_Title** – Returns the title of the //CalendarEvent// or announcement with or without a link, depending on the Description Display Behavior as defined in your Calendar.
    * **{$_BEGIN_DESCRIPTION}** – Returns the appropriate markup for the div that holds an event description. Contains proper microformat class and an id for the blind-down effect.
    * **{$_END_DESCRIPTION}** – Closes the description DIV tag. Use for consistency on your template.


### Extending the Calendar

While the EventCalendar module is feature-rich on its own, it is intended to provide a starting point for a more customized calendar. Its easy-to-use API makes extending the calendar very simple. See [ Extending your Calendar](http://doc.silverstripe.com/doku.php?id=recipes:extending_the_event_calendar&s=recipes%20calendar ) for more information.

### Comments

Please raise issues, bugs, contributions in the silverstripe.com forum.

### To Do

#### European date format compliance

Add a static variable the CalendarDateTime class that determines US or European date format

#### More control over date display

Currently, the only date display available through the MagicDates method is M j, Y (in the PHP date() syntax).

#### Calendar date popup bug

If a CalendarDateField appears on a TableField and is later used on a ComplexTableField, clicking on the calendar icon will open a popup window throwing an error.


### Troubleshooting and Common Mistakes

If you have installed the EventCalendar module and you are not seeing events correctly on your calendar check the following:

1. Are event properties being accessed with the $Event accessor? E.g. $Event.Title, $Event.Content, etc?

2. Is the date range in your URL invalid? Proper format is YMD format with no dashes or spaces with leading zeros. For instance www.mysite.com/my-calendar/20081002/20081020 for date range October 2-20.

3. Did you set up a repeating event with a start date that is not part of the pattern? E.g. an event that is set up to repeat every Monday should not have a start date that is a Wednesday.

4. Rebuild the Silverstripe database with /db/build?flush=1

5. Flush the template cache with ?flush=1

