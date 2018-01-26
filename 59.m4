dnl -*- html -*-
define(__timestamp, 2006-08-23T12:17:40Z)dnl
define(__title, `yes,  elunit 1.0!')dnl
define(__id, 59)dnl
include(header.html)
<p>Has it really almost been a week? Well,  it's been a good week for
  hacks.</p>

<p><a href='http://dev.technomancy.us/phil/wiki/ElUnit'>ElUnit</a> is
  a unit testing framework for Emacs Lisp designed to allow
  Test-Driven development. I believe it to be pretty much at release
  quality,  though a few more convenience macros (assert-equal,  for
  instance) remain to be written. You define suites of tests using
  the <code>defsuite</code> macro: </p>

    <pre class='code'>
(defsuite <span class="keyword">my-test-suite</span>
  (two-plus-two
    <span class="string">"Test that 2 + 2 = 4"</span>
    (<span class="warning">assert</span> (equal 4 (+ 2 2))))

  (another-test
    (<span class="warning">assert</span> (equal 0 (- 2 2))))

  (bad-math
    <span class="string">"This test should fail!"</span>
    (<span class="warning">assert</span> (equal 5 (+ 2 2))))

  (another-test
    <span class="string">"duplicate should overwrite original"</span>
    (<span class="warning">assert</span> (equal 3 (length (elunit-suite 'my-test-suite))))))

(add-hook 'my-test-suite-teardown-hook (<span class="keyword">lambda</span> () (message <span class="string">"teardown hook"</span>)))
</pre>

<p><kbd>M-x elunit</kbd> gets you some nicely formatted reports: </p>

<pre class='code'>
Loaded suite:  my-test-suite

.<span style='color:  red;'>F</span>.

1) Failure:  bad-math [<u>/home/phil/.emacs.d/elunit-test.el: 13</u>]
            This test should fail!
    Result:  (cl-assertion-failed (equal 5 (+ 2 2)))


3 tests total,  1 failures in 0 seconds.
</pre>

<p>How many times do I have to tell you that two plus two is four?
  Anyway,  I'm pretty happy with the results,  especially considering I
  was able to keep it at about 90 LOC. Give it a shot,  and if you've
  got anything to say,  pipe up
  on <a href='http://dev.technomancy.us/phil/wiki/ElUnit'>the wiki
  discussion</a>.</p>

<p><a
      href='http://dev.technomancy.us/phil/browser/dotfiles/.emacs.d/elunit.el?format=txt'>Grab
      it</a> straight out of my Trac.</p>

include(footer.html)
