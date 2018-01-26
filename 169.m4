dnl -*- html -*-
define(__timestamp, 2013-07-17T21:54:49Z)dnl
define(__title, `in which the reader is invited to engage in comparative lispology')dnl
define(__id, 169)dnl
include(header.html)
<p><a href="https://github.com/technomancy/skaro">Skaro</a> is a simplistic implementation
of <a href="https://en.wikipedia.org/wiki/Robots_(BSD_game)">the BSD
"robots" game</a> that I've ported to a number of different lisps
over the past few days. I started out putting together a version in
Chicken Scheme just to get a feel for that environment, and I
  followed it up with one in Clojure, one in Racket, and one in
Emacs Lisp.</p>

<p>My goal here was to explore what's idiomatic in each language, so
  while some of the programs could have been cleaner or shorter with
  third-party libraries, I limited myself to what shipped with the
  runtime in each case. In any lisp you end up shaping the language
  to your domain, but you still end up having to read lots of public
  code that may not share your same values about what's readable and
  maintainable, so the way the language feels out of the box is very
  important. I made no attempt to consider performance. Tuning
  and optimization are nuanced, application-specific tasks, and I'd
  be doing these languages a disservice if I attempted to
  generalized based on my experiences here.</p>

<p>The game's logic is pretty simple: you move around on a board,
  pursued by enemies who move towards you on every turn. When two
  enemies collide, they leave behind a pile of smoking refuse
  towards which you can lure more enemies. Finally, you can teleport
  to a random location on the board. In the interests of simplicity,
  this implementation doesn't support diagonal movement, making it a
  bit less fun to play, but we'll ignore that.</p>

<h4><a href="https://github.com/technomancy/skaro/blob/master/skaro.scm">Scheme</a></h4>

<p>So while I've <a href="/104">played with implementing Scheme
    before</a>, it's been quite a while; plus even while
    implementing it I never really used it for much. So the Scheme
    implementation of the game is pretty straightforward; it's a
    mostly-imperative version that
    uses <a href="http://srfi.schemers.org/srfi-9/srfi-9.html">mutable
    SRFI-9 records</a> for board state, storing enemies, piles, and
    the player position as <code>(x . y)</code> cons cells. For
    display it loops over all positions, <code>set-car!</code>ing a
    list of lists which is then printed.</p>

<p>My <a href="https://github.com/technomancy/skaro/blob/c7e823c185f0bfdaa1354c78a06418dff0b75563/skaro.scm">original
  implementation</a>
  used <a href="http://srfi.schemers.org/srfi-69/srfi-69.html">SRFI-69
  hash-tables</a> instead of records. While they are a bit more
  flexible due to not having to declare your fields up-front, they
  are a lot more verbose since every access has to go through
  the <code>hash-table-ref</code> function. A major annoyance was
  that neither records or hash-tables have a convenient literal
  syntax for printing and reading, making debugging cumbersome. With
  hash-tables I was able to send everything
  through <code>hash-table->alist</code> before printing, but the
  lack of literal syntax was a big annoyance.</p>

<p>The main earlier advantage in this codebase of using hash tables
  instead of records was the <code>hash-table-update!</code>
  function which takes a hash table and a key, and then takes an
  updater function which is passed the old value and returns the new
  value. This higher-order update is a nice touch, and I wish it was
  more common. For instance, without it in this case
  we must <code>map</code> to get the moved state of the enemies, and
  then set the record's field using <code>board-enemies-set!</code>:

  <pre class="code">(<span class="keyword">define</span> (<span class="function-name">move-enemies!</span> board)
  (board-enemies-set! board (<span class="keyword">map</span> (cut move-enemy (board-player board) &lt;&gt;)
                                 (board-enemies board))))</pre>

<p>While it's not a problem in this program, this could easily be a
  race condition in a concurrent context. An updater function could
  ensure this operation could be atomic.</p>

<p>Despite being mostly imperative, there are still a few places
  where it uses features commonly thought of as functional. While it
  updates data structures in place, the data structures are passed
  around as arguments rather than defined as top-level globals,
  meaning that from the perspective of embedding this code in a
  wider system, it can be treated a bit like a black box; none of
  the mutation escapes local scope. Also it uses
  <a href="http://srfi.schemers.org/srfi-26/srfi-26.html">SRFI-26's <code>cut</code>
  macro</a> in a few places to specialize a few parameters for
  higher-order function usage. Here a collision is defined
  as when a specific position is occupied by more than one
  entity:</p>

<pre class="code">(<span class="keyword">define</span> (<span class="function-name">collision?</span> position obstacles)
  (&gt; (count (cut equal? position &lt;&gt;) obstacles) 1))

(<span class="keyword">define</span> (<span class="function-name">get-collisions</span> enemies obstacles)
  (filter (cut collision? &lt;&gt; obstacles) enemies))</pre>

<p>In this case <code>cut</code> returns a function which has the
  given arguments fixed, using the <code>&lt;&gt;</code> identifier
  as a placeholder for un-fixed args. It's similar to
  Clojure's <code>partial</code> or Emacs
  Lisp's <code>apply-partially</code> but a bit more flexible since
  it supports args in any position. However, it's a macro rather
  than a function, so there's a bit of a composability
  trade-off. For simple <code>count</code> or <code>filter</code>
  functions it works great though.</p>

<h4><a href="https://github.com/technomancy/skaro/blob/master/skaro.rkt">Racket</a></h4>

<p>Racket started as a dialect of Scheme but has evolved into its
  own language, or more accurately into a collection of tools for
  creating languages. As such it's superficially very similar to the
  Scheme version. It uses <code>curry</code>, which
  has <a href="http://raganwald.com/2013/03/07/currying-and-partial-application.html">some
  subtle differences</a> from <code>cut</code>'s partial
  application, but for the purposes of this codebase is
  equivalent.</p>

<p>The main difference with this version is its use of immutable
  hash tables. The board here is simply a hash table
  with <code>'width</code>, <code>'height</code>, <code>'player</code>, 
  <code>'enemies</code>, and <code>'piles</code> keys. Updates are
  all purely functional, and we get the nice higher-order updater
  function from <code>hash-update</code> which was described above.
  Racket has records (aka structs) too, which can be immutable, but
  for the purpose of contrast I chose to stick with its hashes since
  from what I could tell they are a lot more capable than the SRFI
  equivalents. Structs in Racket also have the option of not being
  opaque, which means they have a nice readable syntax when
  printed. This is not the default, but I hear this will change in
  the future.[<a href="#fn1">1</a>]</p>

<p>Speaking of data structures,
  Racket's <a href="http://docs.racket-lang.org/reference/sequences.html">uniform
  sequence-handling functions</a> (similar to Clojure's) stand out as
  a major advantage over Scheme and some other lisps. Having a
  single abstraction that works across all collection data types
  makes a huge difference; there's just much less to keep in your
  head when you decide to use something other than a list, which
  means you're more likely to choose the right data structure for
  the job.</p>

<p>The best example of where the functional approach shines is the
  way the game logic is built. The <code>play</code> loop checks for
  various end-game states and then calls <code>round</code> to get
  the next board state. Then it draws the board and recurses with
  new player input:</p>

<pre class="code"><span class="paren">(</span><span class="keyword">define</span> <span class="paren">(</span><span class="function-name">play</span> board input<span class="paren">)</span>
  <span class="paren">(</span><span class="keyword">cond</span> [<span class="paren">(</span>killed? board<span class="paren">)</span>
         <span class="paren">(</span>display <span class="string">"You died.\n"</span><span class="paren">)</span>]
        [<span class="paren">(</span>eq? input 'quit<span class="paren">)</span>
         <span class="paren">(</span>display <span class="string">"Bye.\n"</span><span class="paren">)</span>]
        [<span class="paren">(</span>null? <span class="paren">(</span>hash-ref board 'enemies<span class="paren">))</span>
         <span class="paren">(</span>display <span class="string">"You won. Nice job.\n"</span><span class="paren">)</span>]
        [<span class="keyword">else</span> <span class="paren">(</span><span class="keyword">let</span> <span class="paren">(</span>[board <span class="paren">(</span>round board input<span class="paren">)</span>]<span class="paren">)</span>
                <span class="paren">(</span>draw-board board<span class="paren">)</span>
<span class="hl-line">                </span><span class="paren"><span class="hl-line">(</span></span><span class="hl-line">play board </span><span class="paren"><span class="hl-line">(</span></span><span class="hl-line">read</span><span class="paren"><span class="hl-line">)))</span></span><span class="hl-line">]</span><span class="paren"><span class="hl-line">))</span></span></pre>

<p>So what does <code>round</code> do then? It's a simple
  composition of three functions: <code>move-player</code> which
  takes the board and player input and returns a board with the new
  player position, <code>move-enemies</code> which updates enemy
  positions to move toward the player, and <code>collisions</code>,
  which checks for any space with two enemies on it and returns a
  board with those enemies replaced with a pile. Because each of
  these functions simply takes arguments and returns a new board
  state, the <code>compose</code> function can combine them into one
  function for the <code>play</code> loop to call.</p>

<pre class="code"><span class="paren"><span class="hl-line">(</span></span><span class="keyword"><span class="hl-line">define</span></span><span class="hl-line"> </span><span class="function-name"><span class="hl-line">round</span></span><span class="hl-line"> </span><span class="paren"><span class="hl-line">(</span></span><span class="hl-line">compose collisions move-enemies move-player</span><span class="paren"><span class="hl-line">))</span></span></pre>

<p>In this particular codebase all the state updates happen on the
  stack, but when you do need mutable references to immutable data
  structures, Racket
  provides <a href="http://docs.racket-lang.org/guide/boxes.html">boxes</a>
  for that purpose which wrap immutable data structures and can
  <a href="http://docs.racket-lang.org/reference/boxes.html?q=box-cas#%28def._%28%28quote._~23~25kernel%29._box-cas%21%29%29">enforce
  atomic updates</a>. This is quite nice, but it's a bit more
  cumbersome than Clojure's <code>swap!</code> since it's up to the
  caller to provide old and new values; for some reason there's no function
  which simply takes an updater function like <code>hash-update</code>.</p>

<h4><a href="https://github.com/technomancy/skaro/blob/master/skaro.clj">Clojure</a></h4>

<p>In the interest of full disclosure, Clojure is the one on this
  list I'm most familiar with, and it's also the shortest of these
  implementations: 59 lines vs 80 lines for each of the
  others. Whether these two facts are related is left as an exercise
  to the reader. The fact that you can destructure maps (aka hash
  tables) in argument declarations contributes the most to the
  reduction in lines. Racket and Emacs Lisp have pattern matching
  which can have a similar effect, but having it built-in to
  function definitions means it's used ubiquitously, whereas you're
  only likely to pull out an explicit pattern match in longer
  functions where you want to use it for control flow as well.</p>

<pre class="code">(<span class="keyword">defn</span> <span class="function-name">move-enemies</span> [{<span class="constant">:keys</span> [enemies player] <span class="constant">:as</span> board}]
  (<span class="builtin">update-in</span> board [<span class="constant">:enemies</span>] (<span class="builtin">partial</span> map (<span class="builtin">partial</span> move-enemy player))))</pre>

<p>The other thing making Clojure maps a lot more convenient is the
  fact that they can be called just like functions. I must admit to
  being baffled by the fact that other lisps don't support
  this. Hash tables (of the immutable variety) in fact
  have <b>more</b> in common with the mathematical definition of
  functions than functions[<a href="#fn2">2</a>] themselves, yet you
  can't call them like functions; you're stuck going through
  the <code>hash-table-ref</code> accessor
  function.[<a href="#fn3">3</a>]</p>

<p>Apart from these things the flow of the Clojure version is pretty
  similar to the Racket implementation. There's the
  same <code>play</code> loop with the same <code>round</code>
  composition of the steps. In Clojure the loop is done through an
  explicit <code>recur</code> form rather than a TCO'd
  self-invocation, which is arguably less elegant, but the result is
  the same. The board drawing code uses vectors, which we couldn't
  do in Racket because Racket's vectors are fixed-length; they're
  suitable for producing one-time read-optimized copies of lists but
  not for building up piece-by-piece from scratch.</p>

<p>Another downside here is that while Clojure supports partial
  application with <code>partial</code>, it can only support fixing
  arguments on the left, vs Racket's <code>curryr</code> which works
  on the right and Scheme's <code>cut</code> which can place them
  anywhere. This problem doesn't arise in this codebase, but it's
  worth pointing out.</p>

<h4><a href="https://github.com/technomancy/skaro/blob/master/skaro.el">Emacs Lisp</a></h4>

<p>The Emacs implementation has the least in common with the
  others. Purists, avert your eyes&mdash;Emacs Lisp is not what you
  would call a functional language. Whereas the other
  implementations pass around state as function arguments, this one
  calls <code>setq</code> in several places on
  top-level <code>defvar</code>s. Since Emacs Lisp is a Lisp-2,
  higher-order functions are fairly awkward. There's only a single
  higher-order function here in a <code>remove-if-not</code>
  call. Partial application was recently added to Emacs, but given
  that you usually need a <code>funcall</code> to actually invoke
  the partially applied function, it's seldom used, and a lot of
  basic functional mechanisms are simply
  absent. [<a href="#fn4">4</a>]</p>

<p>That said, this implementation possesses some compelling
  advantages that aren't obvious at first glance. The UI of the
  other implementations consists of a rudimentary loop in which a
  line is read from standard in and a representation of the board is
  printed out, with old boards simply scrolling up off the terminal,
  but in Emacs the user is presented with a buffer in which the
  board is updated directly. There's a proper asynchronous event
  loop (with user-customizeable key bindings, no less). All commands
  are discoverable, and fully cross-referenced documentation is easy
  to add. These benefits simply come for free by virtue of targeting
  the Emacs runtime.</p>

<p>The use of buffer-local defvars mitigates the perils of using
  top-level <code>defvar</code>s to a degree. It's still not as
  elegant as the functional approach, but it means that the
  top-level state doesn't prevent multiple copies of the game from
  interfering with each other; you can invoke <kbd>M-x skaro</kbd>
  twice and have two instances running side-by-side in the same
  process.</p>

<h4>So What?</h4>

<p>This short demo program obviously barely scratches the surface of
  the strengths of each individual language/runtime. If you need to
  do a lot of interfacing with C code, Chicken Scheme is the obvious
  choice&mdash;in those situations an imperative style is less
  likely to be a hindrance. Emacs Lisp has a strong lead when
  writing UIs for certain geeks despite its lack of functional
  features. When you are shooting for functional elegance, Clojure
  and Racket are both solid contenders. Clojure's access to the JVM
  libraries gives it an edge for certain projects, but Racket has
  the edge in places where the bulky, slow-to-start JVM runtime
  isn't welcome. (Racket executables can be as small as 700kb.)
  Racket has by far the strongest story for beginners due to its
  friendly culture and emphasis on documentation. In any case it's a
  great time to be a lisper.</p>

<p><b>Update</b>: I added
  an <a href="https://github.com/technomancy/skaro/blob/master/skaro.ml">OCaml
  implementation</a> after writing this post. In general I found it
  turned out very similar to the Clojure version, except with
  records instead of maps. I did not find the type system particularly
  interesting for this particular codebase because I had already
  written the complete program four times over, so I knew exactly
  how it should work while I was writing it. The type system is most
  helpful at catching mistakes while you make unexpected changes to
  the codebase, which didn't happen on this toy 80-line project.</p>

<hr>

<p>[<a name="fn1">1</a>] While I was writing this, I started having
  second thoughts about my use of hash tables here. I originally shied
  away from records after having poor experiences with them in
  Clojure and Emacs Lisp, but none of those issues come into play
  here. I'm starting to think that hash tables in Racket are really
  only appropriate when you don't know the keys up-front, which
  makes some of their quirks (like implicit quoting in their literal
  syntax) significantly less infuriating.</p>

<p>[<a name="fn2">2</a>] In fact, Scheme and Racket both refer to
  functions as <i>procedures</i>, presumably to emphasize the fact
  that they are not functions in the mathematical sense.</p>

<p>[<a name="fn3">3</a>] The
  third-party <a href="https://github.com/greghendershott/rackjure">rackjure</a>
  library</a> adds callable hash tables to Racket as well as a
  number of other creature comforts from Clojure.</p>

<p>[<a name="fn4">4</a>] Again, third-party libraries
  (like <a href="https://github.com/magnars/dash.el">dash.el</a>)
  help a lot here.</p>
include(footer.html)
