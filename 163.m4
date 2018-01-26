dnl -*- html -*-
define(__timestamp, Tue 21 Aug 2012 10:50:47 PM PDT)dnl
define(__title, `in which we retire a workhorse')dnl
define(__id, 163)dnl
include(header.html)
<p>When I <a href="/121">first got started with Clojure</a> I was
  disappointed that the process of getting started was pretty rough
  around the edges, but one of the things that helped sustain my
  momentum was the fact that I could
  use <a href="http://common-lisp.net/project/slime/">SLIME</a> to
  write Clojure code from Emacs via
  the <a href="https://github.com/technomancy/swank-clojure">swank-clojure</a>
  project, running and testing it while in the middle of writing it.
  This helped me overlook the fact that I needed to construct
  nasty <tt>java</tt> command-line invocations to launch the
  process.</p>

<img src="/i/uw.jpg" alt="UW" class="right" />

<p>As time went on I did what I could to try to improve the
  situation. <a href="https://github.com/technomancy/clojure-mode/blob/47caba15ff31f339e74378fd3c05bcffa7091550/clojure-mode.el#L627">Early</a> <a href="https://github.com/technomancy/emacs-starter-kit/blob/63797f61aa7019e2cc5f0e79793f8bdd4b50ad21/starter-kit-lisp.el#L39">attempts</a>
  were quite primitive, but eventually
  when <a href="http://leiningen.org">Leiningen</a> came out
  the <tt>lein swank</tt> command obsoleted all my hokey elisp
  setup scripting. Still a few other things kept it from being a
  really smooth experience. The main issue is that SLIME was
  developed primarily for Common Lisp. The protocol behind it
  changes every so often, and there aren't any stable releases;
  users are expected to simply run straight out of CVS.</p>

<p>When the creator of swank-clojure passed maintainership to me, I
  kept things going by applying patches and adding a handful of
  features at the edges, but nobody really understood the ins and
  outs of the project. Part of this was because it was just a really
  old quirky codebase, (most of it predated the introduction of
  Clojure atoms) but part of it was because it was a fairly literal
  port of the Common Lisp server.</p>

<p>The end result was that SLIME moved forward while swank-clojure
  stood still. This mostly worked once we bundled a frozen SLIME
  revision, but it was common to have confused users wander into the
  IRC channel with a broken setup, unsure of where it went wrong or
  how to get the right SLIME. Even for experienced users it was
  impossible to have a setup that could connect to both Clojure and
  Common Lisp at the same time.</p>

<p>Meanwhile in Clojure-land
  the <a href="https://github.com/clojure/tools.nrepl">nREPL</a>
  project was started as a tool-agnostic counterpart to
  swank-clojure, building a general networked repl server and an
  ecosystem around it. While I appreciated the idea, I thought that
  it would be a long time before Emacs support for it could catch up
  to the level of functionality in SLIME.</p>

<p>Still, one evening on a short flight to San Francisco I bashed
  out the beginnings of an nREPL client in Emacs. I got a bit stuck
  on the socket-based bencode functionality and dropped it after the
  flight, but not before pushing the code out and
  <a href="http://groups.google.com/group/clojure/browse_thread/thread/2bd91de7dca55ca4">mentioning
    it on the Clojure mailing list</a>.</p>

<p>Fortunately Tim
  King <a href="https://github.com/kingtim/nrepl.el/">picked it back
  up</a>, and now it has quickly become a respectable competitor to
  SLIME. I've switched over to it for day-to-day use. The main thing
  I've noticed about it is how accessible the codebase is; I've
  found it very easy to dive in and add features. So even though
  it's still missing a few things that SLIME boasts, it's on course
  to improve at a steady pace. It also works out of the box with
  Leiningen 2.x's <tt>repl</tt> task without any extra plugin
  needed.</p>

<p>It's now gotten to the point where I'm ready to consider
  swank-clojure deprecated. Of course, it will go on working, so if
  you already have a setup that works for you, there's no need to
  switch. Also if you find yourself particularly attached to the
  inspector or debugger from SLIME you might want to hold off. (For
  debugging in particular
  the <a href="https://github.com/pallet/ritz">ritz</a> project
  works with SLIME and has advanced debugging features.) But if
  you're looking for a simpler way to get
  started, <a href="https://github.com/kingtim/nrepl.el">give
  nrepl.el a try</a>.</p>

<p><b>Update</b>: Jeffrey Chu, original author of swank-clojure,
  writes: <i>As creator of swank-clojure, I'm a little sad to see it
  die. But I'm very happy to see that it's being replaced by
  something designed/maintainable instead of hacked about just to
  scratch an itch. Thanks for keeping it alive all this time and I
  look forward to the great work coming out of nrepl.el.</i></p>
include(footer.html)
