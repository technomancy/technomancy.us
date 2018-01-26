dnl -*- html -*-
define(__timestamp, 2007-10-13T07:00:01Z)dnl
define(__title, `timely plugin')dnl
define(__id, 76)dnl
include(header.html)
  <p>One of the things I've needed to do at work is provide a
  date/time picker for events. The datetime select stuff that's
  built-in to Rails is pretty pathetic in terms of UI. It gets the job
  done,  but it definitely gives the impression of scaffolding rather
  than the kind of polish that belongs in a final product.</p>

  <p>There's a neat-looking javascript calendar entry widget
  called <a href="http://datebocks.inimit.com/">Datebocks</a> that
  provides a nicer interface. It
  was <a
  href="http://atmos.org/2007/2/1/datebocks-as-a-plugin">packaged into
  a Rails plugin</a> by Corey Donohoe,  but his plugin was for dates
  only rather than dates and time. I made some modifications to it so
  it works with datetime as well. You should be able to just use it as
  a drop-in replacement after installing the plugin and
  running <kbd>rake calendar:assets:install</kbd>.</p>

  <p>Note that by default Datebocks allows you to choose from a number
  of date formats popular in different locales. The default is ISO
  format:  <i>yyyy-mm-dd HH: MM</i>,  but if you poke at the javascript, 
  you can adjust this. There is currently no way to adjust this on the
  Ruby side of things,  and my time additions only affect the default
  date format. There is some really ugly logic in the JS that
  discouraged me from doing a complete fix,  but it's really not much
  work to adjust if you need another date format. But really:  ISO date
  format should keep everyone happy; it's something fairly easy to
  agree upon.</p>

  <p>And because it always helps to have a sample: </p>

  <script src="http://technomancy.us/javascripts/prototype.js" type="text/javascript"></script>
  <script src="http://technomancy.us/javascripts/datebocks_engine.js" type="text/javascript"></script>
  <script src="http://technomancy.us/javascripts/calendar.js" type="text/javascript"></script>
  <script src="http://technomancy.us/javascripts/calendar-setup.js" type="text/javascript"></script>
  <script src="http://technomancy.us/javascripts/calendar-en.js" type="text/javascript"></script>
   <link href="http://technomancy.us/stylesheets/datebocks_engine.css" media="screen" rel="Stylesheet" type="text/css" />
   <link href="http://technomancy.us/stylesheets/calendar.css" media="screen" rel="Stylesheet" type="text/css" />

  <div id="dateBockstimer_dt" class="dateBocks">
    <ul>
      <li><input id="timer_dt" name="timer[dt]" onChange="magicDate('timer_dt');" onClick="this.select();" onKeyPress="magicDateOnlyOnSubmit('timer_dt',  event); return dateBocksKeyListener(event);" size="17" type="text" /></li>
      <li><img src='/i/icon-calendar.gif' alt='Calendar' id='timer_dtButton' style='cursor:  pointer; border:  0;' /></li>
      <li style='display:  none;'><img src='/i/icon-help.gif' alt='Help' id='timer_dtHelp' /></li>
    </ul>
    <div id="dateBocksMessagetimer_dt"><div id="timer_dtMsg"></div></div>
    <script type="text/javascript">
      $('timer_dtMsg').innerHTML = calendarFormatString;
      Calendar.setup({
      inputField     :     "timer_dt",         // id of the input field
      ifFormat       :     calendarIfFormatTime,      // format of the input field
      button         :     "timer_dtButton",   // trigger for the calendar (button ID)
      help           :     "timer_dtHelp",     // trigger for the help menu
      align          :     "Br",                      // alignment (defaults to "Bl")
      singleClick    :     true, 
      showsTime      :     true
      });
    </script>
  </div>

<p>In closing,  I link to <a href="http://www.beigerecords.com/cory/pizza_party/">Pizza Party</a>,  a unix tool for ordering pizza.</p>


include(footer.html)
