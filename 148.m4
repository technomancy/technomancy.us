dnl -*- html -*-
define(__timestamp, 2011-05-01T06:05:12Z)dnl
define(__title, `in which a violent metaphor features prominently')dnl
define(__id, 148)dnl
include(header.html)
<p>This past week I've had a lot of fun
  with <a href="http://github.com/technomancy/slamhound">Slamhound</a>,
  my most recent project. Often times when writing Clojure, your
  <a href="http://blog.8thlight.com/articles/2010/12/6/clojure-libs-and-namespaces-require-use-import-and-ns">namespace
  declarations</a> are a pain to keep in order&mdash;you've got to
  specify all the namespaces you depend upon, and once you've got a
  lot of them in there, it's hard to keep them straight; often
  duplicates sneak in and things just get really messy. So Slamhound
  takes a source file, discards the namespace declaration, and tries
  to determine how to reconstruct it from the code alone. I had a
  lot of fun putting it together, so here's a little walk-through of
  how it works.</p>

<p>A big part of why it was so much fun is that the code is very
  functional. It takes a file as input, throws it into a pipeline,
  and spits out an answer. The only impure part is the reading of
  the file.[<a href="#fn1">1</a>] The pipeline is built in
  the <code>slam.hound/reconstruct</code> function: </p>

<pre class="code"><span class="esk-paren">(</span><span class="keyword">defn</span> <span class="function-name">reconstruct</span> [filename]
  <span class="esk-paren">(</span><span class="keyword">-&gt;</span> <span class="esk-paren">(</span>io/reader filename<span class="esk-paren">)</span>
      asplode
      regrow
      stitch-up<span class="esk-paren">))</span> </pre>

<p>But first a little back-story: Slamhound is named after the
  explosive device from William Gibson's novel
  <a href="http://en.wikipedia.org/wiki/Count_Zero">Count
  Zero</a>. At the start of the story, the main character Turner
  has an encounter with one, after which he spends three months in
  surgery while his skin and organs are regrown before he's
  stitched back together. Files in Slamhound go through the same
  process: asplode, re-grow, stitch-up. (I've quoted code selections
  inline, but for the complete listing a link is given for each phase.)</p>

<h4>Phase 1: <a href="https://github.com/technomancy/slamhound/blob/master/src/slam/hound/asplode.clj">asplode</a></h4>

<pre class="code"><span class="esk-paren">(</span><span class="keyword">defn</span> <span class="function-name">asplode</span> [rdr]
  <span class="esk-paren">(</span><span class="keyword">let</span> [rdr <span class="esk-paren">(</span><span class="preprocessor">PushbackReader.</span> rdr<span class="esk-paren">)</span>
        ns-map <span class="esk-paren">(</span>ns-to-map <span class="esk-paren">(</span><span class="builtin">read</span> rdr<span class="esk-paren">))</span>
        stripped-ns <span class="esk-paren">(</span><span class="builtin">apply</span> dissoc ns-map [<span class="builtin">:use</span> <span class="builtin">:require</span> <span class="builtin">:import</span>]<span class="esk-paren">)</span>
        body <span class="esk-paren">(</span><span class="builtin">take-while</span> #<span class="esk-paren">(</span><span class="builtin">not=</span> <span class="builtin">::done</span> %<span class="esk-paren">)</span>
                         <span class="esk-paren">(</span><span class="builtin">repeatedly</span> #<span class="esk-paren">(</span><span class="builtin">read</span> rdr false <span class="builtin">::done</span><span class="esk-paren">)))</span>]
    [stripped-ns body]<span class="esk-paren">))</span> </pre>

<p>Like its counterpart in the book,
  the first
  phase is quick, simple, and messy. First we need to construct
  a PushbackReader in order for <code>clojure.core/read</code> to
  operate. This gives us the <code>ns</code> form as a list. Then in
  <code>ns-to-map</code> (not shown) we perform the translation into
  a map by splitting each clause
  (<code>:use</code>, <code>:require</code>,
  and <code>:import</code>) out, since the map form is a lot easier
  to operate on in during the regrow stage. But often times you have
  left-over clauses from earlier revisions, so
  we <code>dissoc</code> them out in order to start from
  scratch. Then we <code>repeatedly</code> <code>read</code> until
  EOF to get the body. The stripped ns and body are passed to the
  next phase. </p>

<h4>Phase 2: <a href="https://github.com/technomancy/slamhound/blob/master/src/slam/hound/regrow.clj">regrow</a></h4>

  <pre class="code"><span class="esk-paren">(</span><span class="keyword">defn</span> <span class="function-name">regrow</span>
  <span class="esk-paren">(</span>[[ns-map body]]
     <span class="esk-paren">(</span><span class="builtin">force</span> pre-load<span class="esk-paren">)</span>
     <span class="esk-paren">(</span>regrow [ns-map body] nil<span class="esk-paren">))</span>
  <span class="esk-paren">(</span>[[ns-map body] last-missing]
     <span class="esk-paren">(</span><span class="keyword">if-let</span> [{<span class="builtin">:keys</span> [missing type]} <span class="esk-paren">(</span>check-for-failure ns-map body<span class="esk-paren">)</span>]
       <span class="esk-paren">(</span><span class="keyword">if</span> <span class="esk-paren">(</span><span class="builtin">=</span> last-missing missing<span class="esk-paren">)</span>
         <span class="esk-paren">(</span><span class="keyword">throw</span> <span class="esk-paren">(</span><span class="preprocessor">Exception.</span> <span class="esk-paren">(</span><span class="builtin">str</span> <span class="string">"Couldn't resolve "</span> missing<span class="esk-paren">)))</span>
         <span class="esk-paren">(</span><span class="keyword">recur</span> [<span class="esk-paren">(</span>grow-step missing type ns-map<span class="esk-paren">)</span> body] missing<span class="esk-paren">))</span>
       ns-map<span class="esk-paren">)))</span></pre>

<p>The re-grow phase is where the pain-staking progress is made. The
  first arity forces the <code>pre-load</code> delay which ensures
  all the source is loaded for compilation purposes, then hands off
  to the second arity. There's a recursive loop here: we attempt to
  compile the body with the current ns-map
  in <code>check-for-failure</code> (see below.) If it fails, we analyze the
  problematic <code>missing</code> piece in <code>grow-step</code>,
  which searches for all possible <code>candidates</code>, sorts
  in <code>disambiguate</code>, and picks one. Then the compilation
  is retried by <code>recur</code>ring.</p>

<p>Right now if the retry results in the same failure, it gives up,
  though there's no reason in the future it couldn't continue down
  the list of candidates. Of course, if compilation succeeds, the
  re-grow process is finished, and it returns
  the <code>ns-map</code> with the new clauses for the next
  phase, <code>stitch-up</code>.</p>

<p>But <code>check-for-failure</code> deserves special attention as
  it's where the meat of the process happens:</p>

<pre class="code"><span class="esk-paren">(</span><span class="keyword">defn</span> <span class="function-name">check-for-failure</span> [ns-map body]
  <span class="esk-paren">(</span><span class="keyword">let</span> [sandbox-ns `slamhound.sandbox#
        ns-form <span class="esk-paren">(</span>stitch/ns-from-map <span class="esk-paren">(</span><span class="builtin">assoc</span> ns-map <span class="builtin">:name</span> sandbox-ns<span class="esk-paren">))</span>]
    <span class="esk-paren">(</span><span class="keyword">binding</span> [*ns* <span class="esk-paren">(</span><span class="builtin">create-ns</span> sandbox-ns<span class="esk-paren">)</span>]
      <span class="esk-paren">(</span><span class="keyword">try</span>
        <span class="esk-paren">(</span><span class="builtin">eval</span> `<span class="esk-paren">(</span><span class="keyword">do</span> ~ns-form ~@body nil<span class="esk-paren">))</span>
        <span class="esk-paren">(</span><span class="keyword">catch</span> <span class="preprocessor">Exception</span> e
          <span class="esk-paren">(</span><span class="keyword">or</span> <span class="esk-paren">(</span>failure-details <span class="esk-paren">(</span><span class="preprocessor">.getMessage</span> e<span class="esk-paren">))</span>
              <span class="esk-paren">(</span><span class="keyword">throw</span> e<span class="esk-paren">)))</span>
        <span class="esk-paren">(</span><span class="keyword">finally</span>
         <span class="esk-paren">(</span><span class="builtin">remove-ns</span> <span class="esk-paren">(</span><span class="preprocessor">.name</span> *ns*<span class="esk-paren">)))))))</span></pre>

<p>Here we see that a unique sandbox namespace is created using
  auto-gensym. Next we reach ahead a bit into the
  next <code>stitch-up</code> phase for the <code>ns-from-map</code>
  function, which takes our map representation and turns it back
  into an executable <code>ns</code> declaration. Stepping into this
  sandbox namespace with <code>binding</code>, we attempt
  to <code>eval</code> the body. If it fails, we analyze the
  exception with <code>failure-details</code>. This tells us whether
  it was a <code>:use</code>, <code>:require</code>,
  or <code>:import</code> clause that caused the failure as well as
  the name of the missing class or var. These details are used
  by <code>candidates</code> to determine the ns-map for the next
  attempt.</p>

  <pre class="code"><span class="esk-paren">(</span><span class="keyword">defmethod</span> <span class="function-name">candidates</span> <span class="builtin">:require</span> [type missing]
  <span class="esk-paren">(</span><span class="keyword">for</span> [n <span class="esk-paren">(</span><span class="builtin">all-ns</span><span class="esk-paren">)</span>
        <span class="builtin">:when</span> <span class="esk-paren">(</span><span class="builtin">=</span> missing <span class="esk-paren">(</span><span class="builtin">last</span> <span class="esk-paren">(</span><span class="preprocessor">.split</span> <span class="esk-paren">(</span><span class="builtin">name</span> <span class="esk-paren">(</span><span class="builtin">ns-name</span> n<span class="esk-paren">))</span> <span class="string">"\\."</span><span class="esk-paren">)))</span>]
    [<span class="esk-paren">(</span><span class="builtin">ns-name</span> n<span class="esk-paren">)</span> <span class="builtin">:as</span> <span class="esk-paren">(</span><span class="builtin">symbol</span> missing<span class="esk-paren">)</span>]<span class="esk-paren">))</span></pre>

<p>The <code>candidates</code> multimethod operates on each of the
  three clause types
  (<code>:use</code>/<code>:require</code>/<code>:import</code>),
  but they're all slight variations on the same
  theme. The <code>:require</code> version is given here: it simply
  loops through all the available namespaces and returns the ones
  which match the <code>missing</code> name from the compilation
  failure.</p>

<h4>Phase 3: <a href="https://github.com/technomancy/slamhound/blob/master/src/slam/hound/stitch.clj">stitch up</a></h4>

<pre class="code"><span class="esk-paren">(</span><span class="keyword">defn</span> <span class="function-name">stitch-up</span> [ns-map]
  <span class="esk-paren">(</span><span class="keyword">-&gt;</span> ns-map
      collapse-clauses
      sort-subclauses
      ns-from-map
      prettify<span class="esk-paren">))</span></pre>

<p>Once we've got a successful compilation, we have what we
  need. All that's left is to turn it back from a map into code
  form, which is handled by the stitch phase. Technically only the
  the <code>ns-from-map</code> function we saw used above is
  necessary, but the ns declaration looks a lot nicer if you
  collapse all the clauses down first:</p>
<pre class="code"><span class="esk-paren">(</span><span class="builtin">:use</span> [clojure.test <span class="builtin">:only</span> [deftest]]
      [clojure.test <span class="builtin">:only</span> [testing]]
      [clojure.test <span class="builtin">:only</span> [is]]
      [clojure.test <span class="builtin">:only</span> [are]]<span class="esk-paren">)</span>

<span class="comment-delimiter">;; </span><span class="comment">after collapsing becomes:
</span>
<span class="esk-paren">(</span><span class="builtin">:use</span> [clojure.test <span class="builtin">:only</span> [deftest testing is are]]<span class="esk-paren">)</span></pre>

<p>Sorting subclauses doesn't hurt either, though it's strictly
  cosmetic. Finally we turn it back into code form and pretty-print
  it using <code>clojure.pprint/pprint</code>. And that's it!</p>

<hr />
<div class="footnotes">
<p><a name="fn1"></a><b>1</b>: Technically there's one exception to
  this; see if you can spot it.</p>
</div>
include(footer.html)
