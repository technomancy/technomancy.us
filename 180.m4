dnl -*- html -*-
define(__timestamp, 2016-07-20T17:48:45Z)dnl
define(__title, `in which a spacefaring text editor holds up against an onslaught')dnl
define(__id, 180)dnl
include(header.html)
<p>I've been meaning to write about my latest
  project <a href="https://gitlab.com/technomancy/bussard">Bussard</a>
  for a while now. I describe it as a "spaceflight programming
  adventure", but it might be easier to think of it as "Emacs in
  space, but with a sci-fi novella in it", written in Lua with
  the <a href="https://love2d.org">LÖVE</a> engine. There's a lot to
  tell about the game and how I want it to eventually be a way for
  newcomers to learn programming, but I want to write here about a
  particular part of the development I had a lot of fun with.</p>

<video src="https://p.hagelb.org/bussard-1.3.webm" width="854" height="480"
       poster="/i/bussard-trailer.jpg" controls>
  <a href="https://www.youtube.com/watch?v=r_gdeS3d6F8">View on YouTube</a>
</video>

<p>The game is played by interacting with your ship's onboard
  computer. Naturally because I wanted to give the player the
  freedom to customize the interface as much as possible, I've
  modeled it on Emacs. The game starts with your ship in orbit
  around a star and hoping to intercept an orbiting space station,
  but once you poke around a bit you realize that "flight mode" is
  only one of many modes you can activate in your onboard
  computer.</p>

<p>Pressing <kbd>ctrl-o</kbd> allows you to open any file in the
  in-game computer, and pressing <kbd>ctrl-enter</kbd> opens a Lua
  repl buffer that uses the same editor infrastructure but lets
  you write code interactively and explore your ship's computer's
  API. Communicating with space station and planet port computers is
  done over an SSH client that also lives inside the editor. But all
  the various modes of the editor are configured
  with <a href="https://gitlab.com/technomancy/bussard/blob/master/data/src/config">Lua
  code</a> that runs in user-space; basically that code defines
  keyboard controls which simply invoke functions of your ship's
  computer to edit text[<a href="#fn1">1</a>], open SSH connections, engage the ship's
  engine, etc. Every action you can take is just a Lua function
  call.</p>

<pre class="code"><span class="comment-delimiter"><span class="region">-- </span></span><span class="comment"><span class="region">bind is for commands that only call their functions once even when held.
</span></span><span class="comment-delimiter"><span class="region">-- </span></span><span class="comment"><span class="region">it takes the name of a mode, a key combo, and a function to run when pressed.
</span></span><span class="region">bind(</span><span class="string"><span class="region">"flight"</span></span><span class="region">, </span><span class="string"><span class="region">"escape"</span></span><span class="region">, ship.ui.pause)

</span><span class="comment-delimiter"><span class="region">-- </span></span><span class="comment"><span class="region">you can bind keys to existing functions or inline functions.
</span></span><span class="region">bind(</span><span class="string"><span class="region">"flight"</span></span><span class="region">, </span><span class="string"><span class="region">"ctrl-return"</span></span><span class="region">, </span><span class="keyword"><span class="region">function</span></span><span class="region">()
        ship.editor.change_buffer(</span><span class="string"><span class="region">"*console*"</span></span><span class="region">)
</span><span class="keyword"><span class="region">end</span></span><span class="region">)

</span><span class="comment-delimiter"><span class="region">-- </span></span><span class="comment"><span class="region">the mouse wheel is handled just like any other key press.
</span></span><span class="region">bind(</span><span class="string"><span class="region">"flight"</span></span><span class="region">, </span><span class="string"><span class="region">"wheelup"</span></span><span class="region">, zoom_in)
bind(</span><span class="string"><span class="region">"flight"</span></span><span class="region">, </span><span class="string"><span class="region">"wheeldown"</span></span><span class="region">, zoom_out)

</span><span class="comment-delimiter"><span class="region">-- </span></span><span class="comment"><span class="region">regular tab selects next target in order of distance from the star.
</span></span><span class="region">bind(</span><span class="string"><span class="region">"flight"</span></span><span class="region">, </span><span class="string"><span class="region">"tab"</span></span><span class="region">, ship.actions.next_target)</span></pre>

<p>This is a fantastically flexible model for rich
  interaction&mdash;it can be completely rewritten on the fly, and
  it's seamless to experiment with new ideas you think might support
  a better way of doing things. No recompiling, no restarting, just
  flow. But another benefit of the editor API is that you can call
  it against in an automated context, such
  as <a href="https://gitlab.com/technomancy/bussard/blob/master/tests/fuzz.lua">a
    headless run</a>[<a href="#fn2">2</a>] that
  does <a href="https://en.wikipedia.org/wiki/Fuzz_testing">fuzz
  tests</a>.</p>

<p>I had to make a few changes to the API for this to work nicely,
  but in the end I realized they made the system a lot more consistent
  anyway. The fuzz testing uncovered a nice set of nasty edge-case
  editor bugs that were not too difficult to fix, but would have
  taken a lot of time to uncover with manual testing.</p>

<pre class="code" style="font-size: 85%"><span class="keyword"><span class="region">local</span></span><span class="region"> </span><span class="keyword"><span class="region">function</span></span><span class="region"> </span><span class="function-name"><span class="region">fuzz</span></span><span class="region">(n)
   </span><span class="comment-delimiter"><span class="region">-- </span></span><span class="comment"><span class="region">need to display the seed so we can replay problematic sequences
</span></span><span class="region">   </span><span class="keyword"><span class="region">local</span></span><span class="region"> </span><span class="variable-name"><span class="region">seed</span></span><span class="region"> = </span><span class="builtin"><span class="region">tonumber</span></span><span class="region">(</span><span class="builtin"><span class="region">os</span></span><span class="region">.</span><span class="builtin"><span class="region">getenv</span></span><span class="region">(</span><span class="string"><span class="region">"BUSSARD_FUZZ_SEED"</span></span><span class="region">) </span><span class="keyword"><span class="region">or</span></span><span class="region"> </span><span class="builtin"><span class="region">os</span></span><span class="region">.</span><span class="builtin"><span class="region">time</span></span><span class="region">())
   </span><span class="builtin"><span class="region">print</span></span><span class="region">(</span><span class="string"><span class="region">"seeding with"</span></span><span class="region">, seed)
   </span><span class="builtin"><span class="region">math</span></span><span class="region">.</span><span class="builtin"><span class="region">randomseed</span></span><span class="region">(seed)

   </span><span class="keyword"><span class="region">for</span></span><span class="region"> </span><span class="variable-name"><span class="region">i</span></span><span class="region">=1,n </span><span class="keyword"><span class="region">do</span></span><span class="region">
      </span><span class="keyword"><span class="region">local</span></span><span class="region"> </span><span class="variable-name"><span class="region">mode</span></span><span class="region"> = editor.mode()
      </span><span class="comment-delimiter"><span class="region">-- </span></span><span class="comment"><span class="region">smush together all the different sub-maps (ctrl, alt, ctrl-alt)
</span></span><span class="region">      </span><span class="keyword"><span class="region">local</span></span><span class="region"> </span><span class="variable-name"><span class="region">commands</span></span><span class="region"> = lume.concat(vals(mode.map), vals(mode.ctrl),
                                   vals(mode.alt), vals(mode[</span><span class="string"><span class="region">"ctrl-alt"</span></span><span class="region">]))
      </span><span class="keyword"><span class="region">local</span></span><span class="region"> </span><span class="variable-name"><span class="region">command</span></span><span class="region"> = lume.randomchoice(commands)

      </span><span class="builtin"><span class="region">print</span></span><span class="region">(</span><span class="string"><span class="region">"run "</span></span><span class="region"> .. binding_for(mode, command) .. </span><span class="string"><span class="region">" in mode "</span></span><span class="region"> .. mode.name)
      try(lume.fn(editor.wrap, command))

      </span><span class="comment-delimiter"><span class="region">-- </span></span><span class="comment"><span class="region">sometimes we should try inserting some text too
</span></span><span class="region">      </span><span class="keyword"><span class="region">if</span></span><span class="region">(love.math.random(5) == 1) </span><span class="keyword"><span class="region">then</span></span><span class="region">
         try(lume.fn(editor.handle_textinput, random_text()))
      </span><span class="keyword"><span class="region">end</span></span><span class="region">
   </span><span class="keyword"><span class="region">end</span></span><span class="region">
</span><span class="keyword"><span class="region">end</span></span><span class="region"></span></pre>

<p>Of course, this is pretty limited in the kinds of bugs it can
  catch&mdash;only problems that result in crashes or hangs can be
  identified by the fuzz tests. But it gives me confidence when I
  make further changes if I can throw 32768 cycles of random
  commands at it without seeing it break a sweat. And it's even
  better
  when <a href="https://gitlab.com/technomancy/bussard/pipelines">every
  incoming patch automatically has the testing applied against
  it</a> using GitLab's CI.</p>

<p>Stay tuned for
  a <a href="https://gitlab.com/technomancy/bussard/blob/master/Changelog.md#beta-2-">second
  beta of Bussard</a> to be released very soon! There is still a lot
  more I want to do with the story line and missions, but the engine
  is getting more and more polished with each milestone. Feedback is
  very welcome, as
  are <a href="https://gitlab.com/technomancy/bussard/blob/master/Contributing.md">contributions</a>.</p>

<p><b>Update</b>: I found that the fuzzer above has a critical flaw:
  it does not inspect the current mode's parent mode to look for
  commands there. (For instance, the console's parent mode is edit,
  and the ssh mode's parent is the console.) Fixing this immediately
  uncovered four new bugs.</p>

<hr/>

<p>[<a name="fn1">1</a>] Yes, I know I just set myself up for the
  old "Bussard is a great OS, it just lacks a decent text editor"
  joke. Honestly I am just waiting for someone to come along and
  implement a vim mode in-game; if any player thinks they can do
  better than the built-in editor they are welcome to try!</p>

<p>[<a name="fn2">2</a>] It's a bit tricky to get LÖVE to run
  headless, but it can be done. Mostly it
  involves <a href="https://gitlab.com/technomancy/bussard/blob/master/conf.lua#L18">disabling <tt>love.graphics</tt>
  and <tt>love.window</tt> modules in <tt>conf.lua</tt></a> and
  being careful with the order of loading. You also have to
  make sure that no calls to <tt>love.graphics</tt> functions happen
  outside your <tt>love.draw</tt> function.</p>
include(footer.html)
