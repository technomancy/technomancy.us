dnl -*- html -*-
define(__timestamp, 2013-11-24T15:05:43Z)dnl
define(__title, `in which hardware heats things up')dnl
define(__id, 171)dnl
include(header.html)
<p>As a remote hacker, I spend a fair bit of time in
  my <a href="http://www.flickr.com/photos/technomancy/tags/laboratory">code
  lab</a> when I'm
  not <a href="http://www.flickr.com/photos/technomancy/tags/remoteoffice">out
  and about around Seattle</a>. It's great to have a space away from
  the rest of the house where I can work in isolation, but around
  this time of year in the Northern hemisphere the temperatures
  start to drop. I've had a powerful wall heater in the lab for a
  while now, but some days I'd be a little reluctant to head out
  across the frost-covered lawn since the heater takes 20-30 minutes
  before it really gets things comfortable on a cold day.</p>

<p>I've
  been <a href="http://www.flickr.com/photos/43319799@N00/9522005426">getting
  my feet wet with hardware hacking</a> the past few months, so to
  me the problem was practically begging to be solved with a little
  applied technology. Of course there are plenty of of-the-shelf
  devices that can toggle a 110V outlet, but the particular heater
  I'm using is wired directly into 220V mains, calling for a custom
  solution. I recently built
  a <a href="https://secure.flickr.com/photos/technomancy/10982587913/">binary
  clock for my car</a> using a Raspberry Pi, so I'd had a bit of
  experience with embedded Linux boards. For this project I ended up
  choosing
  the <a href="http://beagleboard.org/Products/BeagleBone%20Black">BeagleBone
  Black</a>, an impressive board costing only US$10 more than the Pi
  but packing in a lot more power as well as boasting a Creative
  Commons-licensed hardware design. Of course an Arduino could have
  worked here too, but once you add Ethernet to the cost of an Uno
  it ends up costing nearly as much and would have offered much
  more limited language and library support.</p>

<img src="i/bbb-wall.jpg" alt="beaglebone black" />

<p>I ended up with this little board running Debian with
  an <a href="https://www.adafruit.com/products/165">temperature
  sensor</a> in its analog input and
  a <a href="http://www.fotek.com.hk/solid/SSR-1.htm">solid-state
  relay</a> hooked up to one of the GPIO pins. The analog input is
  the main thing that makes this a much better fit for the
  BeagleBone than a Pi; all the inputs on the Pi are digital, which
  would have made reading the temperature more
  complicated. Unfortunately the input to the relay won't trigger
  with less than 7.5ma, so it was necessary to hook it into SYS 5V
  (the taped wire above) and toggle it by way of an NPN transistor
  in between the relay's negative terminal and the board's
  ground. Disclaimer: working with mains power is dangerous; be sure
  to switch off the appropriate circuit breaker before you touch any
  of the high-voltage wires.</p>

<img src="i/relay.jpg" alt="heater relay" align="left" />

<p>In order to control the relay, I put
  together <a href="https://github.com/technomancy/prometheus">an
  Erlang XMPP bot</a> which monitors the current temperature and
  switches the GPIO pin on or off accordingly depending on the
  target temperature. The target temperature can be set by messaging
  the bot, and the current temperature can be queried as well. The
  GitHub repo contains a few schematics along with more detailed
  instructions on how it was built.</p>

<p>There's still a bit more I'd like to do with it. Right now it's a
  pretty lame Erlang app that doesn't use any fancy OTP features to
  improve reliability, so a lost connection to the XMPP server can
  cause downtime. This is supposedly something OTP makes really
  easy; I just need to read through the appropriate chapters
  in <a href="http://learnyousomeerlang.com">Learn You Some
  Erlang</a>. In addition I'd like to get logging in place; it would
  be useful to be able to plot temperatures over
  time. <b>Update</b>: it's now a proper OTP app with temperature
  logs in place.</p>

<p>I'm having a lot of fun with it, and I'm loving how I can just
  walk out to the shed and have it toasty right upon entry. It feels
  like a great practical project where a bit of hacking can really
  make life more convenient.</p>
include(footer.html)
