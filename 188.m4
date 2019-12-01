dnl -*- html -*-
define(__timestamp, 2018-05-06T02:05:03Z)dnl
define(__title, `in which a game jam is recounted further')dnl
define(__id, 188) dnl
include(header.html)

<p>This is the second part continuing my <a href="/187">previous
    post</a> about creating the
  game <a href="https://technomancy.itch.io/exo-encounter-667">EXO_encounter
    667</a> using <a href="https://fennel-lang.org">the Fennel
    programming language</a> and the <a href="https://love2d">LÖVE</a>
  game framework for
  the <a href="https://itch.io/jam/lisp-game-jam-2018/">Lisp Game
    Jam 2018</a>; you'll probably want to read the first installment
  if you haven't already. I wrote about the game design and art, but
  in this post I'd like to dive into the more technical aspects of
  the game.</p>

<img src="/i/exo-term.png" alt="exo encounter terminal" class="right">

<p>The <a href="https://itch.io/jam/lisp-game-jam-2018/results">voting
    for the game jam</a> just closed, and EXO_encounter 667 came in
  ranked first! Three out of the top four winners are LÖVE
    games; <a href="https://verma.itch.io/gravity-fall">one other in
    Fennel</a> and <a href="https://tmw.itch.io/need-for-seeds">one
    in Urn</a>.</p>

<h4>Libraries</h4>

<p>I pulled in a couple libraries on top of LÖVE to help out in a few
  areas. First and foremost I would dread to do any work on the Lua
  runtime without <a href="https://github.com/rxi/lume">lume</a>, which
  I like to think of as Lua's "missing standard library". It brings
  handy things like <tt>filter</tt>, <tt>find</tt>, <tt>reduce</tt>,
  etc. It's mostly sequence-related functions, but there are a few
  other handy functions as well like <tt>split</tt>, a bizarre
  omission from the standard library, or <tt>hotswap</tt> which I'll
  get to below.</p>

<p>The <a href="https://github.com/kikito/bump.lua">bump.lua</a>
  library is used for collision detection, and as long as you only
  need to operate in terms of axis-aligned rectangles, it is very easy
  to use and gets the job done with no
  fuss.<sup><a href="#fn1">1</a></sup> But one of the nicest things
  about bump is that it's integrated
  into <a href="https://github.com/Karai17/Simple-Tiled-Implementation">Simple
  Tiled Implementation</a>, which handles maps exported
  from <a href="http://www.mapeditor.org">Tiled</a>. On its own the
  Tiled library just handles drawing them (including their animations
  and layering), but it can automatically integrate with bump if you
  set properties on a layer or object to flag it as <tt>collidable</tt>.</p>

<p>The documentation for the Tiled library unfortunately leaves quite a bit
  to be desired; it's one of those projects that just dumps a list of
  all functions with a line or two describing what each one does and
  considers that "the documentation". Fortunately the source is pretty
  readable, but figuring out how to handle opening and closing of
  doors was definitely the roughest spot when it came to 3rd-party
  libraries. The readme does describe how to implement a custom
  drawing routine for a layer, which allows us to draw a door
  differently based on whether it's closed or open. The problem is
  there's no easy way to do the same thing for the collision
  detection side of the story.</p>

<p>The Tiled library handles setting up the "world" table from bump by
  seeding it with all the <tt>collidable</tt> things from the map. The
  problem is it doesn't actually use the same tables from the map when
  adding them to the bump table; it wraps them in bump-specific tables
  stripping it down to just the fields relevant to collision
  detection. This is fine until have a door you need to open. Normally
  you'd do this by calling <tt>bump.remove</tt> with the door table to
  make the door no longer take part in collision detection, but bump
  doesn't know about the door table; it only knows about the wrapper
  table, which we no longer have access to.</p>

<p>I ended
  up <a href="https://gitlab.com/technomancy/exo-encounter-667/commit/a90ccb4e99c90378d086adb6f542310789e3d83c">hacking
  around this</a> by making the Tiled library save off all the wrapper
  tables it created, and introducing a new <tt>bump_wrap</tt> function
  on the map which would intercept methods on the bump world, accept a
  regular table and look up the wrapped table and use it instead in
  the method call. It got the job done quickly, but I couldn't help
  but feel there should be a better way. I've
  opened <a href="https://github.com/karai17/Simple-Tiled-Implementation/issues/180">an
  issue</a> with the Tiled library to see if maybe I missed an
  undocumented built-in way of doing this. But as far as the coding
  went, this was really the only hiccup I encountered with any of the
  libraries I used.</p>

<h4>Interactive Development</h4>

<p>As a lisp, of course Fennel ships with a REPL (aka interactive
  console, often mistakenly called an "interpreter") which allows you
  to enter code and see the results immediately. This is absolutely
  invaluable for rapid game development. There's a bit of a hiccup
  though; the REPL reads from standard in, and LÖVE doesn't ship with
  a method for reading from standard in without blocking. Since Lua
  doesn't have concurrency, this means reading repl input would block
  the whole game loop until enter was pressed! LÖVE saves the day here
  by allowing you to construct
  "<a href="http://love2d.org/wiki/love.thread">threads</a>" which are
  really just completely independent Lua virtual machines that can
  <a href="/183">communicate with each other over queues</a> but can't
  share any data directly. This turns out to be just fine for the
  repl; one thread
  can <a href="https://gitlab.com/technomancy/exo-encounter-667/blob/master/stdio.fnl">sit
  and block on standard in</a>, and when it gets input send it over a
  queue to the main thread which evaluates and sends the response
  back.</p>

<pre class="code">(<span class="keyword">defn</span> <span class="variable-name">start-repl</span> []
  (<span class="keyword">let</span> [code (<span class="type">love.filesystem.read</span> <span class="string">"<a href="https://gitlab.com/technomancy/exo-encounter-667/blob/master/stdio.fnl">stdio.fnl</a>"</span>)
        lua (<span class="type">love.filesystem.newFileData</span> (<span class="type">fennel.compileString</span> code) <span class="string">"io"</span>)
        thread (<span class="type">love.thread.newThread</span> lua)
        io-channel (<span class="type">love.thread.newChannel</span>)]
    <span class="comment-delimiter">;; </span><span class="comment">this thread will send "eval" events for us to consume:
</span>    (<span class="keyword">:</span> thread <span class="builtin">:start</span> <span class="string">"eval"</span> io-channel)
    (<span class="keyword">set</span> <span class="type">love.handlers.eval</span>
         (<span class="keyword">fn</span> [input]
           (<span class="keyword">let</span> [(ok val) (<span class="builtin">pcall</span> <span class="type">fennel.eval</span> input)]
             (<span class="keyword">:</span> io-channel <span class="builtin">:push</span> (<span class="keyword">if</span> ok (view val) val)))))))</pre>

<p>As I use Emacs, I've
  configured <a href="https://gitlab.com/technomancy/fennel-mode">fennel-mode</a>
  to add a key combo for reloading the module for the current
  buffer. This only works if the current file is in the root directory
  of the project; it won't work with subdirectories as the module name
  will be wrong, but it's pretty helpful. It also
  requires <tt>lume</tt> be defined as a global variable. (Normally I
  avoid using globals, but I make two exceptions; one
  for <tt>lume</tt> and another for <tt>pp</tt> as a pretty-print
  function.) I haven't included this in <tt>fennel-mode</tt> yet
  because of these gotchas; maybe if I can find a way to remove them
  it can be included as part of the mode itself in the future.</p>

<p>Simply run <kbd>C-u M-x run-lisp</kbd> to start your
  game, and use <kbd>love .</kbd> as your command. Once that's
  started, the code below will make <kbd>C-c C-k</kbd> reload the
  current module.</p>

<pre class="code">(eval-after-load 'fennel-mode
  '(define-key fennel-mode-map (kbd <span class="string">"C-c C-k"</span>)
     (<span class="keyword">defun</span> <span class="function-name">pnh-fennel-hotswap</span> ()
       (<span class="keyword">interactive</span>)
       (comint-send-string
        (inferior-lisp-proc)
        (format <span class="string">"(lume.hotswap \"%s\")\n"</span>
                (substring (file-name-nondirectory (buffer-file-name)) 0 -4)))))<span class="whitespace-line">)</span></pre>

<p><strong>Update</strong>: I added first-class support for reloads
  to <a href="https://gitlab.com/technomancy/fennel-mode">fennel-mode</a>,
  though you will still need the stdin hack described above when using
  it inside LÖVE. <!-- 
I <a href="/189">wrote more about reloading</a>.--></p>

<p>The other gotcha is that currently an error will crash your whole
  game. I really wanted to add an error handler which would allow you
  to resume play after reloading the module that crashed, but I didn't
  have time to add that. Hopefully I'll have that ready in time for
  the next jam!</p>

<h4>Tutorial</h4>

<p>From a usability perspective, one of the most helpful things was
  adding a tutorial to explain the basic controls and mechanics. The
  tutorial displays instructions onscreen until the point at which the
  player carries out those instructions, at which point it moves on to
  the next instructions. There are various ways you could go
  about doing this, but I chose to implement it
  using <a href="https://www.lua.org/pil/9.1.html">coroutines</a>,
  which are Lua's way of
  offering <a href="https://en.wikipedia.org/wiki/Cooperative_multitasking">cooperative
    multitasking</a>.</p>

<pre class="code">(<span class="keyword">defn</span> <span class="variable-name">tutorial</span> [state world map dt]
  (echo <span class="string">"Press 2 to select rover 2; bring it near the"</span>
        <span class="string">"main probe and press enter to dock."</span>)
  (<span class="keyword">while</span> (not (<span class="keyword">.</span> <span class="type">state.rovers</span> 2 <span class="builtin">:docked?</span>))
    (<span class="type">coroutine.yield</span>))

  (echo <span class="string">"With at least 3 rovers docked, the main"</span> <span class="string">"probe has mobility."</span>
        <span class="string">""</span> <span class="string">"Now do the same with rover 3."</span>)
  (<span class="keyword">while</span> (not (<span class="keyword">.</span> <span class="type">state.rovers</span> 3 <span class="builtin">:docked?</span>))
    (<span class="type">coroutine.yield</span>))

  (echo <span class="string">"The probe's communications laser can be"</span>
        <span class="string">"activated by holding space. Comma and"</span>
        <span class="string">"period change the aim of the laser."</span>)
  (<span class="keyword">while</span> (not (<span class="keyword">or</span> (<span class="keyword">and</span> <span class="type">state.laser</span> (<span class="keyword">~=</span> <span class="type">state.selected.theta</span> <span class="type">math.pi</span>))
                  (<span class="keyword">&gt;</span> (<span class="keyword">:</span> world <span class="builtin">:getRect</span> <span class="type">state.selected</span>) 730)
                  (sensor? map <span class="string">"first"</span>)))
    (<span class="type">coroutine.yield</span>))

  <span class="keyword">...</span>)</pre>

<p>The <tt>tutorial</tt> function runs inside a coroutine started
  with <tt>coroutine.wrap</tt>; it echoes the first message and then
  suspends itself with <tt>coroutine.yield</tt> which returns control
  to the caller. On every tick, the <tt>love.update</tt> function
  <tt>coroutine.resume</tt>s it which allows it to check whether the
  conditions have been fulfilled. If so it can move on to the next
  instruction; otherwise it just yields back immediately. Of course,
  it would be possible to do something like this using only closures,
  but coroutines allow it to be written in a very linear,
  straightforward way.</p>

<img src="/i/exo-laser.png" alt="exo encounter laser screenshot">

<h4>Distribution</h4>

<p>With LÖVE you get portability across many operating systems;
  however it does not actually handle creating the executables for
  each platform. I used an old version
  of <a href="https://github.com/MisterDA/love-release/">love-release</a><sup><a href="#fn2">2</a></sup>
  to create zip files which include everything you need to run on
  Windows and Mac OS. This was a huge help; I could run my entire
  build from my Debian laptop without even touching a Windows machine
  or a Mac.</p>

<p>For the jam I just published a <tt>.love</tt> file for other
  platforms, which requires you to manually install LÖVE
  yourself. This is a bit of a drag since most package managers don't
  include the correct version of LÖVE, and even if they did today, in
  the future they'd upgrade to a different one, so this is one place
  where relying on the package manager is definitely not going to cut
  it. Soon after the jam I
  discovered <a href="https://appimage.org/">AppImages</a> which are a
  way of bundling up all a program's dependencies into a single
  executable file which should work on any Linux distribution. While I
  think this is a really terrible idea for a lot of software, for a
  single-player game that doesn't load any data from untrusted
  sources, I believe it to be the best option. The love-release tool
  doesn't currently support creating AppImages, but I am hoping to add
  support for this. I also didn't get around to automating uploading
  of builds to itch.io
  using <a href="https://itch.io/docs/butler/">butler</a>, but I'm
  hoping to have that working for next time.</p>

<h4>Play my game!</h4>

<p>Now that the jam is over, I've gotten some great feedback from
  players that resulted
  in <a href="https://gitlab.com/technomancy/exo-encounter-667/blob/master/todo.md">a
  nice todo list</a> of items that can be improved. I hope to release
  a "special edition" in the near future that includes all the things
  I wasn't able to get to during the jam. But in the mean time, I hope you
  enjoy <a href="https://technomancy.itch.io/exo-encounter-667">EXO_encounter
    667</a>!</p>

<hr>
<div class="footnotes">

  <p>[<a name="fn1">1</a>] LÖVE ships with
    a <a href="https://love2d.org/wiki/love.physics">physics engine</a>
    built-in, but the API it uses is much more complicated. It's capable
    of more sophisticated behavior, but unless you <em>really</em> can't
    work in terms of rectangles, I'd recommend sticking with the much
    simpler bump.lua.</p>

  <p>[<a name="fn2">2</a>] The love-release project has since been
    rewritten in Lua instead of being a shell script as it was at the
    time I downloaded the version I used. I haven't tried the new
    version but it looks promising.</p>

</div>
include(footer.html)
