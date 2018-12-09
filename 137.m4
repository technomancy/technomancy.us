dnl -*- html -*-
define(__timestamp, 2010-05-12T04:20:17Z)dnl
define(__title, `in which is divulged more detail than is generally interesting')dnl
define(__id, 137)dnl
include(header.html)
<p>So this post is ridiculously self-indulgent; you've been
  warned. I've mostly written it out here for my future self to look
  back on in a mix of amusement and embarassment. It's just a
  write-up of the tools I use daily in the style
  of <a href="http://usesthis.com/">the Q&amp;As at
  usesthis.com</a>.</p>

<p><b>Update</b>: I had a
  real <a href="http://phil.hagelberg.usesthis.com/">interview posted
    on usesthis.com</a> in 2012.</p>

<p><b>Update</b>: I started keeping <a href="/gear">a changelog of my
    gear</a>.</p>

<h4>What hardware do you use?</h4>

<p>I use a Thinkpad X200s primarily. It's hard to find a machine
  that's acceptably light (2.4 lbs/1.1 kg) but still has a decent
  resolution; most "small" laptops these days have a vertical
  resolution no greater than my phone, which would be embarrassing for
  me to use. The Thinkpad has the best keyboard of any laptop; I
  appreciate the crisp response. It also has an integrated trackpoint,
  which is nice in that you can move the pointer without taking your
  hands off the home row, but I try to avoid it as much as
  possible. I'm much more productive when using 100% keyboard
  commands. Sometimes I'll just pluck the trackpoint out entirely just
  to make sure I'm not using it without thinking.</p>

<p>I work from coffee shops frequently since I have a remote job,
  but when I'm
  in <a href="http://www.flickr.com/photos/technomancy/tags/laboratory/">my
  code lab</a> I use a standing desk with an external 23-inch
  monitor. I rotate the monitor to portrait orientation when I'm not
  remote pairing
  with <a href="http://tmux.sourceforge.net/">tmux</a>. I have a
  recliner next to the desk onto which I fall back to for a couple
  hours out of the day. While I'm standing I wear what has been
  affectionately
  termed <a href="http://www.flickr.com/photos/technomancy/4397554484/">"keyboard
  pants"</a>. It's a Kinesis Freestyle with kneepads attached. The
  kneepads are worn significantly above the knee&mdash;the idea is
  to allow myself to type in as neutral of a position as
  possible. My arms are relaxed in a downward position, and my
  wrists are totally straight. It takes some getting used to, but
  from an RSI perspective it's quite beneficial. It also just feels
  great not to be sitting all day.</p>

<p>I keep a Nexus One phone in my pocket. As far as I know it's the
  only major phone currently available that's designed to be
  rootable by the end user, and hence the only phone I am
  comfortable purchasing. As a nice bonus it also happens to
  be <a href="http://technomancy.us/134">one of the best phones
  available</a>, though it seems absurd to call it a phone. I hardly
  make any actual voice calls on it, though when I do it's VOIP
  calling through <a href="http://sipdroid.org/">Sipdroid</a>. I
  have <a href="http://www.cyanogenmod.com/">CyanogenMod</a>
  installed, which has a really nice auto-tether over USB.</p>

<h4>And what about software?</h4>

<p>I start with a boring old Ubuntu GNOME install. To my
  embarrassment I actually even use metacity, the default window
  manager. My secret sauce is
  <a href="http://burtonini.com/blog/computers/devilspie/">devilspie</a>,
  which is a rules engine for window placement and behaviour. I
  <a href="http://github.com/technomancy/dotfiles/blob/master/.devilspie/max.ds">fullscreen
  and undecorate all my commonly-used programs</a> and have certain
  programs only show up on a given virtual desktop. It's flexible enough
  to trick people into thinking I use <a href="http://xmonad.org/">a real
  WM</a>. My other main desktop-level customization
  is <a href="http://www.nongnu.org/xbindkeys/xbindkeys.html">xbindkeys</a>,
  a little app that embeds a Scheme interpreter to configure
  bindings. This is nice because it decouples them from the window
  manager. The only part of GNOME I use on a regular basis is the
  panel. I like having CPU/network/memory graphs available so I can tell
  when my machine is hard at work. The panel wifi tool is pretty handy
  too.</p>

<p>Apart from that it's Emacs, Emacs, and Emacs. I am mostly able to
  maintain the illusion that Emacs is the only program I actually
  interact with regularly. I generally have four or five instances
  running at once which is uncommon; most Emacs users keep single
  instances with uptimes in the weeks range. I use this as a
  namespacing technique to keep real work separated from
  play/chat/mail. My staple modes
  are <a href="http://alexvollmer.com/posts/2009/01/18/meet-magit/">magit</a>, <a href="http://github.com/technomancy/clojure-mode">clojure-mode</a>, <a href="http://common-lisp.net/project/slime/">slime</a>,
  <a href="http://www.emacswiki.org/emacs/ParEdit">paredit</a>, <a href="http://orgmode.org/">org-mode</a>,
  and <a href="http://www.emacswiki.org/emacs/ERC">erc</a>. I used
  to waver
  between <a href="http://emacs-jabber.sourceforge.net/">jabber.el</a>
  or <a href="http://www.emacswiki.org/emacs/ELIM">elim</a> and
  leaving the embrace of Emacs for something like Pidgin, which was
  not pleasant at all. But now I'm pretty settled
  on <a href="http://www.bitlbee.org/main.php/news.r.html">bitlbee</a>,
  which allows you to connect to your IM accounts via an IRC
  client.</p>

<p>I have all my Emacs config (accumulated over years of obsessive
  tweaking) bundled up as
  the <a href="http://github.com/technomancy/emacs-starter-kit">Emacs
  Starter Kit</a>. Lots of other developers use this as a base off
  which to build or just to steal ideas from, which I love. (It's a
  little funny to get bug reports for your own dotfiles.) I try to
  save all my other config in git as well in order to make it easy
  for me to get up and running quickly on a new machine.</p>

<p>The other key to maintaining the Emacs-all-the-time illusion
  is <a href="http://conkeror.org">Conkeror</a>. Emacs doesn't have
  a modern web browser in it yet, so this is an attempt to trick
  Mozilla Xulrunner into thinking it's Emacs. Apart from being
  implemented in JS instead of lisp, it's a very good
  approximation. The buffer switcher features completion that's far
  better than anything I've used in a mainstream browser, and its
  mouseless browsing support is excellent. It's also very stable as
  long as you don't have any garbage plugins like Adobe Flash
  installed. <strike>Its only flaw is being based on Gecko rather than
  Webkit. I've experimented a bit with mouseless extensions for
  Chromium, but the extension mechanism in that browser is crippled
  in comparison to what's possible in Mozilla, so while the speed
  boost was nice, this ended up being very frustrating in
  practice.</strike></p>

<p><b>Update</b>: I recant my complaints regarding the speed of
  Gecko in light of
  <a href="http://nightly.mozilla.org/">the latest Mozilla
  nightlies</a>; they are absolutely zippy. I am no longer tempted
  to go back to Chromium. You can use Firefox rather than Xulrunner
  to launch Conkeror by doing <kbd>bin/firefox -app
  ~/src/conkeror/application.ini</kbd>.</p>

<p>Unfortunately I need to use skype for work. While I've been
  pretty impressed with its ability to use a very limited amount of
  bandwidth, it's quite unstable, and its UI is very awkward. Since
  it's not free software there's very little hope of this improving
  soon. The one thing that eases this pain is the skype plugin
  for <a href="http://do.davebsd.com/">gnome-do</a>. It allows calls
  to be initiated from the keyboard. While I am a fan of the ideas
  behind gnome-do, this is the only thing I use it for since in
  general Emacs does a better job at the kinds of things it
  does.</p>

<h4>What would your dream setup be?</h4>

<p>I really wish I could buy a modern laptop with a 4:3 aspect
  ratio. I find the loss of vertical space in widescreens very
  annoying for anything other than watching movies. Apart from that
  the Thinkpad X200s is nearly everything I want in a laptop. In a
  perfect world I would have a battery with the weight of a 4-cell
  and the capacity of a 9-cell. Half the weight of my laptop is the
  battery.</p>

<p>I recently switched to using gmail in the browser, and while it's
  decent for everyday mail it is markedly inferior to gnus for mailing
  lists. I'm only using it because it syncs with my phone, and setting up
  offlineimap to work with gnus and gmail sounds like a lot of work. This
  is definitely the least-satisfying part of an all-Emacs setup, at least
  if you want to read mail on a mobile device.</p>

<p>I imagine if they ever get
  the <a href="http://senseboard.com">senseboard</a> working it will
  be a pretty sweet innovation. I could also use a HUD for my phone
  for when I'm in the car. Or possibly on my sunglasses for when I'm
  just walking around; you know... I'm not picky.</p>
include(footer.html)
