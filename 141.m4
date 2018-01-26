dnl -*- html -*-
define(__timestamp, 2010-09-29T04:18:59Z)dnl
define(__title, `in which public speaking is foreshadowed')dnl
define(__id, 141)dnl
include(header.html)
<p>I was <a href="http://first.clojure-conj.org/speakers#hagelberg">invited
    to speak at this year's Conj</a>, the first Clojure conference. My talk
  is titled "Making Leiningen Work for You":</p>

<blockquote>Everyone is probably familiar with the basic Leiningen
  workflow: new, deps, test, swank, etc. But there's more to our
  resourceful friend than meets the eye. Learn how to customize
  Leiningen for your project and how to teach it new tricks through
  plugins.</blockquote>

<p>I'll be speaking on lesser-known new features, plugin
  development, and the things that make Leiningen the
  most-contributed-to Clojure project. As a little teaser about
  plugin development
  using <a href="http://github.com/technomancy/robert-hooke">Robert
  Hooke</a>, here's a plugin I wrote yesterday.</p>

<pre class="code"><span class="esk-paren">(</span><span class="keyword">ns</span> rodney.leonard.stubbs
  <span class="string">"Replace all vars in all namespaces  with their :stub metadata."</span>
  <span class="esk-paren">(</span><span class="builtin">:use</span> [robert.hooke <span class="builtin">:only</span> [add-hook]]
        [leiningen.compile <span class="builtin">:only</span> [eval-in-project]]<span class="esk-paren">))</span>

<span class="esk-paren">(</span><span class="keyword">def</span> <span class="function-name">stubbery</span>
  `<span class="esk-paren">(</span><span class="builtin">fn</span> [f# &amp; args#]
     <span class="esk-paren">(</span><span class="keyword">doseq</span> [n# <span class="esk-paren">(</span><span class="builtin">all-ns</span><span class="esk-paren">)</span>
             [_# v#] <span class="esk-paren">(</span><span class="builtin">ns-publics</span> n#<span class="esk-paren">)</span>
             <span class="builtin">:when</span> <span class="esk-paren">(</span><span class="builtin">:stub</span> <span class="esk-paren">(</span><span class="builtin">meta</span> v#<span class="esk-paren">))</span>]
       <span class="esk-paren">(</span><span class="builtin">alter-var-root</span> v# <span class="esk-paren">(</span><span class="builtin">fn</span> [f# v#] <span class="esk-paren">(</span><span class="builtin">with-meta</span> <span class="esk-paren">(</span><span class="builtin">:stub</span> <span class="esk-paren">(</span><span class="builtin">meta</span> v#<span class="esk-paren">))</span>
                                       <span class="esk-paren">(</span><span class="builtin">assoc</span> <span class="esk-paren">(</span><span class="builtin">dissoc</span> <span class="esk-paren">(</span><span class="builtin">meta</span> v#<span class="esk-paren">)</span> <span class="builtin">:stub</span><span class="esk-paren">)</span>
                                         <span class="builtin">:stubbs/original</span> f#<span class="esk-paren">)))</span> v#<span class="esk-paren">))</span>
     <span class="esk-paren">(</span><span class="builtin">apply</span> f# args#<span class="esk-paren">)))</span>

<span class="esk-paren">(</span><span class="keyword">defn</span> <span class="function-name">add-stub-form</span> [eval-in-project project form &amp; [handler]]
  <span class="esk-paren">(</span><span class="keyword">let</span> [form `<span class="esk-paren">(</span><span class="keyword">do</span> <span class="esk-paren">(</span><span class="builtin">require</span> '~'clojure.test<span class="esk-paren">)</span>
                  <span class="esk-paren">(</span><span class="builtin">require</span> '~'robert.hooke<span class="esk-paren">)</span>
                  <span class="esk-paren">(</span>#'robert.hooke/add-hook #'~'clojure.test/<span class="type">run-tests</span>
                                           ~stubbery<span class="esk-paren">)</span>
                  ~form<span class="esk-paren">)</span>]
    <span class="esk-paren">(</span>eval-in-project project form handler<span class="esk-paren">)))</span>

<span class="esk-paren">(</span>add-hook #'eval-in-project add-stub-form<span class="esk-paren">)</span>
</pre>

<p>With this in place you can kick up some action.</p>

<pre class="code">
<span class="esk-paren">(</span><span class="keyword">ns</span> rodney.test-stubbs
  <span class="esk-paren">(</span><span class="builtin">:use</span> [clojure.test]<span class="esk-paren">))</span>

<span class="esk-paren">(</span><span class="keyword">defn</span> ^{<span class="builtin">:stub</span> <span class="esk-paren">(</span><span class="builtin">constantly</span> true<span class="esk-paren">)</span>} <span class="function-name">stubbed?</span> []
  false<span class="esk-paren">)</span>

<span class="esk-paren">(</span><span class="type">deftest</span> test-stubbed
  <span class="esk-paren">(</span><span class="type">is</span> <span class="esk-paren">(</span>stubbed?<span class="esk-paren">)))</span>
</pre>
<a href="http://achewood.com/index.php?date=03142006">
  <img src="/i/ramses.gif" class="right" 
       alt="The Man with the Blood on his Hands" /></a>

<p>This test passes because <tt>stubbed?</tt> gets replaced
  with <tt>(constantly true)</tt> at test time. The idea is that
  functions which may rely on external services can easily be
  replaced with stubs that return hard-coded data in order to make
  your tests run faster and more reliably. Of course, you should
  couple this with an set of integration tests that use the
  original definitions; for this purpose,
  there's a <tt>:stubbs/original</tt> entry added to the var's
  metadata containing the original value of the function that's
  been replaced.</p>

<p>The plugin uses Robert Hooke's <tt>add-hook</tt> to modify the
  behaviour of Leiningen's built-in <tt>eval-in-project</tt>
  function. All code that runs in your project goes through this
  function. Inside your project's code, it
  wraps <tt>clojure.test/run-tests</tt> in order to search for all
  vars that have <tt>:stub</tt> metadata and
  call <tt>alter-var-root</tt> on them to stub out their
  behaviour. It's a little more awkward than most Robert Hooke usage
  since there's a lot of use of auto-gensym and quote-unquoting
  involved in order to work around the fact that the code is
  constructed in a Leiningen plugin but intended to run inside your
  project's process, but it's a good testament to the flexibility
  that metadata and hooks offer.</p>
include(footer.html)
