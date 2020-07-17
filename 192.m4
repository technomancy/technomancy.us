dnl -*- html -*-
define(__timestamp, 2020-06-30 08:30:17)dnl
define(__title, `in which a compiler takes steps towards strapping its boots')dnl
define(__id, 192) define(__last) dnl
include(header.html)
<p>One of the biggest milestones in a programming language is when the
  language gets to the point where it can be used to write its own
  implementation, which is
  called <a href="https://en.wikipedia.org/wiki/Self-hosting_(compilers)">self-hosting</a>. This
  is seen as a sign of maturity since reaching this point requires
  getting a lot of common problems shaken out first.</p>

<p>The compiler for the Fennel programming language was written using
  Lua, and it emits Lua code as output. Over time, certain parts of the
  compiler were added that were written in Fennel, starting
  with <tt>fennelview</tt>, which is the pretty-printer for Fennel
  data structures. Once the macro system stabilized, many built-in
  forms that had originally been hard-coded into the compiler using
  Lua got ported to the macro system. After that the REPL was ported
  to Fennel as a relatively independent piece of code, followed by the
  command-line launcher script and a helper module to explain and
  identify compiler errors. The parser had already seen
  <a href="https://gitlab.com/benaiah/fennel-the-book">an impressive
    port to Fennel</a> using a literate programming approach, but we
  hadn't incorporated this into the mainline repository yet because
  the literate approach made it a bit tricky to bring in.</p>

<p>As you might expect, any attempt at self-hosting can easily run into
  "chicken or egg" problems&mdash;how do you use the language to write
  the implementation if the language hasn't been finished being
  defined yet? Sometimes this requires simply limiting yourself to a
  subset; for instance, the built-in macros in Fennel cannot
  themselves use any macros but must be written in a macroless subset
  of Fennel. In other cases, such as the launcher, we keep a copy of
  the old pre-self-hosted version around in order to build the new version.</p>

<img src="/i/canal.jpg" alt="lake union/lake washington canal" >

<p>That's about as far as we could get on the path to self-hosting
  without changing the approach, because most of the remaining code was
  fairly entangled, and we didn't have clear boundaries to port it one piece
  at a time. At this stage there were 2250 lines of Lua and 1113 lines
  of Fennel. I recently took some time
  to <a href="https://github.com/bakpakin/Fennel/pull/297">reorganize
  the compiler</a> into four independent "pseudo-modules" with clear
  dependencies between the pieces. But even with the independent
  modules broken out, we were still looking at porting 800 lines of
  intricate compiler code and 900 lines of special forms all in two
  fell swoops.</p>

<p>That's when I started to consider an alternate approach. The Fennel
  compiler takes Fennel code as input and produces Lua code as output. We
  have a big pile of Lua code in the compiler that we want turned
  into Fennel code. What if we could reverse the process? That's when
  <a href="https://git.sr.ht/~technomancy/antifennel/">Antifennel</a>
  was born.</p>

<pre class="code">(<span class="keyword">fn</span> <span class="variable-name">compile</span> [ast tail?]
  (<span class="keyword">when</span> (<span class="type">os.getenv</span> <span class="string">"DEBUG"</span>) (<span class="builtin">print</span> <span class="type">ast.kind</span>))
  (<span class="keyword">match</span> <span class="type">ast.kind</span>
    <span class="string">"Chunk"</span> (chunk (map <span class="type">ast.body</span> compile <span class="keyword">true</span>)) <span class="comment">; top-level container of exprs
</span>    <span class="string">"LocalDeclaration"</span> (local-declaration compile ast)
    <span class="string">"FunctionDeclaration"</span> (declare-function compile ast)

    <span class="string">"FunctionExpression"</span> (function compile ast)
    <span class="string">"BinaryExpression"</span> (binary compile ast)
    <span class="string">"ConcatenateExpression"</span> (concat compile ast)
    <span class="string">"CallExpression"</span> (call compile ast)
    <span class="string">"LogicalExpression"</span> (binary compile ast)
    <span class="string">"AssignmentExpression"</span> (assignment compile ast)
    <span class="string">"SendExpression"</span> (send compile ast)
    <span class="string">"MemberExpression"</span> (member compile ast)
    <span class="string">"UnaryExpression"</span> (unary compile ast)
    <span class="string">"ExpressionStatement"</span> (compile <span class="type">ast.expression</span>)

    <span class="string">"IfStatement"</span> (if* compile ast tail?)
    <span class="string">"DoStatement"</span> (do* compile ast tail?)
    <span class="string">"ForInStatement"</span> (each* compile ast)
    <span class="string">"WhileStatement"</span> (while* compile ast)
    <span class="string">"RepeatStatement"</span> (repeat* compile ast)
    <span class="string">"ForStatement"</span> (for* compile ast)
    <span class="string">"BreakStatement"</span> (break compile ast)
    <span class="string">"ReturnStatement"</span> (<span class="keyword">if</span> tail?
                          (vals compile ast)
                          (early-return compile ast))

    <span class="string">"Identifier"</span> (sym <span class="type">ast.name</span>)
    <span class="string">"Table"</span> (table* compile ast)
    <span class="string">"Literal"</span> (<span class="keyword">if</span> (<span class="keyword">=</span> <span class="keyword">nil</span> <span class="type">ast.value</span>) (sym <span class="builtin">:nil</span>) <span class="type">ast.value</span>)
    <span class="string">"Vararg"</span> (sym <span class="string">"..."</span>)
    <span class="keyword">nil</span> (sym <span class="builtin">:nil</span>)

    _ (unsupported ast)))</pre>

<p>Antifennel takes Lua code and parses[<a href="#fn1">1</a>] it, then
  walks the abstract syntax tree of Lua and builds up an abstract syntax tree
  of Fennel code based on it. I had to add some features
  to <a href="https://git.sr.ht/~technomancy/fnlfmt">fnlfmt</a>, the
  formatter for Fennel, in order to get the output to look decent, but
  the overall approach is overall rather straightforward since Fennel
  and Lua have a great deal of overlap in their semantics.</p>

<p>The main difficulties came from supporting features which are
  present in the Lua language but not in Fennel. Fennel omits
  somethings which are normal in Lua, usually because the code becomes
  easier to understand if you can guarantee certain things never
  happen. For instance, when you read a Fennel function, you don't
  have to think about where in the code the possible return values can
  be found; these can only occur in tail positions because there is no
  early return. But Lua allows you to return (almost) anywhere in the
  function!</p>

<p>Fennel has one "secret" feature to help with this: the <tt>lua</tt>
  special form:</p>

  <pre class="code">(<span class="keyword">lua</span> <span class="string">"return nextState, value"</span>)</pre>

<p>Included specifically to make the task of porting existing code
  easier, the <tt>lua</tt> form allows you to emit Lua code directly
  without the compiler checking its validity. This is an "escape
  hatch" that can allow you to port Lua code as literally as possible
  first, then come back once you have it working and clean up the ugly
  bits once you have tests and things in place. It's not pretty, but
  it's a practical compromise that can help you get things done.</p>

<p>Unfortunately it's not quite as simple as just calling <tt>(lua
    "return x")</tt>, because if you put this in the output every time
  there's a <tt>return</tt> in the Lua code, most of it will be in
  the tail position. But Fennel doesn't understand that
  the <tt>lua</tt> call is actually a return value; it thinks that
  it's just a side-effect, and it will helpfully insert a <tt>return
    nil</tt> after it for consistency. In order to solve this I needed
  to <a href="https://git.sr.ht/~technomancy/antifennel/commit/baabd1dc9b610c28f65328324d9377309fd43ed2">track
    which returns occurred in the tail position and which were early
    returns</a>, so I could use normal Fennel methods for the tail
  ones and use this workaround hack only for early returns[<a href="#fn2">2</a>]. But that
  ended up being easier than it sounds.</p>

<p>Other incompatibilities were the lack of a <tt>break</tt> form
  (which could easily be addressed with the <tt>(lua "break")</tt>
  hack because it <em>only</em> happens in a non-tail position), the
  lack of <tt>repeat</tt> form (compiled into a <tt>while</tt> with
  a <tt>break</tt> at the end), and the fact that locals default to
  being immutable in Fennel and mutability is opt-in. This last one I
  am currently handling by emitting <em>all</em> locals
  as <tt>var</tt> regardless of whether they are mutated or not, but I
  plan on adding tracking in to allow the compiler to emit the
  appropriate declaration based on how it's used.</p>

<p>While it's still too early to swap out the canonical implementation
  of the Fennel compiler, the Antifennel-compiled version works
  remarkably well, passing the entire language test suite across every
  supported version of the Lua runtime at 79% the length of the Lua
  version. I'm looking forward to finishing the job and making the
  Fennel codebase written purely using Fennel itself.</p>

<hr>

<p>[<a name="fn1">1</a>] Antifennel uses the parser from
  the <a href="https://github.com/franko/luajit-lang-toolkit">LuaJIT
  Language Toolkit</a>, which is another self-hosted compiler
  that takes Lua code as input and emits LuaJIT bytecode without
  requiring any C code to be involved. (Of course, in order to <em>run</em> the
  bytecode, you have to use the full LuaJIT VM, which is mostly
  written in C.) I had to
  make <a href="https://git.sr.ht/~technomancy/antifennel/commit/c436ed1418acd1cecf63db41326617101688afa1">one
  small change</a> to the parser in order to help it "mangle"
  identifiers that were found to conflict with built-in special forms
  and macros in Fennel, but other than that it worked great with no
  changes. The first big test of Antifennel was making sure it could
  compile its own parser dependency from Lua into Fennel,
  which <a href="https://git.sr.ht/~technomancy/antifennel/commit/baabd1dc9b610c28f65328324d9377309fd43ed2">it
  could do on the second day</a>.</p>

<p>[<a name="fn2">2</a>] Even that is a slight oversimplification,
  because the <tt>lua</tt> return hack only works on literals and
  identifiers, not complex expressions. When a complex expression is
  detected being returned, we compile it to a wrapping <tt>let</tt>
  expression and only pass in the bound local name to the <tt>return</tt>.</p>

include(footer.html)
