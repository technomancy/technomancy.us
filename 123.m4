<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Sat 21 Mar 2009 11:12:49 PM PDT)dnl
define(__title, `in which is recounted a tale of versions')dnl
define(__id, 123)dnl
include(header.html)
<p>There are a number of ways to solve the problem of distributing
  prerelease gems in Ruby. Indicating a version is a prerelease in
  the documentation alone won't cut it; it's bound to sneak on to a
  production system and be forgotten about. Some projects simply
  don't bump the version until it's final, but this means if you try
  out a prerelease version it will replace an existing stable one,
  which is bad news. Up until recently, Rails marked them by
  counting backwards from the target, so the prerelease for 2.1.0
  was 2.0.999. This ends up being better, but it still breaks when
  another gem says it depends on any version of Rails in the 2.0
  series since 2.0.999 should be in the 2.1 series and introduces
  changes that will break gems expecting 2.0. Now Rails has changed
  strategies, saying that 2.1.0 is actually a prerelease, and that
  the first stable version would be 2.1.1. This is safer in terms of
  dependencies, but much more confusing to users; they expect 2.1.0
  to be the actual release.</p>

<img src='/i/moss.jpg' alt='moss' class='right' />

<p>So during RubyConf, I worked
  with <a href='http://alexvollmer.com'>Alex Vollmer</a>
  and <a href='http://blog.hasmanythrough.com'>Josh Susser</a> to
  <a href='/117'>fix the problem from within RubyGems</a>. The idea
  was that you should be able to mark a given version as a
  prerelease, and it wouldn't be downloaded unless someone
  specifically asked to include prereleases. This way in-development
  gems can get served without projects needing to run their own gem
  servers or rely on github; everything can be done through
  RubyForge. It also has the advantage of being much more clear;
  there's no need for each project to have their own policy on the
  matter. I've finally finished committing the new functionality to
  RubyGems trunk, so if you're interested in creating a prerelease
  gem, I'd encourage you to grab a copy of trunk and try it out:</p>

<p><kbd>$ svn co svn://rubyforge.org/var/svn/rubygems/trunk rubygems</kbd></p>
<p><kbd>$ cd rubygems && sudo ruby setup.rb</kbd></p>

<p>Once it's installed, try releasing a gem (using hoe or whatever)
  with a version with a segment that contains letters, and it will
  be considered prerelease. 2.2.0.rc1 or 1.6.5.a would work. The
  numeric segments are sorted as you'd expect, and the alphanumeric
  segments are sorted with String#sort, but prereleases always sort
  lower than releases within a version series. So 2.2.0 would be
  higher than 2.2.0.rc1 though they'd both be in the 2.2
  series. This should ease a lot of confusion in this area. As
  always, if you run into any problems,
  please <a href='http://rubyforge.org/tracker/?atid=575&group_id=126&func=browse'>report
  them on the tracker</a> since a 1.3.2 release is not far away.</p>

<img src='/i/mtns.jpg' alt='mountains' align='left' />

<p>In other news, it appears that you should be very careful when
  you <a href='http://twitter.com/technomancy/statuses/1313409184'>complain
  about how software isn't being maintained</a>. I had been keeping
  my own fork
  of <a href='http://github.com/technomancy/gitjour'>Gitjour</a>,
  which is a tool for sharing repositories over local networks when
  either your Internet connection is unreliable (like at tech
  conferences) or when you can't be bothered to host a repo
  somewhere. My fork allowed gitjour to work with Avahi and had a
  few other tweaks and had never made it back upstream, but it
  seemed like there was a lot of uncoordinated development on them
  across github forks as well.</p>

<img src='/i/instaweb.png' alt='instaweb' align='left' />

<p>Somehow my call for the maintainers to step up got turned around
  into me <i>becoming</i> the maintainer. Not exactly what I had
  expected, but I was happy to be able to help out. I ended up
  pushing out my fixes in a release as well as pulling in
  some <a href='http://github.com/alexvollmer/gitjour/commit/bd843d2aaeae4a5b721dbefd3725d5868645903c'>nice
  web-related stuff from Alex</a>. <kbd>gitjour web</kbd> will now
  throw up
  an <a href='http://www.kernel.org/pub/software/scm/git/docs/git-instaweb.html'>instaweb</a>
  instance, and <kbd>gitjour browse</kbd> will let you look through
  all the instawebs being advertised locally. So if you're headed to
  a conference at which you plan to hack any time soon, be sure to
  not leave home without a copy of gitjour. You know the <kbd>sudo
  gem install</kbd> drill.</p>

<p>Finally, there's been a recent turn of events that's left me
  without work for the present. As I've hopefully made obvious, I've
  got a pretty decent portfolio of free software contributions, but if
  you're not convinced,
  visiting <a href='/projects'>http://technomancy.us/projects</a>
  should do the trick. My <a href='/resume'>r&eacute;sum&eacute;</a>
  may also be of interest. Thanks for reading.</p>
include(footer.html)
