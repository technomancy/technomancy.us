dnl -*- html -*-
define(__timestamp, Mon 30 Aug 2010 06:23:38 PM PDT)dnl
define(__title, `in which the lessons of ZZ Top are applied to the marketplace')dnl
define(__id, 140)dnl
include(header.html)
<p>I've been thinking a lot about ZZ Top recently. This isn't
  something I generally do as a rule, but it was prompted by
  re-reading <a href="http://gilesbowkett.blogspot.com/2007/10/im-bad-im-nationwide-job-security-vs.html">a
  blog post</a> by the inimitable Giles Bowkett ostensibly about the
  song <a href="http://www.youtube.com/watch?v=SxHyHk3h2IU">I'm Bad;
  I'm Nationwide</a>. Go ahead and cue that up in the background
  while you read this post; it's vaguely relevant.</p>

<img src="/i/zz-top.jpg" alt="zz top" />

<p>"Bad" in this sense of course is the good kind of bad, like the
  Michael Jackson song. It seems to be mostly about attitude. Giles
  makes the point that generally being bad is not correlated with
  being nationwide.</p>

<blockquote>
  <p>"I'm Bad, I'm Nationwide" is a ZZ Top song. Hopefully
  you can figure out what it's about, but just in case, the singer's
  point is that he is bad, and he is nationwide. [...]</p>

  <p>It's good to be bad. It's good to be nationwide. It's
  even better to be worldwide. How can we apply the lessons of ZZ
  Top in the workplace?</p>

  <p>Obviously if you walk into your boss' office, jump on
  his or her desk, pull down your pants, and perform toilet
  functions all over the place, that would be bad. But it would not
  be nationwide, and it would not encourage becoming nationwide. In
  fact, it would not really be bad, it would just be stupid. But
  this silly example highlights a deeper paradox: that which is bad
  is usually local, and that which is nationwide is usually
  good.</p></blockquote>

<p>Giles goes on to talk about how the bad/nationwide balancing act
  applies to a career in software development, which is interesting,
  but I've been thinking about it in terms of projects instead. Take
  the familiar realm of editors. There are a few of them that are
  nationwide just by virtue of having survived and built up a
  following over the course of several decades. And they're also
  often bad when flame wars erupt over them, as is fairly
  common.</p>

<p>So Emacs and vi have somehow achieved the intersection of bad and
  nationwide, which as Giles posits is tricky to pull off. Simply
  being bad doesn't work in the long-term, and while quiet
  competence sometimes does, it's worth noting that in many cases
  attention helps a project improve in concrete
  ways&mdash;especially projects whose users are developers. This
  is pretty key for things like languages, libraries, and build tools.</p>

<p>The problem I'm faced with here is that being bad is also often
  correlated with being inflammatory. The easiest way to get attention in
  the software world is to pick a fight. You see this <i>all the
  time</i> on sites like Reddit; when people smell blood they
  upvote, which is why stuff like
  <a href="http://dosync.posterous.com/clojure-nodejs-and-why-messaging-can-be-lame">Aleph
  vs Node.js: the smackdown</a> makes it to the front page despite
  being a superficial comparison.</p>

<p>The thing you have to remember about picking fights with another
  project or language just for the sake of it is that often the
  attention fallout is more evenly distributed than is
  intended. When someone goes out of their way to pick a fight, they
  <a href="http://www.jroller.com/obie/entry/top_10_reasons_why_java">usually
  aren't much good at hiding the fact that they've got an investment
  in one side</a>. Impartial readers can usually pick up on this
  pretty easily, and they're likely to spot holes in the argument
  or write it off it as a piece of cheerleading. In cases of
  particularly unfair partisanship, they may even begin to
  sympathize with the target under attack.</p>

<p>The closest I've come to this sort of bad/nationwide
  is <a href="http://twitter.com/technomancy/status/10994115673">this
  post I made on Twitter a few months back</a>:</p>

<blockquote><p>Q: What's the difference between Ant and Maven? A: The
    creator of Ant has apologized.</p></blockquote>

<p>This turned out to be just the right mix of nasty and clever
  to really take off; hundreds and hundreds of people passed it on, and
  over the next few days searches for my name came up with just
  pages and pages of this over and over again. At the time of this
  writing it's still on the second page of results in a search for
  my name.</p>

<p>I've got to admit, as the author
  of <a href="http://github.com/technomancy/leiningen">a build
  system that competes with Maven</a>, this felt kind of good. The
  problem is it's totally a cheap shot&mdash;everyone involved with
  build tools ends up in a position of needing to apologize to their
  users given enough time. James Duncan Davidson has expressed his
  regrets over the use of XML in ant, Dave Thomas is less than proud
  of how RDoc has turned out, and I'm pretty sure the only reason
  the guy responsible for the tabs/spaces distinction in Makefiles
  hasn't apologized is that he fled to Tijuana for facial
  reconstructive surgery. Anyway, Leiningen will eventually be in
  the same position if it's not already.</p>

<img src="/i/why-range.gif" alt="why sample" class="right" />

<p>So we're still left with this question of whether you can be bad
  and nationwide without also being a jerk. I think it's doable, but
  you just don't see it much because picking fights is so much
  easier. One example that comes readily to mind
  is <a href="http://en.wikipedia.org/wiki/Why_the_lucky_stiff">_why
  the lucky stiff</a>. He qualified not just by his off-kilter visual style
  but by his aversion to what he scoffed at as "best practices".</p>

<blockquote><p>Perhaps this is why I have trouble swallowing unit
  testing or extreme programming or other best practices as the
  law. I guess there’s a place for these tricks (the work place,)
  but they do not speak to the pure form of hacking for hacking’s
  sake, which I so ardently defend! Unit testing, in particular, is
  designed to reel in spontaneous hacking. It is like framing a
  picture before it has been painted. Hacking, at heart, will
  continue to be something of spontaneous order, something of
  anarchy, and the landscape of hacking is something which comes
    from human action but is not of human design.</p>

<p><a href="http://web.archive.org/web/20080512050317/hackety.org/2007/12/24/thisHackWasNotProperlyPlanned.html">&#8213;
    This Hack was not Properly Planned</a></p></blockquote>

<p>This may not sound particularly controversial, but in the context
  of the test-driven-fanatic Ruby community it was a pretty weighty
  heresy. But he was all about exploring the fringe, and some
  excellent ideas came of it. It caught peoples' eyes and drew them
  in, so much so that when he disappeared, the communities
  surrounding his projects picked up the orphaned bits and carried
  them forward.</p>

<img src="/i/zz-top2.jpg" alt="gibbons" align="left" />

<p>Bad... and <i>nationwide</i>.</p>

<p>This is way more productive than us-vs-them fights that normally
  accompany attempts to be bad and nationwide. So what does this
  mean for you and me? Most people can't draw like _why, but
  injecting your own particular brand of crazy into your projects
  may be a slick hack you can pull to sidestep the negativity.</p>

<p>Here's an example: the <tt>new</tt> task in Leiningen spits out a
  blank Clojure project skeleton. At the time I saw a few too many
  "foojure"-type names popping up for new projects, and when I saw
  one called "Couverjure" I said enough is enough. Now
  the <tt>new</tt> task will refuse to generate projects named after
  *jure puns. Arbitrary? You bet. Ridiculous? Perhaps. But harmless
  and easy to work around. And don't forget controversial:</p>

<a href="http://github.com/technomancy/leiningen/commit/39732d5b649dedb70b14e88fe561dfc9ddb31611"><img src="/i/enough.png" alt="no more jure names" /></a>

<p>The point is: don't take yourself too seriously. Hack the good
  hack and leave an easter egg or two around for the
  adventurous. Then you too can be bad... and <i>nationwide</i>.</p>
include(footer.html)
