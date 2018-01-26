dnl -*- html -*-
define(__timestamp, 2008-11-10T23:24:03Z)dnl
define(__title, `in which the rubyconf attended is the eighth')dnl
define(__id, 117)dnl
include(header.html)
<p>I'm back in Seattle after an excellent RubyConf in Orlando,
  FL. These events are always a treat, and this year's was no
  exception. <a href='/96'>Last year</a> the dominant theme was
  alternate implementations, and this time around it has become an
  ingrained assumption rather than something that needed to be
  stated. Distributed version control has also graduated to
  something that can practically be taken for granted&mdash;at least
  half the slide sets
  referenced <a href='http://github.com'>github</a>
  repositories.</p>

<a href="http://www.flickr.com/photos/technomancy/3015637388/"
   title="img_2850.jpg by Technomancy, on Flickr">
  <img src="http://farm4.static.flickr.com/3277/3015637388_fb48da9faa_m.jpg"
       width="240" height="180" alt="Omni Hotel" class='right' /></a>
       
<p>But the big theme for the year was concurrency. A number of talks
  were given on the topic of going distributed, map/reduce-type
  strategies, how to deal with threads/fibers, etc. Particularly
  interesting
  was <a href='http://pragdave.blogs.pragprog.com/pragdave/'>Dave
  Thomas's</a> keynote. To encourage new developments, he said, we
  should spin off forks of the language (not necessarily the
  implementation) where incompatible changes can be experimented
  with freely without worrying about cluttering up mainline
  Ruby. Parallelism and reducing the number of built-in (and hence
  inextensible) mechanisms were the main directions he suggested. I
  like the idea, but such a project would be able to attract more
  contributors if it were based on Rubinius instead of MRI or YARV,
  so it may be best to wait until that's closer to completion. The
  talk
  on <a href='http://www.espace.com.eg/neverblock/blog/2008/09/04/neverblock-instant-scaling-for-your-rails-apps/'>NeverBlock</a>
  was also very interesting; they seem to have a way to harness the
  benefits of an event-driven approach without the twisty execution
  flow logic that regular EventMachine requires.</p>

<p>My personal favourite talk
  was <a href='http://geeksomnia.com'>John Barnette</a>
  and <a href='http://tenderlovemaking.com'>Aaron Patterson</a>'s
  talk on <a href='http://github.com/jbarnette/johnson'>Johnson</a>,
  the Ruby/Javascript bridge. They turned the hilarity gauge way up,
  but the actual code is extremely impressive. Being able to hop
  between languages like Johnson allows could have some interesting
  implications that no one has yet thought of.</p>

<a href='http://flickr.com/photos/68498640@N00/3018641584/'><img src='http://farm4.static.flickr.com/3211/3018641584_855e4abf20_m_d.jpg'
alt='Seattle.rb' title='We will light you on fire' align='left'
/></a>

<p>As I <a href='/116'>mentioned earlier</a>, the Seattle Ruby Group
  presented a bunch of our projects near the end of the
  conference. I got to introduce Bus Scheme in ten minutes, so it
  was a very cursory look. Aaron performed a "historical
  re-enactment" of the group's history that had to be seen to be
  appreciated.</p>

<p>As usual, a lot of code was written during the conference. One of
  the things that I got to help with was the addition of support for
  prerelease versions in Rubygems. The lack of such support has been
  shown to be particularly annoying with the impending release of
  Rails 2.2, since they are using 2.2.0 as a prerelease version
  number and calling 2.2.1 their first stable 2.2 release. It'd be
  better if Rubygems allowed 2.2.0.a to be treated specially as a
  prerelease version that would be superceded by a later real
  release, and that's
  what <a href='http://blog.hasmanythrough.com'>Josh
  Susser</a>, <a href='http://blog.livollmers.net'>Alex Vollmer</a>,
  and myself worked on. I'll post more about this when it's
  complete.</p>

<p>Lots of thanks are due to the <a href='http://rubycentral.org'>
  RubyCentral team</a> who are somehow able to consistently pull off
  these amazing events. I'm also really looking forward to
  Confreaks posting the videos of the conference so I can catch the
  talks I missed; thanks guys!</a>
include(footer.html)
