dnl -*- html -*-
define(__timestamp, 2018-05-03T03:08:16Z)dnl
define(__title, `in which a game jam is recounted')dnl
define(__id, 187) define(__last) dnl
include(header.html)
<p>This past weekend I just finished competing in
  the <a href="https://itch.io/jam/lisp-game-jam-2018/">Lisp Game Jam
  2018</a>. While I'd made
  a <a href="https://technomancy.itch.io/liquid-runner">game under
  game-jam-like constraints</a> I had never officially participated in
  one before, so this one was a perfect place to start. I wrote my game in
  the <a href="https://fennel-lang.org">Fennel</a> programming
  language using the <a href="https://love2d.org">LÖVE</a> game
  framework. The game is
  called <a href="https://technomancy.itch.io/exo-encounter-667">EXO_encounter
  667</a>; you play an unmanned probe exploring the exoplanet
  <a href ="https://en.wikipedia.org/wiki/Gliese_667_Cc">Gliese 667
  Cc</a> that uncovers remains of an ancient outpost.</p>

<p><strong>Update</strong>: I'm proud to say that EXO_encounter 667
  won <a href="https://itch.io/jam/lisp-game-jam-2018/results">first
    place</a> in the game jam!</p>

<img src="/i/exo1.png" alt="exo encounter title screen" class="right" />

<p>Overall I'm thrilled with how it turned out; at the end of the jam
  I ended up with a game I'm very proud of. This game jam is a
  little unusual in that it ran over the span of ten days; most jams
  limit you to closer to 3 days and end up being much more of a
  crunch. Ten days was enough time to make something fairly polished
  (though of course still short) without pulling a bunch of
  all-nighters.</p>

<h4>The Language</h4>

<p>Using Fennel allowed me to take advantage of a bunch of existing
  tools without starting from square one. I had used the LÖVE
  framework before, but only from Lua. As I <a href="/186">blogged
  about previously</a>, Fennel is a lisp language which compiles to
  Lua output and stays very close to Lua semantics, which means it's
  very easy to use tools and libraries from the Lua world. I can't
  speak to how it would hold up in a larger codebase (the game ended
  up being only 663 lines of code), but I felt that for this project
  using Fennel with LÖVE and a couple helper libraries put me on
  nearly the perfect level of abstraction. I ran into one minor
  problem with Fennel where the line numbering of the output wasn't
  quite right, but I was able to fix it quickly in-flight.</p>

<h4>Art and Music</h4>

<img src="/i/hard-vacuum.png" alt="hard vacuum screenshot" class="left">

<p>One of the limitations of the jam is that all game coding and level
  design must be done during the ten days of the jam, but if you have
  pre-made assets you can use them as long as they're
  freely-licensed. I found like I hit the jackpot when I stumbled
  across <a href="http://www.lostgarden.com/2005/03/game-post-mortem-hard-vacuum.html">Daniel
  Cook's Hard Vacuum tileset</a>. Created in 1993 for a Dune2-inspired
  strategy game, it was released under a Creative Commons license
  because the game was never finished. I was really impressed with the
  impeccable pixel art and the wide variety of terrain and buildings
  available in the set. Often when you are looking for freely-licensed
  art it's not that hard to find what you need if you look across
  various sets, but combining several sets leads to some pretty
  jarring inconsistencies in visual style. Here I found one set which
  had basically everything I
  needed.<sup><a href="#fn1">1</a></sup></p>

<p>I also found a couple pieces of music that I felt really fit the
  theme I was going for: ambient and thoughtful to put you in the mood
  of exploring on a distant planet that took hundreds of years to
  reach. My son helped me choose
  <a href="https://opengameart.org/content/galactic-temple">Galactic
  Temple</a> for the main theme, and for the endgame I used the
  slightly more
  upbeat <a href="https://opengameart.org/content/freelance">Bazaar
  Net</a> by Max Stack, who also composed music I used for
  the <a href="https://www.youtube.com/watch?v=r_gdeS3d6F8">trailer of
  another of my games</a>.</p>

<h4>Design</h4>

<p>I had sketched out a plan up-front which I <em>mostly</em> was able
  to stick to; the main thing I cut scope on was the level layout. The
  original plan had the map divided into three sections: one where you
  approach the base, one base where all the text is in Russian, and the
  other base where things are in English. Because the aliens
  abandoned the outpost in 1999, the signals they received from Earth were
  from 1976 when the space race was still in full swing, so they were
  preparing for first-contact with Russia as well as the US. This was
  supposed to be part of the mystery you uncovered, but in the end it
  was just too meandering, and the final product ended up a lot more
  focused with a single base containing six doors you had to figure
  out how to open.</p>

<img src="/i/exo-tiled.png" alt="terminal" class="right">

<p>I spent most of the jam on a business trip where I had the evenings
  alone in a hotel room, so I was able to get a lot done there. I
  wrote the entire story text
  from <a href="https://www.dnapizza.com/">DNA Pizza</a>, a 24-hour
  pizza shop owned by <a href="https://www.jwz.org/blog">JWZ</a> that
  features bizarre, surreal music
  videos.<sup><a href="#fn2">2</a></sup> For something written in 2
  hours I'm really happy with how the story turned out; it was
  inspired heavily by
  the <a href="http://marathon.bungie.org/story/">the mythos of
  Marathon series</a> as well as
  the <a href="https://en.wikipedia.org/wiki/The_Three-Body_Problem_(novel)">Three
    Body Problem</a> novel.</p>

<p>But when on Saturday I got home from my trip and still didn't have
  any puzzles ready, I started to get a little worried. Not only did I
  not have any puzzles, I also didn't really have any
  idea <em>how</em> I would make puzzles in the first place or what
  would be fun. I sat down with my kids
  in <a href="http://www.mapeditor.org">the Tiled map editor</a> and
  just worked thru a progression of the mechanics I had implemented so
  far, starting with using the probe's laser to trigger sensors which
  open doors, and working up thru reflecting the laser off one of your
  rovers, to a multiple reflection chain puzzle, and that worked
  better than I expected.</p>

<p>The next day eight hours before the competition closed I had half a
  map worth of puzzles and was running out of ideas. The reflection
  mechanic I had implemented was solid, but it wasn't enough to carry
  the game by itself. In about an hour I added in beam splitters as
  well as sensors which would only open the door as long as the laser
  remained on them. My son came up with the idea for the last puzzle
  involving <span class="spoiler">splitting the laser and then
  reflecting the laser back into the splitter to get three
  beams</span> which I felt worked really well.</p>

<p>In the end, I was able to finish the map within the last
  hour before the deadline, but just barely.</p>

<h4>What worked well, and what didn't</h4>

<p>The versatility and ease of use of Tiled impressed me greatly. Once I
  loaded up my tileset into it, I had a tool simple enough that I
  could put my kids in front of it and they could make genuinely
  helpful contributions to the map. Highly recommended! All the
  collision and layer data is part of the map, as well as all the
  non-player animations.</p>

<p>Each object in the Tiled map contains a set of properties I used
  for various purposes; for instance I set a "door" property on each
  laser sensor switch to indicate which door should open when it was
  triggered. Early on I found myself making a lot of mistakes where I'd
  forget to set a property, so I added
  a <a href="https://gitlab.com/technomancy/exo-encounter-667/tree/master/lint.fnl">linter</a>
  which would error out early if it detected that a certain type of
  object was missing a required property or if a sensor referred to a
  door that didn't exist. This saved me a lot of fruitless manual
  debugging, and I'd strongly suggest doing something like it if you
  use map object properties.</p>

<p>I tried to introduce each mechanic with a very simple puzzle before
  moving on to non-obvious tricks. (I really messed up the difficulty
  curve near the end; the second-to-last puzzle is a fair bit more
  difficult than the last one.) This can be really tricky to do
  depending on your mechanics; I had one player who didn't see the
  message that explained how to aim because he accidentally skipped
  ahead by opening a door too soon. After the jam I went back and
  fixed this by starting off with the laser aimed in the wrong
  direction, so it's impossible to open the door without first
  aiming.</p>

<p>Using LÖVE was an obvious win; I got so much functionality for free
  as well as compatibility across operating systems and access to
  third-party libraries like the Tiled renderer. I wasn't sure how it
  would work to use Fennel for this, but looking back on it I find it
  remarkable how seamless it felt. The language just got out of
  the way and let me focus on the task at hand; I barely noticed it.</p>

<p>In the last hour I got my wife to playtest the game, which yielded
  some interesting insights. (Why can the rovers move forward but not
  backward? I just didn't think of it.) I found that having my kids
  playtest continually as the game evolved meant that they didn't see
  certain flaws; things that were clear to them weren't obvious to
  first-time players. (Of course, as the author I expect to be blind
  to many flaws myself.) In particular, getting a precise aim of the
  laser was much too difficult because the turn speed was too fast. I
  added a "hold shift to turn slowly" feature early on, but it wasn't
  introduced in the tutorial and you had to read the help text to see
  it. In the future I'd make more of an effort to get playtesting
  feedback earlier on in the process.</p>

<p>Speaking of the tutorial, having a tutorial was very helpful in
  introducing the mechanics. The implementation of the tutorial had
  some interesting technical features, but I will save that for part 2
  of this post. Thanks for reading, and please enjoy playing
  <a href="https://technomancy.itch.io/exo-encounter-667">EXO_encounter 667</a>.</p>

<hr>

<div class="footnotes">

<p>[<a name="fn1">1</a>] I did need two other graphical assets: intro
  and endgame screens. For those I used Creative-Commons-licensed
  <a href="https://commons.wikimedia.org/wiki/File:Sky_around_Gliese_667C.jpg">photos</a>
  and <a href="https://commons.wikimedia.org/wiki/File:Gliese_667.jpg">renders</a>
  of Gliese 667 from
  the <a href="https://en.wikipedia.org/wiki/European_Southern_Observatory">European
  Southern Observatory</a>.</p>

<p>[<a name="fn2">2</a>] I have this tradition where every time I'm in
  San Francisco I try to go to JWZ's pizza place and
  read <a href="https://www.jwz.org/blog">JWZ's blog</a> and also use
  Emacs,
  which <a href="https://www.jwz.org/doc/emacs-timeline.html">JWZ had
    a hand in the development of</a> in the 90s.</p>
</div>
include(footer.html)
