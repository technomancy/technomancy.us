<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Thu 31 Mar 2011 08:03:55 PM PDT)dnl
define(__title, `in which secrets are kept')dnl
define(__id, 147)dnl
include(header.html)
<p>Back when Leiningen was <a href="/131">first launched</a> it
  coincided with the launch
  of <a href="http://clojars.org">Clojars</a>, the public community
  repository for Clojure
  projects. This <a href="http://www.infoq.com/news/2009/11/clojars-leiningen-clojure">worked
  out really well</a> for Clojure as far as the timing was
  concerned&mdash;it allowed the ecosystem to grow quickly.</p>

<img src="/i/chain-stump.jpg" alt="scenery" class="right" />

<p>But
  Clojars <a href="http://mobile.twitter.com/cemerick/status/45923604000555008">doesn't
  work for everything</a>; some situations call for libraries to be
  shared on a team without making them public. For cases like this
  it's necessary to publish to private repositories. This has been a
  really common question with Leiningen that hasn't had a good
  answer until recently; some folks bite the bullet and run <tt>lein
  install</tt> on every development machine while others set up
  shared static-file repositories maintained mostly by
  hand. At <a href="http://sonian.net">work</a> we've nginx'd up a
  directory that gets deployed to from our Hudson (soon to
  be <a href="http://jenkinsci.org">Jenkins</a>) jobs.</p>

<p>But the 1.5.0 release of Leiningen has added the <tt>deploy</tt>
  task along with
  a <a href="https://github.com/technomancy/leiningen/blob/stable/DEPLOY.md">deploy
  guide</a>. Now you can deploy to private repositories like
  instances of <a href="http://archiva.apache.org">Archiva</a> and
  <a href="http://nexus.sonatype.org">Nexus</a>. Just configure
  your <tt>:repositories</tt> in project.clj with the URL and
  credentials for uploading:</p>

<pre class="code" style="font-size: 90%;">
  <span class="builtin">:repositories</span> {<span class="string">"snapshots"</span> {<span class="builtin">:url</span> <span class="string">"http://blueant.com/archiva/snapshots"</span>
                              <span class="builtin">:username</span> <span class="string">"milgrim"</span> <span class="builtin">:password</span> <span class="string">"locative.1"</span>}
                 <span class="string">"releases"</span> <span class="string">"http://blueant.com/archiva/internal"</span>}</pre>

<p>If you're shy about checking passwords into project.clj, you can
  put them in <tt>~/.lein/init.clj</tt> as mentioned in
  the <a href="https://github.com/technomancy/leiningen/blob/stable/DEPLOY.md">deploy
  guide</a>. Note that the naming is significant; if you are
  deploying a <code>SNAPSHOT</code> version, it will go to the
  "snapshots" repository, while stable versions will go to the
  "releases" repository. Hopefully this is useful for teams
  collaborating on multiple projects in private.</p>

<p><b>Update</b>: Don't store your repository credentials in
  plaintext on your drive. Leiningen 2 features transparent GPG
  support if you store them in <tt>~/.lein/credentials.clj.gpg</tt>,
  which you should use instead.</p>
include(footer.html)
