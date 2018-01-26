dnl -*- html -*-
define(__timestamp, 2013-04-12T08:56:45Z)dnl
define(__title, `in which everything is ephemeral')dnl
define(__id, 166)dnl
include(header.html)
<p>There's been enough written about the benefits
of <a href="http://ted.io/celebrate-remote-work.html">remote</a> 
  <a href="http://sysadvent.blogspot.com/2012/12/day-15-remote-working-right-way.html">work</a>
  that I'm not sure I can add much to it beyond anecdotes. From my
  own experience I've been a remote worker for all but a year and a
  half of my career and have loved it. The amount of time wasted by
  cars commuting is sobering, and the ability to start the day after
  simply crossing my back yard to the
  <a href="https://secure.flickr.com/photos/technomancy/tags/laboratory">code
  lab</a> is not something I'd give up lightly. Especially with
  warmer weather coming up in Seattle the draw
  of <a href="https://secure.flickr.com/photos/technomancy/tags/remoteoffice/">working
  outdoors</a> and at <a href="/156">various coffee shops</a> is
  strong indeed.</p>

<img src="/i/syme.png" align="left" alt="syme splash"
     style="margin-left: 0;" />

<p>But the thing about remote work is that it can be really
  difficult to do effectively. At my last job we were dedicated from
  the outset to making the fully-remote model work, and we were able
  to assemble a team that functioned fantastically well while
  drawing from talent all over the country. But in order to make
  this work we had to set things up so that no one operated in
  isolation. We had our daily stand-ups, but more important was
  spending the bulk of the time paired with another hacker over SSH
  and VoIP. And even when not paired, there was the understanding
  that you could easily grab someone to get a real-time review of
  whatever you were writing.</p>

<p>In order to facilitate this, we would usually set up a shared
  user on each laptop (or sometimes on an unused server sitting
  under a desk somewhere) and do the necessary port forwarding
  wrangling and public key management to ensure others could SSH in
  and join our <tt>tmux</tt> sessions. Given that it was something
  we relied on every day it wasn't particularly onerous to set things
  up, and over time the tools got a bit better.
  (<a href="http://vagrantup.com">Vagrant</a> to manage pairing VMs,
  a common repository for the team's pubkeys, etc.)</p>

<p>These days things are different&mdash;I'm at a company that
  embraces a remote/local mix of teams rather than being fully
  remote. While I've got co-workers who are happy to discuss and
  review code remotely, I can't assume everyone has spent the time
  to to facilitate remote collaboration if it's not an everyday tool
  for them. And when you're looking for another set of eyes on a
  problem, you need frictionless tools; otherwise you might not even
  bother asking for help. So I put
  together <a href="https://syme.herokuapp.com">Syme</a>.</p>

<p>Syme sets up disposable EC2 hosts for collaborating on GitHub
  projects via <tt>ssh</tt> and <tt>tmux</tt>. The idea came from a
  fantastic site called <a href="https://pair.io">pair.io</a>, which
  has since unfortunately fallen into disrepair. (There's a great
  video on their splash page explaining things if you've got a
  couple minutes.) Basically you give it the name of a project you
  want to hack on and who you want to hack on it with, and it can
  preconfigure the host by checking out a copy, adding SSH public keys
  for all invited users, and running all the necessary setup scripts
  to get dependencies and user settings installed. Then everyone
  just SSHes into the machine and joins a shared tmux session, and
  it's all yours.</p>

<p>I had access to the private alpha of pair.io, but since
  billing hadn't been implemented yet I always felt a bit guilty
  whenever I launched a machine to work on since it would just rack
  up the hours in the author's Amazon account.</p>

<p>I'd been thinking what it would take to implement that kind of
  thing myself but had been dissuaded by the idea of writing a
  billing system. Whenever you're dealing with money on behalf of
  the user it can hardly be considered a for-fun project. But then I
  realized that can be neatly sidestepped simply by prompting for
  the user's AWS credentials while launching the instances. It turns
  out keeping those around in an encrypted cookie in the browser
  makes it possible to perform further operations on the user's
  behalf without getting into the harrowing business of storing
  secrets. It also means it can be done completely as free software,
  and it's not tied to myself at all&mdash;if I lose interest and
  wander off anyone else can pick it up and deploy on their own.</p>

<p>So I've gotten it to the point where I'm pretty happy with it. At
  just a shade over 500 lines of Clojure it's quite tidy. I'm hoping
  it comes in handy streamlining things at work, but it's open for
  any remote collaborators who may find it useful in any kind
  of pairing contexts. If you run into any issues trying it out or
  have suggestions, please head over to
  the <a href="https://github.com/technomancy/syme/issues/new">GitHub
  issue tracker</a> and let me know.</p>
include(footer.html)
