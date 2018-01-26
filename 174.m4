dnl -*- html -*-
define(__timestamp, 2014-10-07T22:25:46Z)dnl
define(__title, `in which cards are stacked')dnl
define(__id, 174)dnl
include(header.html)
<p> My childhood summers involved many days spent building out
  expansive <a href="https://en.wikipedia.org/wiki/HyperCard">HyperCard</a>
  stacks to explore in a game world that spanned across cities
  and islands and galaxies, littered with creatively absurd death
  scenes to keep you on your toes. The instant accessibility of
  HyperCard invited you to explore and create without feeling
  intimidated. Especially for younger minds, I believe there's
  something fundamental about the spatial aspect of HyperCard. Every
  button has its place, and rather than creating an abstract
  hierarchy of classes or a mesh of interconnected modules, you can
  see that buttons have a specific place on a card, which exist
  "inside" a stack in a metaphor that maps to the way we already
  perceive the world.</p>

<img src="/i/for-kids.jpg" alt="you know, for kids" class="right" />

<p>While <a href="http://www.loper-os.org/?p=568">Apple killed
  HyperCard off many years ago</a>, there exist tools for children
  today that maintain this accessible spatial
  arrangement. I've <a href="/167">written before</a> about how my
  kids love playing
  with <a href="http://scratch.mit.edu">Scratch</a>, a
  <a href="https://en.wikipedia.org/wiki/Logo_%28programming_language%29">Logo</a>-descendant
  providing colorful sprites and drag-and-drop scripts to animate
  them. While this is unbeatable for the early years, (especially
  for kids who are only just beginning to learn to read) eventually
  you hit an abstraction ceiling beyond which it becomes very
  tedious to express your ideas due to its non-textual nature. There
  are modern HyperCard clones
  like <a href="http://livecode.com">LiveCode</a>, which offers a
  very sophisticated platform, but falls prey to the same tragic
  pitfall of attempting to
  build <a href="https://en.wikipedia.org/wiki/HyperTalk">an
  "English-like" programming language</a>, an endeavour which has
  been attempted many times but
  always <a href="http://andykonwinski.com/applescript-the-most-unnatural-natural-language/">ends
  in tears</a>.</p>

<img src="/i/myst.jpg" class="right" alt="myst island" />

<p>So as I've thought a good next step for my own children, we
  happened to start playing the
  game <a href="https://en.wikipedia.org/wiki/Myst">Myst</a>. Given
  my children's proclivities, this was immediately followed by Myst
  copycat worlds drawn out in elaborate detail with pen and paper the
  next day. I thought of what I could do to bring back the
  exploration and creativity of HyperCard, and eventually I got to
  <a href="https://github.com/technomancy/cooper">building my own
  implementation</a>.</p>

<p>The natural choice for this project was definitely
  the <a href="http://racket-lang.org">Racket</a> language. While
  I'm much more familiar with Clojure, it's a very poor fit for a
  first-time programmer, especially at a young age. Racket boasts
  lots of great learning material, but beyond the texts there's
  just an ever-present focus on usability and clarity that shines
  through in all aspects of the language and community.</p>

<img src="/i/drracket-error.png" alt="drracket error" align="left" />

<p>Racket's roots lie with the famously-minimalistic Scheme, but it's grown
  to be a much more practical, expansive programming language. While
  there are still a few places in which its imperative roots show
  through, it has good support for functional programming and
  encourages good functional practice by default for the most
  part. (I hope to do a future post on a few ways to improve on its
  FP, both via
  the <a href="https://github.com/greghendershott/rackjure">Rackjure</a>
  library and some
  of <a href="http://p.hagelb.org/fstruct.rkt.html">my own
  hacks</a>.) But what really sets Racket apart is its solid tooling
  and libraries. I wouldn't put my kids down in front of Emacs, but
  Racket ships
  with <a href="http://docs.racket-lang.org/drracket/index.html">a
  very respectable IDE</a> that's capable and helpful without being
  overwhelming. The GUI and drawing libraries that come with Racket
  have proven to be very useful and approachable for what I've done
  so far.</a>

<p>So
  far <a href="https://github.com/technomancy/cooper">Cooper</a>, my
  HyperCard clone, is fairly simplistic. But in just over 500 lines
  of code, I have a system that supports manipulating stacks of cards,
  drawing backgrounds on them, and laying out buttons which can
  either navigate to other cards or invoke arbitrary functions.</p>

<p>It's not sophisticated, but my children have already shown plenty
  of interest in using it to build out small worlds of their own in
  the cards. They've so far been willing to put up with lots of
  glitches and poor performance to bring their imaginations to life,
  and I'm hoping that this can gradually grow into a deeper
  understanding of how to think in a logical, structured way.</p>

<p><b>Update</b>: I'm not working on this any more, but I
  have <a href="https://technomancy.itch.io/bussard">another
  project</a> which takes a different approach towards teaching
  programming. However, for approachable, kid-friendly
  storytelling-type programming I would strongly
  recommend <a href="http://twinery.org">Twine</a>.</p>
include(footer.html)
