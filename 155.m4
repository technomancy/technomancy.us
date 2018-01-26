dnl -*- html -*-
define(__timestamp, 2011-12-01T07:15:11Z)dnl
define(__title, `in which version two seems a treacherous stage')dnl
define(__id, 155)dnl
include(header.html)
<p>I recently got back from
  the <a href="http://clojure-conj.org/">Clojure Conj</a> conference
  in Raleigh. The sessions were great, but the main highlight for me
  was meeting with <a href="http://flatland.org/">the developers of
  Cake</a> (an alternate Clojure build tool) and discussing how we
  could collaborate on the future of build tools in Clojure. As
  was <a href="http://groups.google.com/group/leiningen/browse_thread/thread/5a79d02198a91b91">announced</a>
  <a href="https://groups.google.com/group/clojure-cake/browse_thread/thread/186ec36c2426996e">elsewhere</a>,
  we will be taking some features from Cake and merging them into
  Leiningen 2.0 as well as just having more hackers involved in
  development efforts.</p>

<p>The development of Leiningen 1.x pretty much just fell out of the
  usage patterns we saw during my time at Sonian as an early adopter
  of Clojure. We used Maven for eight months, tried to make it work,
  and then took our experience from the pain we saw there to
  Leiningen. Some features (especially checkout dependencies) arose
  directly from finding certain operations with multi-module Maven
  builds extremely cumbersome. But in general nearly everything
  about Leiningen so far has been obvious. I wouldn't say it
  practically wrote itself, but once the central model of a project
  map and resolving/applying tasks from defns was established, the
  only really tricky thing was being strict about establishing a
  narrow scope and knowing when to avoid adding features.</p>

<blockquote cite="http://twitter.com/#!/cemerick/status/131414628474437633">
  <p>"Version 2" is the most dangerous phase in a software
    project's life.</p>
  <footer>— <a href="http://twitter.com/#!/cemerick/status/131414628474437633">Chas
  Emerick</a></footer>
</blockquote>

<p>So now
  we're <a href="https://github.com/technomancy/leiningen/wiki/VersionTwo">digging
  into the question of what bigger-picture changes could be made</a>
  to improve Leiningen if we leave backwards-compatibility out of
  it. The biggest improvement we've seen implemented so far is
  switching over dependency resolution to the Aether library
  via <a href="https://github.com/cemerick/pomegranate">Chas
  Emerick's Pomegranate library</a>. Aether is a library that
  contains all the dependency management features from Maven
  extracted into an independent module&mdash;basically designed with
  exactly Leiningen's use case in mind.</p>

<p>But there's more coming. Cake has had the ability to run project
  code <a href="https://github.com/flatland/classlojure">in the same
  process as the build tool</a>, significantly speeding up many
  operations, which is in the process of being ported over to
  Leiningen. I've been working on explicitly delimiting the parts of
  Leiningen that comprise its public API as part
  of <a href="https://github.com/technomancy/leiningen/tree/master/leiningen-core">a
  separate "leiningen-core" library</a> which other tools can depend
  upon. We're looking at adding something like "profiles" do bundle
  up configuration sets which can be activated in given
  contexts.</p>

<p>With all these ideas flying around I hope we can buckle down and
  get some solid design discussions resulting in well-factored
  features. If you've been looking to contribute, now is a great
  time. Join the <tt>#leiningen</tt> channel on Freenode and hop on
  the <a href="http://groups.google.com/group/leiningen/">mailing
  list</a>.</p>
include(footer.html)
