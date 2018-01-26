dnl -*- html -*-
define(__timestamp, 2009-10-03T22:37:47Z)dnl
define(__title, `in which the effects of distance are reduced')dnl
define(__id, 129)dnl
include(header.html)
<p>Since joining <a href='http://sonian.net'>Sonian</a> in April,
  I've been part of a distributed team that has grown to four
  Clojure programmers all living in different states of the
  US. While it's been great to be able to draw from a wide pool of
  talent, working with a distributed team has its challenges.  While
  we had
  everyone <a href='http://www.flickr.com/photos/technomancy/tags/sonian/'>in
  Seattle</a> for a week we got to do lot of pair programming, but
  after everyone went back home we were left wondering how we could
  emulate that over-the-shoulder atmosphere without all being
  physically in one place.</p>

<p>We tried VNC, but it was simply too laggy. Then we tried
  <a href='http://haruska.com/2009/09/29/remote-pair-programming/'>shared
    screen sessions</a>. This worked out pretty well. The defining
    characteristic here is that both participants see exactly the
    same thing. Only one can edit at a time, which is usually not a
    big deal when you're pairing. Since it's shared on a per-session
    basis rather than a per-document basis, it means you can share
    things like the woefully under-appreciated <kbd>M-x
    erevision</kbd> feature, which is fantastic for code
    reviews. But it still feels a bit restrictive and out of the
    regular groove. We also use mobile Internet connections a lot, and
    unfortunately port forwarding is not permitted by most mobile ISPs.</p>

<img src="/i/rudel.png" alt="rudel" />

<p>Then I discovered <a href='http://rudel.sf.net'>Rudel</a>, an
  Emacs client for the <a href='http://gobby.0x539.de/trac/'>Obby
  protocol</a>. Years ago I'd started <a href='/45'>my own
  implementation of this called Ebby</a>, but I wasn't aware of the
  more nuanced implications of the protocol, so my implementation
  was never very robust. Rudel, on the other hand, does a great job
  of allowing us to share documents among collaborators in
  real-time.</p>

<p>Now we use Rudel for our main solution and then fall back to
  screen whenever we want to do something that involves
  synchronizing the whole screen. While you can run shell or SLIME
  sessions in Rudel, it's a bit awkward since only the original
  publisher of the document can actually interact with the
  subprocess. The other person can enter commands, but they can't
  run them, since pressing <kbd>enter</kbd> will simply insert a
  newline. I have been playing with the idea of using the Obby chat
  functionality as a side-channel to perform these kinds of things,
  but I haven't written any code for it yet.</p>

<p>One thing you've really got to be careful with in this situation
  is communicating who's responsible for committing. Otherwise you
  could easily get conflicting commits. SIP works great for talking
  through this vocally, though unfortunately mostly at work we're
  using Skype, which has a fairly lousy client for GNU/Linux.</p>

<!--  <p>Of course, this is only feasible if everyone on the team can work
  in an environment that's obby-aware. Gobby, the reference
  implementation, is a pretty weak editor for coding, and Rudel
  seems to be the only other existing implementation. So if an
  intrepid Vim user came along who could implement an Obby client in
  Vimscript, we might be able to consider him, but for now we're an
  all-Emacs team.</p> -->

<p>I'm working with Jan, the Rudel author, towards an 0.2 release
  (quite soon, it looks like) which should improve stability pretty
  significantly. At that point I should be able to bundle it up for
  ELPA, though if you're running an Emacs that's older than October
  2009 you will still need to install
  the <a href='http://cedet.sf.net/eieio.shtml'>eieio</a> library by
  hand.</p>

<p>Anyway, if you work on a distributed team, you
  should <a href='http://rudel.sf.net'>give it a shot</a>. Until 0.2
  is released, you'll have best luck with the development
  version:</p>

<p><kbd>bzr branch
    bzr://rudel.bzr.sourceforge.net/bzrroot/rudel/trunk rudel</kbd></p>

<p>Then in your Emacs config:</p>

<pre class="code">(load-file "/PATH/TO/RUDEL/rudel-loaddefs.el")</pre>

<p>Once you've got a Gobby server running, <kbd>M-x
    rudel-join-session</kbd> should get you connected, and <kbd>C-c
    c s</kbd> will let you subscribe to a new document. Have fun!</p>

<p><b>Update</b>: A few months after writing this post we switched
  to using shared <tt>tmux</tt> sessions for our collaboration. At
  the time of this writing Rudel wasn't 100% reliable, but we also
  found the requirement to share one buffer at a time to be fairly
  awkward. The cross-editor aspect is theoretically nice, but no one
  has implemented the protocol for Vim yet. The fact that you can't
  share shell buffers or repl buffers is a pretty serious
  drag. There are some downsides with tmux, but whenever you have
  two people comfortable with the same editor it's a pretty
  compelling way to work.</p>

<p><b>Update</b>: This is even better using <tt>tmux</tt>
  with <a href="https://tmate.io">tmate</a>.</p>

include(footer.html)
