dnl -*- html -*-
define(__timestamp, 2018-05-10T02:11:41)dnl
define(__title, `in which interactive development saves the day')dnl
define(__id, 189) define(__last) dnl
include(header.html)

<p>When I was
  writing <a href="https://technomancy.itch.io/exo-encounter-667">EXO_encounter
    667</a> in <a href="https://fennel-lang.org">Fennel</a>, I
  benefited immensely from the ability to do live reloads. Instead of
  having to restart the whole process, I could run a single key
  command from my editor and have the game see the new code
  immediately. This isn't particularly difficult to do in Fennel, but
  it's not immediately obvious at a glance either.</p>

<p>Before you understand how reloading works in Fennel, you need a
  little background regarding Lua's module system, since Fennel is
  just a compiler that emits Lua code. Older versions of Lua had
  a <tt>module</tt> function which would declare the whole rest of the
  file as being part of a specific module and register that with the
  module system, and all functions that would normally be declared as
  global within that file would be exported as part of the module instead.
  But in version 5.1, that system was recognized as redundant:
  nowadays a module is just a file that returns a
  table<sup><a href="#fn1">1</a></sup> with closures and other values
  in it. This is reflects the relentless simplicity behind the design
  of Lua; why have modules as their own concept when tables and
  closures can do just as good a job?</p>

<p>So that's all well and good; you can just write code that uses
  functions written in other files by just calling <tt>dofile</tt> on
  the filename and putting that value in a local. And that works, but
  every time you use the module from another place it loads a fresh
  copy, which is wasteful. Enter the <tt>require</tt> function. It
  takes a module name which maps to a filename (by searching the
  entries of <tt>package.path</tt>) and gives you the value returned
  by that file, but it also caches subsequent calls. So every time
  you <tt>require</tt> a module, you're getting the exact same
  table<sup><a href="#fn2">2</a></sup> in the exact same memory
  location.</p>

<img src="/i/mtsth.jpg" alt="Valley near Mt. Saint Helens">

<p>We can take a little detour here from Lua land and back into
  Fennel, because <tt>dofile</tt> only works on Lua code. Fennel
  provides its own <tt>fennel.dofile</tt> function which works just
  like the built-in one, but on <tt>.fnl</tt> files instead. But what
  about <tt>require</tt>? Well it turns out <tt>require</tt> is
  implemented in a pretty clever way that allows us to teach it new
  tricks. The way <tt>require</tt> works is that it looks at
  the <tt>package.searchers</tt> table, (it's <tt>package.loaders</tt> on
  Lua 5.1) which contains a list of searcher functions. It iterates over
  the list, calling each searcher with the module name. If that
  returns nil, it indicates that searcher can't find the module and it
  moves on, but a searcher which can load the module will return a
  function which allows <tt>require</tt> to get (and cache) the value
  for the module in question. So simply by
  adding <tt>fennel.searcher</tt> to <tt>package.searchers</tt>, we
  can make it so that <tt>require</tt> works seamlessly on modules
  whether they are written in Fennel or Lua:</p>

<pre class="code">(<span class="keyword">local</span> fennel (<span class="builtin">require</span> <span class="string">"fennel"</span>))
(<span class="type">table.insert</span> <span class="type">package.searchers</span> <span class="type">fennel.searcher</span>)</pre>

<p>Now this seems somewhat academic; after all, you have a lot of
  memory; why do you care if modules are duplicated in memory? But
  using <tt>require</tt> for modules proved invaluable during the
  development of my game because it allowed me to do all my local
  hacking using <tt>.fnl</tt> files I was constantly editing, but
  when I prepared a release, I precompiled it all into <tt>.lua</tt>
  files and didn't have to change a line of my code to reflect
  that.</p>

<p>Well that's wonderful, but if <tt>require</tt> caches the value of
  each module, doesn't that interfere with live reloading? Indeed it
  does; simply re-requiring a module has no effect. You can
  call <tt>fennel.dofile</tt> to get a <strong>copy</strong> of the updated
  module. But that's no help to the existing code which has the old
  version of the module. What to do?</p>

<p>To understand the solution it's helpful to make a distinction
  between the <strong>identity</strong> of the table and
  the <strong>values</strong> it contains. The identity of a table is
  what makes it truly unique; it can be thought of in terms of that
  table's particular location in memory. When you pass a table to a
  function, that function has access to the exact same table, and
  changes made to it inside the function of course are visible to any
  other function that has access to the
  table<sup><a href="#fn3">3</a></sup>. The value of a table refers to
  what it contains; in the case of a module it's usually about what
  functions are present under what keys. Since the tables are mutable,
  the value can change over time but the identity cannot. When you
  call <tt>dofile</tt> on a module you get a table that might have the
  same <strong>values</strong> as last time you
  called <tt>dofile</tt>, (if the file on disk hasn't changed)
  but it will never have the same <strong>identity</strong>. When you
  call <tt>require</tt> you're guaranteed to get the exact
  same <strong>identical</strong> table every
  time.<sup><a href="#fn4">4</a></sup></p>

<p>With that background maybe you can see now how this might work. All
  the existing code has access to the original module table. We can't
  swap out that table for a new one without reloading all the
  modules that use it, and that can be disruptive. But we can grab
  that original table, load a fresh <strong>copy</strong> of its module from
  disk, then go in and replace its <strong>contents</strong> with the
  values from the new one.</p>

<pre class="code">(<span class="keyword">defun</span> <span class="function-name">fennel-reload-form</span> (module-keyword)
  <span class="doc">"Return a string of the code to reload the `</span><span class="doc"><span class="constant">module-keyword</span></span><span class="doc">' module."</span>
  (format <span class="string">"%s\n"</span> `(<span class="keyword">let</span> [old (<span class="keyword">require</span> ,module-keyword)
                            _ (tset package.loaded ,module-keyword nil)
                            new (<span class="keyword">require</span> ,module-keyword)]
                    <span class="comment-delimiter">;; </span><span class="comment">if the module isn't a table then we can't make
</span>                    <span class="comment-delimiter">;; </span><span class="comment">changes which affect already-loaded code, but if
</span>                    <span class="comment-delimiter">;; </span><span class="comment">it is then we should splice new values into the
</span>                    <span class="comment-delimiter">;; </span><span class="comment">existing table and remove values that are gone.
</span>                    (<span class="keyword">when</span> (= (type new) <span class="builtin">:table</span>)
                      (each [k v (pairs new)]
                            (tset old k v))
                      (each [k (pairs old)]
                            <span class="comment-delimiter">;; </span><span class="comment">the elisp reader is picky about where . can be
</span>                            (<span class="keyword">when</span> (not (,<span class="string">"."</span> new k))
                              (tset old k nil)))
                      (tset package.loaded ,module-keyword old)))))</pre>

<p>The code above looks like Fennel, but it's actually Fennel embedded
  inside Emacs Lisp code; because they're both just made up of
  s-expressions, you can write Fennel code as Elisp code and quote it,
  then send it to the Fennel repl subprocess which is launched
  with <kbd>M-x
    run-lisp</kbd>. My <a href="https://gitlab.com/technomancy/fennel-mode/commit/21e184b2a862290db9dcf839f0e4a2df480a642e">recent
    changes</a> to <tt>fennel-mode.el</tt> allow this to work out of
  the box, but they could easily be adapted to any other editor that
  supports communicating with an integrated repl subprocess.</p>

<p>Of course, all this background really isn't necessary; you can just
  hit reload now and have it work with no fuss. But sometimes it's
  interesting to understand why it works, and especially I think in
  this case the design decisions that went into the module system are
  noteworthy for allowing this kind of thing to be done in a graceful
  way, so that's worth appreciating and hopefully learning from.</p>

<p><strong>Update</strong>: Charl Botha wrote up a great
  <a href="https://vxlabs.com/2018/05/18/interactive-programming-with-fennel-lua-lisp-emacs-and-lisp-game-jam-winner-exo_encounter-667">blog
  post</a> that goes into more detail about setting up the live reload
  functionality with Emacs.
</p>

<hr>
<div class="footnotes">

  <p>[<a name="fn1">1</a>] Technically a module can return any value,
    not just a table. But if you return a non-table, then the
    reloading features described don't work, because only tables can
    have their contents replaced while retaining their same object
    identity.</p>

  <p>[<a name="fn2">2</a>] Yep; this means you can abuse the module
    system to do terrible things like share application state across
    other modules. Please resist the temptation.</p>

  <p>[<a name="fn3">3</a>] Oddly enough in some languages this is not
    true and data structures default to being copied implicitly every
    time you pass them to a function, which can be very
    confusing. To muddle things even more, this behavior is referred
    to as "pass by value" instead of "we make copies of everything for
    you even when you don't ask". That doesn't happen here.</p>

  <p>[<a name="fn4">4</a>] For a fascinating discussion of the
    difference between value and identity and how it relates to
    equality I strongly recommend reading the very
    insightful <a href="http://home.pipeline.com/~hbaker1/ObjectIdentity.html">Equal
    Rights for Functional Objects</a> which goes into much more depth
    on this subject. Notably Lua's (and Fennel's) equality semantics
    are consistent with its recommendations despite Lua being an
    imperative language.</p>
</div>
include(footer.html)
