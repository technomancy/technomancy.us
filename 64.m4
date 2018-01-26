dnl -*- html -*-
define(__timestamp, 2006-10-24T07:00:01Z)dnl
define(__title, `sixth rubyconf recap')dnl
define(__id, 64)dnl
include(header.html)
<p>Just finished up RubyConf yesterday; it was most excellent. There
  were tons of quality talks,  and of course it's always fun to let
  yourself go and totally geek out. Last year I had Planet RubyConf
  set up,  but this year I got a late start and wasn't able to gather
  enough feeds to really do anything
  interesting. Luckily <a
  href="http://blog.nicksieger.com/articles/tag/rubyconf2006">Nick
  Sieger</a> was able to liveblog with astonishing prolificicity,  and
  the horde in #rubyconf
  was <a href="http://ni.hili.st/posts/pages/16">tumblelogging</a>
  like they were infected with a tumbleness disorder. Much fun and
  good-natured heckling was to be had. (Tip:  don't be That Guy.)</p>

<img src="/i/rubyconf06.png" alt="rubyconf 06 Denver logo" class="right"/>

<p><a
  href="http://arko.net/2006/6/26/rails-core-q-amp-a-session">Obligatory</a>
  out-of-context quotes that attendees will have a jolly belly-laugh
  at and everyone else will scratch their heads reading: </p>

<ul>
  <li>Fact:  One time this programmer posted profiling data without
  noting his standard deviation,  and Zed Shaw vaporized him from
  across the room.</li>
  <li>"We tell the computer to do something and it does it. We tell
  people to do something,  and they don't. That's why we like computers
    better than people." - Forrest Chang</li>
  <li>Fact:  Zed Shaw's code profiles itself.</li>
  <li>"Take us to mongrel factor 9. But Sir,  Zed said that we do not
  need 9 mongrels!" - Adam Keyes</li>
  <li>Fact:  Zed Shaw is so awesome that he uses Chad Fowler as a
    remote control.</li>
  <li>"One of the more exciting things about Vista is its security is
    really good." - XAMLchick</li>
  <li>Fact:  Zed Shaw runs his production apps out of irb.</li>
  <li>"Myths:  YARV finds your girlfriend." - SASADA Koichi</li>
  <li>Fact:  Zed Shaw writes code using every single one of those
    250,000 [unicode] characters.</li>
  <li>"Hello Joe." "Hello Mike."</li>
  <li>Fact:  Zed Shaw rfuzzed your girlfriend.</li>
</ul>

<p>(The next time Zed is looking for a job his interviewers are going
  to have a blast poking around on Google. I think it'll improve his
  chances though; most teams would be improved by adding someone who
  can refactor living organisms.)</p>

<p>A good portion of my time was spent pondering and discussing how to
  improve Emacs support for Ruby and Rails. I've been hacking a lot of
  that in my spare time,  and I'm pretty confident saying rhtml support
  has been much improved for it. We've also been talking a lot about
  Smalltalk-style refactoring support,  which will be a titanic
  task. Fortunately it looks
  like <a href="http://soc.jayunit.net/">some folks</a> have put some
  work in to hacking that for Eclipse. (I know... I know! Hopefully it
  can be extracted and generalized.)</p>

<p>I got to brush shoulders with all sorts of top-notch fellow hackers
  and even got a conversation in with the
  venerable <a href="http://www.rubyist.net/~matz/">Matz</a> and the
  controversial <a href="http://tbray.org/ongoing">Tim
  Bray</a>. Mostly we talked about those refactoring
  ideas,  and Tim mentioned that leveraging tests would be a good way
  to get typing data about your code provided you've got good
  coverage. There's tons to be done,  but I'm excited to see how this
  progresses.</p>

<p><a href="http://www.flickr.com/photos/technomancy/tags/rubyconf2006/">Photos</a> up when I get home to my F-spot.</p>

include(footer.html)
