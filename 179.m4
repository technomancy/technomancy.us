dnl -*- html -*-
define(__timestamp, 2016-06-05T15:13:54Z)dnl
define(__title, `in which four cards make a gang')dnl
define(__id, 179)dnl
include(header.html)
<p>I really enjoy programming with my kids. For me helping them
  learn how computers work is more about training them in logical
  thinking, creativity, and problem solving than it is about
  teaching them to accomplish specific tasks with software. My goal
  isn't to help them land lucrative programming jobs when they get
  older, but to expand their horizons with skills they can use in
  any kind of profession.</p>

<p>Over the past couple years, we've gotten the chance to create a
  few different games in several different styles. My kids were
  recently gifted a deck
  of <a href="https://www.daysofwonder.com/gangoffour/en/">Gang of
  Four</a> cards and were playing it nearly every day. This made it
  easy for them to get on board with the idea of
  <a href="https://gitlab.com/technomancy/gang-of-four">turning it
  into a computer game</a> when I suggested it. Adapting a card game
  turns out to be a great way for beginners to learn about
  programming since you start with a very clear goal, and it is
  easily broken up into natural steps.</p>

  <p>I've tried to
  document here the topics that came up as we progressed through
  building one of these games, but I also think they learned a lot
  from just seeing how the program comes together bit by bit and by
  debugging when we ran into problems. While my kids can type and
  do often work independently, I've found that the best approach
  usually has me at the keyboard guiding through the steps in a kind
  of <a href="http://www.garlikov.com/Soc_Meth.html">socratic
  style</a> of questioning. There are certainly times when I'll
  cheat and simply cut off an avenue of thought that I feel will be
  unproductive or frustrating, but ideally I try to stick with
  asking questions and typing.</p>

<p>Right now our weapon of choice is the
  <a href="http://lua.org">Lua</a> programming language due to its
  relentless simplicity and the availability of the
  wonderful <a href="https://love2d.org">LÖVE</a> game
  framework. While we've done graphical games with LÖVE, this one
  makes more sense to start out as a plain Lua game that uses
  console input and output. The complete source code
  is <a href="https://gitlab.com/technomancy/gang-of-four">available
    on GitLab</a>.</p>

<pre class="code"><span class="function-name"><span class="region">make_deck</span></span><span class="region"> = </span><span class="keyword"><span class="region">function</span></span><span class="region">()
  </span><span class="keyword"><span class="region">local</span></span><span class="region"> </span><span class="variable-name"><span class="region">deck</span></span><span class="region"> = {}
  </span><span class="keyword"><span class="region">for</span></span><span class="region"> </span><span class="variable-name"><span class="region">i</span></span><span class="region">=1,10 </span><span class="keyword"><span class="region">do</span></span><span class="region">
    </span><span class="keyword"><span class="region">for</span></span><span class="region"> </span><span class="variable-name"><span class="region">_</span></span><span class="region">,</span><span class="variable-name"><span class="region">c</span></span><span class="region"> </span><span class="keyword"><span class="region">in</span></span><span class="region"> </span><span class="builtin"><span class="region">pairs</span></span><span class="region">({0.1, 0.2, 0.3}) </span><span class="keyword"><span class="region">do</span></span><span class="region">
      </span><span class="builtin"><span class="region">table</span></span><span class="region">.</span><span class="builtin"><span class="region">insert</span></span><span class="region">(deck, i + c) </span><span class="comment-delimiter"><span class="region">-- </span></span><span class="comment"><span class="region">two of each
</span></span><span class="region">      </span><span class="builtin"><span class="region">table</span></span><span class="region">.</span><span class="builtin"><span class="region">insert</span></span><span class="region">(deck, i + c)
    </span><span class="keyword"><span class="region">end</span></span><span class="region">
  </span><span class="keyword"><span class="region">end</span></span><span class="region">
  </span><span class="builtin"><span class="region">table</span></span><span class="region">.</span><span class="builtin"><span class="region">insert</span></span><span class="region">(deck, 1.4) </span><span class="comment-delimiter"><span class="region">-- </span></span><span class="comment"><span class="region">special 1+ card
</span></span><span class="region">  </span><span class="builtin"><span class="region">table</span></span><span class="region">.</span><span class="builtin"><span class="region">insert</span></span><span class="region">(deck, 11.1) </span><span class="comment-delimiter"><span class="region">-- </span></span><span class="comment"><span class="region">two phoenixes
</span></span><span class="region">  </span><span class="builtin"><span class="region">table</span></span><span class="region">.</span><span class="builtin"><span class="region">insert</span></span><span class="region">(deck, 11.2)
  </span><span class="builtin"><span class="region">table</span></span><span class="region">.</span><span class="builtin"><span class="region">insert</span></span><span class="region">(deck, 12.3) </span><span class="comment-delimiter"><span class="region">-- </span></span><span class="comment"><span class="region">dragon
</span></span><span class="region">  </span><span class="keyword"><span class="region">return</span></span><span class="region"> lume.shuffle(deck)
</span><span class="keyword"><span class="region">end</span></span><span class="region">
</span></pre>

<p>Constructing the deck leads to some good opening questions of how
  to represent cards and what hands should look like. After seeing
  it deal out the exact same hands a few times, it also offered an
  opportunity to talk about what it means for a process to be
  deterministic and why you need
  to <a href="https://www.youtube.com/watch?v=GtOt7EBNEwQ">seed your
  random number generator</a> to make the game fun.</p>

<p>Once you add a loop which prints your hand and asks you which
  cards you want to play, the game is playable (in a "hot-seat"
  multiplayer style) as long as you already know the rules. Of
  course you will want to add checks for legal plays, but the
  minimum required for a playable prototype is here. Working in
  small discrete steps like this really helps with kids because
  reaching each milestone feels like a big win.</p>

<p>After we added in functions to enforce the rules, we began to add
  computer players. Writing AI may seem like a really advanced
  topic, but for a card game like this it's pretty
  straightforward. Granted our computer players don't always make
  the most strategic decisions, but they get by pretty well with a
  basic strategy of always trying to get rid of their lowest-ranked
  cards. Here again we found a way to break it into smaller
  steps&mdash;first the computer players are added to the rounds but
  only know how to pass, then they learn to play during single-card
  rounds, then they learn doubles and triples, etc. Writing computer
  players also led to a discussion about re-usable functions; many
  of the things we needed we had just implemented to determine
  whether a given hand was legal.</p>

<img src="i/pong.jpg" alt="writing pong on the porch" />

<p>In Gang of Four, the most powerful hand is a "gang", a set of
  four or more which can always beat any non-gang hand. It's not
  unusual for a gang of four to appear, but a gang of five is pretty
  rare. We've only seen a gang of six once, and while it is
  theoretically possible to get a gang of seven (there is only one
  way to make a gang of seven since most numbers only have six
  cards) the odds are astronomically against it. Still, the
  possibility that a gang of seven could exist kept my kids'
  fascination.</p>

<p>But now that we have a functioning simulation of the game, we can
  run
  through <a href="https://gitlab.com/technomancy/gang-of-four/blob/master/howmany.lua">a
  simulation of dealing out hands over and over again and check for
  gangs</a>. We found that running a repeated dealing simulation
  could sometimes find a gang of seven after as little as 3,000
  games, but sometimes it would take up to 120,000. Not only does
  this give a good opportunity to talk about permutations,
  histograms, and simple optimizations[<a href="#fn1">1</a>], but it
  also serves as a great demonstration of using <em>code</em> to
  satisfy your own curiosity.</p>

<img src="i/gang-of-four.jpg" alt="gang of four cards" align="left" />

<p>The grand finale of this enterprise involved the realization that
  <a href="http://www.computercraft.info/wiki/Main_Page">the
  ComputerCraft mod for MineCraft</a> provides a way to run Lua code
  in-game which should be compatible with what we just wrote. While
  this wasn't quite seamless,[<a href="#fn2">2</a>] seeing our code
  that we'd so far only run in a regular terminal running on an
  in-game machine was quite a thrill.</p>

<p>We still have a few steps further open to us from
  here. Implementing multiplayer over a simple socket interface is
  not too difficult[<a href="#fn3">3</a>], but it forces you to
  revisit the assumptions you have so far about input and
  output. Another fun direction would be to add a GUI for the game
  using <a href="https://love2d.org/wiki/love.graphics">LÖVE's
  graphical capabilities</a>. Or implementing a user interface in
  a <a href="http://minetest.net">MineTest</a> Lua mod where the
  cards are individual items. The point is being able to just
  explore whatever direction the kids interest takes them.</p>

<hr/>

<p>[<a name="fn1">1</a>] The only possible gang of seven is a hand
  of seven ones, so you can quickly check for a gang of seven on a
  sorted hand by seeing if the seventh card is a 1. There are lots
  of other optimizations you can make, but they were excited to see
  significant speed boosts from replacing the naive check with this
  one. But there was also a complexity cost if we wanted to keep
  the old code around for compatibility with detecting gangs of 4,
  5, or 6.</p>

<p>[<a name="fn2">2</a>] If I were to do this over, I would
  use <a href="http://ocdoc.cil.li/">OpenComputers</a> instead since
  it's a lot better-documented and open source.</p>

<p>[<a name="fn3">3</a>] We actually already implemented
  multiplayer, but this post is getting long enough as it is.</p>

<!-- further topics:
     * implementing an existing design instead of designing while you code
     * tension between working code and clean code, learning by messiness -->
include(footer.html)
