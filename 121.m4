dnl -*- html -*-
define(__timestamp, 2009-01-03T22:08:56Z)dnl
define(__title, `in which new paradigms are explored, clojure is reached, and impressions are still cursory')dnl
define(__id, 121)dnl
include(header.html)
<p>With the new year coming up, I've been planning what I'll be
  focusing on in 2009. I toyed with the idea of learning Haskell,
  but after
  watching <a href='http://clojure.blip.tv/file/1313398/'>these</a>
  <a href='http://clojure.blip.tv/file/1313503/'>videos</a> I
  couldn't help but give <a href='http://clojure.org'>Clojure</a> a
  shot. I've played around with functional programming a bit in
  Elisp and Scheme and am familiar with the concepts, but I don't
  think you can really get immersed in FP without the
  variables-are-immutable-by-default paradigm that the strict FP
  languages offer. Clojure is a modern dialect of Lisp designed from
  the ground up with concurrency in mind.</p>

<p>First impressions about the language:</p>
<ul class='spaced'>
  <li>It's fast. Really fast.[<a href='#fn121-1'>1</a>] Being hosted
    on the JVM means a language gets access to what seems to be the
    most advanced compiler and runtime known to mankind, regardless
    of the manifold shortcomings of Java&trade; the language. When
    the normal speed is not enough, ("No no; Light Speed is too
    slow. We need to go to Ludicrous Speed." if I may mix metaphors)
    it's trivial to add hints that provide Java-native speeds.</li>

  <img src='/i/cons.png' alt='cons' class='right' />

  <li>The basic data structures Clojure provides are brilliant. In
    Lisp, lists are composed by attaching a new head to an
    existing list. The list structure is very flexible and has a
    convenient syntax, but vectors, hash-tables, and sets are much
    more efficient for many uses. So in Common Lisp folks generally
    prototype applications using lists since they're simple and
    convenient, and then switch over to more efficient structures
    once they have a better idea of the structure of the program.
    The problem is that most of the fast structures don't have
    convenient literal syntax, and they don't use same APIs,
    so rewiring a program to use hash tables instead
    of associative lists can be a pretty significant change in most
    lisps. Clojure has convenient literal syntax for all its basic
    data structures, and they have the property of being composable
    in the same way lists are, so hardly any change is necessary to
    switch between them. They also offer lots of internal structure
    sharing so that creating new ones based on existing (immutable)
    ones is very cheap.</li>

  <li>Clojure's approach to concurrency centers on using immutable
    data structures, which makes most code safe for parallel
    execution by default. When you do need to change state, it uses
    a Software Transactional Memory system to ensure that the
    changes are coordinated across threads. This means you never
    have to write any locks manually, which is usually the most
    error-prone kind of concurrency strategy. I haven't done much
    with the STM system yet, but being immutable by default means
    most confusing issues you run into with parallel code in other
    languages simply do not occur.</li>

  <li>The biggest shortcoming of Clojure is easily its packaging and
    command-line interface. Launching it from the shell involves
    simply invoking the <kbd>java</kbd> CLI launcher with the proper
    arguments; there are no shell scripts in the distribution. The
    problem with this is that you're supposed to know your classpath
    up front. When you're dealing with lisp code, the classpath acts
    a lot like the load path in other lisps, but when you're dealing
    with Java libraries you're supposed to specify each jar file up
    front. Libraries that you install into your system (say via
    apt-get) are not automatically visible to your programs; you
    actually have to change your shell invocation to get access to
    them. This is inconvenient and feels very awkward when you're
    used to a good integrated package manager. Fortunately this is
    not a problem intrinsic to the language; it's just what you get
    when you use a language that hasn't been around very
    long.</li>

  <li>Making up for this shortcoming is the excellent 
    <a href='http://common-lisp.net/project/slime/'>SLIME</a>
    interface. Instead of using the command-line launcher, you get a
    much more integrated experience by connecting to a Lisp process
    using Emacs. This lets you send new function definitions on the
    fly without reloading or restarting your whole process. You can
    even use SLIME to debug production servers. In the end, this
    more than makes up for the lousy command-line experience, but it
    takes a bit of getting used to if you're more familiar
    developing with short-lived processes that run a few tests and
    then exit.</li>
</ul>

<p>I'm looking at using
  the <a href='http://hashdot.sourceforge.net'>Hashdot</a> project
  to help improve the CLI situation. We're using it at work with
  JRuby, but it works with anything that's JVM-hosted. It gives you
  a better launcher and overall shell experience but also makes the
  process name look decent instead of the meaningless jumble of
  alphanumerics that <kbd>java</kbd> gives you out of the box and
  provides some d&aelig;monization help.</p>

<p>As a way of diving in, I'm using
  the <a href='http://github.com/weavejester/compojure/tree/master'>Compojure</a>
  web framework</a> to port over
  my <a href='http://technomancy.us/47'>RailsDay 06</a>
  application. Compojure is inspired by <a href='http://sinatra.rubyforge.org'>Sinatra</a>[<a href='#fn121-2'>2</a>], and it
  seems to be a pretty slick way to put together web apps, though
  overall the Clojure community is not nearly as web-centric as
  Ruby's.</p>

<img src='/i/clojure.gif' alt='clojure' align='left' />

<p>All in all, Clojure is an extremely impressive package. Lisp has
  always offered significant advantages in expressivity and power,
  but it's often come packaged in some rather disagreeable garb,
  like the ANSI Common Lisp standard that feels like it hasn't
  changed since the mid-80's or Elisp's lack of lexical
  scoping. Things that only made sense back then are stuck with most
  present-day lisps, but Clojure is very refreshing in the way that
  it learns from history while still being able to break away from
  it in places where it needs to.</p>

<hr>
<div class='footnotes'>
<p>[<a name='fn121-1'>1</a>] Clojure can make the Kessel Run in under
  twelve parsecs.</p>
<p>[<a name='fn121-2'>2</a>] Often described as "<a href='http://camping.rubyforge.org/files/README.html'>Camping</a> without the LSD".</p>
</div>
include(footer.html)
