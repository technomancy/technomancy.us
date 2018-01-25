<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Sat Oct 13 00: 00: 01 -0700 2007)dnl
define(__title, `vannevar')dnl
define(__id, 74)dnl
include(header.html)
<p>So I finally replaced
my <a href="http://philisha.net/articles/2005/01/20/high-living">aging
laptop</a> with something a bit more up-to-date:  a Core 2 Duo Thinkpad
T60p. I'm really happy with it; it's definitely got that <i>solid</i>
feeling to it for which Thinkpads are famous. I'm pretty sure it's the
most sturdily-constructed laptop I've used. Even the Trackpoint device
is a pleasure to use. If you've hated Trackpoints on other laptops, 
the Thinkpad version is much more comfortable,  and being able to move
the pointer without leaving the home row is a big usability win.</p>

<p>The only disappointment I've noticed so far is the graphics card;
it's an ATI FireGL V5250 for which no Free drivers are available. If I
had known I'd have to use the binary fglrx drivers, I would have
gotten another configuration&mdash;the ATI drivers are kind of lame
compared to the Free drivers that work for other cards. They work
better for 3D effects, but they don't work with AIGLX
and <a href="http://beryl-project.org">Beryl</a>, which is the only 3D
stuff I would actually be marginally interested in using. I've also
heard that the binary driver can cause major issues with hibernation,
but I haven't really tried that much; suspend seems to be fine. Next
time I'm getting an Intel card if at all possible.</p>

<img src="/i/t60p.png" alt="thinkpad t60p"
title="vannevar" style="border:  0" align="left" />

<p>The resolution (1600x1200) is ridiculously sharp,  which is the main
reason I chose the Thinkpad over the similarly-priced Macbook Pro. It
has 2.3 times as many pixels as my last laptop. It's also got a
nifty <a href="http://thinkfinger.sf.net">fingerprint reader</a> that
you can plug into <acronym title="Pluggable Authentication
Modules">PAM</acronym> and use to authorize yourself with any regular
Unixy programs. Pretty cool. I was a bit worried about the extra
weight,  (~2.5 kg vs the 1.5 of my old Dell) but it turns out I don't
tote it around nearly as much as I used to when I got my Dell,  being
in university at the time,  so the weight doesn't bother me.</p>

<p>The other issue is that the folks at Adobe don't have a Flash
player that works on 64-bit Linux systems,  so I can't watch YouTube. I
was already on the edge about whether I should bother with installing
Flash on this machine,  so this made that decision easier. All in all
I'd consider not having Flash a blessing in disguise,  and it's not
even a very convincing disguise. Maybe once <a href="http://www.gnu.org/software/gnash/">Gnash</a> gets more polished
things will change. (Or if Adobe gets a clue,  but I'm not holding my
breath.)</p>

<p>I decided to go ahead and try out Ubuntu "Fiesty Fawn" 7.04. It's a
bit rough around the edges as it always is with prereleases that are
still a few months away from primetime,  but it's definitely stable and
usable enough for my daily work. All the hardware was detected fine
with the exception of the video card&mdash;since it's nonfree it
required an extra step to get working&mdash;and the fingerprint
reader,  for which I had to compile the driver manually. (This was very
easy to do.) By default it uses the vesa video drivers which work for
display but are quite slow. I'm going to hold off on <kbd>apt-get
upgrade</kbd>ing frequently just because that can be a recipe for
disaster when you've got a lot of work to do. For my own use I
kept <a
href="http://dev.technomancy.us/phil/wiki/UbuntuInstallation">notes on
the installation process</a> so I remember all the steps in the
future; perhaps that would come in handy for others.</p>

<p>The real news is that this frees up my old laptop for
a <a href="http://dev.technomancy.us/phil/wiki/NorbertRobot">career in
robotics</a>. Once I get a chance to research UARTs and pick up the proper
chips,  I should be able to get that project rolling again.</p>

include(footer.html)
