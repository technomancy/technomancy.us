<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, 2013-05-15T18:09:44Z)dnl
define(__title, `in which a turtle moves things forward')dnl
define(__id, 167)dnl
include(header.html)
<p>Recently on the Clojure mailing list someone
started <a href="https://groups.google.com/group/clojure/browse_thread/thread/e6feafe15b0908d4">an
interesting thread on what motivates you as a programmer</a>. My
friend <a href="http://nelsonmorris.net/">Nelson Morris</a>
responded as so:</p>

<blockquote>Contributions and projects start off well, and energy might
  wane depending on time and life factors.  Even contributing to
  tools used by many of the members of the community like [Leiningen] and
  Clojars doesn't prevent it. What helps is direct involvement by
  someone else.</blockquote>

<p>This really resonated with me because it emphasizes that people are
  more important than programs. For me sharing is the thing that
  makes programming even worth doing in the first place. So it got
  me thinking about different technologies and what kind of people
  they're good for helping.</p>

<p>If you follow my writing it will be obvious that I enjoy working
  in Emacs and Clojure. While these are among the most powerful,
  flexible technologies I know of, collaborating with others on
  tools for Emacs and Clojure basically limits me to working with
  professional programmers, because both environments are very poor
  from a beginner's perspective. If I'm working solo or on a team of
  seasoned hackers, I'll definitely be most effective with
  Clojure. If my primary goal is to interact with the widest group
  of programmers possible, I would use Ruby as it's the most
  commonly-used language I can bring myself to
  use. But if I want to reach out to people who
  don't already spend all day thinking about functions and data
  structures, well that's another thing entirely.</p>

<p>This is particularly relevant for me personally as a father. I'm
  taking an active role in the education of my sons, and of course I
  think technical literacy must be an important part of it. But when you
  look at how computers used in traditional educational settings,
  you're much more likely to see computers programming children than
  children programming computers. So I've been looking for ways to
  foster technical skills and encourage algorithmic thinking in
  engaging ways that can keep the attention of my five-year-old.</p>

<img src="/i/scratch.jpg" alt="scratch" align="left" style="margin-left: 0" />

<p>In the
  book <a href="http://www.amazon.com/Mindstorms-Children-Computers-Powerful-Ideas/dp/0465046746">Mindstorms</a>,
  Seymour Papert describes the shift from concrete reasoning to
  formal reasoning as one of the main transitions children undergo
  as they learn to think like adults. One of the design goals of the
  Logo system he created was to provide transitional concepts to
  bridge the gap between the two.</p>

<p>Children interact with Logo by giving commands to an onscreen
  object known as
  the <a href="https://en.wikipedia.org/wiki/Turtle_graphics">turtle</a>.
  While the turtle lives in the abstract world of geometry comprised
  of points and lines, children are able to identify with it since
  they tell it to move in ways which they can relate to&mdash;it has
  a heading and position, and it turns and moves forward and
  backwards just like they do. Because the turtle's movements on the
  screen are isomorphic to their own physical movements, it gives
  them a model to help them grasp abstract geometrical concepts
  though they're only used to thinking in concrete terms. And
  <a href="https://en.wikipedia.org/wiki/Jean_Piaget#Education:_Teaching_and_Learning">Piagetian
  learning</a>&mdash;ambient, natural learning which children are so
  adept at doing without study&mdash;is all a matter of building
  models of the world.</p>

<p>Most people know Logo from its original triangle-turtle-centric
  incarnation, but in Mindstorms Papert describes Logo as more of an
  educational philosophy than any single program, language, or
  implementation. A more recent version of Logo
  is <a href="http://scratch.mit.edu/">Scratch</a>, a drag-and-drop
  visual programming environment from MIT's Media Lab targeting
  school children. Since my older son is an early reader he's been
  able to construct simple scripts (with some guidance) for the
  characters within Scratch, watching them interact with each other
  and even in some
  cases <a href="https://www.youtube.com/watch?v=vVRIryCOA50">the
  outside world</a>.</p>

<p>While it's been lots of fun to come up with ideas and talk
  through how we'd bring them to life on the screen, one of the most
  rewarding parts is watching his problem-solving abilities
  develop. Papert talks about how children are often afraid to try
  things for fear of failure, but Scratch teaches that debugging is
  a normal part of making things work. Rather than "does it work?",
  the question becomes "how can we make it work?" This was
  demonstrated the other day (outside the context of Scratch) when
  he was putting together
  some <a href="http://snapcircuits.net/">Snap Circuits</a>:</p>

  <iframe width="560" height="315" 
          src="http://www.youtube-nocookie.com/embed/hBsegnCBhtw?rel=0" 
          frameborder="0" allowfullscreen></iframe>

<p>Of course the goal is not to produce "little programmers". It's
  primarily about developing the ability to think systematically,
  but it extends beyond that into getting them thinking about
  thinking itself. In some sense once they're in the habit of asking
  the right epistemological questions, the parent or teacher almost
  just needs to get out of the way and let them explore. At that
  point the process of discovering a topic <i>with</i> someone is
  much more rewarding than telling facts <i>at</i> them.</p>
include(footer.html)
