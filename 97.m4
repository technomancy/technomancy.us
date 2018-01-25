<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Tue Nov 06 22:33:17 -0800 2007)dnl
define(__title, `strike force:  assemble!')dnl
define(__id, 97)dnl
include(header.html)
<p>Another highlight of the <a href='http://technomancy.us/96'>time I spent at RubyConf 07</a> was hanging out with the Ruby Emacs crew. Interestingly enough,  this included Matz himself,  who regaled us with a great historical anecdote. When he was first starting out writing Ruby,  he was coding the Emacs <code>ruby-mode.el</code> for it at the same time. He expressed some frustration with modes for other languages like Python and Pascal in which the editor could not look at a line of code and figure out where it should be indented to,  so he resolved that Ruby as a language should not fall into that particular trap. With that in mind he chose the end keyword as a block delimiter so that it would be easier to write an Emacs mode for.</p>
<p>All that to say,  Emacs and Ruby have a history that's been interconnected since the beginning. Recently I've noticed it seems that things have fallen into a state of relative disrepair. At the very least the situation could use some improvement. So the night after my talk I gathered anyone who was interested in Emacs/Ruby integration for a discussion. I was pleasantly surprised by the size of the crowd that gathered&mdash;for a while we even outnumbered the <a href='http://headius.blogspot.com/2007/11/is-werewolf-killing-conference-hackfest.html'>Werewolf</a> players. We started to put together a plan for how the state of our tools could be improved.</p>
<p>First off was the simple idea that we should actually use the mailing list that's existed for so long to communicate. The <a href='http://tech.groups.yahoo.com/group/ruby_emacs_dev/'>emacs-ruby-dev</a> mailing list sees a short flurry of traffic after every Rubyconf,  but it's silent most of the year. But we've never gotten quite this many people gathered in the interest of working together,  so I think this could very well go somewhere. I like the idea of forming a focused 'Strike Force' for getting this done. Publicising a strong group identity creates strong motivation to see the project succeed,  as evidenced by the <a href='http://rubyhitsquad.com'>Ruby Hit Squad</a>. The other big idea was to coordinate using the EmacsWiki. For a while we had a Basecamp project set up,  but it quickly died. I think the lower barrier-to-entry of a wiki is worth the chaos that's often associated with it. It's especially true in this case because the EmacsWiki is already a prominent community establishment.</p>
<p>As for the actual tasks,  a number of things were suggested: </p>
<ul> <li><b>core ruby-mode.el and friends</b> - There's a certain set of elisp that actually comes with the Ruby distribution. It's quite helpful,  but there are still a few bugs that you come across in day-to-day use,  especially with <code>ruby-electric</code> mode. This could use some work and would probably be the best starting place since improvement here helps everyone.</li>
<li><b>rails.el</b> - I was added to the developer list for <a href='http://rails-emacs.rubyforge.org'>rails.el</a> a few months ago. Unfortunately soon after I was put on a project that involved little-to-no day-to-day rails work,  so my involvement (though not my motivation) in moving this forward has been slight. I'd like to open this up to the Strike Force with the understanding that Emacs conventions should be honored and <a href='http://emacs-rails.rubyforge.org/svn/trunk/rails-cmd-proxy.el'>complexity</a> eschewed where possible. This would probably be handled by me reviewing patches as they come in,  especially as things get started. I'm pretty opinionated about what goes into my <code>~/.emacs.d</code>.</li>
<li><b>gem distribution</b> - It would be great to package up all the awesome ruby-related elisp for one easy installation. Building a gem for this would be the natural choice since Emacs-based packaging hasn't really gotten much traction and everyone who'd be interested in this would already have rubygems installed.</li>
<li><b>rhtml-mode</b> - The focus on rhtml-mode has mostly been on syntax highlighting so far. It doesn't even have that perfect yet; embedded templating languages are notoriously difficult to parse in font-lock,  but it wouldn't hurt to expand its focus to other functionality. Perhaps deriving it from nxhtml-mode would be good as this is (a) <a href='http://pluskid.lifegoo.com/?p=59'>most excellent</a> and (b) making its way into the core Emacs distribution soon IIRC.</li>
<li><b>misc fixes</b> - The <a href='http://rubyforge.org/projects/ri-emacs/'>ri-emacs tool</a> is invaluable,  but the delay upon the first invocation often discourages me from using it as often as I should. This could probably be fixed. Some have expressed a desire to fix up the <a href='http://code.google.com/p/smart-snippet/'>snippet</a> library as well. Getting these patched up,  distributing them together,  and submitting the patches back upstream would be great.</li>
<li><b>augment integration</b> - As per <a href='http://technomancy.us/96'>my last post</a>,  I've been working on a generalized system to get feedback from your code and display it back to the user in the editor. Naturally the first editor support I worked on was for Emacs. It's a bit buggy,  so improvement and new functionality is a must.</li>
<li><b>elunit</b> - What,  you didn't think we were going to be writing all this code without tests did you? Tests are discouragingly rare in Emacs Lisp Land,  but don't let that stop us. We're going to have to make <a href='http://www.emacswiki.org/cgi-bin/wiki/ElUnit'>elunit</a> rock so hard that elisp authors won't be able to help but use it. Am I making myself clear? </li>
<li><b>documentation</b> - A lot of folks who are new to Ruby get intimidated by the initial face that Emacs presents new users. Writing up tutorials and perhaps even putting together screencasts would go a long way towards easing this pain. Emacs is the original environment for writing Ruby,  but new users need a gentle introduction.</li> </ul>
<p>Anyway,  that's quite a lot of work. We talked about how to best get everyone involved,  and it looks like tracking the project with git and using a rubinius-esque open commit bit would encourage participation. If this sounds like something you'd like to be involved in,  please get on the <a href='http://tech.groups.yahoo.com/group/ruby_emacs_dev/'>mailing list</a> and make yourself heard! Even if you don't code much elisp,  there's still documentation,  feature suggestions,  testing,  and more that you can help with. Watch this space as I'm sure to report on the project as it progresses.</p>
include(footer.html)
