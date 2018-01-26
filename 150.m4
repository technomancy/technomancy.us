dnl -*- html -*-
define(__timestamp, Wed 29 Jun 2011 08:42:38 AM PDT)dnl
define(__title, `in which systems are captured')dnl
define(__id, 150)dnl
include(header.html)
<p>When working on a project, I try to take care
  that <a href="http://www.jbarnette.com/2009/09/07/boring-things-first.html">a
  dev environment can be brought up with as little fuss as
  possible</a>. This requires some discipline even with simple
  programs, but once you get into the realm of <i>systems</i>, more
  up-front effort is required for repeatability.</p>

<p>We've all been in the position of being the new hire on the
  team. On some teams you're lucky if you can get to actually
  running code on your machine in your first week. You think to
  yourself that it could surely be simplified, but once you're all
  set up there's not a lot of incentive to come back and make it
  easy for the next time.</p>

<p>It's easy enough to track language-level
  dependencies using
  <a href="http://github.com/technomancy/leiningen">Leiningen</a>,
  Rubygems, or whatever is standard for your language, but very few
  large systems end there. You almost always have further external
  dependencies that are best handled by the system-level package
  manager, be they databases, message queues, or even your language
  runtime itself.</p>

<img src="/i/pond.jpg" alt="discovery park. no reason." />

<p>I've found the best way to make sure this stuff is kept up is to
  make it the status quo. At work nearly everyone develops in a VM,
  and when a new dependency is needed, instead of everyone having to
  hunt down and install it, it just gets added to the setup
  script. This reduces redundancy as well as helping to
  eliminate <a href="http://codinghorror.typepad.com/.a/6a0120a85dcdae970b0128776ff992970c-pi">Works
  on My Machine</a> issues.</p>

<p>Recently I've found <a href="http://vagrantup.com">Vagrant</a> to
  be a really helpful tool for streamlining this process even
  further. Before I was using
  raw <a href="http://www.virtualbox.org">VirtualBox</a>, which was
  all right for launching fresh VMs, though the interface was always
  a little awkward. Vagrant streamlines this greatly, making it
  trivial to configure, suspend, and rebuild VMs. It also helps keep
  the configuration of the VM alongside the project for which it's
  meant.</p>

<p>Vagrant allows you to provision new VMs
  with <a href="http://wiki.opscode.com/display/chef/">Chef</a>. While
  this is pretty handy if you've already got recipes written, it's a
  bit intimidating as the mental model needed to operate Chef is
  quite baroque. But it's easy enough to bypass Chef and
  provide <a href="https://github.com/Seajure/emacs-clojure-vagrant/blob/master/clojure_emacs.sh">an
  arbitrary shell script</a> as a provisioner. You need to take a
  bit of care to ensure the script is idempotent as it's much more
  useful if you can re-run it whenever the dependencies change, but
  it's a great way to get started.</p>

<p>There are a few gotchas. Vagrant is rather particular about what
  version of Virtualbox (and the VBox extension pack) you use, and
  reinstalling Virtualbox only makes it confused. The OSS edition
  isn't supported, but thankfully an apt repository is
  available:</p>

<pre style="font-size: 80%;">$ sudo apt-add-repository "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -cs) contrib"
$ wget -q -O - http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc | sudo apt-key add -
$ sudo apt-get update && sudo apt-get install virtualbox-4.0
$ sudo gem install vagrant</pre>

<p>On a related note, I've had had a couple people ask what a good
  project to get started with Clojure web programming would be. The
  most widely-used Clojure web app that I know of
  is <a href="http://clojars.org">Clojars</a>, the community
  repository. But it's been pretty dormant recently; there are
  <a href="http://groups.google.com/group/clojars-maintainers/browse_thread/thread/d4149ec96316d5b1">plenty
  of great features</a> just waiting to be implemented, but getting
  it set up is hard work given all the moving parts.</p>

<p>Vagrant is perfect for smoothing this over. I've got
  a <a href="https://github.com/technomancy/clojars-web/tree/vagrant">vagrant
  branch of clojars</a> that makes it as simple as <kbd>vagrant
  up</kbd> (modulo a small issue with the nailgun scp server I'm
  still working out). So this should allow folks to contribute to
  the codebase more easily.</p>

<p>I've also helped out
  with <a href="https://github.com/Seajure/emacs-clojure-vagrant">Justin
  Lilly's Clojure/Emacs environment</a> which provides a
  fully-configured Emacs 24 install intended to help facilitate our
  <a href="http://seajure.github.com">Seajure hackfests</a>. Give
  it a try if you've had trouble configuring Emacs for Clojure
  hacking. And feel free to crib from these setups for automating
  your own projects.</p>
include(footer.html)
