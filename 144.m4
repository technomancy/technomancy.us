dnl -*- html -*-
define(__timestamp, Thu 30 Dec 2010 20:32:42 AM PST)dnl
define(__title, `in which the author sighs and realizes he publishes very few posts which do not contain the word package')dnl
define(__id, 144)dnl
include(header.html)
<p>As someone who maintains a fair amount of Emacs libraries, I've
  long been in search of improvements to the release process. I've
  <a href="/133">lobbied for including package.el in
    Emacs itself</a>, which finally happened over the summer. But
    political concerns interfered a bit, and it is only configured
    to point
    to <a href="http://elpa.gnu.org/packages/archive-contents">the
    FSF package repository</a> out of the box. This repository only
    accepts code for which copyright has been granted to the Free
    Software Foundation. At the time of this writing it has only six
    packages in it compared to ELPA's 130, making it somewhat less
    useful than it could be. For a number of
    reasons[<a href="#fn1">1</a>] the copyright assignment policy
    doesn't work for the packages I maintain, so this was a bit
    disappointing to me.</p>

<img src="/i/corn.jpg" 
     alt="some corn or something, I dunno man. unrelated."
     title="some corn or something, I dunno man. unrelated."
     class="right" />

<p>On the other hand, I was able to add support for multiple package
  sources to package.el before it was included in Emacs. This allows
  users to add alternate third-party sources like the
  original <a href="http://tromey.com/elpa">ELPA</a> repository. I
  should note here that there's been some confusion regarding the
  difference between package.el and ELPA which I must admit to
  having helped spread at one point. To be precise, package.el is
  the package manager, while ELPA is the original package source
  from which most packages so far have been hosted. The term "ELPA"
  is often mistakenly used to refer to package.el because for a long
  time package.el was hard-coded to only download from ELPA, but now
  that it supports multiple sources it's important to make a
  distinction between them.</p>

<p>Unfortunately ELPA is still manually curated with package
  submission over email, so it can take weeks or even months for new
  versions of my libraries to become available. I've started my own
  package source
  at <a href="http://repo.technomancy.us/emacs">http://repo.technomancy.us/emacs</a>,
  but it turns out maintaining a package source consisting of a
  bunch of static files is not a lot of fun and can be error
  prone. Luckily Nathan Wizenbaum has cooked
  up <a href="https://marmalade-repo.org">Marmalade</a>, a community
  package source that allows users to upload their own packages much
  like <a href="http://clojars.org">Clojars</a>
  or <a href="http://rubygems.org">Rubygems.org</a>. While it hasn't
  seen much use yet, it's quite promising as a way for elisp authors
  to get their code out to users. The following snippet will add
  Marmalade as a repository:</p>

<pre class="code">(<span class="keyword">require</span> '<span class="constant">package</span>)
(add-to-list 'package-archives
             '(<span class="string">"marmalade"</span> . 
               <span class="string">"https://marmalade-repo.org/packages/"</span>) t)
(package-initialize)</pre>

<p>You'll need to run <kbd>M-x package-refresh-contents</kbd>
  manually to download the latest package list. If you are using
  Emacs 23 you can <a href="http://bit.ly/pkg-el23">download a
  compatible package.el</a>. The version from tromey.com doesn't
  support multiple archive sources.</p>

<p>Moving forward I'm planning on uploading the packages I maintain
  over to Marmalade. It offers a much faster turnaround time
  for updates than the old system of submitting by email to
  ELPA. I've already uploaded my Clojure libraries and am working
  on a version of
  the <a href="http://github.com/technomancy/emacs-starter-kit">Emacs
  Starter Kit</a> that is structured as a set of packages in order
  to be more modular. (The new Starter Kit only targets Emacs 24 and
  up, so at this point it's intended for the adventurous.) Happy hacking!</p>

<p><b>Update</b>: I can no longer in good conscience recommend the
  use of package.el since at the time of this writing there are no
  community repositories which offer installation over SSL or signed
  packages. I have switched over to
  using <a href="https://github.com/dimitri/el-get/pull/1856">el-get</a>
  with <tt>(setq el-get-allow-insecure nil)</tt>. This will
  blacklist all recipes that attempt to install over a non-encrypted
  connection.
</p>

<hr />

<div class="footnotes">
<p>[<a name="fn1">1</a>] The main reason being that I could never
  bring myself to answer the question "can you apply this patch?"
  with "well that depends, <a href="http://achewood.com/index.php?date=11222006">do you have a fax machine</a>?".</p>
</div>
include(footer.html)
