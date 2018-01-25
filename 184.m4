<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, 2017-10-23T19:04:13Z)dnl
define(__title, `in which a path is charted through the coming apocalypse')dnl
define(__id, 184)dnl
include(header.html)
<p>I've long counted myself among the grumpy old-timers who
  grudgingly accept the shift towards web-based-everything and just
  try to make the most of it, wistfully remembering the days when I
  could just do everything from within Emacs. One of my core
  survival strategies in this web-first world has been to trick my
  browser into at least having the decency to pretend to be Emacs. I
  accomplished this in Firefox<sup><a href="#fn1">1</a></sup> with
  the <a href="https://github.com/mooz/keysnail/wiki">Keysnail</a>
  extension. Keysnail has remarkable flexibility in how it overrides
  Firefox's default key bindings to match those of Emacs, and
  everything has been more or less great.</p>

<p>Unfortunately, <a href="https://blog.mozilla.org/addons/2016/11/23/add-ons-in-2017/">a
  soon-to-be-released update to Firefox</a> will remove the
  extension
  mechanism <a href="https://github.com/mooz/keysnail/issues/222">used
  by Keysnail</a>.</p>

<img src="/i/green-lake-laptop.jpg" alt="laptop at Green Lake" />

<p>I have felt very conflicted about this, because the old state of
  affairs is admittedly untenable. Firefox currently
  uses <a href="https://developer.mozilla.org/en-US/docs/Mozilla/Gecko">Gecko</a>,
  a decades-old rendering engine written in C++, and like much
  software written in C++ it has a pretty distressing security track
  record. Version 57 of Firefox replaces parts of Gecko with
  functionality from <a href="https://servo.org">Servo</a>, a
  browser engine implemented in the Rust programming language. Most
  of the bugs in Gecko which have led to embarrassing security flaws
  are simply impossible in Servo. The fact
  that so much safety-critical code is still being written in C++
  and similar languages is a sad state of affairs, and we should
  celebrate changes that mean end users will no longer bear the penalty
  for programmers' reluctance to move beyond the technology of the
  1980s.</p>

<p>But on the other hand, losing the ability to shape your computing
  environment to your whims is <em>awful</em>. I lost track of how
  many times (when using Chromium or other keysnail-less browsers)
  I've wanted to throw my laptop out the window when I held
  down <kbd>ctrl-n</kbd> to scroll down and it opened seventeen new
  windows instead. I can't remember ever wanting to open a new browser
  window in the past <em>decade</em>; why should I be stuck with a
  key bound to that command and no way to disable it?</p>

<p>Of course, the new Firefox will still have an extension
  mechanism, but it's a pale shadow of the old one. Citing the
  flimsy<sup><a href="#fn2">2</a></sup> excuse
  of <a href="https://github.com/lusakasa/saka-key/issues/53#issuecomment-332319791">security</a>,
  key bindings like <kbd>C-n</kbd> are hard-coded into the browser
  and forbidden from being overridden.</p>

<img src="/i/tumwater.jpg" alt="Tumwater Falls" align="left" />

<p>Things were looking bleak for me, and I contemplated whether I
  would switch to curl or just give up software development
  altogether for a career in goat-herding. I ended up finding a
  solution from a most unlikely place.</p>

<h4>EXWM saves the day</h4>

<p>I had heard of <a href="https://github.com/ch11ng/exwm">EXWM</a>
  a while ago, and it struck me as a quixotic curiosity. The X
  Window System uses a network socket for its control protocol,
  allowing a lot of flexibility including native forwarding of
  interfaces for remote programs. The developer of EXWM had taken an
  XML description of the specification for the network protocol and
  written a compiler to turn it
  into <a href="https://github.com/ch11ng/xelb/blob/master/xelb.el#L36">a
  library of Emacs Lisp functions</a> which he then used to
  implement a window manager in pure Emacs Lisp. While I admired the
  chutzpah this must have taken, I assumed it was a novelty that
  could never be practical.</p>

<p>Eventually the Firefox conundrum prompted me to give it a second
  look due to a feature called Simulation
  Keys. The <tt>exwm-input-set-simulation-keys</tt> function allows
  you to define a translation mapping so that a certain key
  combination will be intercepted by EXWM when a non-Emacs program
  has focus, and a different set of key input events will be sent
  instead. It seemed too good to be true; I could let go of Keysnail
  and instead get the same features applied to every program I
  use<sup><a href="#fn3">3</a></sup>.</p>

<p>I'm happy to report that EXWM does actually function startlingly
  well as a window manager. The simulation keys feature is amazing
  and puts my Firefox-related fears at ease, and having all
  configuration written in a single language simplifies my setup
  dramatically. Every X window you launch is given an Emacs buffer,
  and all your normal splits and window resizing commands work
  great with it. With the tiling window managers I used in the
  past, it was so unusual for me to use something other than the
  "one fullscreen window per display" setup that I would often
  forget the key bindings for splitting and rearranging
  windows. EXWM even integrates "system tray" programs into the Emacs
  echo area, so your wifi connect tool shows up unobtrusively in
  the bottom right corner.</p>

<p>There are a handful of gotchas. Emacs Lisp lacks general-purpose
  concurrency features, but it does allow for concurrency when
  dealing with subprocesses and network communication. Most
  well-written Emacs Lisp will never block the main event loop,
  which is good because when using EXWM that means the entire window
  manager is stuck until the blocking operation completes. I only
  came across two exceptions to this rule. One of them
  is <tt>smtpmail-send-it</tt>, which can be replaced by
  the <a href="https://github.com/jwiegley/emacs-async/blob/master/smtpmail-async.el">smtpmail-async</a>
  library. The other is the <tt>racket-run</tt> command, which I was
  able
  to <a href="https://github.com/greghendershott/racket-mode/pull/282">patch
  in about an hour</a> to remove the blocking
  call<sup><a href="#fn4">4</a></sup>.</p>

<p>Other folks might run into more problems if they use other
  third-party libraries which don't take care to use the network
  functions properly. But for my use<sup><a href="#fn5">5</a></sup>,
  it's been very smooth, and I'm thrilled to have it.</p>

<p><b>Update</b>: I've
  started <a href="http://p.hagelb.org/exwm-ff-tabs.html">configuring my
  browser to open everything in new windows instead of new tabs</a>,
  which sounds crazy, but is very useful, because it means that you
  can use Emacs's built-in buffer switching tools to change tabs,
  which are much better than anything I've seen inside a browser.</p>

<hr>

<div class="footnotes">
<p>[<a name="fn1">1</a>] I used <a href="http://conkeror">Conkeror</a>
  for several years, but eventually things got to the point where
  browsing without <a href="https://noscript.net">Noscript</a>
  became untenable, and I could never get the two to work well together.</p>

<p>[<a name="fn2">2</a>] The rationale of "it's for security" would
  stand up to a little more scrutiny if it weren't for the fact that
  extensions <em>can</em> rebind <kbd>C-t</kbd>, a key which is used
  hundreds if not thousands of times more often than <kbd>C-n</kbd>.</p>

<p>[<a name="fn3">3</a>]
  Granted <a href="http://www.gnumeric.org/">gnumeric</a> is the
  only program I use outside the browser and Emacs, but it's still
  greatly appreciated. I also use
  the <a href="https://key.saka.io/">Saka Key</a> extension, which
  implements Keysnail's ability to trigger links from the keyboard
  even if they don't have text attached to them.</p>

<p>[<a name="fn4">4</a>] I feel that the increasing "Emacs needs
  concurrency!" calls tend to overstate the problem. Yes, of course
  it would be nicer for the programmer to code using coroutines
  (coming in Emacs 26!) instead of callbacks, but in the end this is
  a convenience for the author, not for the end user.</p>

<p>[<a name="fn5">5</a>] <a href="https://github.com/technomancy/dotfiles/blob/master/.emacs.d/phil/wm.el">My
    customizations</a> largely revolve around replacing
    my <a href="https://github.com/technomancy/dotfiles/blob/master/.xbindkeysrc.scm">xbindkeys</a>
    config with elisp, mapping workspace numbers to physical
    displays, and some <tt>eshell</tt> commands to give one eshell
    buffer per workspace. EXWM has XMonad-style workspaces where you
    can change the workspace for each display independently rather
    than forcing you to change them all at once like many more
    conventional WMs, and I'm very glad it does.</p>
</div>
include(footer.html)
