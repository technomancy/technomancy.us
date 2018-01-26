dnl -*- html -*-
define(__timestamp, Sat Oct 13 00: 00: 01 -0700 2007)dnl
define(__title, `loads of lisp')dnl
define(__id, 89)dnl
include(header.html)
<p>All righty then. Recent silliness aside,  things have been going on
  here. Big things; exciting[<a href='#exciting'>*</a>] things.</p>

<ul>
  <li>I've gotten a job
    at <a href='http://hypertextsolutions.net'>Hypertext Solutions</a>, 
    who are building a pretty nifty product. It's kind of disorienting
    being dropped into a mostly-Java team since right now I know
    more <a href='http://en.wikipedia.org/wiki/Javanese_language'>Javanese</a>
    than Java,  but I'm getting up to speed. More and more Ruby is being
    used day-to-day,  so I'm finding that as the resident Ruby guru I'm
    being asked almost as many Ruby-related questions as I'm asking
    about crazy stuff like Tomcat and
    (<a href='http://www.defmacro.org/ramblings/lisp.html'>shudder</a>)
    Ant.<br /><br /></li>

  <li>I've also been recently rethinking the way things have been going
    with <a href='http://rinari.rubyforge.org'>Rinari</a>,  the Rails
    environment for Emacs. I had a lot of grand visions shared with
    some <a href='http://lathi.net'>really</a>
    <a href='http://funkworks.blogspot.com'>great</a>
    <a href='http://platypope.org/blog'>folks</a>,  but it seems that
    there just isn't enough energy and effort to keep it alive. It's
    also hard to get traction with new users.<br /><br />

    Rinari appeals to Emacs veterans because it follows time-honored
    conventions and doesn't... go overboard,  but someone new to Rails
    and Emacs is just going to go out there and search for 'Emacs for
    Rails' and come
    across <a href='http://emacs-rails.rubyforge.org'>rails.el</a>
    instead. At first glance it seems more featureful,  and newbies
    aren't put off by the ways it deviates from convention; they just
    see a lot of resulting inconsistency in Emacs as a whole as time
    goes on. On top of that,  it makes it seem
    like <a href='http://mmm-mode.sf.net'>mmm-mode</a> was the best way
    to support ERB views,  which
    is <a href='http://technomancy.us/40'>simply not the case</a> any
    more.<br /><br />

    It seems to me that a discouragingly high percentage of rinari users
    have just found about about it because they happened to be asking
    about how to get rails.el working while I was in #emacs,  and I was
    able to direct them to Rinari. So:  there's a definite mind-share
    problem on top of the "nobody has time to hack it"
    problem.<br /><br />

    Anyway,  to make a long story somewhat shorter,  I decided that it'd
    be best to join forces with the rails.el team. I contacted them,  and
    it turns out I'm really the only one who wants to actively develop
    it right now. So I got added to the committer list and started a
    separate branch to add in all the good Rinari stuff and remove all
    the stuff that IMHO is ill-advised. Key bindings stomp all over the
    place and require finger-contortions that would shoot chills down
    the spine of an ergonomicist.

    All that is on its way out in my new version,  available here: <br />

    <pre class='code'>svn co svn: //rubyforge.org/emacs-rails/branches/rinari-merge</pre>
  </li>

  <li>That's not all the Emacs goodness in town; not by a long
    shot. I've been having a lot of fun
    with <a href='http://dev.technomancy.us/wiki/TestUnitMode'>test-unit.el</a>.
    The basic idea is that rather than having tests run in a terminal, 
    (even a terminal within Emacs) you'd rather have them run in the
    test buffer itself. With test-unit-mode,  whenever you save the
    tests,  Emacs kicks off a subordinate process that runs them and then
    will highlight the methods in the buffer based on the output. That
    way you're instantly notified of any failure (faster than with
    <a href=''>autotest</a> even,  though autotest has other advantages
    to be sure),  and the feedback loop is as short as possible. <br /><br />

    There are still a few issues to work out. The trickiest thing is
    figuring out a heuristic for when to run which tests. This is a
    problem that autotest has more or less solved,  so the thing to do
    could be to make test-unit-mode a frontend for autotest but use
    save-hooks to kick off autotest rather than polling directories
    every five seconds and have stuff highlighted if the buffer's open
    rather than just dumping output to the shell. I definitely have
    plenty more to do in this direction.<br /><br />
  </li>

  <li>On a similar note,  Ryan Davis
    of <a href='http://zenspider.com/seattle.rb'>Seattle.rb</a> just
    released <a href='http://ruby.sadi.st'>flog</a>,  a tool that
    analyzes the parse tree to let you know how much pain your code is
    in. Clearly this kind of information is also very useful to see live
    in your buffers to minimize breaks in your workflow,  so I'm working
    on another <a href='http://dev.technomancy.us/wiki/Flog'>library</a>
    called flog.el that shows you the pain levels for your methods as
    you code them. Again there is room for improvements due to the fact
    that what I've got so far works only on a buffer-level rather than a
    project level,  but it's definitely a start.</li>
</ul>

<p>It's pretty cool to be up in the Northwest enjoying the greenery
  and the second-best city in the US for software work. Doesn't hurt
  that it's also the home of the most badass Ruby
  Brigade[<a href='#per-capita'>**</a>] in the country as well.</a>

<p>* <a name='exciting'></a>For some value of "exciting".</p>
<p>** <a name='per-capita'></a>Per capita.</p>

include(footer.html)
