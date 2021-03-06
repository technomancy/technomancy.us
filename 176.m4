dnl -*- html -*-
define(__timestamp, 2014-11-24T08:22:23Z)dnl
define(__title, `in which a shingle is hung out')dnl
define(__id, 176)dnl
include(header.html)
<img src="/i/atreus-production.jpg" alt="Atreus production" class="right" />

<p><a href="/173">Earlier this year</a> I designed and built a small
  ergonomic mechanical keyboard.  My original goal was just that of
  personal use; I wanted to take the joy of mechanical keyboards
  with me when I go work from coffee shops.
  I <a href="https://github.com/technomancy/atreus">put the design
  on Github</a> and documented my build process with photos, and
  once I finished my own keyboard I figured I'd be done with it.
  But a few of my friends were intrigued and asked me if I'd build
  them keyboards.  I had a lot of fun constructing my first one, so
  I agreed to build a few more to sell to friends.
</p>

<p>
  Once I got going, one thing led to another, and I started getting
  queries from friends-of-friends.  I put
  up <a href="http://atreus.technomancy.us">a web site
  with an order form</a>, and orders started trickling in.  Due to
  the hand-wiring approach used the construction of these boards
  took a good four hours of nights and weekends, so a backlog
  started piling up.  At this point I decided I could make myself
  less of a bottleneck by selling kits and allowing interested
  customers to do the assembly themselves.  This was a big help, and
  it seemed people really liked the hands-on approach.  There's
  nothing quite like the satisfaction of using hardware you've
  constructed yourself.
</p>

<img src="/i/atreus-wiring.jpg" alt="Atreus wiring" />

<p>The "proper" way to make a keyboard is to build it around a
  circuit board. But circuit board design is its own skill, and
  their production benefits greatly from volume discounts, so it
  really didn't make sense for my own personal project.  But once I
  started to get more orders it became clear that a circuit board
  would help a lot since the process of hand-wiring is rather
  intimidating if you've never done any soldering before. I broke
  out <a href="">KiCAD</a> and started laying out a circuit board to
  hold the switches, diodes, and microcontroller after reading
  through some documentation and tutorials.
</p>

<img src="/i/atreus-one-hand.png" alt="One side of Atreus PCB" align="left" />

<p>I carefully laid out one side of the circuit board according to
  the row spacing and staggering used in the laser-cut case files without too
  much trouble. Each switch was connected to the others in the row
  with one pin and to the others in the column with the other, and
  each row and column was brought back in to the middle with the
  microcontroller. Then I hit a snag&mdash;the two halves of the
  Atreus keyboard are rotated inward at a 10° angle, but when I went
  to rotate the design in KiCAD rather than rotating them as a unit,
  it simply applied the rotation to each component individually.</p>

<p>At that point I was starting to think I'd have to do all this
  trig by hand and enter the calculated coordinates one by one into
  KiCAD's edit boxes, which did not sound like fun. I asked on the
  Freenode channel and found to my delight that the new file format
  for KiCAD is based on s-expressions! It can all be easily
  manipulated programmatically. Since the data includes symbols with
  leading digits in their names, the Clojure reader couldn't handle
  it, but Racket didn't have a problem with it. So I put
  together <a href="https://github.com/technomancy/atreus/blob/master/atreus.rkt#L157">some
  Racket code</a> to run the trig necessary to calculate the switch
  and diode positions.
</p>

<img src="/i/atreus-pcb.jpg" alt="Atreus PCB" />

<p>Anyway, I just finished assembling my first circuit-board-based
  keyboard, and it works nicely. It's dramatically easier than the
  hand-wired variant, even such that my six-year-old son wants to
  build his own. I had to make one change to give clearance for the
  micro-USB connector, but I was able to apply this "revision" to my
  already-produced circuit boards with a hacksaw.</p>

<p>Up to this point I haven't publically promoted it much, but
  now that the circuit board is here I'm prepared to handle a
  greater volume of orders. So if you're interested in building your
  own mechanical travel keyboard or want to hack some hardware
  designed using Lisp, take a look
  at <a href="http://atreus.technomancy.us">http://atreus.technomancy.us</a>.</p>
include(footer.html)
