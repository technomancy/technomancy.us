dnl -*- html -*-
define(__timestamp, 2008-03-14T22:04:56Z)dnl
define(__title, `in which a newly shaven yak is presented')dnl
define(__id, 106)dnl
include(header.html)
<p><b>Update</b>: Not really sure what I was thinking here. Sorry.</p>
<p>So it turns out I find myself installing on fresh systems an awful lot. I'm tempted by <a href='http://www.ubuntu.com/testing/hardy/alpha6'>Alpha Ubuntu releases</a> even when I know I should probably just wait an extra month for the final release. With these releases happening every six months, I've got the reinstall process down to an exact science. Some of it is pretty obvious&mdash;I've been <a href='http://git.caboo.se/?p=technomancy.git;a=tree'>keeping my dotfiles in version control</a> since 2005, which mitigates a lot of pain. Then there's the  <a href='http://git.caboo.se/?p=technomancy.git;a=tree;f=bin/init'>init scripts</a> I've written for getting my regular set of apt-get and gem packages installed.</p>
<p>This was pretty handy for as much as it did. I could get a decent system up and running with about seven commands from a fresh install. But it left a bit to be desired for a few programs. For instance, I've basically got to have the latest version of GNU Emacs. Call it an addiction, but packaged versions get old quickly. The version of git that comes with Ubuntu 7.10 is a bit old and doesn't have the <kbd>stash</kbd> command, which is six kinds of useful. The latest GNU Screen from CVS has an excellent vertical-split feature that Emacs has gotten me so accustomed to. And what setup is complete without Rubinius, which hasn't even made it into any package management system? The list goes on...</p>
<a href='http://achewood.com/index.php?date=01162004'><img src='/i/roastbeef.png' alt='roast beef' class='right' /></a>
<p>So here we have a bit of a situation. I could add lines to my init script that check out each individual source tree. But each one has a slightly different installation process. GNU Emacs has you run <kbd>make bootstrap</kbd> in between the configure and make commands. Screen makes you cd into a <kbd>src</kbd> directory before you can configure. Who has time to remember all this? And then the biggest problem with installing stuff from source is that there's no automated way to get the latest version of the programs you have installed.</p>
<p>So I know it wasn't really a burning need, but I put together a tool to help the situation.</p>
<blockquote>uh ok so roast beef is some kind of package manager that is for bleeding-edge programs. so basically it does not have its own repositories. instead it just will download source from the upstream repository and will do all the necessary steps to install. you get things that are as fresh as possible. i am talking about really <a href='http://www.achewood.com/index.php?date=05082002'>fresh like your eggs and milk</a>.</blockquote>
<p><a href='http://roastbeef.rubyforge.org'>Roast Beef</a> is named after a character in the splendid  <a href='http://achewood.com'>Achewood</a> comic strip. All documentation, comments, and output text is written in his voice. He also has <a href='http://rbeef.blogspot.com'>a blog</a>.</p>
<p>To get started: <kbd>sudo gem install roastbeef</kbd>.</p>
<p><b>Usage:</b></p>
<ul> <li>roastbeef install package</li> <li>roastbeef update</li> <li>roastbeef upgrade</li> <li>roastbeef remove package</li> <li>roastbeef show package</li> <li>roastbeef search term</li> </ul>
<p><b>Caveats:</b></p>
<ul> <li>We're talking about code that installs bleeding-edge software, so expect breakage. I haven't figured out a good way to run automated tests for it, so I'm not as confident about the reliability of the code, even though it is fairly few lines of code. (currently around 170 with a flog score of 245.)</li>
<li>Some packages have a hefty amount of prerequisites. Right now these get installed via apt-get if the sources list gives enough details about them. I would like to have it use macports, portage, yum, and other dependency tracking systems on other OSes, but I don't have the resources or inclination to do this. Patches welcome.</li>
<li>There aren't many packages in the <a href='http://github.com/technomancy/roast-beef/tree/master/sources.yml'>source listing</a> yet. Feel free to contribute metadata about your favourite programs that you like to install from source.</li>
<li>A lot of packages don't have any automatic removal process when they get installed from source. Right now roastbeef will warn you about such packages, but it's no fun to have to have to remove a program by hand.</li>
<li>It's entirely possible this kind of tool is useful only to me; not everyone installs as much crazy crap as I do. If that's the case please ignore this; I'm really OK with that.</li> </ul>
<p>If it sounds interesting to you, <a href='http://github.com/technomancy/roast-beef/tree/master'>fork it on github</a>. I've still got some invites if anyone wants to contribute.</p>
include(footer.html)