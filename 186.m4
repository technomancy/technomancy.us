dnl -*- html -*-
define(__timestamp, 2018-03-03T16:35:16Z)dnl
define(__title, `in which a compiler gets its wings')dnl
define(__id, 186)dnl
include(header.html)
<p>I've enjoyed writing Lua code for
  my <a href="https://gitlab.com/technomancy/bussard">side</a>
  <a href="https://gitlab.com/technomancy/polywelL">projects</a> for the
  most part. It has a few quirks, but many of them can be solved
  by <a href="https://github.com/mpeterv/luacheck">a little linting</a>.
  For a non-homoiconic language there is little in the syntax to
  object to, and the aggressively minimalist semantics more than make up for
  the few shortcomings.</p>

<p>Still, I always wondered what it would be like to use a language that
  compiled to Lua and didn't have problems like the statement vs
  expression distinction, lack of arity checks, or defaulting to
  globals. Over the past year or so I looked at several such
  languages<sup><a href="#fn1">1</a></sup>, but nothing ever stuck. Then a
  few weeks ago I
  found <a href="https://github.com/bakpakin/Fennel">Fennel</a> (at the
  time called "fnl"), and it really resonated with me.</p>

<p><b>Update</b>: Fennel got <a href="https://fennel-lang.org">its own
    web site</a> with an in-browser repl and tutorial.</p>

<h4>The Microlanguage</h4>

<img src="i/snowy-sidewalk.jpg" alt="snowy sidewalk" class="right">

<p>The thing that sets Fennel apart is that it is strictly about adding
  new syntax to Lua and keeping Lua's semantics. This allows it to operate
  as a compiler which introduces <em>no runtime overhead</em>. Code in
  Fennel translates trivially to its Lua equivalent:</p>

<pre class="code">(<span class="keyword">let</span> [x (<span class="keyword">+</span> 89 5.25)
      f (<span class="keyword">fn</span> [abc] (<span class="builtin">print</span> (<span class="keyword">*</span> 2 abc)))]
  (f x))</pre>

<p>... becomes ...</p>

<pre class="code"><span class="keyword">do</span>
  <span class="keyword">local</span> <span class="variable-name">x</span> = (89 + 5.25)
  <span class="keyword">local</span> <span class="keyword">function</span> <span class="function-name">_0_</span>(abc)
      <span class="keyword">return</span> <span class="builtin">print</span>((2 * abc))
  <span class="keyword">end</span>
  <span class="keyword">local</span> <span class="variable-name">f</span> = _0_
  <span class="keyword">return</span> f(x)
<span class="keyword">end</span></pre>

<p>There are a few quirks around introducing temporary variable names in
  cases where it's unnecessary like the above, but these are only
  readability concerns and do not affect the performance of the code,
  since Lua is smart enough to collapse it down. The
  temporary locals are introduced in order to ensure that every form in
  Fennel has a value; there are no statements, only expressions. This
  fixes a common problem in Lua where you can't use an <tt>if</tt> to
  calculate the value of an expression, because it's implemented as a
  statement, so you have to construct complex <tt>and</tt>/<tt>or</tt>
  chains to simulate <tt>if</tt> expressions. Plus it's just simpler and
  more consistent to omit statements completely from the language semantics.</p>

<p>The one exception to the no-overhead rule is Fennel's <tt>lambda</tt> form.
  Fennel's <tt>fn</tt> keyword compiles straight to a no-nonsense
  Lua <tt>function</tt> with all that implies. But Lua's <tt>function</tt>
  has one feature that is quite error-prone: it doesn't check to ensure
  that it was called with the correct number of arguments. This leads
  to <tt>nil</tt> values easily getting propagated all thru the call stack
  by mistake. Fennel's solution to this is <tt>lambda</tt>, which includes
  checks to ensure that this doesn't happen. This function will signal an
  error when it's called with zero or one argument, but the <tt>?w</tt>
  and <tt>?h</tt> arguments are optional:</p>

<pre class="code">(<span class="keyword">lambda</span> [x y ?w ?h]
  (make-thing {<span class="builtin">:x</span> x <span class="builtin">:y</span> y
               <span class="builtin">:width</span> (<span class="keyword">or</span> ?w 10) <span class="builtin">:height</span> (<span class="keyword">or</span> ?h 10)}))</pre>

<p>The other main difference between Fennel and Lua is that Fennel takes
  more care to distinguish between sequential tables and key/value
  tables. Of course on the Lua runtime there is no difference; only one
  kind of table exists, and whether it is sequential or not is just a
  matter of how it's constructed or used. Lua uses <tt>{}</tt> notation
  for all tables, but Fennel allows you to construct sequential tables
  (array-like tables which have consecutive integers as keys)
  using <tt>[]</tt> instead. Lua overloads the <tt>for</tt> keyword to
  iterate over a numeric range as well as to work with generic iterators
  like <tt>pairs</tt> for values in tables. Fennel uses <tt>each</tt> for
  the latter, which makes the difference clearer at a glance.</p>

<h4>The Compiler</h4>

<p>To be clear, these are very small improvements over Lua. Normally I
  wouldn't consider switching to a new language over such things. But
  Fennel is unique in its simplicity and lack of overhead, so it doesn't
  cost much to bring it in. When I found out about Fennel, it was an
  experimental compiler that had been written over the course of one week
  in 2016 and then forgotten. But I was impressed with how <em>useful</em>
  it was after only that week of development. I could see at a glance that
  in around a thousand lines of code it had a functional compiler that
  output fairly readable Lua code and fixed the problem of statements.</p>

<p>So I dived into the codebase and started adding a few conveniences,
  starting with a test case and some static analysis. When Fennel's
  creator Calvin Rose saw what I was doing, he gave me feedback and
  started to pick back up on development too. As I got more comfortable
  with the code I started adding features,
  like <tt>each</tt>, <tt>when</tt>, and comments. Then I started putting
  it thru the paces by porting some of my existing Lua programs
  over<sup><a href="#fn2">2</a></sup>. This went much more smoothly than I
  anticipated. I did find a few compiler bugs, but they were either easy
  to fix myself or fixed quickly by Calvin Rose once I pointed them
  out. Once I had a few programs under my belt I wrote
  up <a href="https://github.com/bakpakin/Fennel/blob/master/tutorial.md">an
  introductory tutorial</a> to the language that you should read if you
  want to give it a try.</p>

<img src="i/tumwater-rapids.jpg" alt="Tumwater falls, with raging water">

<h4>But what about the lines?</h4>

<p>But one thing really bothered me when writing Fennel programs. When you
  needed to debug, the Lua output was fairly readable, but you quickly ran
  into the curse of all source→source compilers: line numbers didn't add
  up. Some runtimes allow you to provide source maps which change the
  numbering on stack traces to match the original source code, but Lua
  runtimes don't offer this. If your compiler emits bytecode instead of
  source, you can set the line numbers for functions directly. But then
  you're tied to a single VM and have to sacrifice portability.</p>

<p>So what's a poor compiler to do? This being Fennel, the
  answer is "the simplest thing possible". In this case, the simplest
  thing is to track the line number when emitting Lua source, and only
  emit newlines when it's detected that the current output came from
  input with a line number greater than the one it's currently on.</p>

<p>For most compilers, this naive approach would quickly fall to
  pieces. Usually you can't rely on the output being in the same order as
  the input that generated it<sup><a href="#fn3">3</a></sup>. I honestly
  did not have high hopes for this when I started working on it. But
  because of Fennel's 1:1 simplicity and predictability, it actually works
  surprisingly well.</p>

<h4>The future?</h4>

<p>At this point I'm pretty happy with where the compiler is, so my own
  plans are mostly just to write more Fennel code. The
  upcoming <a href="https://itch.io/jam/lisp-game-jam-2018">Lisp Game
  Jam</a> will be a perfect excuse to do just that. I have a few ideas for
  further compiler improvements, like associative destructuring (sequential
  destructuring already works great), pattern matching, or even making the
  compiler self-hosting, but there's nothing quite like getting out there
  and banging out some programs.</p>

<hr>

<div class="footnotes">
  <p>[<a name="fn1">1</a>]
    Here's a list of the lisps I found that compile to Lua and my brief
    impression of them:</p>
  <dl style="font-size: 140%;">
    <dt><a href="https://github.com/leafo/moonlisp">Moonlisp</a></dt>
    <dd>An experimental lisp by the creator of Moonscript. Looks neat, but
      it requires an alpha build of Moonscript 0.2.0 from 2012 to run.</dd>

    <dt><a href="https://github.com/larme/hua">Hua</a></dt>
    <dd>Inspired by <a href="http://hylang.org">Hy</a>, this seems to be
      an improvement over Hy, since the latter inherits some of Python's
      unfortunate design bugs around scoping. If you're a Hy user, this
      might be a nice way to trade library availability for speed and
      consistency, but since the compiler is written in Hy it means you
      need two runtimes, which complicates deployment.</dd>

    <dt><a href="https://github.com/raph-amiard/clojurescript-lua">ClojureScript-Lua</a></dt>
    <dd>This looked promising when it was first announced, but it was
      based on a <em>very</em> early version of ClojureScript that was
      still quirky and didn't have a repl, and was abandoned a few
      months after it was announced. It has the same problem of
      requiring a separate runtime for the compiler as Hua, except that
      runtime needs dramatically greater resources.</dd>

    <dt><a href="https://github.com/kstep/scheme.lua">scheme.lua</a></dt>
    <dd>This actually looks pretty nice if you like Scheme. It's pretty
      immature, but probably wouldn't take that much work to get to a
      usable state. Personally I find Lua tables to be much more friendly
      to work with than Scheme's lists, so sticking strictly with Scheme's
      semantics seems like a step backwards, but I know some people like
      it.</dd>

    <dt><a href="https://github.com/meric/l2l">l2l</a></dt>
    <dd>I actually did use
      this <a href="https://gitlab.com/technomancy/bussard/blob/beta-2/os/lisp/resources/portal.lsp">in
      my game</a>. But since I tried it the compiler has been more or less
      completely rewritten. The unique thing about the new l2l compiler is
      that it allows you to mix Lua code and lisp code in the same file. I
      found it rather difficult to follow code that does this, but it's an
      interesting idea. The readme for l2l includes some very apt Taoist
      quotations, which earns it extra points in my book.</dd>

    <dt><a href="http://urn-lang.com/">Urn</a></dt>
    <dd>I saved the best for last. Urn is a very impressive language with
      a smart compiler that has great error messages, pattern matching,
      and tree-shaking to strip out code that's not used. The main reason
      I decided not to use Urn is that it wants to do a lot of
      optimization and analysis up-front and sacrifices some interactivity
      and reloading features to achieve it. As one who prizes interactivity
      above all other considerations, I found it a poor fit. Urn wants
      to be its own language that just uses Lua as a runtime, and that's
      great, but right now I'm looking for something that just takes Lua
      and makes the syntax nicer.</dd>
  </dl>

  <p>[<a name="fn2">2</a>] My first program
    was <a href="https://p.hagelb.org/pong.fnl.html">a 1-page Pong</a>,
    which is kind of the "hello world" of games. Then I ported the
    user-level config
    from <a href="https://gitlab.com/technomancy/polywell/blob/fennel/config/repl.fnl">Polywell</a>,
    my Emacs clone, over to Fennel. This has made Polywell seem a lot more
    Emacsy than it used to be.</p>

  <p>[<a name="fn3">3</a>] Of course, once macros are introduced to the
    picture you can write code where this guarantee no longer
    applies. Oddly enough I'm not particularly interested in complex
    macros beyond things like pattern matching, so I don't see it being a
    problem for code I write, but it's worth noting that there are
    complications.</p>
</div>

include(footer.html)
