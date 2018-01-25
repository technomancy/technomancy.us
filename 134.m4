<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Sun 07 Feb 2010 09:35:24 PM PST)dnl
define(__title, `in which telephone seems like entirely the wrong word')dnl
define(__id, 134)dnl
include(header.html)
<p>After years of resisting phone ownership followed by a few years
  of owning a 2003-era Nokia dumbphone, I finally decided to make
  the jump when the Nexus One was announced. I've got a strong
  distaste for systems that <a href="http://apple.com/iphone">place
  arbitrary restrictions on their users</a>, and while the Android
  OS itself doesn't have any, many Android phones before the Nexus
  One have had the carriers interfere with the user's control over
  their phone, though not to the same offensive degree as
  Apple. The Nexus One is sold directly through Google without
  giving the carriers a chance to sully it.</p>

<h3>Daily Usage</h3>

<p>The screen is just brilliant, and the 800x480 resolution means
  everything is sharp. The OS is very smooth and responsive. Having
  spent so long on a system where the keyboard is king and the mouse
  is only used in exceptional cases, switching to the inverse
  situation on the phone is a bit odd, but not as disorienting as
  you'd expect. Like any handheld keyboard, the Nexus's is bad for
  writing anything longer than a chat, but it's certainly no worse
  than the hardware keyboard on the
  old <a href="http://www.amazon.com/Sharp-SL-5500-Zaurus-PDA/dp/B000063D6E">Zaurus</a>
  I toy around with occasionally or the one on my Kindle. The built-in apps work great, and
  if you take the plunge to fully switch to GMail, it pretty much
  makes syncing your mailbox a solved problem.</p>

<img src="/i/nexus-one.jpg" alt="nexus logo" class="right" />

<p>There are a few nit picks like the color balance being a bit off
  on the camera, the way the face buttons don't trigger unless you
  push the upper half, and the fact that the built-in jabber client
  only supports a single account. But these are all pretty minor or
  easy to work around. The only thing that really bugs me about it
  is the fact that there's no ZeroConf implementation yet for the
  platform. But there are people working on this, so it's just a
  matter of time.</p>

<h3>Oh, and using it to Talk?</h3>

<p>It turns out you can also use the Nexus One to interface with the
  global legacy telephone system and make calls on that. Supposedly
  it has a very nice dual-mic noise suppression system for when you
  do this, but I've only made a handful of test calls so far. I got
  a <a href="http://www.t-mobile.com/shop/plans/cell-phone-plans-detail.aspx?tp=tb1&rateplan=T-Mobile-Total-Internet-Rate-Plan">data-only
  plan</a> for half of what the regular voice+data plans go for and
  had planned to use <a href="http://sipdroid.org/">Sipdroid</a> to
  make VoIP calls with it, but then I realized I just don't make
  voice calls any more. So while there's a barely-noticeable delay
  with SIP calls over the 3G network, it really doesn't bother me. I
  also have used
  the <a href="http://code.google.com/p/android-wired-tether/">Wired
  Tether</a> app to hook up my laptop on the go and can confirm that
  calls via Skype sound fine too. So it's nice that T-Mobile isn't
  blocking that on a network level. They do seem to be the
  least-user-hostile of all the US carriers.</p>

<p><b>Update</b>: Skype has released an Android version, which is
  now what I use for all my voice needs.</p>

<h3>Hacking It</h3>

<p>Of course once you get past the formalities, the question that
  matters to a hacker is how it feels to hack. I've only really
  gotten started with this, but my initial report is fairly
  positive. The official toolsets are either Eclipse or Ant, neither
  of which give me warm fuzzies, but luckily you can use Ant out of
  the box without getting exposed to the XML-editing ickiness.</p>

<img src="/i/garrett.png" alt="garrett demo" align="left" />

<p>Getting programs onto the device is pretty simple. Once your
  source is ready, you run <kbd>ant debug</kbd>, which produces a
  .apk package. You can use the <kbd>adb</kbd> (android debugger)
  program to load it up over USB, but since I keep leaving my USB
  cable various places, I prefer just <kbd>scp</kbd>ing it to my
  server and pointing my device's browser directly at the .apk. You
  can also use this to install dev builds of various apps before
  they have been uploaded to the Market.</p>

<p>The API seems pretty sane. Clearly a lot of thought has gone into the
  notion of supporting a single front-and-center application while
  allowing others to run in the background without impacting battery
  life and performance too severely. I've played a bit with the
  graphics tools, and they remind me a fair bit
  of <a href="http://processing.org">Processing</a>, which is a good
  thing. I haven't done much intricate UI work with a lot of buttons
  or menus, but that kind of stuff can be tedious even in the nicest
  environments.</p>

<h3>Language of Choice</h3>

<p>Since Dalvik (the Android VM) is based on the JVM, there's a whole host of
  languages that can run on it. Unfortunately, Dalvik is no
  Hotspot&mdash;it currently lacks JIT, and the GC is merely
  serviceable rather than astoundingly good like Hotspot's. The lack
  of a good GC makes using <a href="/132">persistent data
  structures</a> a real drag since they generate a lot of ephemeral
  garbage, so Clojure is not a good choice. The lack of JIT coupled
  with CPUs that are comparatively low-powered means that
  while <a href="http://groups.google.com/group/ruboto">JRuby
  runs</a>, it's not altogether pleasant, especially considering the
  blitz with which regular apps perform. I've been told there is
  some low-hanging fruit for improving performance on Android, so
  this is likely to improve to a degree. Rhino, Python, Lua, Scala,
  and others work, (including, I'm told, even some legacy languages
  like Java, if you can imagine that) but I decided to try the
  less-traveled route with something
  called <a href="http://github.com/headius/duby">Duby</a>.</p>

<p><b>Update</b>: Duby has (thankfully) been renamed <a
  href="http://mirah.org">Mirah</a>.</p>

<p>Duby is a language created by Charles Nutter, the head of the
  JRuby project. JRuby is an amazing feat in part because Ruby's
  object model is vastly different from what's natively available on
  the Java platform. By an astounding effort they've managed to put
  together a first-class Ruby implementation, but it does raise the
  question: what would a modern language look like that
  went <i>with</i> the grain of its host instead of violently
  against it? Duby is an attempt to answer that question.</p>

<p>The syntax of Duby is nearly identical to that of Ruby; it only
  adds type declarations to method definitions. Yes, that means it's
  statically-typed. While it has type inference, it's not
  Hindley-Milner-style, it's closer to Scala's. Locals get their
  types inferred, it's only arguments in method definitions that
  need hints. So far I keep forgetting this nearly every time I
  write a new method since it looks so close to Ruby otherwise, but
  I'm sure I'll get the hang of it. Closures are compiled into
  anonymous inner classes, and you can iterate over collections with
  blocks. Duby is also unique in that it literally has no
  runtime&mdash;its literals translate directly to ArrayLists and
  HashMaps, so once you've compiled, the code is more or less
  identical to what the Java compiler would have output.</p>

<h3>Progress</h3>

<p>So far I've only put together a couple toy apps: Hello World, and
  a <a href="http://github.com/technomancy/Garrett">graphics demo
  with a bouncing ball</a>. Unfortunately, Duby is a <i>very</i>
  immature language, and it shows. Starting out I had to go to
  Charlie at nearly every turn with stack traces. Half the time it
  would be my fault, and half the time it would be something
  as-yet-unsupported by the compiler. But so far he's been able to
  turn around and bring in all the features I need, which has been
  quite amazing. I'm hoping to get a chance to dive into the
  compiler source myself and get to the point where I can add
  features I need with minimal guidance.</p>

<p>Adapting the Android build process to Duby was surprisingly easy. You
  <a href="http://github.com/technomancy/Garrett/blob/master/build.xml#L67">redeclare
    the compile task</a> to call the Duby compiler instead of javac,
    tell it to output its bytecode in the right directory, and the
    rest of it just falls into place.</p>

<p>My next plans are to add more interactivity to my graphics demo;
  I'd like to play with creating objects and applying motion rules
  to them; I hope to come up with something my two-year-old would
  get a kick out of. So far it's been a lot of fun and a great way
  to explore the capabilities of this remarkable device.</p>
include(footer.html)
