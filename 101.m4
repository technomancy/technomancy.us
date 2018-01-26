dnl -*- html -*-
define(__timestamp, 2008-01-06T19:49:21Z)dnl
define(__title, `in which the blog undergoes an octo-redux')dnl
define(__id, 101)dnl
include(header.html)

<blockquote><p>I know lots of perfectly decent and honorable people
connect databases to websites at runtime,  and many of them go on to
have happy and useful lives,  in fact some of my best friends use
runtime databases (but my new daughter isn't going to marry one
of <i>them</i>).</p>
<p>&mdash;<a href='http://www.tbray.org/ongoing/When/200x/2006/07/10/Gone-Camping'>Tim Bray</a></p></blockquote>
<p>You may (or may not) have noticed that the new comment submission form disappeared. I just re-implemented the software that runs my blog (for the eighth time,  once in raw unmanaged HTML,  twice in PHP (University days; don't ask),  twice in Rails,  once in Common Lisp,  and once in Javascript). I know this is starting to sound like the kind of <a  href='http://philisha.net/2003/11/New-setup/'>lame meta-blogging self-indulgence</a> that always makes me quickly mentally check out,  so I'll try to avoid that if you will <a href='http://xkcd.com/365/'>bear with me for a moment</a>.</p>
<p>A lot of the stuff I've been doing at work has been focusing on dropping layers of architecture and simplifying services to the point where it's mostly just sending out static files. When you get into this mindset,  the idea of hooking something as simple as a blog up to a relational database at runtime starts to seem pretty silly. Serious overkill,  if you will. So I ported over the <a href='/85'>Helma app</a> that had been running technomancy.us since last May over to a 70-line Rake file that deploys with a simple rsync.</p>
<p>It used to be that when people would ask what Rails blogging software to use,  I would tell them to write their own rather than use <a href='http://mephistoblog.com'>Mephisto</a> or Typo,  not because I don't like them (well,  OK,  maybe I don't like Typo&mdash;personal grudge from the pain it's caused me) but because it's a simple project that teaches you a lot about the interesting parts of Rails. Actually,  I would probably still recommend that to someone who needs to get familiar with Rails,  but then once they'd been using Rails for a while I would consider it a good idea to challenge them as to whether they really think what they wrote was the best tool for the job.</p>
<p> I'm not saying that everyone who is using a hand-rolled Rails blog should rewrite it to use static files,  (it's not a hard task,  but the payoff: effort ratio turns out to be fairly low) but it is a useful exercise in simplicity for someone with a few hours to kill. It's easy to get caught up in the excitement of new tools,  but learning when you need to step back and re-evaluate the appropriateness of a tool that you enjoy using and know well is not a common skill.</p>
<p>A few of the advantages of the static approach I've noticed: </p> <ul> <li>Deploying on Dreamhost without tearing hair out over FastCGI</li> <li>Trivially applying version control to posts</li> <li>Saving memory on localhost when running it there to make modifications</li> <li>Writing posts in the editor of choice without resorting to <a href='http://savannah.nongnu.org/projects/emacsweblogs'> blogging extensions</a></li> <li>Depending on far fewer libraries</li> </ul>
<p>Anyway,  that's what's been on my mind. Nothing earth-shattering. Comment submission should be on the way once I get a moment to sit down and spend a bit of quality time with CGI.rb. <b>Update</b>: Comments working.</p>
include(footer.html)
