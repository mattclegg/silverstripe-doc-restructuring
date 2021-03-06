Scheduled tasks are tasks that are run at a certain time or set interval. For example, notify a page owner that their
page is about to expire.

Scheduled tasks are implemented as singleton instances and a single instance is responsibly directly or indirectly for
executing all tasks that should be run at that time.

There are three scheduled interval at the moment: Daily, Weekly and Monthly.

Implement a daily task by extending DailyTask and implementing process().

	:::php
	class MyTask extends DailyTask {
	    
	    function process() {
	      // implement your task here
	    }
	  }


You can also implement the index() method to overwrite which singleton classes are instantiated and processed. By
default, all subclasses of the task are instantiated and used. For the DailyTask class, this means that an instance of
each subclass of DailyTask will be created.

You can test your task from the command line by running:

''cli-script.php /`<MyTask>`

Where `<MyTask>` is the classname of your task. 

To perform all Daily tasks, run from the command line:

''cli-script.php /DailyTask''

Or, surf to URL ''http://mydomain.com/silverstripe/DailyTask''. Within the cron (or similar scheduler) configuration,
you can use one of these commands


*  ''wget 'http://mydomain.com/silverstripe/DailyTask'''

*  ''lynx -dump 'http://mydomain.com/silverstripe/DailyTask'''

*  ''w3m, elinks, elinks2, nc, telnet, ...''

You may also like to redirect output of these commands to ''/dev/null'' if you do not want to receive the emails from
''cron''.

Note, do it similarly for ''WeeklyTask'' and ''MonthlyTask''.

See [API Documentation](http://api.silverstripe.org/trunk/sapphire/ScheduledTask.html)
