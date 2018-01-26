dnl -*- html -*-
define(__timestamp, Fri 28 Oct 2011 10:21:54 AM PDT)dnl
define(__title, `in which the lesser-known are brought to the forefront')dnl
define(__id, 154)dnl
include(header.html)
<p>In my time hacking in Clojure I've found a bunch of
  under-appreciated Clojure libraries of which I'm rather fond. I
  thought it'd be helpful to share, so here they are:</p>

<h4><a href="https://github.com/maravillas/lein-multi">lein-multi</a></h4>

<p>As support for Clojure 1.3 becomes widespread, it becomes more
  important for projects to think about backwards compatibility. You
  can specify a range of versions for Clojure in <tt>project.clj</tt>
  with <code>[org.clojure/clojure "[1.2.0,1.3.0]"]</code>, but when
  you're developing, it will just find the latest and pull that in,
  so it's easy for dependence on 1.3-specific features to sneak
  in.</p>

<p>Enter lein-multi, a plugin for running arbitrary tasks against
  multiple dependency sets. It's most commonly used with
  the <kbd>test</kbd> task, but it's a general higher-order task
  that can be applied to any other just as well.
  Seeing <tt>lein-multi</tt> in someone's project.clj is a good
  indicator that they take backwards-compatibility seriously.
</p>

<p><b>Update</b>: Leiningen 2 supports this out of the box using
  profiles, so the <tt>lein-multi</tt> plugin is deprecated.</p>

<p><code>[lein-multi "1.0.0"]</code></p>

<h4><a href="https://github.com/mmcgrana/clj-stacktrace">clj-stacktrace</a></h4>

<img src="i/clj-stacktrace.png" alt="stack trace" class="right" />

<p>The most common complaint I hear about developing in Clojure is
  the fact that its error messages often obscure the true cause of
  the problem. While practice helps here, it's still true that
  there's a lot of irrelevant detail here that can overwhelm the
  trained eye. Mark McGranaghan's clj-stacktrace library does a
  great job at summarizing stack traces by aligning each frame,
  making the namespace distinct from the function name, and even
  coloring frames differently based on whether they come from
  Clojure, Java, or user code. The next version should let you
  filter out frames that are deemed irrelevant on a per-project
  basis.</p>

<p>To use it in your project's repl as well as
  in <code>clojure.test</code> error reporting, place this code
  in <tt>~/.lein/init.clj</tt> after running <kbd>$ lein plugin
  install clj-stacktrace 0.2.4</kbd>:</p>

<pre class="code"><span class="esk-paren">(</span><span class="variable-name">require</span> 'leiningen.hooks.clj-stacktrace-test<span class="esk-paren">)</span>

<span class="esk-paren">(</span><span class="keyword">def</span> <span class="function-name">settings</span> {<span class="constant">:repl-options</span> [<span class="constant">:init</span> <span class="esk-paren">(</span><span class="variable-name">require</span> 'clj-stacktrace.repl<span class="esk-paren">)</span>
                              <span class="constant">:caught</span> 'clj-stacktrace.repl/pst+]}<span class="esk-paren">)</span></pre>

<h4><a href="https://github.com/scgilardi/slingshot">slingshot</a></h4>

<p>Another common question you hear is "How do I generate custom
  exception classes?". It's awkward and somewhat un-idiomatic to do
  this, so people generally try to get by with the Exception
  classes that ship with the JDK. But why shouldn't exceptions get
  the same level of dynamicity and flexibility that Clojure affords
  other data types?</p>

<p>This is basically the question Slingshot addresses. It provides
  enhanced <code>try+</code> and <code>throw+</code> counterparts to
  the built-in error mechanisms that let you throw arbitrary data
  types like maps. Then rather than dispatching in your catch blocks
  based on class, you can use arbitrary predicates. You can even
  perform destructuring on maps that are thrown. It's a big step up
  in expressiveness:</p>

<pre class="code"><span class="esk-paren">(</span><span class="keyword">defn</span> <span class="function-name">asplode!</span> []
  <span class="esk-paren">(</span>throw+ {<span class="constant">:bad?</span> true <span class="constant">:tachyon-level</span> 21}<span class="esk-paren">))</span>

<span class="esk-paren">(</span><span class="keyword">defn</span> <span class="function-name">ignorable?</span> [e]
  <span class="esk-paren">(</span><span class="builtin">and</span> <span class="esk-paren">(</span><span class="constant">:silent</span> e<span class="esk-paren">)</span> <span class="esk-paren">(</span><span class="variable-name">not</span> <span class="esk-paren">(</span><span class="constant">:fatal?</span> e<span class="esk-paren">))))</span>

<span class="esk-paren">(</span>try+ <span class="esk-paren">(</span>asplode!<span class="esk-paren">)</span>
  <span class="esk-paren">(</span><span class="builtin">catch</span> ignorable? _<span class="esk-paren">)</span>
  <span class="esk-paren">(</span><span class="builtin">catch</span> <span class="constant">:bad?</span> e
    <span class="esk-paren">(</span>log/warn <span class="string">"Bummer dude!"</span> e<span class="esk-paren">))</span>
  <span class="esk-paren">(</span><span class="builtin">catch</span> <span class="constant">:fatal?</span> {<span class="constant">:keys</span> [exit-code]}
    <span class="esk-paren">(</span><span class="preprocessor">System/exit</span> exit-code<span class="esk-paren">)))</span></pre>

<p><b>Update</b>: The equivalent of the exception-throwing side of
  Slingshot has been included in Clojure 1.4 using
  the <code>ex-info</code> and <code>ex-data</code> functions, so
  unless you are targeting old versions of Clojure you should use
  those instead. Nothing has been added on the exception handling
  side though, so Slingshot's <code>try+</code> macro is still very
  useful.</p>

<p><code>[slingshot "0.8.0"]</code></p>

<h4><a href="https://github.com/brentonashworth/lein-difftest">lein-difftest</a></h4>

<p>If you've ever written a test where you expect two lengthy data
  structures to be equal, you'll remember how annoying it is to try
  to compare the failure message where "expected" and "actual" are
  each spat out on a single line and you're supposed to try to hunt
  down the difference. Using <kbd>lein difftest</kbd> makes it easy:</p>

<a href="https://github.com/brentonashworth/lein-difftest">
  <img src="i/lein-difftest.png" alt="difftest example" /></a>

<p>It also uses <tt>clj-stacktrace</tt> to report errors. This one
  is better off installed as a user-level plugin since you're
  likely to want to be able to use the <kbd>difftest</kbd> task
  across all your projects:</p>

<p><kbd>$ lein plugin install lein-difftest 1.3.7</kbd></p>

<p><b>Update</b>: Use version 2.0.0 of <tt>lein-difftest</tt> for
  compatibility with Leiningen 2.x.</p>

<h4><a href="https://github.com/joegallo/robert-bruce">robert-bruce</a></h4>

<p>From the do-one-thing-and-do-it-well department, we have Robert
  Bruce, which concerns itself only with determinedly retrying a
  given function. It provides all the options you could imagine for
  how to perform the retries, including pausing between them (with
  exponential decay on backoffs), retry limits, callbacks on
  failure, and so on.</p>

<p><code>[robert/bruce "0.7.1"]</code></p>

<h4>Happy hacking!</h4>

<p>Do you have a favourite that I've missed here? Leave a comment
  about it. Remember that the version numbers provided here are
  current as of the time of this writing but may be outdated when
  you read this.</p>
include(footer.html)
