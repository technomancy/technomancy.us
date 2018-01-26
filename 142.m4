dnl -*- html -*-
define(__timestamp, Sat 30 Oct 2010 10:15:28 PM PDT)dnl
define(__title, `in which the conjference is recapitulated')dnl
define(__id, 142)dnl
include(header.html)
<p>I got back last night from a week in <abbr title="Boston-Atlanta
  Metropolitan Axis">BAMA</abbr> for
  the <a href="http://first.clojure-conj.org/">Clojure Conj</a>
  conference. The consistent quality of the talks surpassed any
  other conference I've attended so far, and there was a palpable
  high-energy air of potential with so many focused hackers
  congregating for the first time. The only downside was that the
  breakneck pace of fitting all the talks into two days left little
  time for ad-hoc chatter and hackfests, something I've greatly
  enjoyed at Ruby conferences.</p>

<p>I got a chance to speak on
  Leiningen. [<a href="http://p.hagelb.org/conj-2010-slides.org.html">slides</a>]
  I opened with basic usage followed by a few little-known but
  useful features. After that I took some time to explain how
  Leiningen tasks are written and <a href="/141">extended</a>. I
  spent a little more time on this since
  it's <a href="http://stackoverflow.com/questions/3906276/whats-the-difference-between-cake-and-leiningen/3908108#3908108">something
  that folks have asked about recently</a>. The gist I tried to get
  across is that it's best to structure core concepts like tasks
  around functions rather than one-off mechanisms like macros or
  custom deftypes if at all possible as it encourages composability
  and is instantly recognizable to users at a glance.</p>

<p>It turned out the emphasis on functions in order to support
  composability was a common theme that everyone seemed to come back
  around to, most notably Mark McGranahan on Ring and Stuart
  Halloway on simplicity in general.</p>

<img src="/i/stuart-simple.jpg" alt="Stuart Halloway on Simplicity" />

<p>Near the end of the conference Rich gave a self-professed
  non-technical rant on the simple subject of thinking hard about
  hard problems. He said that one of the things he's most thankful
  of in his life is the opportunity to spend years thinking about a
  few problems. The idea that you could think about a hard problem
  for months on end, in what he termed "hammock time", is something
  most people (myself included) just hadn't ever considered.</p>

<img src="http://p.hagelb.org/hammock.jpg" 
     alt="Stop. Hammock Time." align="left" />

<p>When I met him after the <a href="/139">Emerging Languages</a>
  conference earlier this year, he mentioned how the notion of
  linear version numbers no longer meshes with the reality of
  distributed development. On
  <a href="http://clojars.org">Clojars</a> there's a notion of
  non-canonical versions being distributed under a separate group,
  which makes Maven unable to weed out duplicates. But if they were
  kept under the same group, it would have to use version numbers to
  distinguish between the official version and the patched
  one-offs. Even in a non-forked project you have branches from
  which you may wish to publish artifacts. Being linear, version
  numbers are really not well-suited for this. They are
  lexographically sorted, which means there's no way to denote that
  <code>1.3.0-alpha3</code> may be newer
  than <code>1.3.0-par2</code>. Dependency management needs to
  accept the fact that versions branch into trees. But representing
  it as such is really only the first step; the other tricky part is
  coming up with a strategy to choose a branch and how to decide
  between different dependencies that both may request different
  branches of a third dependency. It's a juicy problem that was also
  mentioned a few times at the Conj, and it may be the kind of
  "hammock time" problem to keep in the back of my mind for a few
  months or years.</p>
include(footer.html)
