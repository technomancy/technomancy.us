dnl -*- html -*-
define(__timestamp, 2009-09-01T04:24:34Z)dnl
define(__title, `in which it is time for something that is almost completely different')dnl
define(__id, 128)dnl
include(header.html)
<p>Remember that funky leaf shape you used to draw with your ruler
  in math class in high school when you got bored? I can't be the
  only one who did this...</p>

<p> Right before _why the lucky stiff took himself
  <a href='http://ejohn.org/blog/eulogy-to-_why/'>off the grid</a> I
  started reading up on his experiments with code and art, and he
  spoke pretty highly of
  the <a href='http://processing.org'>Processing</a> language as a
  very approachable way to get into programming. As someone who got
  started coding in QBasic, I've always felt that the amount of
  effort needed to get started in most modern languages is quite a
  shame. Sure you can get going easily with text, but when you're
  new to it you want to see pictures drawn and colors fly around the
  screen. Processing restores that level of immediacy; if you want a
  line, you call the <code>line</code> function; there's no fussing
  with setting up an event loop or a menu bar or any of that
  nonsense.</p>

<img src="/i/chu-small.png" alt="chu" class="right" />

<p>The problem is that while Processing is a great toolkit for
  drawing, it's is actually a pretty poor language when it comes to
  computational expressivity. It's statically-typed without any sort
  of inference, and there are no first-class functions or
  associative data type literals. Iteration is only possible using
  the most primitive of C-style <code>for</code> loops, and there's a
  shameful level of statefulness in much of the core
  functionality... You're not going to miss these things if you're
  just starting out with programming, but as a seasoned hacker,
  going back to a language like that feels quite limiting.</p>

<p>Luckily Processing is implemented on the JVM, so any other
  JVM-hosted languages can call out to it trivially. My weapon of
  choice right now is Clojure, and there's an adapter library that
  <a href='http://github.com/rosado/clj-processing'>fits the bill
  nicely</a>. (A <a href='http://wiki.github.com/jashkenas/ruby-processing'>ruby 
  bridge</a> exists too.) I've been playing around with it and have started a
  <a href='http://github.com/technomancy/sketchbook'>sketchbook
  project</a> containing each of the programs I've written so far.</p>

<img src="/i/myu-small.png" alt="myu" align="left" />

<p>The first thing you notice when you read up on Processing and
  take a look at some of the shorter sketches is that very simple
  ideas often yield interesting and subtle results. This image
  simply bounces a circle around the window while varying its
  opacity in a sine pattern. It's
  around <a href='http://github.com/technomancy/sketchbook/blob/master/src/sketchbook/myu.clj'>thirty
  lines of Clojure</a>, but you can see emergent weave patterns in
  it. This
  is a <a href='http://www.complexification.net/gallery/machines/substrate/appletl/index.html'>fairly
  common occurrence</a> among Processing projects.</p>

<p>The canonical <a href='http://www.amazon.com/Processing-Programming-Handbook-Designers-Artists/dp/0262182629/ref=sr_1_1?ie=UTF8&s=books&qid=1251782317&sr=8-1'>handbook
  by Reas and Fry</a> has proven to an excellent introduction. It's
  geared towards beginner programmers, but the sections are broken
  up well so that it's easy to skip those on control and iteration
  while still getting a lot out of the more art-focused parts if
  you're coming from a programming background.</p>

<p>A nice bonus of being JVM-hosted is that it's possible to run
  Processing programs as applets (remember applets?) in the
  browser. I haven't gotten mine exported yet, but having the option
  to share easily makes it a lot more fun; I hope to have a
  sketchbook page uploaded soon. In the mean time
  it's <a href='http://github.com/technomancy/sketchbook'>on
  Github</a> if you want to try it yourself.</p>

<p><b>Update</b>: I've compiled <a href='/misc/sketchbook.jar'>all my
  sketches so far together for download</a>. Depending on your OS
  you may be able to double-click on it; otherwise just launch it
  with <kbd>java -jar sketchbook.jar</kbd>. The <code>chu</code>
  sketch has trouble launching, and there's one bug where the
  sketches' window size is wrong upon launch, but you can adjust
  that.</p>
include(footer.html)
