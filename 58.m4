<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, 2006-08-17T09:11:48Z)dnl
define(__title, `elunit?')dnl
define(__id, 58)dnl
include(header.html)
<p>Considering the number
  of <a
  href="http://sztywny.titaniumhosting.com/2006/07/23/stiff-asks-great-programmers-answers/">agile
  folk who use emacs</a>,  it's pretty surprising how difficult it is
  to find code for automated testing of elisp. There's plenty of stuff
  for <a
  href="http://www.emacswiki.org/cgi-bin/emacs/unit-test.el">running
  tests in other languages</a>,  but I was only able to find <a href='http://www.panix.com/~tehom/my-code/regress.el'>one Emacs
  Lisp specific testing library</a>.</p>

<p>Unfortunately as I look at the internals of regress.el,  it's clear
  that it's written by someone very unfamiliar with everyday Lisp
  idioms: </p>

  <pre>
    (<span class="keyword">while</span> suites
      (setq suite (car suites)
            suites (cdr suites))
      (<span class="keyword">if</span> (and (car suite) (not (stringp (car suite))))
          (setq description <span class="string">"Untitled test suite"</span>)
        (setq description (car suite)
              suite (cdr suite)))
  </pre>

<p>Apparently the map function is unfamiliar to the author. It's
  strange,  because this is a <i>really useful</i> library. It works
  very well,  and it's quite well documented. (It was well-tested,  go
  figure.)  I've made a few improvements to it so the test results are
  more readable,  but I'm thinking I might just want to rewrite it.
  This is partially because the internals <i>are</i> so bad,  partially
  to make it more xUnit-ish and focused on TDD rather than regression
  testing,  and partially just because it would be a good exercise in
  emacs lisp.</p>

<p>We'll see how that goes. It should be fun,  but it may be foolish to
  put off improving Rails support for the time that this will take to
  implement. Then again,  if my past experiences with elisp are any
  indication,  this will take a lot less time than it would seem like
  it should up front. Also,  having this in place while writing the
  Rails support modes would probably smooth things along quite a
  bit.</p>

<p>Speaking of Rails support,  I've
  improved <a
	      href="http://dev.technomancy.us/phil/browser/dotfiles/.emacs.d/arorem2/rhtml-mode.el">RHTML-mode</a>
  rather significantly in the past few days. There is still
  one <a href="http://dev.technomancy.us/phil/ticket/216">immensely
  irritating bug</a> that is getting in the way,  but on the whole it's
  coming along quite nicely.</p>

include(footer.html)
