dnl -*- html -*-
define(__timestamp, 2018-01-12T19:53:51Z)dnl
define(__title, `in which the cost of structured data is reduced')dnl
define(__id, 185) define(__last)dnl
include(header.html)
<p>Last year I got the wonderful opportunity to
  attend <a href="https://con.racket-lang.org/">RacketCon</a> as it
  was hosted only 30 minutes away from my home. The two-day
  conference had a number of great talks on the first day, but what
  really impressed me was the fact that the entire second day was
  spent focusing on contribution. The day started out with a few 15-
  to 20-minute talks about how to contribute to a specific codebase
  (including that of Racket itself), and after that people just
  split off into groups focused around specific codebases. Each
  table had maintainers helping guide other folks towards how to
  work with the codebase and construct effective patch
  submissions.</p>

<img src="/i/chronicles-of-lensmen.jpg" alt="lensmen chronicles" class="right">

<p>I came away from the conference with a great sense of
  appreciation for how friendly and welcoming the Racket community
  is, and how great Racket is as a swiss-army-knife type tool for
  quick tasks. (Not that it's unsuitable for large projects, but I
  don't have the opportunity to start any new large projects very
  frequently.)</p>

<p>The other day I wanted to generate colored maps of
  the world by categorizing countries interactively, and Racket
  seemed like it would fit the bill nicely. The job is simple: show
  an image of the world with one country selected; when a key is
  pressed, categorize that country, then show the map again with
  all categorized countries colored, and continue with the next
  country selected.</p>

<h4>GUIs and XML</h4>

<p>I have yet to see a language/framework more accessible and
  straightforward out of the box for
  drawing<sup><a href="#fn1">1</a></sup>. Here's the entry point
  which sets up state and then constructs a canvas that handles key
  input and display:</p>

<pre class="code">(<span class="keyword">define</span> (<span class="function-name">main</span> path)
  (<span class="keyword">let</span> ([<span class="variable-name">frame</span> (<span class="builtin">new</span> frame% [label <span class="string">"World color"</span>])]
        [<span class="variable-name">categorizations</span> (<span class="builtin">box</span> '())]
        [<span class="variable-name">doc</span> (<span class="keyword">call-with-input-file</span> path read-xml/document)])
    (<span class="builtin">new</span> (<span class="builtin">class</span> canvas%
           (<span class="builtin">define/override</span> (<span class="function-name">on-char</span> event)
             (handle-key <span class="builtin">this</span> categorizations (<span class="builtin">send</span> event get-key-code)))
           (<span class="builtin">super-new</span>))
         [parent frame]
         [paint-callback (draw doc categorizations)])
    (<span class="builtin">send</span> frame show <span class="racket-selfeval">#t</span>)))</pre>

<p>While the class system is not one of my favorite things about
  Racket (most newer code seems to avoid it in favor
  of <a href="https://docs.racket-lang.org/reference/struct-generics.html">generic
  interfaces</a> in the rare case that polymorphism is truly called
  for), the fact that classes can be constructed in a light-weight,
  anonymous way makes it much less onerous than it could be. This
  code sets up all mutable state in
  a <a href="https://docs.racket-lang.org/reference/boxes.html?q=box#%28def._%28%28quote._~23~25kernel%29._box%29%29"><tt>box</tt></a>
  which you use in the way you'd use a <tt>ref</tt> in ML or
  Clojure: a mutable wrapper around an immutable data structure.</p>

<p>The world map I'm using
  is <a href="https://commons.wikimedia.org/wiki/File:BlankMap-World_gray.svg">an
  SVG of the Robinson projection</a> from Wikipedia. If you look
  closely there's a call to bind <tt>doc</tt> that
  calls <a href="https://docs.racket-lang.org/reference/port-lib.html#(def._((lib._racket%2Fport..rkt)._call-with-input-string))"><tt>call-with-input-file</tt></a>
  with <a href="https://docs.racket-lang.org/xml/index.html?q=read-xml#%28def._%28%28lib._xml%2Fmain..rkt%29._read-xml%2Fdocument%29%29"><tt>read-xml/document</tt></a> which loads up the whole map
  file's SVG; just about as easily as you could ask for.</p>

<p>The data you get back from <tt>read-xml/document</tt> is in fact
  a <a href="https://docs.racket-lang.org/xml/#%28def._%28%28lib._xml%2Fmain..rkt%29._document%29%29">document</a>
  struct, which contains an <tt>element</tt> struct
  containing <tt>attribute</tt> structs and lists of
  more <tt>element</tt> structs. All very sensible, but maybe not
  what you would expect in other dynamic languages like Clojure or
  Lua where free-form maps reign supreme. Racket really wants
  structure to be known up-front when possible, which is one of the
  things that help it produce helpful error messages when things
  go wrong.</p>

<p>Here's how we handle keyboard input; we're displaying a map with
  one country highlighted, and <tt>key</tt> here tells us what
  the user pressed to categorize the highlighted country. If that
  key is in the <tt>categories</tt> hash then we put it
  into <tt>categorizations</tt>.</p>

<pre class="code">(<span class="keyword">define</span> <span class="variable-name">categories</span> #hash((select . <span class="string">"eeeeff"</span>)
                         (<span class="racket-selfeval">#\1</span> . <span class="string">"993322"</span>)
                         (<span class="racket-selfeval">#\2</span> . <span class="string">"229911"</span>)
                         (<span class="racket-selfeval">#\3</span> . <span class="string">"ABCD31"</span>)
                         (<span class="racket-selfeval">#\4</span> . <span class="string">"91FF55"</span>)
                         (<span class="racket-selfeval">#\5</span> . <span class="string">"2439DF"</span>)))

(<span class="keyword">define</span> (<span class="function-name">handle-key</span> canvas categorizations key)
  (<span class="keyword">cond</span> [(<span class="builtin">equal?</span> <span class="racket-selfeval">#\backspace</span> key) <span class="comment-delimiter">; </span><span class="comment">undo
</span>         (swap! categorizations <span class="builtin">cdr</span>)]
        [(<span class="builtin">member</span> key (<span class="builtin">dict-keys</span> categories)) <span class="comment-delimiter">; </span><span class="comment">categorize
</span>         (swap! categorizations (<span class="builtin">curry</span> <span class="builtin">cons</span> key))]
        [(<span class="builtin">equal?</span> <span class="racket-selfeval">#\space</span> key) <span class="comment-delimiter">; </span><span class="comment">print state
</span>         (<span class="builtin">display</span> (<span class="builtin">unbox</span> categorizations))])
  (<span class="builtin">send</span> canvas refresh))</pre>

<h4>Nested updates: the bad parts</h4>

<p>Finally once we have a list of categorizations, we need to apply
  it to the map document and display. We apply
  a <a href="https://docs.racket-lang.org/reference/for.html?q=for%2Ffold#%28form._%28%28lib._racket%2Fprivate%2Fbase..rkt%29._for%2Ffold%29%29"><tt>fold</tt></a>
  reduction over the XML document struct and the list of country
  categorizations (plus <tt>'select</tt> for the country that's
  selected to be categorized next) to get back a "modified" document
  struct where the proper elements have the style attributes applied
  for the given categorization, then we turn it into an image and
  hand it
  to <a href="https://docs.racket-lang.org/pict/Rendering.html?q=draw-pict#%28def._%28%28lib._pict%2Fmain..rkt%29._draw-pict%29%29"><tt>draw-pict</tt></a>:</p>

<pre class="code">(<span class="keyword">define</span> (<span class="function-name">update</span> original-doc categorizations)
  (<span class="keyword">for/fold</span> ([doc original-doc])
            ([category (<span class="builtin">cons</span> <span class="racket-selfeval">'select</span> (<span class="builtin">unbox</span> categorizations))]
             [n (<span class="keyword">in-range</span> (<span class="builtin">length</span> (<span class="builtin">unbox</span> categorizations)) <span class="racket-selfeval">0</span> <span class="racket-selfeval">-1</span>)])
    (set-style doc n (style-for category))))

(<span class="keyword">define</span> ((<span class="function-name">draw</span> doc categorizations) _ context)
  (<span class="keyword">let*</span> ([<span class="variable-name">newdoc</span> (update doc categorizations)]
         [<span class="variable-name">xml</span> (<span class="builtin">call-with-output-string</span> (<span class="builtin">curry</span> write-xml newdoc))])
    (draw-pict (<span class="builtin">call-with-input-string</span> xml svg-port-&gt;pict) context <span class="racket-selfeval">0</span> <span class="racket-selfeval">0</span>)))</pre>

<p>The problem is in that pesky <tt>set-style</tt> function. All it
  has to do is reach deep down into the <tt>document</tt> struct to
  find the <tt>n</tt>th <tt>path</tt> element (the one associated
  with a given country), and change its <tt>'style</tt>
  attribute. It ought to be a simple task. Unfortunately this
  function ends up being anything but simple:</p>

<pre class="code"><span class="comment">;; you don't need to understand this; just grasp how huge/awkward it is</span>
(<span class="keyword">define</span> (<span class="function-name">set-style</span> doc n new-style)
  (<span class="keyword">let*</span> ([<span class="variable-name">root</span> (document-element doc)]
         [<span class="variable-name">g</span> (<span class="builtin">list-ref</span> (element-content root) <span class="racket-selfeval">8</span>)]
         [<span class="variable-name">paths</span> (element-content g)]
         [<span class="variable-name">path</span> (<span class="builtin">first</span> (<span class="builtin">drop</span> (<span class="builtin">filter</span> element? paths) n))]
         [<span class="variable-name">path-num</span> (list-index (<span class="builtin">curry</span> <span class="builtin">eq?</span> path) paths)]
         [<span class="variable-name">style-index</span> (list-index (<span class="keyword">lambda</span> (x) (<span class="builtin">eq?</span> <span class="racket-selfeval">'style</span> (attribute-name x)))
                                  (element-attributes path))]
         [<span class="variable-name">attr</span> (<span class="builtin">list-ref</span> (element-attributes path) style-index)]
         [<span class="variable-name">new-attr</span> (make-attribute (source-start attr)
                                   (source-stop attr)
                                   (attribute-name attr)
                                   new-style)]
         [<span class="variable-name">new-path</span> (make-element (source-start path)
                                 (source-stop path)
                                 (element-name path)
                                 (<span class="builtin">list-set</span> (element-attributes path)
                                           style-index new-attr)
                                 (element-content path))]
         [<span class="variable-name">new-g</span> (make-element (source-start g)
                              (source-stop g)
                              (element-name g)
                              (element-attributes g)
                              (<span class="builtin">list-set</span> paths path-num new-path))]
         [<span class="variable-name">root-contents</span> (<span class="builtin">list-set</span> (element-content root) <span class="racket-selfeval">8</span> new-g)])
    (make-document (document-prolog doc)
                   (make-element (source-start root)
                                 (source-stop root)
                                 (element-name root)
                                 (element-attributes root)
                                 root-contents)
                   (document-misc doc))))</pre>

<p>The reason for this is that while structs are immutable, they
  don't support functional updates. Whenever you're working with
  immutable data structures, you want to be able to say "give me a
  new version of this data, but with field <tt>x</tt> replaced by
  the value of <tt>(f (lookup x))</tt>". Racket
  can <a href="https://docs.racket-lang.org/reference/dicts.html?q=dict-update#%28def._%28%28lib._racket%2Fdict..rkt%29._dict-update%29%29">do
  this with dictionaries</a> but not with structs<sup><a href="#fn2">2</a></sup>.  If you want a
  modified version you have to create a fresh
  one<sup><a href="#fn3">3</a></sup>.</p>

<h4>Lenses to the rescue?</h4>

<img src="/i/first-lensman.jpg" alt="first lensman" align="left">

<p>When I brought this up in the <tt>#racket</tt> channel on
  Freenode, I was helpfully pointed to the 3rd-party
  <a href="https://docs.racket-lang.org/lens/lens-guide.html">Lens</a>
  library. Lenses are a general-purpose way of composing arbitrarily
  nested lookups and updates. Unfortunately at this time
  there's <a href="https://github.com/jackfirth/lens/issues/290">a
  flaw</a> preventing them from working with <tt>xml</tt> structs, so
  it seemed I was out of luck.</p>

<p>But then I was pointed
  to <a href="https://docs.racket-lang.org/pollen/second-tutorial.html?q=xexpr#%28part._.X-expressions%29">X-expressions</a>
  as an alternative to
  structs. The <a href="https://docs.racket-lang.org/xml/index.html?q=xexpr#%28def._%28%28lib._xml%2Fmain..rkt%29._xml-~3exexpr%29%29"><tt>xml->xexpr</tt></a>
  function turns the structs into a deeply-nested list tree with
  symbols and strings in it. The tag is the first item in the list,
  followed by an associative list of attributes, then the element's
  children. While this gives you fewer up-front guarantees about the
  structure of the data, it does work around the lens issue.</p>

<p>For this to work, we need to compose a new lens based on the
  "path" we want to use to drill down into the <tt>n</tt>th country
  and its <tt>style</tt>
  attribute. The <a href="https://docs.racket-lang.org/lens/lens-reference.html#%28def._%28%28lib._lens%2Fcommon..rkt%29._lens-compose%29%29"><tt>lens-compose</tt></a>
  function lets us do that. Note that the order here might be
  backwards from what you'd expect; it works deepest-first (the way
  <a href="https://docs.racket-lang.org/reference/procedures.html#%28def._%28%28lib._racket%2Fprivate%2Flist..rkt%29._compose%29%29"><tt>compose</tt></a>
  works for functions). Also note that defining one lens gives us
  the ability to both get nested values
  (with <a href="https://docs.racket-lang.org/lens/lens-reference.html?q=lens-view#%28def._%28%28lib._lens%2Fcommon..rkt%29._lens-view%29%29"><tt>lens-view</tt></a>) <em>and</em> update them.</p>

<pre class="code">(<span class="keyword">define</span> (<span class="function-name">style-lens</span> n)
  (lens-compose (dict-ref-lens <span class="racket-selfeval">'style</span>)
                second-lens
                (list-ref-lens (<span class="builtin">add1</span> (<span class="builtin">*</span> n <span class="racket-selfeval">2</span>)))
                (list-ref-lens <span class="racket-selfeval">10</span>)))</pre>

<p>Our <tt>&lt;path&gt;</tt> XML elements are under the 10th item of
  the root xexpr, (hence the <a href="https://docs.racket-lang.org/lens/lens-reference.html?q=lens-view#%28def._%28%28lib._lens%2Fdata%2Flist..rkt%29._list-ref-lens%29%29"><tt>list-ref-lens</tt></a> with 10) and
  they are interspersed with whitespace, so we have to
  double <tt>n</tt> to find the <tt>&lt;path&gt;</tt> we
  want. The <a href="https://docs.racket-lang.org/lens/lens-reference.html?q=lens-view#%28def._%28%28lib._lens%2Fdata%2Flist..rkt%29._second-lens%29%29"><tt>second-lens</tt></a> call gets us to that element's
  attribute alist, and <a href="https://docs.racket-lang.org/lens/lens-reference.html?q=lens-view#%28def._%28%28lib._lens%2Fdata%2Fdict..rkt%29._dict-ref-lens%29%29"><tt>dict-ref-lens</tt></a> lets us zoom in on
  the <tt>'style</tt> key out of that alist.</p>

<p>Once we have our lens, it's just a matter of
  replacing <tt>set-style</tt> with a call
  to <a href="https://docs.racket-lang.org/lens/lens-reference.html?q=lens-view#%28def._%28%28lib._lens%2Fcommon..rkt%29._lens-set%29%29"><tt>lens-set</tt></a>
  in our <tt>update</tt> function we had above, and then we're
  off:</p>

<pre class="code">(<span class="keyword">define</span> (<span class="function-name">update</span> doc categorizations)
  (<span class="keyword">for/fold</span> ([d doc])
            ([category (<span class="builtin">cons</span> <span class="racket-selfeval">'select</span> (<span class="builtin">unbox</span> categorizations))]
             [n (<span class="keyword">in-range</span> (<span class="builtin">length</span> (<span class="builtin">unbox</span> categorizations)) <span class="racket-selfeval">0</span> <span class="racket-selfeval">-1</span>)])
    (lens-set (style-lens n) d (<span class="builtin">list</span> (style-for category)))))</pre>

<img src="/i/second-stage-lensman.jpg" alt="second stage lensman" class="right">

<p>Often times the trade-off between freeform maps/hashes vs
  structured data feels like one of convenience vs long-term
  maintainability. While it's unfortunate that they can't be used
  with the <tt>xml</tt> structs<sup><a href="#fn4">4</a></sup>,
  lenses provide a way to get the best of both worlds, at least in
  some situations.</p>

<p>The final version of the code clocks in at 51 lines and is
  is available <a href="https://gitlab.com/technomancy/world-color/blob/master/world-color.rkt">on GitLab</a>.</p>

<hr>

<div class="footnotes">

<p>[<a name="fn1">1</a>] The <a href="https://love2d.org">LÖVE</a>
  framework is the closest thing, but it doesn't have the same
  support for images as a first-class data type that works in the repl.</p>

<p>[<a name="fn2">2</a>] If you're defining your own structs, you
  can make
  them <a href="https://github.com/technomancy/cooper/blob/master/cooper/fstruct.rkt#L26">implement
  the dictionary interface</a>, but with the <tt>xml</tt> library we
  have to use the struct definitions provided us.</p>

<p>[<a name="fn3">3</a>] Technically you can use
  the <a href="https://docs.racket-lang.org/reference/struct-copy.html"><tt>struct-copy</tt></a>
  function, but it's not that much better. The field names must be
  provided at compile-time, and it's no more efficient as it copies
  the entire contents instead of sharing internal structure. And it
  still doesn't have an API that allows you to express the new value as a
  function of the old value.</p>

<p>[<a name="fn4">4</a>]
  Lenses <a href="https://docs.racket-lang.org/lens/lens-reference.html#(form._((lib._lens%2Fdata%2Fstruct..rkt)._define-struct-lenses))">work
  with most regular structs</a> as long as they
  are <a href="https://docs.racket-lang.org/guide/define-struct.html?q=transparent%20structs#%28part._trans-struct%29">transparent</a>
  and don't use subtyping. Subtyping and opaque structs are
  generally considered bad form in modern Racket, but you do find
  older libraries that use them from time to time.</p>
</div>
include(footer.html)
