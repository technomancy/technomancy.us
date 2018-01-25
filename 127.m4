<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Sat 06 Jun 2009 10:27:32 PM PDT)dnl
define(__title, `in which a brotherhood gathers')dnl
define(__id, 127)dnl
include(header.html)
<p>This week I had the good fortune to be in San Francisco
  for <a href='http://www.meetup.com/The-Bay-Area-Clojure-User-Group/calendar/10417495/'>a
  meeting of the Bay Area Clojure Meetup</a>. This meeting was a
  special event since Clojure's creator, Rich Hickey, was in town
  for the big JavaOne conference. We ended up packing out the room
  with sixty people, which made it probably the largest gathering of
  Clojure programmers ever.</p>

<p>The meeting began with a handful of so-called "lightning talks"
  (of various lengths) on all sorts of topics. A few highlights were
  Amit
  Rathore's <a href='http://s-expressions.com/2009/05/02/startup-logbook-distributed-clojure-system-in-production-v02/'>Swarmiji</a>
  clustering library and George Jahad's talk
  on <a href='http://georgejahad.com/clojure/cljdb.html'>decompiling
  Clojure with jdb</a>, which showed tools to get a new perspective
  on how your code gets compiled.</p>

<p>After these Rich gave a talk on the recent work he's been doing
  on chunked sequences. Basically when a seq wraps a vector or
  vector-like collection, rather than every first/rest invocation
  breaking the vector down piece by piece, the seq can break a chunk
  of the vector off to work on all at once and keep its own internal
  counter that points to the current position in the chunk. The
  motivation here was that while you generally can rely on the seq
  abstraction to map over each element in a vector in a functional
  manner, sometimes performance concerns force you to use a more
  imperative-style loop instead. With the chunking in place, the map
  approach is even faster than the less-idiomatic loop, so
  there's one fewer reason to stray from the functional
  approach. It's really encouraging to see that Rich is making this
  a priority&mdash;he wants to make sure that you never get
  penalized for doing things the elegant way.</p>

<p>After this Rich hosted a Q&amp;A session, from which two main
  points stuck in my mind. He mentioned that before the 1.0 release,
  he <a href='http://groups.google.com/group/clojure/browse_thread/thread/2ee2b28e9dd3516b/b09cdc226c95383a'>asked
  what people thought would be a good set of short-term goals for
  the project</a>, to which the response was overwhelmingly "move
  off SVN to git". Since the project was still fresh of a jump from
  SourceForge to Google Code, he was reluctant at first, but he
  seems to have been convinced that the distributed approach is
  what's best for the community. He promised us that the move will
  happen. He's
  currently <a href='http://github.com/richhickey'>experimenting
  with GitHub</a> and making sure for himself that tool support is
  good enough.</p>

<p>The other question of particular interest
  was <a href='http://blog.objectmentor.com/articles/2009/06/05/rich-hickey-on-testing'>that
  of tests</a>. Rich doesn't write tests for Clojure. The community
  has contributed a test suite, but it's kept in a separate
  repository and doesn't offer full coverage. Rich's opinion is that
  tests are for finding bugs, and that he is able to avoid bugs by
  reasoning out the problem up front, so it's not a wise use of his
  time for him to write his own tests, though he does appreciate and
  run the community-provided suite. This made me very nervous at
  first, but the next day I read
  <a href='http://web.mac.com/ben_moseley/frp/paper-v1_01.pdf'>Out
    of the Tarpit</a> [PDF], a paper he recommended at the meeting.
    The paper makes a strong case for informal reasoning being a
    suitable substitute for test cases in codebases that exhibit
    referential transparency. While I still prefer TDD for its help
    in the design phase of coding, I'm much more ready to accept the
    notion that thinking through the problem up front and verifying
    it with manual tests is actually a feasible approach to getting
    working code in functional languages, though of course in
    situations where mutability is the norm it leads to disastrous
    results.</p>

<p><b>Update</b>: <a href='http://tomfaulhaber.blip.tv'>Videos</a>
  are up! (Unfortunately flash-only; sorry!)</p>

include(footer.html)
