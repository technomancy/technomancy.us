dnl -*- html -*-
define(__timestamp, 2014-10-13T20:50:41Z)dnl
define(__title, `in which preconceptions are unavoidable')dnl
define(__id, 175)dnl
include(header.html)
<p>In my <a href="/174">last post</a> I introduced my latest
  project, <a href="https://github.com/technomancy/cooper">a
  HyperCard clone</a> I've been writing in
  the <a href="http://racket-lang.org">Racket programming
  language</a>, which is a practical and accessible dialect of
  Scheme. I'd played around a bit with Racket before, but this was
  the first time I'd used it for anything nontrivial. Any
  time <a href="http://www.greghendershott.com/2014/10/hands-on-with-clojure.html">you
  come to an unfamiliar language</a>, there's naturally a period of
  disorientation in which it can be frustrating to find your
  footing. Racket's similarity to Clojure (the language I'm
  currently most proficient in) means this shouldn't be as
  pronounced as it would be with many languages, but these are my
  subjective reactions to how it's gone implementing my first
  project. There are a number of gripes, but if I may offer a
  spoiler, in the end Racket provides satisfactory ways of
  addressing all of them that aren't obvious up-front, and brings
  valuable new perspectives to the table.</p>

<hr />

<p>When I was getting started with Racket, I was pleased to see that
  it defaults to immutable data structures. Coming from a Clojure
  background, I'm used to using free-form maps for
  everything. Racket has hash tables which sound similar, so let's
  take a look at how they're used:</p>

<pre class="code"><span class="racket-paren">(</span><span class="keyword">define</span> <span class="variable-name">h</span> #hash<span class="racket-paren">((</span><span class="racket-selfeval">'a</span> . <span class="racket-selfeval">123</span><span class="racket-paren">)</span>
                <span class="racket-paren">(</span><span class="racket-selfeval">'b</span> . <span class="racket-selfeval">234</span><span class="racket-paren">)</span>
                <span class="racket-paren">(</span><span class="racket-selfeval">'c</span> . <span class="racket-paren">(</span><span class="builtin">+</span> <span class="racket-selfeval">345</span> <span class="racket-selfeval">456</span><span class="racket-paren">))))</span>

<span class="racket-paren">(</span>h <span class="racket-selfeval">'b</span><span class="racket-paren">)</span>
<span class="comment-delimiter">; </span><span class="comment">application: not a procedure;
</span><span class="comment-delimiter">;  </span><span class="comment">expected a procedure that can be applied to arguments
</span><span class="comment-delimiter">;   </span><span class="comment">given: '#hash((a . 123) (b . 234) (c . (+ 345 456)))
</span><span class="comment-delimiter">;   </span><span class="comment">arguments...:
</span><span class="comment-delimiter">;    </span><span class="comment">'b</span></pre>

<p>What's going on here? Well, it looks like hash tables can't be
  called like functions. This has never made any sense to me, since
  immutable hash tables are actually <i>more</i> like mathematical
  functions than lambdas are. But whatever, we'll just
  use <tt>hash-ref</tt> instead; it's more verbose but should get
  the job done:</p>

<pre class="code"><span class="racket-paren">(</span>hash-ref h <span class="racket-selfeval">'b</span><span class="racket-paren">)</span>

<span class="comment-delimiter">; </span><span class="comment">hash-ref: no value found for key
</span><span class="comment-delimiter">;   </span><span class="comment">key: 'b
</span></pre>

<p>It turns out Racket implicitly quotes everything inside the hash
  table. So OK, maybe that's a little nicer since you don't need to
  quote the symbol keys in the hash table:</p>

<pre class="code"><span class="racket-paren">(</span><span class="keyword">define</span> <span class="variable-name">h</span> #hash<span class="racket-paren">((</span>a . <span class="racket-selfeval">123</span><span class="racket-paren">)</span>
                <span class="racket-paren">(</span>b . <span class="racket-selfeval">234</span><span class="racket-paren">)</span>
                <span class="racket-paren">(</span>c . <span class="racket-paren">(</span><span class="builtin">+</span> <span class="racket-selfeval">345</span> <span class="racket-selfeval">456</span><span class="racket-paren">))))</span>

<span class="racket-paren">(</span>hash-ref h <span class="racket-selfeval">'b</span><span class="racket-paren">)</span> <span class="comment-delimiter">; </span><span class="comment">-&gt; 234
</span><span class="racket-paren">(</span>hash-ref h <span class="racket-selfeval">'c</span><span class="racket-paren">)</span> <span class="comment-delimiter">; </span><span class="comment">-&gt; '(+ 345 456)</span></pre>

<p>Oh dear... that's less than ideal, especially compared to Clojure's
  simple <tt>(def h {:a 123 :b 234 :c (+ 345 456)}</tt> and <tt>(:c
  h)</tt> notation. But let's move on[<a href="#fn1">1</a>] since it
  turns out hash tables are not nearly as important as maps are in
  Clojure. It's more idiomatic to use structs if your fields are
  known up-front:</p>

<pre class="code"><span class="racket-paren">(</span>struct abc <span class="racket-paren">(</span>a b c<span class="racket-paren">))</span>
<span class="racket-paren">(</span><span class="keyword">define</span> <span class="variable-name">s</span> <span class="racket-paren">(</span>abc <span class="racket-selfeval">123</span> <span class="racket-selfeval">234</span> <span class="racket-paren">(</span><span class="builtin">+</span> <span class="racket-selfeval">345</span> <span class="racket-selfeval">456</span><span class="racket-paren">)))</span>

<span class="racket-paren">(</span>abc-c s<span class="racket-paren">)</span> <span class="comment-delimiter">; </span><span class="comment">-&gt; 801
</span>s <span class="comment-delimiter">; </span><span class="comment">-&gt; #&lt;abc&gt;
</span></pre>

<p>So that's nice in that it avoids the implicit quoting; our
  regular evaluation rules work at least. But what's this at the
  end? Racket structs default to being opaque. This may have made
  sense years ago when you needed to protect your mutable fields,
  but now that immutability is the default, it just gets in the
  way. Luckily you can set the <tt>#:transparent</tt> option when
  defining structs, and this will likely become the default in the
  future.</p>

<p>One place where Racket has a clear advantage over Clojure is that
  you'll never get nil back from an accessor. Both in hash tables
  and structs, if a field doesn't exist, you'll get an error
  immediately rather than allowing bogus data to percolate through
  your call chain and blow up in an unrelated place. (Though of
  course with hash tables you can specify your own value for the
  "not found" case.)  In any case, less "garbage in, garbage out" is
  a welcome change for me as a human who frequently makes
  mistakes.</p>

<p>What about updates, though? Mutable struct fields have setter
  functions auto-generated, but inexplicably the nondestructive
  equivalents for immutable fields are missing. Instead
  the <tt>struct-copy</tt> macro is recommended. Here we change
  the <tt>b</tt> field of an <tt>abc</tt> struct instance we've
  defined:</p>

<pre class="code"><span class="racket-paren">(</span><span class="keyword">define</span> <span class="variable-name">s2</span> <span class="racket-paren">(</span>struct-copy abc s <span class="racket-paren">[</span>b <span class="racket-selfeval">987</span><span class="racket-paren">]))</span>
<span class="racket-paren">(</span>abc-b s2<span class="racket-paren">)</span> <span class="comment-delimiter">; </span><span class="comment">-&gt; 987</span></pre>

<p>This works, though you have to repeat the struct type in the
  invocation. That's not so bad, but the bigger problem is that this
  is a macro. The field you wish to update must be known at compile
  time, which makes it awkward to use in the context of higher
  order functions.</p>

<p>At this point the post is surely sounding pretty whiny. While the
  out-of-the-box experience working with these data structures is
  not great, Racket gives you plenty of power to make things
  better. Probably the most comprehensive take on this I've seen
  is <a href="http://www.greghendershott.com/rackjure/">Rackjure</a>,
  which gives you a lot of the creature comforts I've noted as
  missing above like nicer hash table syntax and data structures you
  can call like functions, as well as a few other niceties
  like <a href="http://www.greghendershott.com/rackjure/index.html#%28part._.Operational_equivalence%29">a
  general-purpose equality predicate</a>[<a href="#fn2">2</a>]
  and <a href="http://www.greghendershott.com/rackjure/index.html#%28part._.Atomic_swap%29">atomic
  swap for boxes</a>.</p>

<p>In my initial exploration of Racket, I resisted the temptation to
  dive straight into Rackjure in order to give "raw Racket" a fair
  shakedown. Because of this, I've spent more time looking into
  structs and some of the options they provide. Racket has the
  notion
  of <a href="http://docs.racket-lang.org/reference/createinterface.html">interfaces</a>
  you can conform to in order to get generic functionality
  specialized to a certain struct
  type. <a href="http://docs.racket-lang.org/reference/dicts.html">Dictionaries</a>
  are one of the interfaces it ships with out of the box, so you can
  use <tt>dict-ref</tt>, <tt>dict-set</tt>, etc with hash-tables and
  other built-in types that conform to this interface. Your typical
  structs won't work with it, but you can declare structs that
  implement it without too much fuss. I've done this with
  my <a href="https://github.com/technomancy/cooper/blob/master/cooper/fstruct.rkt">fstruct</a>
  macro:</p>

<pre class="code"><span class="racket-paren">(</span>fstruct fabc <span class="racket-paren">(</span>a b c<span class="racket-paren">))</span> <span class="comment-delimiter">; </span><span class="comment">define a struct type with three fields</span>
<span class="racket-paren">(</span><span class="keyword">define</span> <span class="variable-name">fs</span> <span class="racket-paren">(</span>fabc <span class="racket-selfeval">123</span> <span class="racket-selfeval">234</span> <span class="racket-paren">(</span><span class="builtin">+</span> <span class="racket-selfeval">345</span> <span class="racket-selfeval">456</span><span class="racket-paren">)))</span>

<span class="racket-paren">(</span>dict-ref fs <span class="racket-selfeval">'a</span><span class="racket-paren">)</span> <span class="comment-delimiter">; </span><span class="comment">-&gt; 123
</span><span class="racket-paren">(</span>dict-set fs <span class="racket-selfeval">'b</span> <span class="racket-selfeval">999</span><span class="racket-paren">)</span> <span class="comment-delimiter">; </span><span class="comment">-&gt; (fabc 123 234 801)
</span><span class="racket-paren">(</span>dict-update fs <span class="racket-selfeval">'c</span> <span class="racket-paren">(</span><span class="keyword">&#955;</span> <span class="racket-paren">(</span>x<span class="racket-paren">)</span> <span class="racket-paren">(</span><span class="builtin">-</span> x <span class="racket-selfeval">400</span><span class="racket-paren">)))</span> <span class="comment-delimiter">; </span><span class="comment">-&gt; (fabc 123 234 401)</span></pre>

<p>One gotcha if you're used to Clojure is that <tt>dict-update</tt>
  is not variadic&mdash;if you provide a fourth argument it will be
  used as a "not found" value rather than as an argument to the
  updater function. <tt>(dict-update fs 'c - 400)</tt> won't
  work. However, unlike Clojure, Racket can do reverse partial
  application, so <tt>(rcurry - 400)</tt> does the job, which is
  nicer than spelling out the lambda form fully.</p>

<p>Another gotcha is that <tt>dict-update</tt> doesn't appear to
  have a nested equivalent. For instance; it would be nice to be
  able to pass an updater function and a "key path" to a specific
  value in a tree of dictionaries:</p>

<pre class="code"><span class="racket-paren">(</span><span class="keyword">define</span> <span class="variable-name">inner</span> <span class="racket-paren">(</span>fabc '<span class="racket-paren">(</span>a b c<span class="racket-paren">)</span> <span class="racket-selfeval">0</span> <span class="racket-selfeval">0</span><span class="racket-paren">))</span>
<span class="racket-paren">(</span><span class="keyword">define</span> <span class="variable-name">ht-nest</span> `#hash<span class="racket-paren">((</span>key1 . ,inner<span class="racket-paren">)</span>
                       <span class="racket-paren">(</span>key2 . <span class="racket-selfeval">#f</span><span class="racket-paren">)))</span>
<span class="racket-paren">(</span><span class="keyword">define</span> <span class="variable-name">outer</span> <span class="racket-paren">(</span>fabc <span class="racket-selfeval">0</span> ht-nest '<span class="racket-paren">(</span><span class="racket-selfeval">1</span> <span class="racket-selfeval">2</span> <span class="racket-selfeval">3</span><span class="racket-paren">)))</span>

<span class="racket-paren">(</span><span class="keyword">define</span> <span class="variable-name">updated</span> <span class="racket-paren">(</span>dict-update-in outer '<span class="racket-paren">(</span>b key1 a<span class="racket-paren">)</span> <span class="builtin">append</span> '<span class="racket-paren">(</span>d e f<span class="racket-paren">)))</span>

<span class="racket-paren">(</span>dict-ref-in updated '<span class="racket-paren">(</span>b key1 a<span class="racket-paren">))</span> <span class="comment-delimiter">; </span><span class="comment">-&gt; '(a b c d e f)</span></pre>

  <p>So that is easy to add:</p>

<pre class="code"><span class="racket-paren">(</span><span class="keyword">define</span> <span class="racket-paren">(</span><span class="function-name">dict-update-in</span> d ks f . args<span class="racket-paren">)</span>
  <span class="racket-paren">(</span><span class="keyword">if</span> <span class="racket-paren">(</span>empty? <span class="racket-paren">(</span>rest ks<span class="racket-paren">))</span>
      <span class="racket-paren">(</span>dict-update d <span class="racket-paren">(</span>first ks<span class="racket-paren">)</span> <span class="racket-paren">(</span><span class="keyword">&#955;</span> <span class="racket-paren">(</span>x<span class="racket-paren">)</span> <span class="racket-paren">(</span><span class="builtin">apply</span> f x args<span class="racket-paren">)))</span>
      <span class="racket-paren">(</span>dict-set d <span class="racket-paren">(</span>first ks<span class="racket-paren">)</span> <span class="racket-paren">(</span><span class="builtin">apply</span> dict-update-in
                                    <span class="racket-paren">(</span>dict-ref d <span class="racket-paren">(</span>first ks<span class="racket-paren">))</span>
                                    <span class="racket-paren">(</span>rest ks<span class="racket-paren">)</span> f args<span class="racket-paren">))))</span>

<span class="racket-paren">(</span><span class="keyword">define</span> <span class="racket-paren">(</span><span class="function-name">dict-ref-in</span> d ks<span class="racket-paren">)</span>
  <span class="racket-paren">(</span><span class="keyword">if</span> <span class="racket-paren">(</span>empty? <span class="racket-paren">(</span>rest ks<span class="racket-paren">))</span>
      <span class="racket-paren">(</span>dict-ref d <span class="racket-paren">(</span>first ks<span class="racket-paren">))</span>
      <span class="racket-paren">(</span>dict-ref-in <span class="racket-paren">(</span>dict-ref d <span class="racket-paren">(</span>first ks<span class="racket-paren">))</span> <span class="racket-paren">(</span>rest ks<span class="racket-paren">))))</span></pre>

<p>The <tt>fstruct</tt> macro has one more trick up its sleeve. The
  structs it generates are applicable just like Clojure maps:</p>

<pre class="code"><span class="racket-paren">(</span><span class="keyword">define</span> <span class="variable-name">fs2</span> <span class="racket-paren">(</span>fabc <span class="racket-selfeval">123</span> <span class="racket-paren">(</span>fabc <span class="racket-selfeval">234</span> <span class="racket-selfeval">345</span> <span class="racket-paren">(</span>fabc <span class="racket-selfeval">987</span> <span class="racket-selfeval">654</span> <span class="racket-selfeval">321</span><span class="racket-paren">))</span> <span class="racket-selfeval">0</span><span class="racket-paren">))</span>

<span class="racket-paren">(</span>fs2 <span class="racket-selfeval">'a</span><span class="racket-paren">)</span> <span class="comment-delimiter">; </span><span class="comment">-&gt; 123
</span><span class="racket-paren">(</span>fs2 '<span class="racket-paren">(</span>b b<span class="racket-paren">))</span> <span class="comment-delimiter">; </span><span class="comment">-&gt; 345
</span><span class="racket-paren">(</span>fs2 <span class="racket-selfeval">'c</span> <span class="racket-selfeval">9</span><span class="racket-paren">)</span> <span class="comment-delimiter">; </span><span class="comment">-&gt; (fabc 123 (fabc 234 345 (fabc 987 654 321)) 9)
</span><span class="racket-paren">(</span>fs2 '<span class="racket-paren">(</span>b c a<span class="racket-paren">)</span> <span class="racket-selfeval">0</span><span class="racket-paren">)</span> <span class="comment-delimiter">; </span><span class="comment">-&gt; (fabc 123 (fabc 234 345 (fabc 0 654 321)) 0)</span>
<span class="racket-paren">(</span>dict-update-in fs2 '<span class="racket-paren">(</span>b b<span class="racket-paren">)</span> <span class="builtin">+</span> <span class="racket-selfeval">555</span><span class="racket-paren">)</span>
<span class="comment-delimiter">; </span><span class="comment">-&gt; (fabc 123 (fabc 234 900 (fabc 987 654 321)) 0)</span></pre>

<p>They support nested lookups and setting out of the box, but of
  course for expressing updates that are a function of the old value
  to the new value you'll have to use <tt>dict-update</tt>
  or <tt>dict-update-in</tt>. My primary project at the moment has a
  deeply-nested <tt>state</tt> fstruct that contains hash-tables
  which contain fstructs, so being able to use a
  single <tt>dict-update-in</tt> which operates across multiple
  concrete types is very convenient.</p>

<p>Finally, while I prefer pure functions for as much of the logic
  as I can, the outer layer requires tracking state and changes to
  it. Racket provides the <tt>box</tt> type for this, which is
  equivalent to the <tt>atom</tt> of Clojure. Unfortunately while it
  provides the same compare-and-swap atomicity guarantees, it only exposes this
  via the low-level <tt>box-cas!</tt> function. Oh well,
  functional <tt>swap!</tt> which operates in terms of the old value
  is easy to implement on our own or steal from Rackjure:</p>

<pre class="code"><span class="racket-paren">(</span><span class="keyword">define</span> <span class="racket-paren">(</span><span class="function-name">swap!</span> <span class="builtin">box</span> f . args<span class="racket-paren">)</span>
  <span class="racket-paren">(</span><span class="keyword">let</span> <span class="racket-paren">[(</span>old <span class="racket-paren">(</span><span class="builtin">unbox</span> <span class="builtin">box</span><span class="racket-paren">))]</span>
    <span class="racket-paren">(</span><span class="keyword">or</span> <span class="racket-paren">(</span><span class="builtin">box-cas!</span> <span class="builtin">box</span> old <span class="racket-paren">(</span><span class="builtin">apply</span> f old args<span class="racket-paren">))</span>
        <span class="racket-paren">(</span><span class="builtin">apply</span> swap! <span class="builtin">box</span> f args<span class="racket-paren">))))</span>

<span class="racket-paren">(</span><span class="keyword">define</span> <span class="variable-name">b</span> <span class="racket-paren">(</span><span class="builtin">box</span> <span class="racket-selfeval">56</span><span class="racket-paren">))</span>

<span class="racket-paren">(</span><span class="builtin">box-cas!</span> b <span class="racket-selfeval">56</span> <span class="racket-selfeval">92</span><span class="racket-paren">)</span> <span class="comment-delimiter">; </span><span class="comment">-&gt; b now contains 92
</span>
<span class="racket-paren">(</span>swap! b <span class="builtin">+</span> <span class="racket-selfeval">75</span><span class="racket-paren">)</span> <span class="comment-delimiter">; </span><span class="comment">-&gt; b now contains 167</span></pre>

<p>The <a href="https://github.com/technomancy/cooper">HyperCard
  clone</a> I <a href="/174">wrote about in my last post</a>
  consists of a number of modes that define handlers that can update
  the state based on clicks. The handlers are all functions that
  take and return a <tt>state</tt> fstruct and are called via
  the <tt>swap!</tt> function. This allows the bulk of the code to
  be written in a pure fashion while keeping state change
  constrained to
  only <a href="https://github.com/technomancy/cooper/blob/master/cooper/main.rkt#L51">two
  outer-layer mouse and key handler functions</a>. The actual box
  containing the state never leaves the <tt>main</tt> module.</p>

<p>Racket has top-notch support for
  <a href="http://docs.racket-lang.org/reference/data-structure-contracts.html">contracts</a>
  that
  can <a href="https://github.com/technomancy/cooper/blob/master/cooper/cooper.rkt#L55">describe
  the shape of data</a>. In this case rather than attaching
  contracts to functions scattered all over the codebase, I attach
  them only to the box that contains the <tt>state</tt> struct, and
  any time there's a type bug it's usually immediately apparent what
  caused the trouble. For instance, I have a contract that states
  that the "corners" field of each button must be a list of four
  natural numbers, but I've made a change which causes one of them
  to be negative:</p>

<pre class="code">now: broke its contract
   promised: natural-number/c
   produced: -23
   in: the 3rd element of
       the corners field of
       an element of
       the buttons field of
       the values of
       the cards field of
       the stack field of
       the content of
       (box/c (struct/dc state
                         (card string?)
                         (stack (struct/dc stack ...))))</pre>

<p>It's pretty clear here that I've made a miscalculation in the
  button coordinates. If you use DrRacket, the IDE that ships with
  Racket, you get a <a href="/i/drracket-error.png">very slick
  visual trace</a> leading you directly to the point at which the
  contract was violated. While it would be possible to gain more
  certainty about correctness at compile time by
  using <a href="http://docs.racket-lang.org/ts-guide/index.html">Typed
  Racket</a>, contracts let me define the shape of the data in a
  single place rather than annotating every function that handles
  state.</p>

<p>While I'd certainly be happy if Racket accomodated some of these
  functional programming idioms in a more streamlined way out of the
  box, it speaks volumes that I was able to make myself quite
  comfortable on my own only a week or two after beginning with the
  language[<a href="#fn3">3</a>]. It's interesting to note that all
  of the places in which Clojure has the edge[<a href="#fn4">4</a>]
  over Racket (with the conspicuous exception of equality) lie
  around succinctness and greater expressivity, while Racket's
  advantages are all around improved correctness and making mistakes
  easier to prevent and detect.</p>

<hr />

<p>[<a name="fn1">1</a>] It's possible to perform evaluation inside
  hash literal syntax by using backticks: <tt>`#hash((a . ,(+ 5 6
  7))</tt> does what you expect. It's better than nothing, but
  that's a lot of noise to express a simple concept. In practice,
  you don't really use the literal notation in programs; you just
  call the <tt>hash</tt> function.</p>

<p>[<a name="fn2">2</a>] I've blogged about <a href="/159">why egal
  is such a great equality predicate</a>. Racket ships with a
  bewildering array of equality functions, but in functional code
  you really only need this one (sadly absent from the core
  language) for 98% of what you do.</p>

<p>[<a name="fn3">3</a>] With one exception: Racket's macro system
  is rather intimidating coming from Clojure. Its additional
  complexity allows it to support some neat things, but so far I
  haven't gotten to the point where I'd understand why I'd want to
  do those kinds of things. In any case, I got help
  from <a href="http://www.greghendershott.com/">Greg
  Hendershott</a> to turn the <tt>fstruct</tt> macro into something
  properly hygenic.</p>

<p>[<a name="fn4">4</a>] This ignores the advantages conferred by
  the respective implementations&mdash;Clojure has significantly
  better performance and access to libraries, while Racket's
  compiler/debugger/editor tools are much more polished, and its
  resource consumption is dramatically lower.</p>
include(footer.html)
