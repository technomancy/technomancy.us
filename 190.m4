dnl -*- html -*-
define(__timestamp, 2019-05-07T19:52:41)dnl
define(__title, `in which another game is jammed')dnl
define(__id, 190) define(__last) dnl
include(header.html)

<p>All the <a href="https://technomancy.itch.io/bussard">games</a>
  <a href="https://technomancy.itch.io/liquid-runner">I've</a>
    <a href="https://technomancy.itch.io/goo-runner">created</a>
    <a href="https://technomancy.itch.io/exo-encounter-667">previously</a>
    have used the <a href="https://love2d.org">LÖVE</a> framework,
    which I heartily recommend and have really enjoyed using. It's
    extremely flexible but provides just the right level of
    abstraction to let you do any kind of 2D game. I have even
    created <a href="https://git.sr.ht/~technomancy/polywell">a text
    editor</a> in it. But for
    the <a href="https://itch.io/jam/lisp-game-jam-2019">2019 Lisp
    Game Jam</a> I teamed up again
    with <a href="https://emmabukacek.com">Emma Bukacek</a> (we first
    worked together
    on <a href="https://technomancy.itch.io/goo-runner">Goo Runner</a>
    for the previous jam) and wanted to try something
    new: <a href="https://tic.computer">TIC-80</a>.</p>

<p><img src="/i/tic80.gif" alt="tic-80 screenshot" /></p>

<p>TIC-80 is what's referred to as a "fantasy
  console"<sup><a href="#fn1">1</a></sup>; that is, a piece of
  software which embodies an imaginary computer which never actually
  existed. Hearkening back to the days of the Commodore 64, it has a
  16-color palette, a 64kb limit on the amount of code you can load
  into it, and 80kb of space for data (sprites, maps, sound, and
  music). While these limitations may sound severe, the idea is that
  they can be liberating because there is no pressure to create
  something polished; the medium demands a rough, raw style.</p>

<p>The really impressive thing about TIC-80 you notice right away is
  how it makes game development so accessible. It's one file to
  download (or not even download; it runs perfectly fine in a browser)
  and you're off to the races; the code editor, sprite editor, mapper,
  sound editor, and music tracker are all built-in. But the best part
  is that you can explore other people's games (with the <tt>SURF</tt>
  command), and once you've played them, hit ESC to open the editor
  and see how they did it. You can make changes to the code,
  sprites, etc and immediately see them reflected. This kind of
  explore-and-tinker approach encourages you to experiment and see for
  yourself what happens.</p>

<p>In fact, try it now! Go
  to <a href="https://technomancy.itch.io/this-is-my-mech">This is my
  Mech</a> and hit <tt>ESC</tt>, then go down to "close game" and
  press <tt>Z</tt> to close it. You're in the console now, so
  hit <tt>ESC</tt> again to go to the editor, and press the sprite
  editor button at the top left. Change some of the character sprites,
  then hit <tt>ESC</tt> to go back to the console and
  type <tt>RUN</tt> to see what it does! The impact of the accessibility and
  immediacy of the tool simply can't be overstated; it calls out to be
  hacked and fiddled and tweaked.</a>

<p>Having decided on the platform, Emma and I threw around a few game
  ideas but landed on making an adventure/comedy game based on the
  music video <a href="https://m.youtube.com/watch?v=EMgsAD3D948">I'll
  form the Head</a> by MC Frontalot, which is in turn a parody of the
  1980s
  cartoon <a href="https://en.m.wikipedia.org/wiki/Voltron">Voltron</a>,
  a mecha series about five different pilots who work together to form
  a giant robot that fights off the monster of the week. Instead of
  making the game about combat, I wanted a theme of cooperation, which
  led to a gameplay focused around dialog and conversation.</p>

<p><img src="/i/head.png" alt="I'll form the head music video" width="800" /></p>

<p>I focused more on the coding and the art, and Emma did most of the
  writing and all of the music. One big difference when coding on
  TIC-80 games vs LÖVE is that you can't pull in any 3rd-party
  libraries; you have the Lua/Fennel standard library,
  the <a href="https://github.com/nesbox/TIC-80/wiki#functions">TIC-80
  API</a>, and whatever you write yourself. In fact, TIC-80's code
  editor supports only a single file. I'm mostly OK with
  TIC-80's limitations, but that seemed like a bit much, especially
  when collaborating, so I split out several different files and
  edited them in Emacs, using a Makefile to concatenate them together
  and TIC-80's "watch" functionality to load it in upon changes. In
  retrospect, while having functionality organized into different files
  was nice, it wasn't worth the downside of having the line numbers
  be incorrect, so I wouldn't do that part again.</p>

<p>The file watch feature was pretty convenient, but it's worth noting
  that the changes were only applied when you started a new game. (Not
  necessarily restarting the whole TIC-80 program, just
  the <tt>RUN</tt> command.) There's no way to load in new code from a
  file without restarting the game. You <em>can</em> evaluate new code
  with the <tt>EVAL</tt> command in the console and
  then <tt>RESUME</tt> to see the effect it has on a running game, but
  that only applies to a single line of code typed into the console,
  which is pretty limiting compared to LÖVE's
  full <a href="/189">support for hot-loading any module from disk at
  any time</a> that I wrote about previously. This was the biggest
  disadvantage of developing in TIC-80 by a significant
  margin. Luckily our game didn't have much state, so constantly
  restarting it wasn't a big deal, but for other games it would
  be.<sup><a href="#fn2">2</a></sup></p>

<p><b>Update</b>: I was able
  to <a href="https://github.com/nesbox/TIC-80/pull/840">add the above
    feature</a> with a small amount of code, and it was merged
  promptly. It will be included in TIC-80 version 0.80.0. You must
  launch the game with the <tt>-code-watch</tt> flag and run
  the <tt>RESUME</tt> command to activate it. In order to take
  advantage of this you need to store game state in a global and
  ensure not to overwrite that global if it already has a value.</p>

<p>Another minor downside of collaborating on a TIC-80 game is that
  the cartridge is a single binary file. You can set it up so it loads
  the source from an external file, but the rest of the game (sprites,
  map, sound, and music) are all stored in one place. If you use git
  to track it, you will find that one person changing a sprite and
  another changing a music track will result in a conflict you can't
  resolve using git. Because of this, we would claim a "cartridge
  lock" in chat so that only one of us was working on non-code assets
  at a time, but it would be much nicer if changes to sprites could
  happen independently of changes to music without conflict.</p>

<p><img src="/i/mech.gif" alt="screenshot of the game" /></p>

<p>Since the game consisted of mostly dialog,
  the <a href="https://gitlab.com/emmabukacek/this-is-my-mech/blob/master/dialog.fnl">conversation
  system</a> was the central place to start. We used coroutines to
  allow a single conversation to be written in a linear, top-to-bottom
  way and react to player input but still run without blocking the
  main event loop. For instance, the function below moves the Adam
  character, says a line, and then asks the player a question which
  has two possible responses, and reacts differently depending on
  which response is chosen. In the second case, it
  sets <tt>convos.Adam</tt> so that the next time you talk to that
  character, a different conversation will begin:</p>
  
<pre class="code">(<span class="keyword">fn</span> <span class="variable-name">all.Adam2</span> []
  (move-to <span class="builtin">:Adam</span> 48 25)
  (say <span class="string">"Hey, sorry about that."</span>)
  (<span class="keyword">let</span> [answer (ask <span class="string">"What's up?"</span> [<span class="string">"What are you doing?"</span>
                                  <span class="string">"Where's the restroom?"</span>])]
    (<span class="keyword">if</span> (<span class="keyword">=</span> answer <span class="string">"Where's the restroom?"</span>)
        (say <span class="string">"You can pee in your pilot suit; isn't"</span>
             <span class="string">"technology amazing? Built-in"</span>
             <span class="string">"waste recyclers."</span>)
        (<span class="keyword">=</span> answer <span class="string">"What are you doing?"</span>)
        (<span class="keyword">do</span> (say <span class="string">"Well... I got a bit flustered and"</span>
                 <span class="string">"forgot my password, and now I'm"</span>
                 <span class="string">"locked out of the system!"</span>)
            (<span class="keyword">set</span> <span class="type">convos.Adam</span> <span class="type">all.Adam25</span>)
            (<span class="type">all.Adam25</span>)))))</pre>

<p>There was some syntactic redundancy with the questions which could
  have been tidied up with a macro. In older versions of Fennel, the
  macro system is tied to the module system, which is normally fine,
  but TIC-80's single-file restriction makes it so that style of
  macros were unavailable. Newer versions of Fennel don't have this
  restriction, but unfortunately the latest stable version of TIC-80
  hasn't been updated yet. Hopefully this lands soon! The new version
  of Fennel also includes pattern matching, which probably would have
  made a custom question macro unnecessary.</p>

<p>The vast majority of the code is dialog/conversation code; the rest
  is for walking around with collision detection, and flying around in
  the end-game sequence. This
  is <a href="https://gitlab.com/emmabukacek/this-is-my-mech/blob/master/launch.fnl">pretty
    standard animation fare</a> but was a lot of fun to write!</p>

<p><img src="/i/rhinos.gif" alt="rhinos animation" /></p>

<p>I mentioned TIC-80's size limit already; with such a dialog-heavy game
  we did run into that on the last day. We were close enough to the
  deadline with more we wanted to add that it caused a bit of a
  panic, but all we had to do was remove a bunch of commented code
  and we were able to squeeze what we needed in. Next time around I would use
  single-space indents just to save those few extra bytes.</p>

<p>All in all I think the downsides of TIC-80 were well worth it for a
  pixel-art style, short game. Being able to publish the game to an
  HTML file and easily publish it
  to <a href="https://itch.io">itch.io</a> (the site hosting the jam)
  was very convenient. It's especially helpful in a jam situation
  because you want to make it easy for as many people as possible to
  play your game so they can rate it; if it's difficult to install a
  lot of people won't do it. I've never done my own art for a game
  before, but having all the tools built-in convinced me to give it a
  try, and it turned out pretty good despite me not having any
  background in pixel art, or art of any kind.</p>

<p>Anyway, I'd encourage you to give the game a try. The
  game <a href="https://itch.io/jam/lisp-game-jam-2019/results">won
  first place</a> in the game jam, and you can finish it
  in around ten minutes in your browser. And if it looks like fun, why
  not make your own in TIC-80?</p>

<hr />

<p>[<a name="fn1">1</a>] The term "fantasy console" was coined
  by <a href="https://lexaloffle.com/pico-8.php">PICO-8</a>, a
  commercial product with limitations even more severe than
  TIC-80. I've done a few short demos with PICO-8 but I much prefer
  TIC-80, not just because it's free software, but because it supports
  Fennel, has a more comfortable code editor, and has a much more
  readable font. PICO-8 only supports a fixed-precision decimal fork
  of Lua. The only two advantages of PICO-8 are the larger community
  and the ability to set flags on sprites.</p>

<p>[<a name="fn2">2</a>] I'm considering looking into adding support
  in TIC-80 for reloading the code without wiping the existing
  state. The author has been very friendly and receptive to
  contributions in the past, but this change might be a bit too much
  for my meager C skills.</p>

include(footer.html)
 
