dnl -*- html -*-
define(__timestamp, 2006-06-21T21:14:18Z)dnl
define(__title, `after railsday')dnl
define(__id, 48)dnl
include(header.html)
<p>OK,  Concourse has gotten significantly better in the past few days. If there were a Railsday prize for most-improved-project-since-Railsday,  we would definitely be one of the top contenders. The time-choosing code could use some heavy refactoring,  and it doesn't quite send emails at all the right times yet,  but it'll probably be functional before RailsConf ends at the latest. You can reach the subversion code repository at <kbd>http://phil.hagelb.org/concourse</kbd>.</p>
<p>To really qualify as Web-2.0 you need a snappy domain name,  so I registered <kbd>concour.se</kbd> from <a href='http://loopia.se'>Loopia.se</a> with the help of a good web translator and <a href='http://jw.fi'>unfo-</a> from #caboose.</p>
<p>One of the most interesting things about the development was that the data model stayed rather stable almost the whole time. We only had one migration,  and that was to change the data types from datetime to date. But then in the last half hour we had a huge change in how we stored things.</p>
<p>There is an attendances field that records a user's attendance to a meeting. It has a serialized field called 'times' that was originally meant to store a custom data type I would code called a Noncontinuous Range. (Ranges in Ruby are good for storing time ranges,  but we needed to be able to have multiple non-overlapping ranges in a single day and perform set operations (the intersect of Quentin's range and Arthur's range,  for example) that I wanted to code into this class.)</p>
<p>In the last half hour of the contest we came to the conclusion that storing an array of hours would be a lot easier to interface with the Javascript,  since it would just return time information structured that way. Surprisingly enough,  I was able to make that change with time to spare,  even though it was such a core part of our application. I think this is really a testament to the merits of a strong test suite than anything else&mdash;we had a 1:0.8 code-to-test ratio.</p>
<p>Anyway,  I hope you'll try Concourse out. It won't solve your problems quite yet until I can configure ActionMailer on DreamHost,  but hopefully it will be useful very soon.</p>
<p>Tomorrow I'll be getting on the plane to Chicago for RailsConf. It should be very interesting; I'll post thoughts and photos.</p>
include(footer.html)
