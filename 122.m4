dnl -*- html -*-
define(__timestamp, Mon 02 Feb 2009 08:41:09 PM PST)dnl
define(__title, `in which slime and mire and other sludges come into play')dnl
define(__id, 122)dnl
include(header.html)
<p>I've been getting into Clojure more and more recently, and it's
  been really enjoyable. My learning project
  is <a href='http://github.com/technomancy/mire'>Mire</a>, a simple
  multiplayer text adventure. It's a great way to get familiar with
  the concurrency features of Clojure with a codebase that can still
  pretty small due to being text-based.</p>

<p>Using SLIME to interactively develop Mire from within Emacs has
  been really slick&mdash;the level of interactivity is really
  impressive. The problem is, it's a bit of a bear to configure, and
  there are more moving parts than I'm comfortable with. I'm not the
  only one either; one of the most common questions in
  the #clojure channel is how to configure SLIME.</p>

<p><b>Update</b>: This is very out-of-date. The <a
  href="https://github.com/technomancy/swank-clojure#readme">Swank
  Clojure readme</a> is the canonical source of getting started 
  instructions.</p>

<p>I've worked on a bit of code to alleviate the confusion. There's
  nothing about the problem that's particularly tricky; it's just
  that the necessary code is changing so fast that using a package
  manager for it isn't feasible. And installing software by hand
  without a package manager&hellip; well let's just say it's fraught
  with frustration. So I've added an <kbd>M-x clojure-install</kbd>
  function
  to <a href='http://github.com/technomancy/clojure-mode/'>by
  fork of clojure-mode</a> that should handle the necessary
  checkouts and configuration. It should save a lot of confusion
  for folks who are just getting started and not really sure of
  the best way to proceed.</p>

<p><b>Update</b>: If you use the <a
  href='http://github.com/technomancy/emacs-starter-kit'>Emacs
  Starter Kit</a>, you've already got what you need; just hit
  <kbd>M-x clojure-install</kbd> to get going. And it should be in
  ELPA before too long.</p>

<p><b>Update</b>: <kbd>M-x clojure-install</kbd> has been merged into
  <a href='http://github.com/jochu/clojure-mode'>the mainline
  clojure-mode repository</a>, so you don't need to use mine any
  more.</p>

<p><b>Update</b>: It's been a long time since this post was written;
  in the mean time Clojure has had two stable releases and a package
  manager created, so compiling from source as the default
  installation mechanism doesn't make sense any more. <kbd>M-x
  clojure-install</kbd> has been deprecated in favour of built-in
  functionality
  in <a href="http://github.com/technomancy/swank-clojure">swank-clojure</a></p>.
<p><b>Update</b>: Good grief; now even <kbd>swank-clojure</kbd> itself
  is
  deprecated. Try <a href="https://github.com/sanel/monroe">Monroe</a>
  with the nREPL protocol.</p>

include(footer.html)
