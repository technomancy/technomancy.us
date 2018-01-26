dnl -*- html -*-
define(__timestamp, 2008-03-02T22:11:01Z)dnl
define(__title, `in which the benefits of contribution are discussed')dnl
define(__id, 105)dnl
include(header.html)
<p>Well, it seems now that <a href='http://tomayko.com/weblog/2008/02/26/github-is-myspace-for-hackers'>everyone</a> <a href='http://daniel.collectiveidea.com/blog/2008/2/9/on-git-github'>is</a> <a href='http://www.robbyonrails.com/articles/2008/03/01/launch-your-own-rubyurl'>blogging</a> <a href='http://log.emmanuelebassi.net/archives/2008/03/the-laws-have-changed/'>about</a> <a href='http://github.com'>Github</a>. I was originally a bit reluctant to come forth singing its praises since it's clearly not free software... I didn't want to convince my friends to do the work of moving their projects over to this new still-in-private-beta site when there was really no guarantee that the system would continue to be appropriate for them in the future. A number of things have since caused my concerns to abate:</p>
<p>Firstly, Chris and Tom are fairly high-profile in the Ruby community. They've got a reputation to maintain, so I think they'll do all they can to make their service work well. Since Chris does <a href='http://errfree.com'>consulting work</a>, having a reputation for delivering awesome software is great for business.</p>
<p>But even in a worst case scenario where GitHub somehow became no longer appropriate for the projects I work on, the extremely distributed nature of Git makes it so there is very little lock-in compared to other services. With most free email services it's a huge hassle to move to another provider. Even with a relatively open service like <a href='http://flickr.com/photos/technomnacy'>Flickr</a>, it would still be a lot of work to move your data off to another provider. But with Git, all that amounts to naught. The whole point of Git is that it allows anyone to come along, run <kbd>git clone</kbd>, and easily create a complete copy of your repository and its history.</p>
<p>But right now all this is a moot point: they have announced that <a href='http://github.com/blog/11-github--free-for-open-source'>GitHub will remain gratis for Free Software projects</a> within a reasonable size. This is great news and makes me feel much better about promoting the service.</p>
<p>So what's so great about GitHub? Well as you may have read elsewhere, Git is a very powerful piece of version control software that enables a much wider variety of workflow than traditional systems. The biggest legitimate complaint that's been levelled against it is that it can be a bit difficult to learn. While GitHub doesn't alleviate this entirely, it definitely makes the distributed concepts easier to pick up.</p>
<p>But the most interesting new development GitHub brings to the table is discussed by Ryan Tomayko in his blog entry titled <a href='http://tomayko.com/weblog/2008/02/26/github-is-myspace-for-hackers'>My Kind of Social Software</a>. The development process encouraged by Git implicitly creates a kind of social graph with hackers as nodes and clones/pushes as edges. GitHub makes this social graph explicit. My take on this is that marking someone as a "friend" as we see it in Facebook and other social networking systems has very little in common with friendships in real life, since "friendships" in Facebook require no effort to create or maintain. They live and die at the click of a button, which means that friendship information has very little value, since it's so cheap to create. GitHub's social networking embraces the hacker notion that <i>code is all that matters</i>. If you tell GitHub to fork or watch a project, it will mark that, and that could be interpreted as you "friending" someone or joining a group. But unless you contribute back to the project, it's all moot. Anyone can see from a glance at your profile page that you forked this repository a few months ago and haven't done anything with it since. But if you are a frequent committer, that will be obvious too. The weight of connections between nodes becomes much more interesting as it can be measured by the weight of the contributions produced.</p>
<p>And this seamless participation is really what being a hacker is all about. The easier it is to give back to a project you use, the more we'll see valuable cross-polination start to spring up in places we haven't before. This isn't about enabling any one thing that formerly wasn't possible; it's about greasing the wheels and grinding away the rough corners in the processes of participation.</p>
<p>On a seemingly unrelated note, Richard Stallman is in the process of handing off official maintainership of the GNU Emacs project to Stefan Monnier and Chong Yidong. Emacs is one of the oldest extant free software projects. Though the core of Emacs suffers from high <a href='http://www.gnu.org/licenses/why-assign.html'>barriers</a> to <a href='http://technomancy.us/misc/fsf-assign.pdf'>contribution</a>, the community espouses a <a href='http://emacswiki.org'>infectuous spirit of sharing</a> that helps overcome this. Part of that is simply a byproduct of how easy sharing is in Emacs the language&mdash;simply dropping a file in your source directory and requiring it is all it takes. Part of that is because it often takes only <a href='http://technomancy.us/45'>a very little amount of Lisp code</a> to get truly useful things to happen. But I have a feeling this is driven by deeper cultural reasons: the truth is that Richard Stallman is just plain obsessed with contribution. Witness the <a href='http://lists.gnu.org/archive/html/emacs-devel/'>emacs-devel mailing list</a>:</p>
<div style='margin-left: 3em; width: 75%;'> <p><i>I'm just another emacs-user lurking for a chance to say thank you to it's creator and (future) maintainers.</i></p>
<p>How about thanking us by helping?  You could pick something in etc/TODO and implement it.</p> <p><a href='http://article.gmane.org/gmane.emacs.devel/90384'>http://article.gmane.org/gmane.emacs.devel/90384</a></p>
<p><i>What a revolution ! Thank you very much for all you have done on GNU Emacs and for the free software in general!</i></p>
<p>The best way to thank us is to join in and help. You are already doing that -- so thank you, too.</p> <p><a href='http://article.gmane.org/gmane.emacs.devel/90293'>http://article.gmane.org/gmane.emacs.devel/90293</a></p>
<p><i>There is a lot of work to be done on Emacs.  Would you like to help?</i></p>
<p>How about looking at etc/TODO in the latest sources, and implementing one of the projects there?</p> <p><a href='http://article.gmane.org/gmane.emacs.devel/90305'>http://article.gmane.org/gmane.emacs.devel/90305</a></p> </div>
<p>Keep in mind that the context of these posts in a thread in which he's announced he will no longer be the maintainer and people are thanking him for his 32 years of maintainership. But he won't accept the limelight; he constantly throws the focus back on the project and the code and the community. Say what you will about his methods and his tact, but you can't deny that he cares more than anything about getting people involved in the community and fostering an environment in which everyone is a contributor. And in the end, this attitude is the reason I consider writing software something that's worth doing.</p>
<p>Tying it all back together, I should mention that GitHub is still a closed beta. If you want an invitation, I've got five of them to hand out, but I will only send one to people who are genuinely interested in contributing to a project that's hosted there. Whether it's <a href='http://github.com/technomancy/bus-scheme/tree/master'>one</a> <a href='http://github.com/technomancy/augment/tree/master'>of</a> <a href='http://github.com/technomancy/jspec/tree/master'>mine</a> or not is irrelevant. <a href='http://technomancy.us/contact'>Let me know</a> and, I can hook you up.</p>
include(footer.html)
