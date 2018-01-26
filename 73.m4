dnl -*- html -*-
define(__timestamp, Sat Oct 13 00: 00: 01 -0700 2007)dnl
define(__title, `30 plus bad')dnl
define(__id, 73)dnl
include(header.html)

<p><a href="http://behaviour-driven.org">Behaviour-Driven
Development</a> has been percolating around in the collective
consciousnesses of some of the communities I'm involved in. It's
basically a methodology that has grown out of some of the weaknesses
people have observed in test-driven development. Here's the thing: 
TDD is about design. Forcing yourself to think about tests before
the code is actually written helps you think about design in new
ways. Beginners to TDD often think it's all about the tests instead.</p>

<p>The main issue that BDD tackles is one of terminology&mdash;when
you are constantly referring to tests in TDD,  it's easy to forget
that what you really care about is behaviour. It's not <i>really</i>
about tests,  (in fact,  <a href="http://blog.daveastels.com">Dave
Astels's</a> book on TDD begins with the sentence,  "This is not a
book about testing.")  those just happen to be the most obvious way
to get check behaviour. So BDD tries to come in with a new
vocabulary focusing on contexts and specifications and the word
"should" that starts you off thinking in the right direction.</p>

<p>The common criticism here is that it's "just terminology". It's
not really that revolutionary,  it's just a new set of names. Now to
be honest,  I agree with that except for the word just. When people
talk about coding styles and things to always be mindful of,  one of
the things that repeatedly comes up
is <a href="http://cc2e.com/Page.aspx?hid=225">how important good
names are</a>. Not to get
all <a
href="http://en.wikipedia.org/wiki/Sapir-Whorf_hypothesis">Sapir-Whorf</a>
on you,  but the words you use really affect the way you think in an
inescapable way. In fact,  there's an
excellent <a
href="http://deadhobosociety.com/index.php/Essays/ESSAY12">essay on
Confucianism and Technical standards</a> which states: </p> <blockquote>
In a famous
passage,  <a
href="http://www.analects-ink.com/mission/Confucius_Rectification.html">Analects
13.3</a>,  Confucius was asked by a disciple what his first order of
business would be if he were to govern a state. He replied, 
&#27491;&#21517;,  meaning roughly [...] "rectify the names." His disciple
was somewhat incredulous and asked,  "Would you be as impractical as
that?" Confucius strongly rebuked his disciple and explained that
proper nomenclature is the basis of language and that language is
central to taking care of things.</blockquote>

<p>In the words of the Master: </p>

<blockquote>If language is not correct,  then what is said is not what
is meant; if what is said is not what is meant,  then what must be
done remains undone; if this remains undone,  morals and art will
deteriorate; if justice goes astray,  the people will stand about in
helpless confusion. Hence there must be no arbitrariness in what is
said. This matters above everything.</blockquote>

<p>All that to say:  yes,  BDD is (mostly) new words. But that's a big
deal.</p>

<p>Oh yes; the point... I had one about here
somewhere. Right&mdash;<code>behave.el</code>,  my latest hackery: </p>

<pre class="code">
<span class="paren">(</span>context <span class="string">"A list with three items"</span>
       <span class="paren">(</span>tag list example<span class="paren">)</span>
       <span class="paren">(</span><span class="keyword">lexical-let</span> <span class="paren">((</span>list <span class="paren">(</span>list <span class="string">"a"</span> <span class="string">"b"</span> <span class="string">"c"</span><span class="paren">)))</span>

         <span class="paren">(</span>specify <span class="string">"should contain the first item"</span>
                  <span class="paren">(</span>expect <span class="paren">(</span>first list<span class="paren">)</span> equal <span class="string">"a"</span><span class="paren">))</span>

         <span class="paren">(</span>specify <span class="string">"should push new values onto the front"</span>
                  <span class="paren">(</span>push <span class="string">"d"</span> list<span class="paren">)</span>
                  <span class="paren">(</span>expect <span class="paren">(</span>first list<span class="paren">)</span> equal <span class="string">"d"</span><span class="paren">))</span>

         <span class="paren">(</span>specify <span class="string">"should NOT remove the top item when reading the car"</span>
                  <span class="paren">(</span>expect <span class="paren">(</span>first list<span class="paren">)</span> equal <span class="string">"d"</span><span class="paren">)</span>
                  <span class="paren">(</span>expect <span class="paren">(</span>first list<span class="paren">)</span> equal <span class="string">"d"</span><span class="paren">))</span>

         <span class="paren">(</span>specify <span class="string">"should return the top item when popped"</span>
                  <span class="paren">(</span>expect <span class="paren">(</span>pop list<span class="paren">)</span> equal <span class="string">"d"</span><span class="paren">))</span>

         <span class="paren">(</span>specify <span class="string">"should remove the top item when popped"</span> 
                  <span class="paren">(</span>expect <span class="paren">(</span>pop list<span class="paren">)</span> equal <span class="string">"a"</span><span class="paren">)</span>
                  <span class="paren">(</span>expect <span class="paren">(</span>pop list<span class="paren">)</span> equal <span class="string">"b"</span><span class="paren">))))</span></pre><p>It's BDD. In Emacs Lisp. (And it's only 89 lines of code.&lt;/brag&gt;)</p>
<p>The most obvious difference it has from other libraries
like <a href="http://rspec.rubyforge.org">RSpec</a> (well,  apart from
Lisp) is that behave.el meant to run in an interactive environment
rather than from the command line. You could certainly script it,  but
the tagging functionality is designed with interactivity in mind. The
other thing is that you can't structure things in terms of "X should
PREDICATE Y" since Lisp requires that the function go first. I suppose
technically you could write a macro that would mangle things to the
point where that would be feasible,  but it definitely goes against the
grain of Lisp and would require a lot of context
switching. <code>behave.el</code> instead uses the expect macro to state
expectations which the code should fulfill.</p>

<p>Being a first release,  it's missing a few things. For starters,  you
can only <code>expect</code> either that a form is non-nil or that it is
equal something. More flexibility in the expect macro is certainly to
be desired. The other big thing is that each <code>specify</code> form
does not start with a fresh binding of variables. (The <code>setup</code>
methods in both Ruby's Test::Unit and rSpec both provide this,  and it
often proves to be handy.) I've been battling the CL-emulation
libraries in elisp and so far losing,  but I'm sure I can provide such
a thing in a future release.</p>

<p><code>behave.el</code>
supercedes <a
href="http://dev.technomancy.us/phil/wiki/ElUnit">ElUnit</a>,  my
previous unit-testing framework for Emacs Lisp.</p>

<p>Anyway,  real point here is that now that I've got a BDD framework
in Emacs Lisp,  I can port it to Common Lisp and then use it to hack
on <a href="http://technomancy.us/72">Darjeeling</a>. Woo hoo!</p>

<p><a href="http://dev.technomancy.us/phil/browser/dotfiles/.emacs.d/behave">Grab it</a>
from my repository. There's also
a <a
href="http://dev.technomancy.us/phil/wiki/behave">Trac page</a>.</p>

include(footer.html)
