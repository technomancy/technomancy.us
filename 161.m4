dnl -*- html -*-
define(__timestamp, Wed 16 May 2012 09:07:43 AM PDT)dnl
define(__title, `in which three programming methods are compared')dnl
define(__id, 161)dnl
include(header.html)
<p>There are, roughly speaking, three ways to develop large
  user-facing programs, which we will refer to here as 0) the Unix
  way, 1) the Emacs way, and 2) the wrong way.</p>

<p>The Unix way has been expounded upon at length many times. It
  consists of many small programs which communicate by sending text
  over pipes or using the occasional signal. If you can get away
  with using this model, the simplicity and universality it offers
  is very compelling. You hook into a rich ecosystem of text-based
  processes with a long history of well-understood conventions.
  Anyone can tie into it with programs written in any language. But
  it's not well-suited for everything: sometimes the requirement of
  keeping each part of the system in its own process is too high a
  price to pay, and sometimes circumstances require a richer
  communication channel than just a stream of text.</p>

<p>This is where the Emacs way shines. A small core written in a
  low-level language implements a higher-level language in which
  most of the rest of the program is implemented. Not only does the
  higher-level language ease the development of the trickier parts
  of the program, but it also makes it much easier to implement a
  good extension system since extensions are placed on even ground
  with the original program itself. I wrote about this in an earlier
  post on the live-development model Emacs offers:</p>

<blockquote><p>If you have to use some tacked-on "plugin mechanism"
  to customize it, then you’re going to be limited at the very least
  by the imagination of the author of the plugin mechanism; only the
  things he thought you would want to do with it are doable. But if
  you’re using the exact same tools as the original authors were
  using to write the program in the first place, you can bet they
  put all their effort into making that a seamless, powerful
  experience, and you'll be able to access things on an entirely new
  level.</p>
  <p>-<a href="/115">in which a subject is attempted to be
      approached objectively, though such a thing is actually
      impossible</a></p></blockquote>

<p>It's worth noting that this is the model under which Mozilla is
  developed. The core Mozilla platform is implemented mostly in a
  gnarly mash of C++, but applications
  like Firefox and <a href="http://conkeror.org">Conkeror</a>
  are primarily written in JavaScript, as are extensions. Following
  the Emacs way accounted for Firefox's continuing popularity even
  back when it was getting trounced by competitors in terms of
  JavaScript performance. Chrome's extension mechanism is laughably
  simplistic in comparison.</p>

<p>Finally for completeness sake, the wrong way is simply to write a
  large monolithic application in a low-level language, usually C++.
  Often half-hearted attempts at extension mechanisms are bolted on
  to programs developed this way, (usually in order to check off
  another box on a features list) but they are invariably
  frustrating and primitive and don't end up offering extension
  developers the same access to program internals that the
  developers of the original program itself have.</p>

<p>The Unix way makes particularly explicit the notion of composing
  small programs, but the Emacs way shines when a single runtime
  process plays host to a number of independent programs that can
  interact with each other gracefully. For instance,
  the <a href="">Magit</a> version control interface can run in the
  same Emacs instance as a SLIME session controlling a lisp project.
  They coexist in a complimentary way and compose together without
  interference. So rather than saying there are three ways to write
  large user-facing programs, it might be more accurate to say that
  there are zero good ways to write large user-facing programs and
  two ways to compose a number of small programs into a coherent
  system.</p>

<p>This is especially interesting to me right now since it has come
  to my attention that when it was rewritten in the transition from
  version 2 to version
  3, <a href="http://blog.ometer.com/2008/08/25/embeddable-languages/">GNOME
  has switched to the second way</a> via an embedded JavaScript
  runtime, which means things are about to
  get <a href="https://github.com/technomancy/lein-gnome">very
  interesting</a>.</p>

<p><b>Update</b>: I've switched from Gnome
  to <a href="http://xmonad.org">XMonad</a> myself, but Jamie Brandon
  has <a href="https://github.com/jamii/lein-gnome">continued
    development of lein-gnome</a> in his own fork.</p>
include(footer.html)
