dnl -*- html -*-
define(__timestamp, 2016-08-29T19:56:54Z)dnl
define(__title, `in which a surprising affinity is pondered')dnl
define(__id, 181)dnl
include(header.html)
<p>When I got started with Lua, everything about it seemed to be the
  opposite of what I would like in a language, especially coming
  from Racket, Clojure, OCaml, and Erlang. It's unabashedly
  imperative, has nils everywhere, and lacks a macro system or any
  kind of static analysis. But now after spending over a year with
  it, I've developed a fondness for it, and the reasons are not what
  I would have expected.</p>

<p>The most obvious strength of Lua is its relentless
  simplicity. The small number of concepts you have to keep in your
  head when writing Lua can really help you focus, and it picks just
  the right concepts to build on[<a href="#fn1">1</a>]. For
  instance, the module system is largely just constructed out of
  tables and closures. What more do you need? It brings to mind the
  simplicity of Scheme and its "perfection is achieved when there is
  nothing left to remove" philosophy, but I believe Scheme's
  insistence on lists as the fundamental data type actually does a
  great disservice&mdash;fitting sequential data into an associative
  data type is much more natural than going the other way around[<a href="#fn2">2</a>].</p>

<p>There are two advanced features which can be confusing:
  metatables and coroutines. But when used judiciously, these can
  allow you to overcome the limitations of normal tables and
  functions in ways that feel seamless, like the
  way <a href="http://leafo.net/posts/itchio-and-coroutines.html">itch.io
  uses coroutines to hide the fact that many of its functions use
  asynchronous I/O</a> and avoids structuring everything around
  callback soup.</p>

<h4>Embeddability</h4>
<p>But what you most often hear touted as Lua's appeal is actually
  in its ease of embedding. Now obviously when people talk about
  this they are usually referring to how seamless it is to add the
  Lua runtime to a large C program and expose its functionality to
  code that can be written by the end user. And this is huge;
  empowering users to control your programs by doing their own
  coding pays major dividends, and here again Lua's simplicity means
  more users are likely to be able to take advantage of it. But even
  though I don't write large C programs, I found that the ability to
  embed Lua execution <b>inside a Lua program</b> is very
  valuable.</p>

<p>This advantage is not at all intuitive if you haven't seen it, but one
  distinguishing factor of Lua is that it allows sandboxed execution
  contexts to be constructed trivially:</p>

<pre class="code"><span class="keyword"><span class="region">local</span></span><span class="region"> </span><span class="variable-name"><span class="region">chunk</span></span><span class="region"></span></span><span class="region"> = </span><span class="builtin"><span class="region">assert</span></span><span class="region">(</span><span class="builtin"><span class="region">loadstring</span></span><span class="region">(user_code))
</span><span class="builtin"><span class="region">setfenv</span></span><span class="region">(chunk, {api = </span><span class="builtin"><span class="region">require</span></span><span class="region">(</span><span class="string"><span class="region">"my.api"</span></span><span class="region">)})
</span><span class="keyword"><span class="region">return</span></span><span class="region"> chunk()</span></pre>

<p>In these three lines the code loaded from the <tt>user_code</tt>
  string will run with no access to any functions outside
  the <tt>api</tt> table you provide. (In practice you would also
  include a whitelist of pure functions for tables, strings, math,
  etc.) But that's all it takes to allow user code to run inside
  your own limited sandbox.</p>

<h4>Environments as Interfaces</h4>
<p>Now Lua lacks any notion of first-class interfaces. The idea of
  passing a table in which must conform to a certain specified shape
  of fields and functions is fully ad-hoc and must be communicated
  entirely through documentation. And unfortunately it's somewhat
  unusual for Lua programmers to specify which functions in a module
  are for public consumption vs which are internal implementation
  details. But first-class sandboxes as extension points actually
  address many of the same problems as interfaces! Instead of saying
  "you must provide an implementation of this interface that has
  these fields and these functions" you can say "Provide your own
  code here; you will have access to call only this limited subset
  of functions which we've designated as a public API. The
  implementation details aren't even visible to you."</p>

<p>Now this can break down badly when the sandbox doesn't
  expose enough functionality to get the job done. This is why it's
  important not to tack on "scriptability" as a checkbox you fulfill
  at the end, but to embrace
  <a href="http://martinfowler.com/bliki/InternalReprogrammability.html">internal
  reprogrammability</a> from the very start. If you use the same
  methods to build the program in the first place as the end users
  use to customize it, you force yourself to be honest and to give
  the end users everything they need.</p>

<a href="https://www.flickr.com/photos/technomancy/28716234871/"><img src="/i/9and9.jpg" alt="9 and 9 coffee" /></a>

<p>So from this perspective, we can agree that yes, Lua's imperative
  nature and sloppy semantics (especially around nils) put it at a
  disadvantage for large codebases vs languages that have the
  advantage of immutability and/or intelligent type systems. But the
  fact that it offers <tt>setfenv</tt> makes it uniquely suited
  for <b>constructing larger codebases out of small
  codebases</b>. This is the approach I take in my game
  <a href="https://gitlab.com/technomancy/bussard">Bussard</a>, where
  I have four separate execution contexts, none of which have much
  more than 3,000 lines of code in them. Each small codebase is
  perfectly manageable on its own, and the interfaces between them
  are concise and clearly-defined despite Lua lacking first-class
  features for defining interfaces as we normally think of them.</p>

<hr>

<p>[<a name="fn1">1</a>] I have found that this simplicity also
  makes it a great choice for <a href="/179">teaching
  programming</a>, especially to younger kids who haven't reached
  the developmental stages where they can appreciate the more
  abstract, mathematical
  approach <a href="http://htdp.org">espoused by Racket</a>.</p>

<p>[<a name="fn2">2</a>] I know this method has a bad reputation
  because JavaScript and PHP do it very badly, but Lua shows it can
  be done well. There is a bit of awkwardness around ambiguity
  between array-like tables and key/value tables, but it is not
  nearly as awkward as using alists.</p>
include(footer.html)
