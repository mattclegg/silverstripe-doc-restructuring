## Introduction
The calendar module has been done to display a calendar in different views but also to be able to insert events.
The user can also manage easily which view and content to see at the first loading.

To navigate easily in a view, a navigation bar has been created. You also have the possibility to easily change of view thanks to a view bar.

## Download
*  (No release yet)
*  [Daily Build](http://open.silverstripe.com/changeset/latest/modules/calendar/trunk?old_path=/&filename=/modules/calendar/trunk&format=zip) ("trunk")

## Calendar Creation
To create a calendar and to show it on your website, you need to create it in a function and call this function from your template.

To create a calendar to see all the months of this year ( year view ), you need to add this code :

** mysite/code/Page.php **

~~~ {php}
class Page extends SiteTree {

    ...

    function Calendar() {
        return new CalendarYear( $this );
    }

}
~~~


** mysite/templates/Layout/Page.ss **

~~~ {html}
    ...

    $Calendar

    ...
~~~

**__Views__**

 | View  | Class         | Optional Parameters | 
 | ----  | -----         | ------------------- | 
 | Year  | CalendarYear  | year                | 
 | Month | CalendarMonth | year, month         | 
 | Week  | CalendarWeek  | year, week          | 
 | Day   | CalendarDay   | year, month, day    | 

By default, if you don't specify the optional parameters, the calendar will show the actual year, month, week or day.




## Calendar Navigation

To easily navigate in your view, eather you create your own html code by using the functions //PrevLink// and //NextLink// on your calendar object or you can put a default navigation bar directly in you template by adding this code :

~~~ {html}
    ...

    $Calendar
    $Calendar.NavigationBar

    ...
~~~

To navigate from a view to another view, you can do your own html code or put directly this code in your template to see the default view bar of the calendar module :

~~~ {html}
    ...

    $Calendar
    $Calendar.NavigationBar
    $Calendar.ViewBar

    ...
~~~

You will notice that by default, you can access the four different views from the view bar and you can also access the month and day view from the year and month view.

However, if you want to remove some views ( day and month for example ), you have to add this code in your php code :

~~~ {php}
class Page extends SiteTree {

    ...

    function Calendar() {
        $calendar = new CalendarYear( $this );
        $calendar->removeViews( array( 'day', 'month' ) );
        return $calendar;
    }

}
~~~

You have just removed the month and day views but you will notice that you can easily access them by changing the parameter view.
To fix this problem, just add this code in your template :

~~~ {html}
    ...

    <% if Calendar.IsViewAllowed %>
        $Calendar
        $Calendar.NavigationBar
        $Calendar.ViewBar
    <% end_if %>

    ...
~~~





## Week And Day Views Settings
As for this two views, you can change the time period starting, ending and length thanks to this methods :

~~~ {php}
class Page extends SiteTree {

    ...

    function Calendar() {
        $calendar = new CalendarYear( $this );
        $calendar->removeViews( array( 'day', 'month' ) );
        $calendar->setPeriodStartParams( array( 'hours' => 8, 'minutes' => 30 ) );
	$calendar->setPeriodEndParams( array( 'hours' => 19, 'minutes' => 0, 'seconds' => 0 ) );
	$calendar->setPeriodLengthParams( array( 'hours' => 1, 'minutes' => 15 ) );
        return $calendar;
    }

}
~~~

During the development of the day view, you will be able to sort the events by categorie. The first step is to add the categories :

~~~ {php}
class Page extends SiteTree {

    ...

    function Calendar() {
        $calendar = new CalendarYear( $this );
        $calendar->removeViews( array( 'day', 'month' ) );
        $calendar->setPeriodStartParams( array( 'hours' => 8, 'minutes' => 30 ) );
	$calendar->setPeriodEndParams( array( 'hours' => 19, 'minutes' => 0, 'seconds' => 0 ) );
	$calendar->setPeriodLengthParams( array( 'hours' => 1, 'minutes' => 15 ) );
        $calendar->addCategories( array( 'SilverStripe Meetings', 'Project Management', 'Project Development', 'Conferences' ) );
        return $calendar;
    }

}
~~~

## Future extensions
*  Multi Year, Month, Week and Day View creation
*  Link redirection from a calendar to another
*  Periods deleting for the Week and Day views
*  Event integration
