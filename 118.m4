dnl -*- html -*-
define(__timestamp, Thu Nov 27 11:10:32 2008)dnl
define(__title, `in which a hypothetical death occurs in order that a real one may be avoided')dnl
define(__id, 118)dnl
include(header.html)
<p>Say you're writing some Ruby code, and you come across a library
  that deserves consideration. It looks like it might come in handy,
  but you're not sure if it justifies the additional complexity it
  brings with it. You're wondering how heavy-weight it is.</p>

<p>When pondering such things, it can be helpful to come at it from
  a tactile perspective. Sure, there are tools
  like <a href='http://ruby.sadi.st/Flog.html'>flog</a>
  and <a href='http://saikuro.rubyforge.org'>saikuro</a> that can
  give you all kinds of numbers about a piece of code, but sometimes
  you just want to know, "What would this code be like if I printed
  it all out and picked it up?" You can imagine the smell of freshly
  printed pages and think to yourself, "How would it feel to heft it
  from hand to hand?" or "Would I be able to bludgeon someone to
  death with it?"</p>

<p>I can't help you with the first two questions, but I wrote a library
  specially designed to answer the last:</p>

<blockquote><a href='http://github.com/technomancy/bludgeon'>Bludgeon</a>
  is a tool which will tell you if a given library is so large that
  you could bludgeon someone to death with a printout of
  it.</blockquote>

<p>Usage is simple:</p>

<pre>$ bludgeon git://github.com/dchelimsky/rspec.git
== rspec (git://github.com/dchelimsky/rspec.git)
  Lines: 38698
  Pages: 773
You could bludgeon someone to death with a printout.</pre>

<p>It's just a <kbd>sudo gem install bludgeon</kbd> away. I'm not
  saying you should never use a library that's big enough to be
  deadly; I'm just saying you should <i>know</i>.</p>
include(footer.html)
