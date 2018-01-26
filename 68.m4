dnl -*- html -*-
define(__timestamp, 2007-02-10T15:06:10Z)dnl
define(__title, `js invasion')dnl
define(__id, 68)dnl
include(header.html)
<p>"Firefox is a great operating system,  I just wish it had a decent
  web browser."</p>

<p>If you've been programming long enough you've probably heard the
  Emacs version of that joke. (If you've used Emacs enough,  you
  probably know that it's not actually a joke.) Like Emacs,  Firefox
  isn't really an application; it's a dynamic development platform
  disguised as an application. I suppose shouldn't be a huge
  revelation to me since people have been building apps like
  Thunderbird or Sunbird on the Mozilla platform for ages. Folks have
  even been putting together
  some <a href="http://songbirdnest.com">crazier</a>
  <a href="http://flock.com">apps</a> in XUL. But Firefox was always
  a big monolithic app written in a non-dynamic language to me.</p>

<p>Anyway,  the cause of my most recent epiphany
  is <a href="http://dev.hyperstruct.net/mozlab/wiki">Mozlab</a>. It's
  a Firefox plugin that gives you access to a
  killer <a href="http://en.wikipedia.org/wiki/REPL">REPL</a> 
  for interacting with a live Mozilla session. There's
  a <a href="http://dev.hyperstruct.net/movie/mozrepl.html">neat lil'
  flash screencast</a> that explains its usefulness better than I can
  here. The Emacs integration is also top-notch--if you've
  used <a href="http://common-lisp.net/project/slime/">SLIME</a> for
  doing Common Lisp development,  this is basically the same thing for
  XUL. You connect to a running instance of Firefox and can send it
  bits of Javascript that you are working on to evaluate.</p>

<p>All this to say:  the flexibility that Mozilla gives you (when
  coupled with the tools of MozLab) is well suited for ridiculous
  amounts of customization using Javascript alone. It really is a
  platform on which you can build apps that just happen to have access
  to one of the best rendering engines written. I've often
  <a href="http://technomancy.us/44">lamented about the lack
  of a solid browser written in one of my favorite languages</a>. At
  one point I thought the answer might be to try to get bindings to
  the Gecko rendering engine in Ruby or Lisp,  but this involves more C
  than I can stomach. The real answer here is that Firefox is written
  in Javascript,  not C,  and Javascript is dynamic enough to be
  suitable for an application-building framework like Emacs.</a>

include(footer.html)
