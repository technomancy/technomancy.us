dnl -*- html -*-
define(__timestamp, 2009-11-26T06:28:10Z)dnl
define(__title, `in which projects may be more easily compiled and distributed')dnl
define(__id, 131)dnl
include(header.html)
<a href="http://www.flickr.com/photos/31151628@N03/4010921064/"><img src="i/leiningen.jpg" alt="leiningen portrait" class="right" /></a>
<p>So build tools have been a long-standing pain point when working
  on Clojure projects. Most projects have used JVM-centric tools
  like ant or maven, which are far more complicated than what you
  need to build Clojure, and on top of that must be configured with
  XML. It could be made to work, and in the case of projects with
  significant dependencies it was much better than doing it by hand,
  but it was a pain.</p>

<p>Last week I
  launched <a href="http://github.com/technomancy/leiningen">Leiningen</a>,
  which is a project that brings a native build tool to Clojure. It
  seems to have people pretty excited about it, which leads me to
  believe I'm far from the only one who's been feeling the pain
  here. It's configured using a Clojure file called project.clj like
  the sample below.</p>

<pre class="code"><span class="esk-paren">(</span>defproject leiningen <span class="string">"1.0.0-SNAPSHOT"</span>
  <span class="builtin">:description</span> <span class="string">"A build tool designed not to set your hair on fire."</span>
  <span class="builtin">:main</span> leiningen.core
  <span class="builtin">:dependencies</span> [[org.clojure/clojure <span class="string">"1.1.0-alpha-SNAPSHOT"</span>]
                 [org.clojure/clojure-contrib <span class="string">"1.0-SNAPSHOT"</span>]
                 [ant/ant-launcher <span class="string">"1.6.2"</span>]
                 [org.apache.maven/maven-ant-tasks <span class="string">"2.0.10"</span>]]
  <span class="builtin">:dev-dependencies</span> [[org.clojure/swank-clojure <span class="string">"1.0"</span>]]<span class="esk-paren">)</span></pre>

<p><b>Update</b>: Leiningen now has
  a <a href="https://github.com/technomancy/leiningen/blob/master/TUTORIAL.md">tutorial</a>
  that is much more comprehensive than this.</p>

<h3>Testing</h3>

<p>This one's pretty straightforward: <kbd>lein test</kbd> searches
  the test/ directory for namespaces and runs the tests in each.</p>

<h3>Building</h3>

<p>Running <kbd>lein jar</kbd> will compile your code and package it
  up as a .jar file. If you specify a <code>:main</code> class in
  your project config, this will be an executable jar with the class
  you specified. If you just want to compile your code, there's
  a <kbd>compile</kbd> task for that too. Alternatively if you want
  to build a standalone jar that includes all your project's
  dependencies for easier distribution, you can do that
  with <kbd>lein uberjar</kbd>.</p>

<h3>Dependency Management</h3>

<p>This is the fun part. Rather than tracking down and downloading
  all your dependency jars manually (or worse: <i>checking them
  in</i> to your source repository), Leiningen provides
  a <kbd>deps</kbd> task to automatically download them and place
  them in the lib/ directory. This uses some Maven code under the
  covers, but don't panic&mdash;you won't have to see a bit of XML
  unless you want to. It pulls from the central Maven repositories
  by default as well as
  from <a href="http://build.clojure.org">Clojure's nightly builds</a>
  and <a href="http://clojars.org">http://clojars.org</a>. Clojars
  has built-in search, but if you want to pull a library from the
  central repository, you can search for it
  on <a href="http://jarvana.com">Jarvana</a>. You can also specify
  development dependencies with the <code>:dev-dependencies</code>
  key for things that shouldn't be pulled in at production or
  included in the standalone jar; the syntax is the same.</p>

<h3>Publishing with Clojars</h3> <p>By a stroke of luck I dropped
hints about Leiningen the week before I made a public announcement
only to find out that Alex Osborne was approaching the same problem
from the other direction.  He'd been cooking up a web site and
service for hosting Clojure libraries independently of my work on
Leiningen, and we started talking about ways to integrate the
two. So now Leiningen makes it easy to publish jars publicly via
Clojars so other projects can depend on them. The day after
announcing Clojars, Alex was <a
href="http://www.infoq.com/news/2009/11/clojars-leiningen-clojure">interviewed
on InfoQ</a> about the site and how it interacts with Leiningen, so
I was thrilled to see both our projects getting exposure so
quickly.</p>

<h3>Coming Soon...</h3> <p>Soon after the 0.5.0 release, Alex along
with Dan Larkin (of the wonderful <a
href="http://github.com/danlarkin/clojure-json">Clojure JSON
library</a> fame) started diving in and adding
features. <strike>We've got <a
href="http://github.com/technomancy/leiningen/blob/master/todo.org">a
few more tasks</a> on the plate targeted for a 1.0 release, but
should be right around the corner.</strike> <b>Update</b>: <a
href="http://github.com/technomancy/leiningen/blob/1.0.0/NEWS">Leiningen
1.0 released</a>. If you'd like to say hi or drop a line, there's
a #leiningen channel on freenode as well as a <a
href="http://groups.google.com/group/leiningen">mailing
list</a>. If you found this useful, you should take a look at the <a href="https://www.pluralsight.com/courses/functional-programming-clojure">Clojure PluralSight screencast</a>.</p>

<p>Logo by <a href="http://lorenbroach.blogspot.com/">Loren Broach</a>.</p>

include(footer.html)
