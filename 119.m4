dnl -*- html -*-
define(__timestamp, 2008-12-06T06:06:52Z)dnl
define(__title, `in which is revealed a rather ambitious undertaking')dnl
define(__id, 119)dnl
include(header.html)
<p>I've recently been trying to take advantage of
  the <a href='/115'>recent upswing in interest in Emacs</a> by
  working on things to help folks get started easily. I'm proud to
  announce that I'm working with the illustrious Geoffrey Grosenbach
  on a Peepcode screencast about learning Emacs and Lisp. Peepcode
  is well-known especially in the Ruby community for producing
  high-quality, hour-long, informative commercial screencasts. I'm
  doing the writing and coding for it, and Geoff will bring his
  trademark charm with voiceovers and slick recording.</p>

<img src='/i/emacs.png' alt='emacs logo' class='right' />

<p>Geoff makes it look easy, but creating a professional screencast
  is actually tons of work. I'm nearly half-way through writing the
  outline, but the outline is only the beginning. I know a lot of
  people are looking forward to this, so I'm eager to get something
  out there soon.</p>

<p>While you're waiting on me, you can take a look at my new
  project called
  the <a href='http://github.com/technomancy/emacs-starter-kit/'>Emacs
  Starter Kit</a>. It's designed to be a companion to the
  Peepcode&mdash;a set of dotfiles extracted from
  my <a href='http://github.com/technomancy/dotfiles/commits/master/.emacs.d'>years
  of obsessive Emacs tweaking</a>. It acts as a base config from
  which new users can get going with minimal fuss. You
  won't <i>learn</i> Emacs from it, but it will help you get started
  out as it provides saner defaults and bundles a lot of really
  useful functionality.</p>

<p>I've been using it as my main config for quite some time now, so
  it's got all the libraries I need. If you're interested in trying
  out with Emacs but don't know where to start, give this a shot. If
  you're an old hand but are curious to pick up some new tricks, try
  out the starter kit and let me know if it's missing some must-have
  functionality that you're used to.</p>

<p><b>Update</b>:
  Geoff <a href='http://nubyonrails.com/articles/emacs-emacs'>posted
  a short screencast</a> on getting around Emacs and his first
  impressions. It should serve as a nice teaser.</p>

<p><b>Update</b>: Please don't use the Emacs Starter Kit; the
  approach of bundling together unrelated functionality has a number
  of inherent problems, and it's much better addressed by small,
  focused packages. Check out <a
  href="https://github.com/technomancy/better-defaults">better-defaults</a>
  for a better solution.</p>
include(footer.html)
