<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Tue 09 Nov 2010 09:43:43 PM PST)dnl
define(__title, `in which the perils of the gilardi scenario are overcome')dnl
define(__id, 143)dnl
include(header.html)
<p>There's an interesting gotcha that's bitten me a few times while
  exploring the fringes of Clojure. The <code>eval</code> function is
  not often used, but there are some cases when it's justifiable.
  It comes up while writing Leiningen plugins since code needs to
  be constructed in the context of Leiningen and run in the context
  of a project.</p>

<p>The Gilardi Scenario refers to a case where you want to evaluate
  some code that both loads in a new var and refers to that var in
  the same piece of code:</p>

<pre class="code"><span class="esk-paren">(</span><span class="builtin">eval</span> `<span class="esk-paren">(</span><span class="keyword">when</span> ~<span class="esk-paren">(</span><span class="builtin">:some-set</span> project<span class="esk-paren">)</span>
         <span class="esk-paren">(</span><span class="builtin">require</span> '~'clojure.set<span class="esk-paren">)</span>
         <span class="esk-paren">(</span><span class="region">clojure.set/difference</span>
          ~<span class="esk-paren">(</span><span class="builtin">:some-set</span> project<span class="esk-paren">)</span> #{<span class="builtin">:bad-key</span>}<span class="esk-paren">)))</span>

java.lang.ClassNotFoundException: clojure.set</pre>

<p>The problem is that Clojure has to compile this whole block of
  code as a single unit. At compile time, the <code>clojure.set</code>
  namespace has not been loaded yet, so the attempt to look up
  the <code>difference</code> var is doomed to failure.</p>

<p>In Clojure 1.1, the compiler introduced special handling to work
  around this. If the top-level form being evaled is
  a <code>do</code>, then it will be broken up and each subform will
  be evaled separately. Unfortunately this only goes so far; it only
  applies to top-level <code>do</code>s, so even though
  our <code>when</code> above macro-expands to a form that
  contains <code>do</code>, the compiler can't apply its
  special-case.</p>

<p>Another way around it is to look up the var at runtime. The
  <code>ns-resolve</code> function works well for that.</p>

<pre class="code"><span class="esk-paren">(</span><span class="builtin">eval</span> `<span class="esk-paren">(</span><span class="keyword">when</span> ~<span class="esk-paren">(</span><span class="builtin">:some-set</span> project<span class="esk-paren">)</span>
         <span class="esk-paren">(</span><span class="builtin">require</span> '~'clojure.set<span class="esk-paren">)</span>
         <span class="esk-paren">((</span><span class="builtin">ns-resolve</span> '~'clojure.set '~'difference<span class="esk-paren">)</span>
          ~<span class="esk-paren">(</span><span class="builtin">:some-set</span> project<span class="esk-paren">)</span> #{<span class="builtin">:bad-key</span>}<span class="esk-paren">)))</span></pre>

<p>This delays the lookup of <code>clojure.set/difference</code> to
  runtime, incurring a small penalty but tidily avoiding the Gilardi
  scenario. It also looks a bit ugly due to the quote-unquote-quote
  notation. This is necessary inside a backtick since symbols are
  fully-qualified to avoid accidental aliasing existing names. I'm
  not sure if this is an intentional design decision of Clojure,
  but it's certainly a sign that you're off the beaten path and
  into possibly-inadvisable territory.</p>

<p>Leiningen used to encourage the <code>ns-resolve</code> solution
  above since it needed to support eval of arbitrary forms from
  plugins. Even if your form had a <code>do</code> at the top-level
  to invoke the compiler's special-case, you could easily have
  situations where <a href="/141">add-hook</a> has been used to wrap
  the form in enclosing forms, making your <code>do</code> nested
  deeply where the compiler wouldn't split it out.</p>

<pre class="code"><span class="esk-paren">(</span><span class="keyword">defn</span> <span class="function-name">get-readable-form</span> [java project form init]
  <span class="esk-paren">(</span><span class="keyword">let</span> [cp <span class="esk-paren">(</span><span class="builtin">str</span> <span class="esk-paren">(</span><span class="preprocessor">.getClasspath</span> <span class="esk-paren">(</span><span class="preprocessor">.getCommandLine</span> java<span class="esk-paren">)))</span>
        form `<span class="esk-paren">(</span><span class="keyword">do</span> ~init
                  <span class="esk-paren">(</span><span class="keyword">def</span> <span class="function-name">~</span>'classpath ~cp<span class="esk-paren">)</span>
                  <span class="esk-paren">(</span>set! ~'*warn-on-reflection*
                        ~<span class="esk-paren">(</span><span class="builtin">:warn-on-reflection</span> project<span class="esk-paren">))</span>
                  ~form<span class="esk-paren">)</span>]
    <span class="esk-paren">(</span><span class="builtin">prn-str</span> form<span class="esk-paren">)))</span></pre>

<p>But the latest version of Leiningen makes it work
  without <code>ns-resolve</code>. Even
  though <code>eval-in-project</code> accepts any form to eval, it
  splices it into an existing <code>do</code> form that places
  all <code>requires</code> (the <code>init</code> argument in the
  function above) into the top-level of the <code>do</code> where
  the compiler can work its magic. So if you've got a namespace that
  your form is going to depend upon, just pass in <code>'(require
  'my.ns)</code> as the <code>init</code> arg
  to <code>eval-in-project</code> to deftly maneuver your way
  through the Gilardi Scenario.</p>
include(footer.html)
