dnl -*- html -*-
define(__timestamp, Sat 24 Apr 2010 10:44:44 PM PDT)dnl
define(__title, `in which a year is reflected upon')dnl
define(__id, 136)dnl
include(header.html)
<p>It's been <a href="/124">a year</a> since
    the <a href="https://www.pluralsight.com/courses/functional-programming-clojure">PeepCode
    screencast on Clojure</a> (now distributed under PluralSight)
    was released. While it's aged surprisingly well given the
    relative youth of the Clojure language (1.0 hadn't even been
    released at the time), there are a few things that could use
    some updates. I thought it would be helpful for me to step
    through <a href="http://github.com/technomancy/mire">Mire</a>,
    the sample project that's built up in the screencast, and update
    it to reflect the changes that have since occurred in the
    Clojure ecosystem.</p>

<pre class="code">
<span class="esk-paren">(</span>defproject mire <span class="string">"0.13"</span>
  <span class="builtin">:description</span> <span class="string">"A multiuser text adventure game/learning project."</span>
  <span class="builtin">:main</span> mire.server
  <span class="builtin">:dependencies</span> [[org.clojure/clojure <span class="string">"1.2.0"</span>]
                 [org.clojure/clojure-contrib <span class="string">"1.2.0"</span>]]
  <span class="builtin">:dev-dependencies</span> [[swank-clojure <span class="string">"1.3.0-SNAPSHOT"</span>]])</span>
</pre>

<h4><a href="http://github.com/technomancy/mire/commit/8dd4a5dd">Commit
    8dd4a5d</a>: Moving to Leiningen</h4>

<p>Probably the most obvious thing about the Mire project as it's
  seen in the screencast that shows its age is its ad-hoc
  build. (Step 12 of the screencast) At the time there weren't any
  good ways to build and distribute Clojure projects, so Mire simply
  contained a copy of Clojure and Contrib in its git repository and
  included a shell script to perform compilation and
  packaging. Apart from being just generally tacky, this actually
  caused the repository to bloat up by 16MB due to the fact that git
  is really lousy at storing binary files.</p>

<p>Kids these days have it so
  easy&mdash;<a href="http://github.com/technomancy/leiningen">Leiningen</a>
  is generally used for managing Clojure projects now. I'm not going
  to go into detail about this here since it's covered well
  elsewhere, namely in the readme
  and <a href="http://github.com/technomancy/leiningen/blob/master/TUTORIAL.md">tutorial</a>
  as well as
  the <a href="http://blip.tv/clojure/phil-hagelberg-making-leiningen-work-for-you-4733496">Leiningen
  presentation at the Clojure Conj</a>.
  There are other alternatives, but this is certainly the most
  straightforward. Leiningen gives you a basic skeleton to work from
  (<kbd>lein new</kbd>), handles dependencies specified in your
  project file, (<kbd>lein deps</kbd>) and creates jar files for
  you, (<kbd>lein jar</kbd>) among other things. In the latest
  version of leiningen, the <kbd>lein run</kbd> task can be used to
  launch the server.</p>

<h4><a href="http://github.com/technomancy/mire/commit/1326451b">Commit
    1326451b</a>: The player and rooms namespaces: alter-var-root</h4>

<p>The main thing that's going on here is replacing a
  non-toplevel <code>def</code> with a call
  to <code>alter-var-root</code>. It's never a good idea to
  call <code>def</code> from within a function. I tried to justify it by
  the fact that in this case it was a function that was only meant
  to be called at startup time as the docstring emphasized, (to
  initialize the rooms map) but it still felt wrong.</p>

<p>The problem is that the rooms map must be loaded from a bunch of
  files on disk, but the directory to load from isn't known until
  the <code>-main</code> function is called. So some mutability is
  called for here, but it's not really enough to justify a ref or an
  atom since once the server starts it will never change. In the
  updated version, <code>alter-var-root</code> replaces
  the <code>def</code>. It takes a var (<code>mire.rooms/rooms</code> in
  this case) along with a function to apply to the current value of
  the var and uses the return value as the new root value of the
  var. It's also possible to simulate change to a var
  using <code>binding</code>, but this only affects the current thread,
  and in this case we want the changes to be available to all
  threads.</p>

<p>Justifiable use of <code>alter-var-root</code> is rare, but
  startup-time mutability is one of those places it makes sense. For
  a more idiomatic use of <code>alter-var-root</code>
  see <a href="http://github.com/technomancy/robert-hooke">Robert
  Hooke</a>
  or <a href="http://github.com/Seajure/radagast">Radagast</a>.</p>

<p><b>Update</b>: In retrospect, a ref really is suitable here,
  since there's no reason the player's actions couldn't shift rooms
  around in some way. So mutability could happen at runtime. Since
  the mutability needs to be coordinated among players, a ref should
  be used rather than an
  atom. See <a href="https://github.com/technomancy/mire/commit/329056">commit
  329056.</p>

<h4><a href="http://github.com/technomancy/mire/commit/0dbd3402">Commit
    0dbd3402</a>: The commands namespace: contrib shuffle</h4>

<p>This one is pretty basic; it's mostly just adjusting to the new
  layout of Clojure Contrib. A number of namespaces got
  moved: <code>clojure.contrib.duck-streams</code>
  became <code>clojure.contrib.io</code>, <code>clojure.contrib.str-utils</code>
  became <code>clojure.contrib.string</code>, etc. In this case we
  switched from calling <code>clojure.contrib.str-utils/str-join</code>
  to <code>clojure.contrib.string/join</code>. <strike>Some of these namespaces
  (most of <code>io</code> and some of <code>seq</code>) will be promoted out
  of Contrib and into Clojure itself before the final 1.2.0
  release</strike>.</p>

<p><b>Update</b>: Following the release of Clojure 1.2 I replaced
  most of the contrib usage with the libraries that were promoted to
  Clojure. The only remaining use of contrib is the server-sockets
  library.</p>

<p>The other thing worth noting here is that in the original version
  of Mire there were a lot of unqualified calls to <code>use</code>,
  which bring in <i>all</i> the vars from the specified
  namespace. It's a lot more idiomatic now to either switch
  to <code>require</code> with <code>:as</code> to alias the namespace to a
  short name or to stick with <code>use</code> but to limit the list of
  vars using the <code>:only</code> qualifier to avoid pulling every
  single thing in, which is the approach taken here. This may seem
  like a bit of up-front busywork, but makes it easier to track down
  dependencies between namespaces and fix them in cases like the
  Contrib upgrade where things get switched around.</p>

<h4><a href="http://github.com/technomancy/mire/commit/0a0fa0fa">Commit
    0a0fa0fa</a>: Upgrade server namespace: the resources directory</h4>

<p>Here we see more careful <code>use</code> usage along with moving the
  room data files from <code>data/rooms/</code>
  to <code>resources/rooms/</code> following Leiningen conventions. The
  resources dir is meant for files that aren't code but are still
  used by the project, like HTML templates or data files like the
  rooms that Mire uses. They will get included in the jar file when
  the project is packaged.</p>

<h4><a href="http://github.com/technomancy/mire/commit/43ce1f4e">Commit
    43ce1f4e</a>: The test suite: clojure.test and use-fixtures</h4>

<p>In the Clojure 1.1 release the <code>test-is</code> library got
  promoted from Contrib into Clojure itself, so that's reflected
  here. We also move them to a separate <code>test</code> directory to
  reflect Leiningen convention. The tests for <code>mire.rooms</code>
  now uses the <code>use-fixtures</code> function, which is a great way
  to abstract out common setup to be shared among tests.</p>

<p>While OOP test frameworks use setup/teardown methods,
  the <code>use-fixtures</code> feature of <code>clojure.test</code> takes
  advantage of the fact that tests themselves are functions. A
  fixture is simply a function that takes a function argument. In
  our case the fixture just runs the function inside some bindings,
  but other common uses of fixtures are to create data on disk in a
  try/finally block and clean up when it finishes or to
  conditionally run the tests only if a given network service is
  accessible. There's a lot of flexibility with <code>clojure.test</code>
  fixtures.</p>

<h4>What Isn't Here</h4>

<p>There have been a lot more new features introduced to Clojure
  since Mire was released. We haven't
  covered <a href="/132">transients</a>, <a href="http://clojure.org/protocols">protocols</a>,
  <a href="http://clojure.org/datatypes">deftype</a>, or
  the <a href="http://debasishg.blogspot.com/2010/04/thrush-in-clojure.html">thrush
  combinators</a> mostly because these aren't introductory-level
  topics, but also because they're the trendy new exciting topics
  and have been covered well elsewhere. <b>Update</b>: two other
  potentially confusing topics that have gotten a thorough blog
  treatment since this was written
  are <a href="http://copperthoughts.com/p/clojure-io-p1/">I/O
  courtesy of Isaac Hodes</a>
  and <a href="http://blog.8thlight.com/articles/2010/12/6/clojure-libs-and-namespaces-require-use-import-and-ns">the
  ns clause courtesy of Colin Jones</a>. I hope this has been
  enough to modernize the Mire project and help extend the relevance
  of the screencast and associated codebase. Thanks for tuning
  in!</p>

<p><b>Update</b>: <a href="https://github.com/technomancy/mire/commit/87daea26b866d7">the
    latest commit</a> updates the codebase for Clojure 1.4.0 by
    removing the last vestige of the old monolithic contrib.</p>
include(footer.html)
