dnl -*- html -*-
define(__timestamp, Fri 27 Apr 2012 05:45:01 AM UTC)dnl
define(__title, `in which we plot an escape from the quagmire of equality')dnl
define(__id, 159)dnl
include(header.html)
<p>If you follow happenings in the Clojure world, you may have
  noticed that the announcement
  of <a href="https://github.com/halgari/clojure-py">clojure-py</a>
  brings the number of runtimes targeted by Clojure up to four.
  While it's great to see the language expand beyond the JVM, it's
  not too exciting to me personally since the runtime I spend the
  most time in by far is that of Emacs. Of course, Emacs can already
  be programmed with lisp, but the dialect it uses leaves much to be
  desired. I miss first-class functions[<a href="#fn1">1</a>],
  destructuring, literals for associative data, and immutability
  whenever I find myself writing nontrivial Emacs Lisp code, and the
  lack of these features makes me reluctant to write in it even
  though it offers an environment with live feedback unmatched by anything
  but
  the <a href="http://en.wikipedia.org/wiki/Smalltalk#Image-based_persistence">Smalltalk
  images</a>
  and <a href="http://en.wikipedia.org/wiki/Genera_(operating_system)">Lisp
  Machines</a> of yore.</p>

<img src="http://p.hagelb.org/duck-hand.png" class="right"
     alt="why? why do you need a reason?" 
     title="why? why do you need a reason?" />

<p>Part of what makes ClojureScript interesting is that it has
  distilled the number of primitives needed to port Clojure to a new
  runtime down to a small number due to its push towards
  self-hosting. One of the Summer of Code projects for this year is
  to allow for pluggable backends in the ClojureScript compiler,
  with Lua as a proof of concept. I started to think through what
  would be necessary for this to happen on the Emacs runtime, but I
  ran into an interesting quandary
  regarding <a href="http://en.wikipedia.org/wiki/Referential_transparency_(computer_science)">referential
  transparency</a>.</p>

<p>A function is referentially transparent when it is guaranteed to
  return the same value every time it is called with a given set of
  arguments. This is a great guarantee to be able to make about your
  functions as it reduces the number of things you need to keep
  in your head. Referentially transparent functions really can be
  thought of as black boxes: always deterministic and predictable.
  But a function that operates on mutable objects cannot be
  referentially transparent&mdash;it cannot make any guarantees that
  future calls involving that same object will result in the same
  value since that object could have a different value at any time.</p>

<p>Since Emacs Lisp does not provide any immutable data types other
  than numbers, only functions that operate on numbers alone can be
  referentially transparent. This is a shame, since referential
  transparency allows you to have much greater confidence that your
  code is correct. Without it, the best you can say is "as long as
  the rest of this program behaves itself, this function should
  work". This works a lot like older OSes with cooperative
  multitasking and no process memory isolation, which is to say not
  very well.</p>

<p>But arguably the worst thing about lacking referential
  transparency is that you can't check for equality in a
  meaningful way. Henry Baker's
  paper <a href="http://home.pipeline.com/~hbaker1/ObjectIdentity.html">"Equal
  Rights for Functional Objects"</a> addresses the problem of
  equality in Common Lisp[<a href="#fn2">2</a>], which is notable for
  having a plethora of equality predicates depending on what level
  of coarseness you want:</p>

<ul>
  <li><code>EQ</code>: are both arguments the same object in memory?</li>
  <li><code>EQL</code>: like <code>EQ</code>, but compares value for
    non-immediate numbers like tagged fixnums and bignums.</li>
  <li><code>EQUAL</code>: do both arguments have the same structure
    and contents?</li>
  <li><code>EQUALP</code>: like <code>EQUAL</code>, but allows
    integers to equal floats and ignores string case.</li>
  <li><code>=</code>: are both numbers of equal value?</li>
  <li><code>CHAR=</code>, <code>STRING=</code>, <code>STRING-EQUAL</code>,
    ad nauseum.</li>
</ul>

<p>Baker argues that this confusion is due to a muddled notion of
  object identity. Everything would be so much simpler if we could
  think in terms of operational equivalence:</p>

<blockquote>Two objects are "operationally equivalent" if and only
  if there is no way that they can be distinguished, using ...
  primitives other than [equality primitives].[RNRS]</blockquote>

<p>Asking "Are these two objects stored in the same memory
  location?" lets implementation details leak into your code.
  Equality should really be about "Can these two objects behave
  differently in any observable way?". Baker's paper implements the
  <code>egal</code> function in terms of this question; it's an
  equality predicate that defines object identity as a transitive
  closure of immutable attributes of an object. So without
  immutability, <code>egal</code> can't do any better than <code>eq</code>.</p>

<p>Of course, with a compiler that targets Emacs Lisp, you can work
  around this by implementing your own immutable types. But this
  makes any form of interop much more cumbersome; close integration
  with its host platform is one of the core design tenets of
  Clojure, and having to perform conversions on basic types like
  strings just to call native elisp functions would be too
  cumbersome to be practical. So with the Emacs runtime as it is,
  you have to choose between getting equality right and seamless
  interop. Damned if you do; damned if you don't.</p>

<p>There are two possible solutions to this. There has been an
  ongoing effort to
  get <a href="http://www.emacswiki.org/emacs/GuileEmacs">Emacs Lisp
  running on the Guile VM</a>. As it comes from a Scheme background,
  Guile provides the immutable data types we need. (<b>Update</b>:
  the immutable types offered in Guile do not actually come from the
  Scheme standard, but they are present nonetheless.) However, Emacs
  Lisp is very different from Scheme, and the Guile implementors
  have an enormous task ahead of them to get even the basics
  working; the amount of work needed to achieve compatibility with
  the bulk of quirky extant Emacs Lisp code is daunting. But it
  would be wonderful if it were possible.</p>

<p>The more realistic option is to add immutable data types to the
  existing Emacs implementation. I suggested in passing on the
  emacs-devel mailing list that I would be interested in financially
  supporting such a feature, which led
  to <a href="http://lists.gnu.org/archive/html/emacs-devel/2012-04/msg00684.html">
  a discussion of its pros and cons</a>. It turns out there is very
  little code that would break if Emacs strings became immutable;
  even though it's possible to change strings it happens rarely
  enough in real code to not pose serious problems. Changing lists
  to be immutable would break huge amounts of code though, so a more
  reasonable approach would be to offer an alternate list
  constructor for immutable lists so that functional code could have
  access to immutability without wreaking havoc on existing
  functionality. Ideally libraries could opt-in to having the reader
  return immutable lists, but I don't know enough about Emacs's
  reader to know how feasible this is.</p>

<p>Unfortunately I'm not the one calling the shots; I don't have the
  C skills necessary to make it happen even if the Emacs maintainers
  were favourable to the idea. But it's interesting to think about,
  especially as concurrency may be introduced in Emacs 25. One
  certainly can dream.</p>

<hr />

<p>[<a name="fn1">1</a>] Common Lisp fans claim that lisp-2s have
  first-class functions, but the way they are kept separate from
  other first-class values in their own namespace ghetto brings to
  mind claims of "separate but equal"&mdash;at best it is Jim Crow
  functional programming.</p>

<p>[<a name="fn2">2</a>] Emacs Lisp is not Common Lisp, but the two
  dialects are very closely related, and for the purposes of this
  post share the same problems.</p>
include(footer.html)
