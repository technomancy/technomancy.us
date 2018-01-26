dnl -*- html -*-
define(__timestamp, 2012-07-01T04:43:18Z)dnl
define(__title, `in which the facts are laid out concerning swarm coding')dnl
define(__id, 162)dnl
include(header.html)
<p>I've found that user groups often fall into a pattern of lecture
  style presentations with slide shows. Since it's usually difficult
  to find presenters, often it ends up that after a while whoever
  founded the group speaks repeatedly. This leads to burn-out and
  isn't sustainable even if you're fortunate enough to have
  presenters who are skilled public speakers. It's also simply not a
  very good way to learn; your mind is a lot more involved in a when
  engaged in active discussion.</p>

<p>This is why at the <a href="http://seajure.github.com">Seattle
  Clojure group</a> we follow a different model that focuses on code
  and participation. A few months ago at
  the <a href="http://clojurewest.org">ClojureWest conference</a> I
  gave
  a <a href="https://github.com/strangeloop/clojurewest2012-slides/raw/master/Hagelberg-SwarmCoding.pdf">short
  talk</a> (PDF) explaining the motivation behind this style. I call
  it "swarm coding".</p>

<img src="i/athens.jpg" alt="school at athens" class="right" />

<p>The Socratic Method is a form of learning that centers around
  getting people to ask the right questions rather than just
  telling. It's often used in group settings with classical
  education methods, and I've found it's a great way to run a user
  group meeting as well. If you can get everyone hooked in to
  participate in a shared editor session and come up with an idea
  for a small project, you can collaborate in a unique, engaging way
  and learn a lot.</p>

<p>We've found SSH, tmux, and Emacs to be a great combination for
  this. The host prepares his machine with a new user created just
  for the purpose of swarming, and everyone is given the username,
  hostname, and password to log in over SSH.</p>

<p>
  <kbd>$ ssh swarm@zuse.local</kbd><br />
  <kbd>$ tmux attach</kbd>
</p>

<p>Once logged in, running <kbd>tmux attach</kbd> allows a user to
  join an in-process session started by the host, and control can be
  passed around as discussion progresses. If someone has an idea for
  how to address a certain problem, they can just try it out
  straight away. While there are more complicated setups that can
  allow for each user to edit independently, we've found that is
  usually not what you want. If you have a discussion going on, you
  want a single point to focus on. It's really hard to track what's
  happening if you have multiple independent edits happening
  simultaneously.</p>

<p>Usually skill levels vary widely in group settings like this, so
  it's important for the facilitator to be able to gauge them,
  usually by just getting quick introductions from everyone in the
  group beforehand. The temptation is often for those that really
  know their way around to just power through and write some
  slick code, perhaps pausing to explain a particularly subtle
  technique. It's more rewarding to let control pass around the
  group and try to keep everyone involved, but it can be
  difficult.</p>

<p>It's probably a good idea to dedicate a meeting to a tooling
  workshop at first to get people started. Especially with Clojure
  the initial setup can be intimidating, so the newcomers find
  it valuable to get help just getting the basics working on their
  laptops. While I don't recommend newcomers try to learn Emacs as
  their main editor at the same time as picking up a new
  language, it really makes collaboration over SSH much easier, so
  basic familiarity is helpful.</p>

<p>I've coded
  up <a href="https://github.com/technomancy/swarming">some
  scripts</a> to automate setup of swarming sessions. It handles
  getting basic dotfiles in place and provides instructions for how
  to join a session when people log in. Right now it only supports
  Clojure, Leiningen, and Emacs, but there's no reason it couldn't
  be extended for Vim or other languages.</p>

<p><b>Update</b>: I
  have <a href="https://syme.herokuapp.com">another project called
    Syme</a> which handles setting up pair/swarm nodes on EC2. In
  most cases this is a lot simpler than running the tmux session on
  your own machine, though it may not always be feasible depending
  on the quality of the network.</p>

<p>There are a few things to watch for here. First of all, we've
  only tried this with groups of up to 12 participants. Group
  dynamics break down when things get larger, so you may want to
  split up into groups. You could try splitting a project into
  independent parts that could be coded by each group if your
  project divides naturally this way, or you could try both tackling
  the same problem and comparing solutions at the end.</p>

<p>Picking a project to try is also tricky. You want it to be
  somewhat useful and not contrived, but you also need it to match
  the skill level of the group and still be able to make progress on
  it in a couple hours. It's a lot of fun if you end up with a
  project you can publish to Clojars or Heroku at the end.</p>

<p>Happy Hacking!</p>
include(footer.html)
