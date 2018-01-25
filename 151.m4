<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Fri 29 Jul 2011 12:27:51 PM PDT)dnl
define(__title, `in which an operating system makes trade-offs')dnl
define(__id, 151)dnl
include(header.html)
<p>I've been a user of
  Debian's <a href="http://wiki.debian.org/Apt">apt-get</a> package
  manager for nearly as long as I've been serious about computers,
  and I love it. Going back to a system that lacked apt's depth and
  stability would be like having to write with my non-dominant hand
  or worse&mdash;going back to typing on a QWERTY layout. I have
  seamless access to everything I need[<a href="#fn1">1</a>], and it
  never breaks unless I do something crazy like add unsupported
  third-party repositories or run the unstable distribution. Who
  could ask for more? So I'm quite proud to see
  <a href="https://github.com/technomancy/leiningen">Leiningen</a>
  <a href="http://anonscm.debian.org/gitweb/?p=pkg-java/leiningen.git">getting
  packaged for Debian</a> with lots of help from the Java
  Maintainers team.</p>

<img src="/i/rice.jpg" alt="debian rice" class="right" />

<p>It's interesting to get a look inside the sausage factory of
  packaging. The biggest hurdle for me as I was learning the ropes
  was that all the packaging introductions assume you are building a
  C program and
  have <a href="http://twitter.com/technomancy/status/85930967025459202">familiarity
  with makefiles</a>. You can tell that the packaging culture has
  its roots in C, and packages from other runtimes feel a bit
  foreign.[<a href="#fn2">2</a>] Even more so with a language like
  Clojure... you're off into unexplored territory, blazing your own
  trail.</p>

<p>The biggest change from what I'm used to is the notion that only
  a single version of a package can be installed at a time. I think
  I understand the motivation here: it's crucial that when a
  security vulnerability is reported the affected packages and all
  those that depend on them have access to the fix. I'm used to
  developer-focused package managers that allow many versions to be
  installed side-by-side, but that places the burden of security
  updates on the developers using it since it's common for packages
  to depend on exact versions rather than allowing bugfix versions
  to sneak in. It's a lot more work to track down security issues, but
  this is not a big deal in the context of developer-centric systems
  since these particular users are less likely to mind having to pay
  attention to that sort of detail; it's what they're paid to
  do.</p>

<p>So there's a real tension here; end users want packages to just
  work and be safe without thinking about them while developers
  demand repeatability and control. Developers need the flexibility
  to choose exactly when they want to pull in new versions of
  libraries, while end users want things to hum along out of
  sight.</p>

<p>The problem is that the one-version-of-a-package-at-a-time policy
  doesn't always work in practice. Over time backwards compatibility
  is the exception rather than the rule; in many cases there simply
  is no substitute for having multiple versions of a package
  installed simultaneously. And apt's answer here is just to create
  a new package with the incompatible version number as part of the
  package name. There's no clue that these packages are related, and
  upgrades won't pick the new versions up. This is quite a shame,
  because I love everything else about apt. I look at complicated
  production deployment schemes and think to myself how much simpler
  things would be if deploying were just a matter of adding our
  internal apt repository and running apt-get install,
  but... versions.</p>

<p>Of course, these gripes are not really relevant to having
  Leiningen in Debian.[<a href="#fn3">3</a>] Users of Debian-based
  systems will be well-served by getting Leiningen through their OS,
  and once it's on their system, they're free to use it to solve
  their developer-centric problems. This plays to the strengths of
  each system, and everybody wins.</p>

<p><b>Update</b>: Leiningen has
  been <a href="http://packages.qa.debian.org/l/leiningen.html">accepted
    into Debian</a>.</p>

<hr />

<div class="footnotes">
<p>[<a name="fn1">1</a>] Except Emacs; that's the only thing I still
  build myself from
  source. Though <a href="http://emacs.naquadah.org/">http://emacs.naquadah.org</a>
  looks like it delivers perfectly passable builds of 24 if you're
  not interested in any of
  the <a href="http://bzr.savannah.gnu.org/lh/emacs/concurrency/files">experimental</a>
  <a href="http://bzr.savannah.gnu.org/lh/emacs/xwidget/files">branches</a>.</p>

<p>[<a name="fn2">2</a>] It's especially noticeable with Ruby and
  the JVM. Part of this is due to the fact that the JVM has only
  been free software for a relatively short period of time, and a
  lot of the existing culture around Java distribution goes against
  the grain of repeatable builds by ignoring source and shuttling
  binary bytecode around everywhere.</p>

<p>[<a name="fn3">3</a>] And it's looking like it'll make it into
  Ubuntu 11.10 as well.</p>
</div>
include(footer.html)
