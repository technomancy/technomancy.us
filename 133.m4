<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Sun 31 Jan 2010 06:10:28 PM PST)dnl
define(__title, `in which, were a title to be summarized from the content, it would be altogether too similar to many of the titles used for past articles, possibly to the point of indistinguishability')dnl
define(__id, 133)dnl
include(header.html)
<p>Anyone who follows my exploits will have noticed I'm a tireless
  proponent of <a href="http://tromey.com/elpa">ELPA</a>, the Emacs
  Lisp Package Archive. As a maintainer of several Elisp libraries,
  ELPA makes my life easier by helping me sidestep the boring
  problems of distribution and installation. You may not know that
  package.el, the software behind ELPA, has been submitted for
  inclusion in the next version of Emacs. I've taken up the task of
  getting it ready.</p>

<img src="/i/flight-museum.jpg" alt="museum of flight bridge"
     class="right" />

<p>Including something like package.el into Emacs is a big job, and
  it's something that can only happen gradually. Emacs comes with a
  number of applications such as <a href="http://orgmode.org">Org
  Mode</a> and <a href="http://gnus.org">Gnus</a> that are developed
  externally to Emacs and merged periodically into the main Emacs
  source tree. If they were to be redone as packages they could
  still be distributed with Emacs builds but kept out of the source
  tree. They could also be upgraded and installed/removed
  independently of Emacs' historically long release cycles.</p>

<p>If you've submitted packages to ELPA before, you know it's a
  process that could use some streamlining. Currently it's all done
  by email, and packages must be manually uploaded by a single
  maintainer before they appear to users. This has long been the
  biggest shortcoming of ELPA. I've written some additions
  (package-maint.el) that allow you to automate the maintenance of a
  package source. Basically you provide it with a list of git URLs,
  and it will check out each tagged version and create a package
  from it. Of course, that wouldn't be useful without giving clients
  the ability to get packages from multiple sources at once, which I
  also added to package.el.</p>

<p>If you maintain any Emacs packages of your own, please try out
  <a href="http://github.com/technomancy/package.el">my changes to
  package.el</a>. If you use any of my packages, try upgrading and
  adding my package source to your list.</p>

  <pre class="code">(add-to-list 'package-archives
             '("technomancy" . "http://repo.technomancy.us/emacs/") t)</pre>

  <p>That way you'll get access to my updates as soon as they're
    tagged rather than waiting for them to be manually uploaded,
    though currently the latest versions of all my packages are in
    ELPA. Next steps are closer integration with Emacs in order to
    have packages installable on a system-wide level as well as a
    per-user level, prerelease version number support, and
    extraction of some built-in Emacs libraries as
    packages. Suggestions, bug reports, and patches welcome!</p>

  <p><b>Update</b>: package.el has been <a href="http://bit.ly/pkg-el">
  integrated into Emacs 24</a>. If you use Emacs 23, please use <a href="http://bit.ly/pkg-el23">this version instead</a>.</p>

  <p><b>Update</b>: I've started using <a href="https://marmalade-repo.org">Marmalade</a> instead of maintaining my own repository.</p>

  <p><b>Update</b>: Never use any package repository that doesn't have
    TLS, including Marmalade. In fact, you should probably just
    install packages using your version control system you're already
    using for your dotfiles.</p>

include(footer.html)
