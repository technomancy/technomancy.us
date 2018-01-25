<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Fri 24 Apr 2009 09:30:08 PM PDT)dnl
define(__title, `in which codes are peeped at, in clojure')dnl
define(__id, 124)dnl
include(header.html)
<p>I'm very proud to announce the release of my latest
  project, <a href='https://www.pluralsight.com/courses/functional-programming-clojure'>Functional
  Programming with Clojure</a>, a PeepCode screencast created
  with <a href='http://topfunky.com'>Geoffrey Grosenbach</a>. We
  were lucky to have Rich Hickey, the creator of Clojure do the
  technical review.</p>

<p><b>Update:</b>PeepCode is now part of PluralSight.</p>

<p><a href='https://www.pluralsight.com/courses/functional-programming-clojure'>
  <img src='/i/peepcode-clojure-title.png' alt='FP with CLJ' class='right' /></a></p>

<p>I've <a href='/121'>blogged</a> about <a href='/122'>Clojure</a>
  before. It's becoming clear that with the way multi-core systems
  are becoming the norm, functional programming provides tools to
  handle concurrency in a straightforward way. Languages like
  Haskell and Erlang are experiencing surges in popularity, but
  Clojure brings some <a
  href='http://constc.blogspot.com/2009/03/relativity-of-simultaneity.html'>great
  new tricks</a> of its own to the table. Part of this is its
  heritage as part of the Lisp family of languages, part of it is
  being built on a really solid virtual machine, and part of it is
  Rich's ingenuity that shines in its design.</p>

<img src='/i/peepcode-clojure-reduce.png' alt='reduce' align='left' />

<p>If you've been wanting to dive into Clojure, this is a great way
  to get started quickly. The screencast steps through the development
  of <a href='http://github.com/technomancy/mire'>Mire</a>, a
  multiplayer text adventure. I found this to be an fitting
  project to showcase Clojure's strengths since it involves
  concurrent processing while still requiring state to be shared
  between threads, and it's simple enough to cover in an hour.</p>

<p>So take a look! I think you'll like it.</p>
include(footer.html)
