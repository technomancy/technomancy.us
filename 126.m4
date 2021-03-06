dnl -*- html -*-
define(__timestamp, 2009-05-28T00:35:46Z)dnl
define(__title, `in which are found tricks of the trade concerning clojure authorship')dnl
define(__id, 126)dnl
include(header.html)
<p>So it turns out getting set up to write Clojure code can be a
  little tricky. There are a lot of disconnected tidbits about how folks
  have figured out how to configure things, but it can be a bit
  tricky to tell the difference between, "hey, this is how I finally
  got it to work" and "this is how you really should be doing it". I
  figure I know about as much about using Clojure with Emacs as
  anybody, so here's a run-through of how I've done my setup. There
  are a lot of moving parts, but bear with me; most of the
  installation is automated.</p>

<p><b>Update</b>: This is all super old and you should just
  use <a href="https://github.com/sanel/monroe">Monroe</a> instead.</p>

<a name="pieces"></a>
<h3>The Pieces</h3>

<dl>
  <dt><a href='http://tromey.com/elpa'>ELPA</a></dt>
  <dd>The Emacs Lisp Package Archive functions as a centralized
    store for Emacs libraries and provides automated installation and
    upgrades.</dd>

  <dt><a href='http://github.com/jochu/clojure-mode'>clojure-mode</a></dt>
  <dd>This gets you syntax highlighting, indentation, and other basic
    goodies for editing .clj files.</dd>

  <dt><a href='http://common-lisp.net/project/slime/'>SLIME</a></dt>
  <dd>The Superior Lisp Interaction Mode for Emacs was originally
    written to support interacting with Common Lisp subprocesses from
    within Emacs, but it's been extended to work with other
    lisps.</dd>

  <dt><a href='http://github.com/jochu/swank-clojure'>swank-clojure</a></dt>
  <dd>An adapter for SLIME that allows it to work with Clojure.</dd>

  <dt><a href='http://github.com/jochu/clojure-mode'>clojure-test-mode</a></dt>
  <dd>This provides support for running Clojure tests from within
    Emacs buffers and seeing the results displayed inline.</dd>

  <dt><a href='http://mumble.net/~campbell/emacs/paredit.el'>paredit</a></dt>
  <dd>Paredit auto-balances parentheses and other matched chars to
  make sure you don't end up with structurally invalid
  expressions.</dd> </dl>

<a name="installation"></a>
<h3>Installation</h3>

<p>The easiest way to get started is to grab ELPA. If you
  use <a href='http://github.com/technomancy/emacs-starter-kit'>Emacs
  Starter Kit</a> you've already got ELPA. (If you're new to Emacs,
  you might want to use the Starter Kit anyway as a base for your
  own customizations; also check out
  the <a href='https://www.pluralsight.com/courses/meet-emacs'>PeepCode
  screencast</a>.) Use <kbd>M-x package-list-packages</kbd> to pull
  up the package list. Move down to <code>clojure-mode</code> and
  press <kbd>i</kbd> to mark it for installation, then
  press <kbd>x</kbd> to go.</p>

<p>Once it's installed you should be able to work with .clj files,
  and you may be happy with just this. It has rudimentary subprocess
  support with <kbd>M-x run-lisp</kbd>, which is good enough for
  many, including Rich Hickey, the creator of Clojure. But most of
  us find it much more convenient to interact more richly with a
  running Clojure process as we code.</p>

<p><strike>Pressing <kbd>M-x clojure-install</kbd> will kick off the
  Clojure installation process. Once you choose a download location,
  it will download a number of repositories and compile Clojure
  itself, so it will take a few minutes. (It requires having git,
  Java 1.5+, and ant installed.)  When it's done, it will configure
  SLIME and swank-clojure, and it will give you instructions on a
  few lines to add to your personal config (usually found
  in <code>$HOME/.emacs.d/init.el</code>) so it will work for future
  sessions.</strike> Deprecated in favour
  of <a href="/swank-clojure.html">similar functionality in
  swank-clojure</a>.</p>

<a name="usage"></a>
<h3>Usage</h3>

<p>Hitting <kbd>M-x slime</kbd> will launch a new Clojure session in
  a <code>*slime-repl*</code> buffer. You can also interact with
  the <code>*inferior-lisp*</code> buffer, but the slime-repl buffer provides
  a higher-level interface with a few extra niceties. The REPL
  works as you'd expect, but you can hit <kbd>,</kbd> to activate
  some shortcuts, the most useful being <kbd>i</kbd> to change the
  current namespace (with tab-completion) and <code>restart</code>.</p>

<p>Back in your .clj buffers, <kbd>C-x C-e</kbd> has been rebound to
  execute the form under the point in Clojure instead of Elisp. This
  is handy, but you won't get accurate line numbers from stack
  traces involving functions loaded this way. Pressing <kbd>C-c
  C-k</kbd> will load the entire file and ensure stack traces come
  through accurately.</p>

<p>As you type out function calls, you should see their argument
  list show in the minibuffer. This is called <code>eldoc</code>, and
  it's a great way to get a quick refresher about what a function
  expects. For full documentation lookup you'll need to get handy
  with <kbd>C-c C-d d</kbd> though. Finally you can
  use <kbd>M-.</kbd> to jump to the definition of any given
  function.</p>

<a name="projects"></a>
<h3>Projects</h3>

<p>Of course, after a while you'll be done with just playing at the
  REPL and want to hack on a real project. Since the JVM doesn't
  allow you to modify the classpath at runtime, you need to specify
  up front where it should look for code. The simplest thing to do
  is add <code>src/</code>, <code>test/</code>, <code>lib/</code>,
  and <code>classes/</code> (for AOT compilation, if desired)
  directories in your project root to the classpath. Then you place
  your dependency jars in the <code>lib</code> directory. <strike>If
  you've got complicated dependencies, you could
  <a href='http://github.com/dysinger/clojure-pom'>use maven to
  manage them</a>, but if you've only got a couple it's not hard to
  do by hand.</strike>
  Use <a href="http://github.com/technomancy/leiningen">Leiningen</a>
  for dependency management and other build needs.</p>

<p>Invoking <kbd>M-x swank-clojure-project</kbd> will prompt you for
  a project root and start SLIME with the classpath configured
  appropriately.</p>

<a name="tests"></a>
<h3>Tests</h3>

<p>If you've written automated tests for your project using
  the <code>clojure.test</code> library (which you should), you can
  use <code>clojure-test-mode</code> to run them. Install it
  via <kbd>M-x package-list-packages</kbd>, and then you can
  use <kbd>C-c C-,</kbd> to run the tests in the current
  buffer. Failures and errors get highlighted, so if you want to see
  details about a failure, move the point to the red region and
  press <kbd>C-c C-'</kbd>.</p>

<h3>Happy Hacking</h3>

<p>I hope this is helpful and clears up some confusion. Now get out
  there and <a href='http://github.com/languages/Clojure'>write some
    code</a>.</p>

<p><b>Update</b>: If you are using Slime with both Clojure and
  Common Lisp, refer to the instructions
  at <a href='http://felipero.posterous.com/1446961'>http://felipero.posterous.com/1446961</a>.</p>

include(footer.html)
