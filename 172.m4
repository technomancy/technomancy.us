<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, 2013-12-21T13:35:45Z)dnl
define(__title, `in which a collection of keys are gathered and put to good use')dnl
define(__id, 172)dnl
include(header.html)
<p>Choosing computer hardware is really all about trade-offs. For
  the kind of work I do these days once a machine has an SSD in it
  nearly anything will get me the performance I need. So I start to
  look towards creature comforts&mdash;the keyboard and screen are
  the gateways from the physical world into the machine, and for the
  amount of time I spend with them, it makes sense to get the best
  that money can buy. This rules out glossy screens and the
  low-resolution laptop displays that have become ubiquitous in
  recent years, so my options have been limited.</p>

<p>Last year I <a href="/160">took a chance on a new laptop</a>:
  the Samsung Series 9 wooed me with its bright, relatively
  high-resolution matte screen, and I took a chance on it even knowing
  that its keyboard was a step backwards. This turned out to
  be a mistake for me&mdash;the trend of thinness over all else
  forced its designers into some unfortunate compromises around the
  keyboard. There just isn't enough room on an ultrabook for keys
  that have a comfortable travel, to speak nothing of the
  response. So I went back to my 2009-era Thinkpad with its adequate
  screen and decent keyboard, since newer Thinkpads sported brighter
  screens but significantly fewer pixels.</p>

<img src="/i/buckling-spring.png" alt="buckling spring" class="right" />

<p>It wasn't always this difficult to find nice
  keyboards. Relentless cost-cutting has pushed manufacturers
  towards keyboards built mostly out of rubber underneath the caps
  and forced quality key switches to a niche populated mostly by
  gamers and obsessive programmers like me. But if you're
  willing to do some digging, you can find some fantastic
  options. The standard bearer here for a long time has been the
  venerable <a href="https://en.wikipedia.org/wiki/Model_M_keyboard">IBM
  Model M</a> with its buckling spring mechanism. Though IBM hasn't
  sold them since the mid-90s, many extant keyboards from that time
  are still in daily use. They offer a solid, tactile response
  that evokes a passionate fondness in their users.</p>

<p>I'd heard the breathless enthusiasm with which the fans spoke
  of their gear, but I'd delayed taking the plunge myself because
  I've never been comfortable on the standard form factor shared by
  nearly all mechanical keyboards. After being hit by RSI in
  college, I went from the ergonomic-but-cheap Microsoft Natural
  keyboard to the
  good-for-a-rubber-dome <a href="http://www.kinesis-ergo.com/freestyle2.htm/">Kinesis
  Freestyle</a>[<a href="#fn1">1</a>], which had a lousy key response but was the best I
  could find for under US$100. For a long time the only mechanical
  split keyboard I could find was the
  legendary <a href="http://www.kinesis-ergo.com/advantage.htm">Kinesis
  Advantage</a>, which apart from its US$300 price tag kept me at
  bay due to its massive size&mdash;I work from <a href="/156">local
  coffee shops</a> frequently, and the Advantage is just too clunky
  to toss in a bag and tote around.</p>

<p>But over the summer someone on the <tt>#emacs</tt> freenode
  channel brought my attention to the
  mysterious <a href="http://ergodox.org">Ergodox</a> project.</p>

<img src="/i/ergodox-1.png" alt="ergodox" />

<p>The Ergodox is a project to create a freely-licensed ergonomic
  mechanical keyboard design that can be built by anyone. The site,
  while very sparse on details of what's really going on, contains
  links to <a href="http://ergodox.org/Hardware.aspx">everything you
  need</a> to source and assemble your own keyboard. Apart from a
  parts list, the schematics for the printed circuit board are
  freely downloadable and GPL-licensed. The casing comes in
  3D-printed and laser-cut acrylic variants you can have constructed
  at <a href="http://wiki.metrixcreatespace.com/">your local maker
  space</a>,
  and <a href="https://github.com/benblazak/ergodox-firmware">the
  firmware is on GitHub</a>.</p>

<p>This is great news for the adventurous maker, but I've only
  got <a href="/171">the most basic experience building
  electronics</a>. Sourcing all those parts and getting the circuit
  board <a href="http://oshpark.com/">printed</a> myself felt
  daunting. Luckily I discovered a company
  called <a href="http://www.massdrop.com">Massdrop</a> was
  organizing group buys which could get all the parts needed at a
  significant discount. The only problem was the group buys only
  opened up for a limited time, and there was a pretty serious
  turnaround time before delivery. As my luck had it I got in on a
  group buy which hit some snags in the fulfillment process and
  ended up having to wait from August to December for my kit to
  arrive. (I later found out there's another group buy to get just the
  circuit boards, which would have been an interesting way to go.)
  But to my great delight it finally came last week.</p>

<a href="https://secure.flickr.com/photos/technomancy/11396853655/in/photostream/">
  <img src="/i/ergodox-assembly.jpg" alt="assembly" align="left" /></a>

<p>For the drop I participated in Massdrop offered an optional
  partial assembly service. For a small fee the board would have all
  the diodes and the microcontroller pre-soldered, so you'd only
  have to solder the switches. Since the diodes are of the
  tiny <a href="https://en.wikipedia.org/wiki/Surface-mount_technology">surface-mount</a>
  variety, previous bad experience with surface-mount components
  prompted me to opt for the partial assembly. This ended up
  resulting in several extra weeks of delay, and for the most recent drop
  the assembly options have not been offered. But once I got my kit,
  soldering the switches only took around an hour. After another ten
  minutes I had all the caps on[<a href="#fn2">2</a>] (with some help as pictured) and
  the case assembled and was ready to
  roll. I've <a href="http://rossipedia.com/blog/2013/06/ergodox-mechanical-keyboard-review/">heard</a>
  <a href="http://jaymatter.com/blog/2013/12/01/ergodox/">reports</a>
  of others that were new to soldering were able to handle the SMD
  diodes without too much trouble, so maybe my concern was
  unwarranted. But adding in time for the diodes does bring the
  total assembly time up to five or six hours. Massdrop
  provides <a href="https://www.massdrop.com/ext/ergodox/assembly">detailed
  instructions</a> covering the assembly process, and various users
  have created video tutorials as well.</p>

<p>I mentioned
  the <a href="https://github.com/benblazak/ergodox-firmware">hackable
  firmware</a> earlier&mdash;this is really one of the things that
  sets the Ergodox apart. The keyboard embeds
  a <a href="http://www.pjrc.com/teensy/index.html">Teensy 2
  board</a>, an 8-bit Arduino-compatible microcontroller with more
  processing power
  than <a href="https://en.wikipedia.org/wiki/Apollo_Guidance_Computer">the
  computers that took the Apollo projects to the moon</a>. Massdrop
  helpfully provides a
  fantastic <a href="https://www.massdrop.com/ext/ergodox">web-based
  configuration tool</a> that can compile and spit out firmware for
  the microcontroller based on the keys you've specified.</p>

<a href="https://www.massdrop.com/ext/ergodox/?referer=NCVLBE&hash=388aaf52db3e7e0fd3efd99d2d007458">
  <img src="/i/ergodox-layout.png" alt="my current layout" /></a>

<p>I've got it configured with a basic dvorak layout with several of
  my more commonly-used function keys around the edges of the thumb
  clusters. As a lisp hacker it was exciting for me to have
  unshifted parentheses keys on my thumbs. As
  a <a href="http://www.emacswiki.org/emacs/ParEdit">Paredit</a>
  user I put the open paren closer to the thumb resulting in a
  weird-looking backwards configuration, because I rarely hit the
  close paren key. (Unfortunately unshifted parentheses can't be
  added in the web configurator; you have
  to <a href="https://github.com/technomancy/ergodox-firmware/commit/6e0409d">patch
  and build</a> the firmware yourself. I had a Teensy development
  environment set up
  from <a href="http://www.flickr.com/photos/43319799@N00/9522005426">a
  previous project</a> so this wasn't a big deal for me, but the
  convenience of the web configurator is very much appreciated when
  getting started.) Having enter and backspace on the thumbs is
  handy, but I found the outer layer of the thumb cluster is too far
  to hit when touch-typing, so putting my music controls there made
  sense. The code also supports shifting to other layers if you
  need more space. So far I've been comfortable with mostly just one
  layer, but I have a second layer with the full set of function
  keys and arrows for the rare occasions when those are needed.</p>

<p>The feel of a keyboard is obviously a really subjective
  thing. There's no one-size-fits-all, but
  the <a href="http://deskthority.net/wiki/Cherry_MX_Blue">Cherry MX
  blue switches</a> are really growing on me and already bring me
  some disappointment when I have to go back to my internal Thinkpad
  keyboard. But the layout takes a lot of getting used to. In
  particular the fact that it's staggered vertically instead of
  horizontally makes for an awkward adjustment period. Early
  typewriter designers staggered each row in order to avoid jams
  when the levers came up to strike the paper. Like many other
  quirks of early technology, this design has stuck around far
  longer than the reasons behind it. The Ergodox staggers each
  column instead in order to match up with human physiology: each
  finger is of a different length, so the column for the middle and
  longest finger is shifted up a bit higher, etc. It makes a lot of
  sense, but even after several days of on-and-off usage I still
  make lots of typos on the bottom row of my left hand. Though it's
  more effective to move lots of things over to the thumbs, I
  recommend leaving things like control, tab, and shift where you're
  used to them until you get over the disorientation of the new
  alignment.</p>

<a href="https://secure.flickr.com/photos/technomancy/11526060936/">
  <img src="/i/ergodox-colored-caps.jpg" alt="colored caps" /></a>

<p>The Ergodox project appeals to me on a lot of levels: the open
  licensing[<a href="#fn3">3</a>], the customizablility, the
  hands-on electronics[<a href="#fn4">4</a>], and the
  unconventional, human-oriented design. It's probably not for
  everyone, but if you've a professional programmer who's never
  given your keyboard a second thought, maybe it's time to broaden
  your horizons. They should be opening up the group buy for another
  batch in the near future...</p>

<p><b>Update</b>: I've <a href="/173">designed by own keyboard</a>,
  which is meant to be a smaller, more travel-friendly complement to
  the Ergodox that shares a lot of its characteristics.</p>

<hr />

<p>[<a name="fn1">1</a>] Though I can hardly stand the mushy key
  response these days, I have a soft spot in my heart for the MS
  Natural 4000 since it brought me significant relief from my RSI
  symptoms. Using it for several months taught me to angle my hands
  in correctly, a habit that I was able to take with me even when I
  started using other keyboards. Originally I kept my hands
  positioned like the photo below, but the shape of the
  Natural taught me to angle my fingers differently (pinky curled in
  and index finger extended out) so I could keep my wrists straight
  and still have my fingers rest in the home row position.</p>

<img src="/i/bad-angle.jpg" alt="bad angle" style="float: left" />

<p>That said if you are looking for a comfortable keyboard and
  aren't ready to spend over US$100 for something mechanical I would
  recommend the Kinesis Freestyle; even though it's still a
  rubber-dome switch it's got a crisper response than most and
  allows for you to keep your forearms totally straight.</p>

<p>[<a name="fn3">2</a>] The DSA (spherically-shaped cupped tops)
  keycap set that Massdrop offers doesn't include "homing bumps" for
  the keys under the index fingers, making it a bit tricky to get
  your bearing on the keyboard without looking down at your hands. I
  picked up a couple white caps with homing dots from Signature
  Plastics (matching black wasn't an option) and then went ahead and
  swapped the rest of the home-row with white as well along with a
  nice bright red Esc just for good measure. The only further
  hardware modification I have planned is changing out the switches
  under the pinky modifiers
  with <a href="http://deskthority.net/wiki/Cherry_MX_Brown">Cherry
  MX brown</a> switches, which require less force and should reduce
  pinky fatigue.</p>

<p><b>Update</b>: I've replaced the switches on the outermost
  columns: the modifiers (shifts and ctrl next to the A key) are
  Cherry MX reds (lower-force and no tactile bump) since I don't
  feel like tactile response makes sense for modifiers. For the
  non-modifiers I'm using browns which are tactile and lower-force
  without being loud; the idea was to reduce strain on the weak
  pinky fingers. I don't feel like the browns make all that much of
  a difference, but I like the feel of having linear switches for
  modifiers. I've also replaced the modifiers under my thumbs with
  Cherry MX black switches, which are like the reds but with heavier
  springs since the thumb is the strongest finger.</p>

<p>[<a name="fn3">3</a>] There have already been a number of further
  designs based on the Ergodox design, including
  the <a href="http://deskthority.net/workshop-f7/acidfire-s-custom-keyboard-aka-the-grand-piano-t6019.html">"Grand
  Piano"</a> and
  this <a href="http://blog.fsck.com/2013/12/better-and-better-keyboards.html">incredible
  string of prototypes</a> culminating in a
  soon-to-be-kickstarted <a href="http://keyboard.io">production run
  at http://keyboard.io</a>.</p>

<p>[<a name="fn4">4</a>] What's really eye-opening about putting a
  keyboard together is that you discover there's really no magic
  behind it. It's just a grid of switches wired into a
  microcontroller. Since microcontrollers don't have enough pins to
  detect each switch individually, there's a
  clever <a href="http://pcbheaven.com/wikipages/How_Key_Matrices_Works/">matrix
  wiring</a> employed; each hand has six rows and seven columns
  where each row and column is wired to a pin. The microcontroller
  then scans each column by bringing all the column outputs except
  one low and then checking to see which row inputs are high. It can
  only technically scan one column at a time, but it's able to
  rotate through them so quickly that it's indistinguishable from
  simultaneous reads to a human. The same multiplexing approach is
  used for controlling
  an <a href="https://en.wikipedia.org/wiki/Dot_matrix#LED_matrix">LED
  matrix</a> with a limited number of pins. It's all there in the
  code for when you get curious.</p>
include(footer.html)
