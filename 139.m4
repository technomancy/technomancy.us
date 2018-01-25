<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Sat 24 Jul 2010 10:45:24 PM PDT)dnl
define(__title, `in which we watch while a veritable tower of babel is constructed')dnl
define(__id, 139)dnl
include(header.html)
<p>This week I was lucky enough to attend
  the <a href="http://emerginglangs.com">Emerging Languages</a>
  conference, a special event nestled snugly in a corner of
  O'Reilly's
  <a href="http://oscon.com">OSCON</a> open source
  conference. Emerging Languages brought together language designers
  and implementors together to share the things that made their
  languages unique and to cross-pollinate ideas.</p>

<img src="/i/pod-power.jpg" alt="Rich Hickey on Pods" />

<p>The presentations
    covered <a href="http://p.hagelb.org/emerginglangs.org.html">a
    wide variety of languages</a>. The talk on Go was interesting in
    that it wasn't so much about Go as about the historical heritage
    of Go and the languages that led to it. A lot of the interesting
    ideas there came out of Tony
    Hoare's <a href="http://www.usingcsp.com/">Communicating
    Sequential Processes</a> paper, which looks fascinating. The
    talk
    on <a href="http://futureboy.homeip.net/frinkdocs/">Frink</a>
    was a delightful romp through the esoteric and very <i>human</i>
    world of unit calculation, though the licensing issues
    surrounding that language rule it out for most uses. It's been a
    while since I've done web work, but the talk
    on <a href="http://jashkenas.github.com/coffee-script/">CoffeeScript</a>
    made me hope that I never have to write another line of
    Javascript. I also got to see Charlie present
    on <a href="http://mirah.org">Mirah</a>, formerly Duby, which
    I've <a href="/134">posted about before</a>: a language that
    gives you low-level bytecode-equivalent output to Java but
    reduces the pain/verbosity by offering a more reasonable syntax
    and type inference.</p>

<p>The second day started off strong with an engaging demo of the visual
  <a href="http://research.microsoft.com/en-us/projects/kodu/">Kodu</a>
  language. It's unique in that it's designed to run on XBox
  consoles and can be programmed entirely through the controller by
  manipulating icons. Once again there are licensing issues and it
  won't run on anything but Windows or an XBox, but in this case the
  developers are actively working towards remedying the
  problem. They have clearly put a lot of thought and research into
  keeping it engaging especially for kids.</p>

<p>After this Rich Hickey presented on
  a <a href="http://clojure.org">Clojure</a> feature tentatively
  called Pods, which are the new name for an experiment he had
  discussed much earlier called cells. The gist is that
  while <a href="/132">transients</a> can be a boon to performance,
  they introduce mutability (albeit very constrained mutability)
  outside the reference model. Pods separate out a very clear
  reference policy where you're always dealing with persistent
  values coming in and out, and the change happens isolated inside
  the pod. (I posted a link to the above photo in the Clojure IRC
  channel, which caused it to erupt in cries of "what are pods?"
  and "where's the documentation for this?"&mdash;a reminder that
  there are many Clojurians who feel the need to constantly stay
  abreast of every latest change no matter how recent.)</p>

<p>Another highlight of the second day was the talk
  on <a href="http://factorcode.org">Factor</a>, a modern cousin to
  Forth with an excellent compiler and nice tooling. Factor's been
  on my radar for a while since stack-based languages really sound
  like an interesting twist to language design, and everything I
  read about their compiler seems to indicate it's very cutting-edge
  and well-designed. Factor was also the only language presented I
  want to learn that isn't hosted on an existing VM. The demo
  focused on showing some the ways that Factor retains an
  astonishing amount of flexibility and dynamicity even though it
  compiles to very fast machine code. The Emacs
  integration <a href="http://factor-language.blogspot.com/2009/01/screencast-editing-factor-code-with.html">via
  FUEL</a> also impressed me.</p>

<p>There
  were <a href="http://olabini.com/blog/tag/emerging-languages/">many,
  many more languages</a> presented; they came at such a rate that if
  you blinked you'd look up to see the presentation half-through
  already. On the whole this was helpful since it forced presenters
  to focus on a "hook" or two to get you interested enough to dig
  deeper rather than give an overview of features which could easily
  be read from a web site, but such a wild ride left everyone with a
  minor case of mental whiplash.</p>

<p>It's been a while since I've attended an event that showcased this
  level of energy. I hope to look forward to attending Emerging
  Languages 2011.</p>
include(footer.html)
