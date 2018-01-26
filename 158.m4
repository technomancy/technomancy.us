dnl -*- html -*-
define(__timestamp, 2012-02-29T00:57:50Z)dnl
define(__title, `in which we coin a term which is the opposite of deprecate')dnl
define(__id, 158)dnl
include(header.html)
<p>Earlier this month
  I <a href="http://lein-survey.herokuapp.com/results">published the
  results</a> of a survey I had posted for Leiningen users. I got a
  lot of great data, but I especially appreciated the free-form
  "other comments" section that let people just ramble. I was happy
  to see that many of the suggestions have already been implemented
  in the ongoing work on Leiningen 2.</p>

<blockquote>I still think lein-multi should be rolled into core so
  people can be encouraged to test cross-version.</blockquote>

<h4>Profiles</h4>

<p>This brings me to what is probably the biggest feature in
  Leiningen 2.0: profiles. In Leiningen 1 we had some special
  cases to segregate out "dev" mode from the rest so you would only
  have certain dependencies or directories available during
  development. This is useful to have, but the implementation was
  pretty ad-hoc and riddled with special cases. During
  some <a href="/155">discussion with the Cake developers</a> we
  talked about whether that could be generalized, which turned into
  the idea of profiles.</p>

<p>So now rather than a handful of project configuration keys that
  are only active during development time, we have a <tt>:dev</tt>
  profile that's active by default where you can keep your
  additional test-only <tt>:dependencies</tt>
  and <tt>:resource-paths</tt>. You can also keep all
  your <tt>:plugins</tt> that you want active across all projects in
  the <tt>:user</tt> profile rather than using <kbd>lein plugin
  install</kbd>. That way there is only ever one plugin list active
  at a time, meaning it can be de-duplicated, avoiding messy conflicts.</p>

<p>But you can also create profiles for other situations:</p>

<pre class="code"><span class="esk-paren">(</span>defproject clj-http <span class="string">"0.3.3-SNAPSHOT"</span>
  <span class="constant">:description</span> <span class="string">"A Clojure HTTP library"</span>
  <span class="constant">:url</span> <span class="string">"https://github.com/dakrone/clj-http/"</span>
  <span class="constant">:min-lein-version</span> <span class="string">"2.0.0"</span>
  <span class="constant">:dependencies</span> [[org.clojure/clojure <span class="string">"1.3.0"</span>] <span class="comment-delimiter">; </span><span class="comment">elided below...
</span>                 [org.apache.httpcomponents/httpclient <span class="string">"4.1.2"</span>]
                 [cheshire <span class="string">"2.2.0"</span>]]
  <span class="constant">:profiles</span> {<span class="constant">:dev</span> {<span class="constant">:dependencies</span> [[ring/ring-jetty-adapter <span class="string">"1.0.2"</span>]
                                  [ring/ring-devel <span class="string">"1.0.2"</span>]]}
             <span class="constant">:1.2</span> {<span class="constant">:dependencies</span> [[org.clojure/clojure <span class="string">"1.2.1"</span>]]}
             <span class="constant">:1.4</span> {<span class="constant">:dependencies</span> [[org.clojure/clojure <span class="string">"1.4.0-beta1"</span>]]}}
  <span class="constant">:aliases</span> {<span class="string">"all"</span> [<span class="string">"with-profile"</span> <span class="string">"dev,1.2:dev:dev,1.4"</span>]}<span class="esk-paren">)</span></pre>

<p>Here you can see the <tt>:dev</tt> profile with some handy
  dependencies used for testing, but there are also profiles
  for <tt>:1.2</tt> and <tt>:1.4</tt> that can be used like lein
  multi. The <tt>with-profile</tt> task is used to apply alternate
  profiles to a given task run:</p>

<pre>$ lein with-profile dev,1.2 test
Performing task 'test' with profile(s): 'dev,1.2'

Testing clj-http.test.client

Testing clj-http.test.cookies

Testing clj-http.test.core

Ran 47 tests containing 175 assertions.
0 failures, 0 errors.</pre>

<p>You can see that commas allow multiple profiles to be specified
  at once. You can also use colons to chain together profile sets
  sequentially:</p>

<pre>$ lein with-profile dev:dev,1.2:dev,1.4 test
Performing task 'test' with profile(s): 'dev'
[...]
Performing task 'test' with profile(s): 'dev,1.2'
[...]
Performing task 'test' with profile(s): 'dev,1.4'
[...]</pre>

<p>Of course, since <tt>with-profile</tt> is a higher-order task, it
  can accept any other task as an argument, not just <tt>test</tt>.
  So you could use it for deploying to different environments or
  any place where you'd want an alternate set of project
  configuration values.</p>

<h4>Aliases</h4>

<p>You'll also notice that the <tt>:aliases</tt> entry in the
  <tt>defproject</tt> above maps a string to a vector. This is a new
  feature about which I am unreasonably pleased. You've always been
  able to add aliases for Leiningen tasks; this is how <kbd>lein
  halp</kbd> has worked. But now you can actually alias a string to
  a partial application of a task:</p>

<pre class="code"><span class="constant">:aliases</span> {<span class="string">"all"</span> [<span class="string">"with-profile"</span> <span class="string">"dev,1.2:dev:dev,1.4"</span>]}</pre>

<p>This means that <kbd>all test</kbd> translates into
  calling <kbd>with-profile dev,1.2:dev:dev,1.4 test</kbd>. But
  partially-applied aliases have other uses as well:</p>

<pre class="code"><span class="constant">:aliases</span> {<span class="string">"reflect"</span> [<span class="string">"assoc"</span> <span class="string">":warn-on-reflection"</span> <span class="string">"true"</span> <span class="string">"compile"</span>]}</pre>

<p>This allows you to invoke <kbd>lein reflect</kbd> to get a list
  of all your reflection warnings. Note that in this
  case <kbd>assoc</kbd> refers to the task that comes from
  the <a href="https://github.com/technomancy/lein-assoc">lein-assoc</a>
  plugin, not the <kbd>clojure.core/assoc</kbd> function. Each
  string in the alias vector is interpreted the same way as if it
  were a direct command-line argument to the <kbd>lein</kbd> script,
  which is why strings must be used. In this case reading it into
  keywords and booleans happens inside the <kbd>assoc</kbd>
  task.</p>

<p>And that's one of the neat things about having tasks as functions.</p>

<h4>Repl</h4>

<p>The <kbd>repl</kbd> task has been rewritten from the ground-up by
  Colin Jones. The new version supports a JVM-native readline
  implementation as well as thorough completion and nREPL support.</p>

<h4>Preview</h4>

<p>By this point I'm sure you're thinking to yourself, "Gosh, that
  sounds super; I wish I could use it now!" In fact, Leiningen 2 is
  already pretty usable and stable if you don't mind running from
  git. You need a copy of Leiningen 1.x around to bootstrap it, but
  running <kbd>lein install</kbd> inside the <tt>leiningen-core</tt>
  directory should get you to the point where you can
  symlink <tt>bin/lein</tt> to somewhere on your path and have it
  work. I recommend linking it as <tt>lein2</tt> for the time being
  since you'll probably still need an installation of 1.x easily
  accessible.</p>

<p>Of course, being a major version increment it's got some
  backwards-incompatibilities. Fresh from witnessing the very bumpy
  transition to Clojure 1.3, I'd rather avoid that for Leiningen 2,
  so taking a cue from golang's <tt>gofix</tt> tool, I've
  released the <tt>lein-precate</tt> plugin.</p>

<p>Precate, obviously, is the opposite of deprecate. The idea is
  that you could run it on your project and have it spit out a new
  <tt>project.clj</tt> which would be compatible with Leiningen 2.
  It's not perfect, but it should provide you with a starting point
  for your transition:</p>

<pre>$ lein plugin install lein-precate 0.3.0
$ cat project.clj # the original 1.x-compatible version:
(defproject clojure-http-client "1.1.1-SNAPSHOT"
  :description "An HTTP client for Clojure."
  :source-path "src/clj"
  :extra-classpath-dirs ["dumb-stuff"]
  :dev-dependencies [[swank-clojure "1.3.4"]]
  :dependencies [[org.clojure/clojure "1.2.1"]
                 [org.clojure/clojure-contrib "1.2.0"]])

$ lein precate # let's see how that would look for Leiningen 2
(defproject clojure-http-client "1.1.1-SNAPSHOT"
  :description "An HTTP client for Clojure."
  :source-paths ["src/clj"]
  :dependencies {org.clojure/clojure "1.2.1", 
                 org.clojure/clojure-contrib "1.2.0"}
  :profiles {:dev
              {:resource-paths ["dumb-stuff"],
               :dependencies {swank-clojure "1.3.4"}}}
  :min-lein-version "2.0.0")</pre>

<p>Unfortunately that output had to be manually edited a bit for cosmetic
  reasons; Clojure's pretty-printer doesn't really know what to do
  with <code>defproject</code> forms. But it should cover most of
  the changes necessary to take your project into the exciting new
  world of Leiningen 2. The biggest changes will come from the move
  from <tt>:dev-dependencies</tt> to <tt>:dependencies</tt> in
  the <tt>:dev</tt> profile. But this is not a foolproof translation
  since in Leiningen 2 <tt>:dependencies</tt> only run in the
  context of the project itself, while in Leiningen
  1 <tt>:dev-dependencies</tt> ran in both Leiningen and the
  project. In retrospect this was a design mistake, but there are a
  number of plugins out there that take advantage of this fact and
  will need to be split into separate artifacts for the parts that
  run in Leiningen vs the parts that run in the project. I've taken
  some time to adapt some of the most commonly-used plugins for this
  change, but I'm sure I missed some of the more obscure ones.</p>

<p>The plan from here is to polish off a few more features and cut a
  preview release. The preview will still be missing a handful of
  the more obscure features from Leiningen 1 like shell wrappers and
  selective transitive class file cleaning, but for the vast
  majority of projects it should be usable for everyday work. See
  the "post-preview" section
  of <a href="https://github.com/technomancy/leiningen/blob/master/todo.org">the
  todo file</a> for details on what's remaining. The hope is to have
  it ready at latest by
  the <a href="http://clojurewest.org/">Clojure/West
  conference</a>. Enjoy!</p>

<p><b>Update</b>: Leiningen
    2.0.0 <a href="https://github.com/technomancy/leiningen/blob/2.0.0/NEWS.md">has
    been released</a>! See
    the <a href="https://github.com/technomancy/leiningen/wiki/Upgrading">upgrade
    guide</a>.</p>
include(footer.html)
