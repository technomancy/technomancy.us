dnl -*- html -*-
define(__timestamp, Sat Oct 13 00: 00: 01 -0700 2007)dnl
define(__title, `turtle power')dnl
define(__id, 81)dnl
include(header.html)
<p><a href='http://myconfplan.com/conferences/RailsConf2007'>Railsconf</a>
  is a go. The first day is just wrapping up,  and I've finally got
  some downtime. First impressions:  Portland is a great place for a
  conference. There's green everywhere,  and being within the free ride
  zone for the transit system is quite handy. Having
  <a href='http://www.powells.com/technicalbooks'>Powell's Technical
  Books</a> around is an &uuml;bergeek joy. To top it off,  there's
  municipal wireless that would be easily up for the task of handling
  a tech crowd of the size of any previous Ruby-related
  conference. Unfortunately,  we've got more than twice as many
  attendees here than any previous conference,  so that part of the
  equation isn't holding up quite so well.</p>

<p>Speaking of... the crowd. It really is quite a sight. If you
  thought last year's RailsConf was big,  that seems like a warm-up in
  comparison. I've heard estimates from 1200 to 1600&mdash;It's
  staggering. In some sense,  it's a coming-of-age for Rails; this is
  approaching OSCON in size. But it's also a reminder that the heady
  days of <a href='/8'>RubyConf 05</a> are long gone. It's an
  unavoidable side-effect of success,  but losing the tightly-knit
  erudite community that so felt cutting-edge and pioneering is a
  shame. But it's probably worth it as the price of having more
  people share in the fun.</p>

<img src='/i/avi.jpg' alt='avi bryant' title='turtles and web heresies' />

<p>Tonight's keynotes were
  from <a href='http://smallthought.com/avi/'>Avi Bryant</a>
  and <a href='http://zefrank.com'>Ze Frank</a>. Ze had an immensely
  fun talk about how audiences contribute and how the Web is
  accelerating that kind of thing. He's funny as the dickens,  but it
  turns out he's got a sharp technical mind. Avi's talk was probably
  the most thought-provoking thing I've heard in a while. He talked
  about how there's no reason Ruby can't be
  totally <a href='http://en.wikipedia.org/wiki/Self-hosting'>self-hosting</a>.
  Having core classes like Array and Hash implemented in C is
  currently necessary from a performance point of view,  but it causes
  annoyances when you want to peek behind the curtain.</p>

<p>Avi agreed that for Rails web applications,  performance is usually
  not directly very important&mdash;if you've got enough users to feel
  performance pains,  you're likely to have enough money to deal with
  it. (If you don't,  I imagine the problems with your revenue plan are
  likely to be more pressing than your technical problems.) The thing
  is,  performance <i>indirectly</i> affects your app in a huge way:  it
  limits
  the <a href='http://blog.caboo.se/articles/2007/4/8/heresy-and-turtles-all-the-way-down-with-avi-bryant'>Turtle
  Factor</a>.</p>
<img src='/i/turtles1.png' alt='low turtle factor' align='left' />
       
<p>"Turtles all the way down" refers to how much of the language is
  accessible from within the language itself. We're talking about
  reflection,  metaprogramming,  and being able to redefine things on
  the fly&mdash;all the hallmarks of dynamicity.</p>

<p>The current Ruby implementation (MRI) is good for a Unixy language, 
  but it could be better. But when you run into stuff written in C, 
  (altering the behaviour of Arrays,  for instance) the Turtle Factor
  hits a bit of trouble: </p>

<img src='/i/shredder.gif' alt='shredder' class='right' />

<p>Ideally,  Ruby would give programs access (in Ruby) to every level
  of the language,  which would be much easier to do (according to Avi)
  on a Smalltalk VM. One problem I ran into that this would solve is
  that you can't specify how identity should be calculated when
  storing things in a Hash. Occasionally I've found myself wanting to
  override the default behaviour for certain objects that should be
  treated differently,  which is easy in (say) Lisp.</p>

<img src='/i/turtles2.jpg' alt='high turtle factor' align='left' />

<p>It sounds like the low turtle factor of MRI Ruby is necessary in
  order to achieve decent performance in the current implementation, 
  but apparently investment in a Smalltalk VM would leave turtle
  factor much improved. Ruby could join the likes of the classic
  self-hosting dynamic languages that have had decades to work on this
  kind of thing. The exciting thing is that Rubinius is already
  working in this direction; taking cues from the design of Smalltalk
  if not porting to it outright. Can't wait to see where all this heads.</p>

<hr />

<p>On an unrelated note,  I've just ported my blog over to a new
  platform. I'll be posting more on that later,  but in the mean time
  please excuse the mess; many key features (tags,  feeds,  comment
  formatting) haven't been implemented yet.</p>

<p>Teenage Mutant Ninja Turtles is a trademark of Mirage Studios,  Inc.</p>

include(footer.html)
