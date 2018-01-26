dnl -*- html -*-
define(__timestamp, 2007-12-09T15:23:42Z)dnl
define(__title, `bus scheme')dnl
define(__id, 98)dnl
include(header.html)
<p>So during RubyConf,  Matz asked how many in the audience had written a Lisp implementation. It was pretty impressive&mdash;somewhere between five and ten percent of the crowd raised their hands. Unfortunately I was not one of them,  to my great shame.</p>
<p>Anyway,  I figured it was about time to fix that. I've been coding up a little interpreter on my bus rides to work. Bus Scheme it is called,  and it's implemented in Ruby. (I seriously considered doing it in Emacs Lisp,  but I've been writing plenty of that these days,  and I actually haven't been touching Ruby a lot.)  Anyway,  it's a lot of fun. I was thrashing about blindly with the parser for a while,  but once I discovered the proper way of separating the parsing step from the tokenizing step (thanks Ryan! I did learn this in school once; I promise...) it all fell into place with a bit of recursion.</p>
<pre class="code"> > (+ 2 2)
 4
 > (define fives (quote 5 5))
 5
 5
 > fives
 5
 5
 > (concat "foo" "bar")
 foobar
 </pre>
<p>Right now it's just good for simple arithmetic,  basic <code>define</code>s,  and a few primitives,  but I should be getting to <code>lambda</code> next. I think I'll need to read a little further in <i>The Little Schemer</i> before I'm ready to tackle that,  though.</p>
<p><a href='http://technomancy.us/code/bus_scheme.tar'>Code is up as a tarball</a>. I haven't figured out where to host the git repository yet. I'm really enjoying the exercise and would recommend it to like-minded hackers. Bonus fact:  I haven't actually used a real Scheme yet. Everything I know about it I've gathered from reading <i>The Little Schemer</i>,  watching the <a href="http://www.swiss.ai.mit.edu/classes/6.001/abelson-sussman-lectures/">Structure and Interpretation of Computer Programs videos</a>,  and reading lots about Common Lisp and Emacs Lisp&mdash;all of which I can't recommend highly enough.</p>
<p>In closing:  <a href="http://rubyconf2007.confreaks.com/d2t1p5_tightening_the_feedback_loop.html">the video of my RubyConf talk</a> has been posted by ConFreaks. Much thanks to them for taping the conference. There are also a ton of other good videos posted there,  though not every talk is up yet. Dig in!</p>
include(footer.html)
