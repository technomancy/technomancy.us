dnl -*- html -*-
define(__timestamp, 2008-10-25T00:19:01Z)dnl
define(__title, `in which a subject is attempted to be approached objectively, though such a thing is actually impossible')dnl
define(__id, 115)dnl
include(header.html)
<p>In the past few weeks an odd trend has come across my radar: I've
  seen
  <a href='http://twitter.com/technoweenie/status/972740768'>a</a>
  <a href='http://www.al3x.net/2008/10/on-flight-to-old-text-editors.html'>number</a>
  of <a href='http://twitter.com/gilesgoatboy/status/954572275'>hardcore</a> <a href='http://livollmers.net/index.php/2008/10/06/back-to-myemacs/'>Mac</a> <a href='http://github.com/defunkt/emacs/tree/master'>geeks</a>
  <a href='http://weblog.jamisbuck.org/2008/10/10/coming-home-to-vim'>experiment</a>
  with the classic editors, and I've seen others who wonder why
  people would give up the comfort of a "modern program" for them. I
  hesitate to write on the topic because posts that do so often up
  as flame-bait, but it actually sounds like some folks are
  genuinely curious and want to learn rather than just repeat the
  same holy wars of the past, so I will try to stay in the same
  frame of mind.</p>

<a href='http://m.assetbar.com/achewood/uua3cZ7cb'>
  <img src='/i/ray.gif' alt='ray' title='smug' class='right' /></a>

<p>One of the complaints you see leveled over and over is that Emacs
  on OS X doesn't feel "Mac-like". This is asserted as if it's a
  tragic shortcoming of Emacs, and the person stating it never
  specifies what advantages would arise if it were "fixed"; it's
  assumed to be obvious. This usually comes across as cultural
  elitism, but I don't think that's the intent, any more than Ray
  Smuckles intends to offend the Russian people when he
  <a href='http://raysmuckles.blogspot.com/2005_06_01_archive.html'>observes
  that the Cyrillic alphabet "looks like they commissioned a
  smartass to make fun of our letters,"</a>&mdash;he's
  just <a href='http://m.assetbar.com/achewood/uua5HJJnB'>being
  Ray</a>. That is to say, there are some deeply-held assumptions at
  work here that are never questioned. It's pretty easy to explain
  why a buffer list is more effective than a tabbed interface, (an
  explanation is given below) but I've never heard the reasoning why
  supposedly a modal file open dialog box is better for text files
  than reading a location unobtrusively from the minibuffer. It's
  always just set forth as something the user will grudgingly put up
  with, even though it has many advantages over what they're used
  to.</p>

<p>I agree that there are some advantages to a standardized set of
  conventions for user interfaces that apply across a whole
  operating system. Lowering the number of context switches involved
  in day-to-day usage is a definite win. But the problem with
  standards like these is that they can turn restrictive. If
  something comes along that is objectively better and the standard
  doesn't allow for it, the standard is acting as a hindrance.</p>

<h3>Conventions Compared</h3>

<p>The most obvious example is to compare the modern convention of
  multi-document tab-switching to the buffer-switching mechanisms
  you see in Emacs. Once you start opening a significant number of
  tabs, the number of documents you can open and see at the same
  time is limited by the width of your screen. For Firefox on this
  machine, the number is twelve[<a href='#115-1'>1</a>] when it's
  running full-screen. Even if you can see every document, the title
  of each will need to be sharply truncated to fit on the small
  visible tab, making it harder to identify a tab without switching
  to it. To find the tab you want, you need to just press
  control-pageup over and over again.</p>

<p>When the <code>ido</code> buffer switcher that comes with Emacs
  is invoked, it shows a limited number of targets to switch to,
  just like the tab system. So far the only difference is that the
  buffers are in order of when they were used last, so it's much
  more likely that the one you want is at the front of the list. But
  the big win is that you can just start typing a few letters, and
  the list will narrow down to only the options that match what
  you've typed. So once you invoke the buffer switcher it rarely
  takes more than five keystrokes to find what you want even when
  you have a large list of open buffers, whereas with tabs you'd
  have to search linearly for your target.</p>

<p>With predictable frequency we get folks dropping by the #emacs
  freenode channel asking things like "can I get a tabbed interface
  in Emacs?", and the answer is always "of course you can, but you
  don't want to; try this instead". This probably comes off as
  cultural elitism too when the enquirer insists that he really does
  want a tab bar, but I think the motivation is more "we don't
  want to spend the time explaining in painstaking detail the
  advantages of this way to someone who doesn't want to listen" than
  "we don't need the likes of you around here".</p>

<p>The other big under-appreciated advantage is the capability to
  redefine or add functionality on the fly. I'm fairly sure this
  can't really be understood until you try
  it[<a href='#115-2'>2</a>], but the thought of going back to apps
  that don't allow self-modification is usually met with a
  grimace.</p>

<h3>In Action</h3>

<p>Take the example of the version control interface. It's got a bit
  of historic baggage, being designed around a single-file-at-a-time
  mindset encouraged by the version control systems of yore. It's
  recently been rewritten to work better with multiple files at a
  time, but since it provides a uniform interface over all the
  different backends it supports, I noticed a problem with working
  with git repositories. When you add a file to the repository, it
  checks to make sure it hasn't been registered yet. This is pretty
  reasonable with most VCSes, but with git re-registering a file is
  a common operation when you want to add a single change to the
  staging area.</p>

<p>If you didn't have the ability to modify functionality on the
  fly, you'd probably just bite the context-switching bullet and
  drop into the shell for this (or worse, just quit using git's
  ability to build up a patch chunk by chunk and just commit with
  the "-a" option) since it doesn't seem like it's worth fixing. But
  it's really trivial to fix in Emacs:</p>

  <pre class='code'>
<span class="paren">(</span><span class="keyword">defun</span> <span class="function-name">my-vc-add-or-register</span> <span class="paren">()</span>
  <span class="doc">"Register the file if it hasn't been registered, otherwise git add it."</span>
  <span class="paren">(</span>interactive<span class="paren">)</span>
  <span class="paren">(</span><span class="keyword">if</span> <span class="paren">(</span>eq 'Git <span class="paren">(</span>vc-backend buffer-file-name<span class="paren">))</span>
      <span class="paren">(</span>vc-git-register buffer-file-name<span class="paren">)</span>
    <span class="paren">(</span>vc-register<span class="paren">)))</span>

<span class="paren">(</span>global-set-key <span class="paren">(</span>kbd <span class="string">"C-x v i"</span><span class="paren">)</span> 'my-vc-add-or-register<span class="paren">)</span>
</pre>

<p>This took less than two minutes to write, and I was actually able
  to use the functionality I just wrote to add the change to my
  dotfiles repository instantly[<a href='#115-3'>3</a>],
  bootstrapping-style.</p>

<p>If you have to use some tacked-on "plugin mechanism" to customize
  it, then you’re going to be limited at the very least by the
  imagination of the author of the plugin mechanism; only the things
  he thought you would want to do with it are doable. But if you’re
  using the exact same tools as the original authors were using to
  write the program in the first place, you can bet they put all
  their effort into making that a seamless, powerful experience, and
  you'll be able to access things on an entirely new level.</p>

<h3>However</h3>

<p>I don't want to say that there aren't any problems with the
  system I use. The default key bindings are more an accident of
  history without much advantage from the more standard
  conventions. The <kbd>M-x customize</kbd> interface is frankly
  pretty embarrassing and comes across as an attempt to shield users
  from the act of writing and reading code, but this is easy to
  avoid. The lack of concurrency is a very real problem,
  though <a href='http://article.gmane.org/gmane.emacs.devel/96339'>not
  one that's going unnoticed</a> by the
  developers.[<a href='#115-4'>4</a>] The rendering engine is very
  text-centric; it's hard to get it display other things. But these
  are problems that people are working together to address, and it's
  remarkable how approachable some of them are to someone who knows
  a little elisp. And the capability to examine and change running
  code on the fly makes them much easier to deal with.</p>

<hr>
<div class='footnotes'>
  <p>[<a name='115-1'>1</a>] - Perhaps this is intentional; keeping
    too many tabs open at a time in Firefox can cause performance
    issues. But that's another issue entirely.</p>
  <p>[<a name='115-2'>2</a>] - The ex-Smalltalkers never have a hard
    time understanding it.</p>
  <p>[<a name='115-3'>3</a>] - Of course, it doesn't stop here; the
    decent thing to do
    is <a href='http://article.gmane.org/gmane.emacs.devel/104793'>send
    the fix upstream</a>. Unfortunately there's a feature-freeze
    right now, so this specific feature will probably have to wait
    for the next release.</p>
  <p>[<a name='115-4'>4</a>] - The <code>lexbind</code> branch of
    development provides optional lexical binding, the current lack
    thereof being the greatest hindrance towards adding concurrency
    features. The current plan is to merge it and add coroutines
    after the release of version 23 in December.</p>
</div>
include(footer.html)
