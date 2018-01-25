<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Mon 29 Mar 2010 07:58:00 PM PDT)dnl
define(__title, `in which the maintainer's perspective is considered')dnl
define(__id, 135)dnl
include(header.html)
<p>In the past few months I've had a number of contributions pour in
  for some of my projects. It's been really exciting to see this
  level of community involvement, and I try to do everything I can
  to encourage users to get involved in development. But I don't
  have a lot of free time these days&mdash;with two small kids I'm
  lucky to have a few hours a week to address incoming patches, much
  less work on new features.</p>

<img src="/i/github-inbox.png" alt="github inbox (dramatization)"
     title="(dramatization)" />

<p>There are a few things that could streamline the process a bit,
  so I thought I'd take some time to explain how these projects look
  from the maintainer's side and the things that contributors could
  do to make their patches easy to apply.</p>

<h4>Coordinating</h4>

<p>For simple stuff it's great just to get patches out of the
  blue. For more involved work, however, it's important to
  communicate so that parallel feature work doesn't interfere. For
  my projects, there are few enough people working on them that
  usually mentioning it on the mailing list is plenty. Larger
  projects will often track in-progress features using a ticket
  system, so in that case you'll probably want to do both. Then
  you can fork/checkout the project and get started.</p>

<h4>Branches</h4>

<p>The first thing to remember is to keep all your work in topic
  branches. Most people just commit directly to the master branch,
  but then it's trickier for them to keep in sync with
  upstream. Every time you pull in the latest changes it causes a
  merge commit. This needlessly clutters up the history and makes it
  difficult for maintainers to find the exact changes they are
  looking for. It gets worse if there are multiple unrelated
  features committed directly to master. Even once your changes are
  merged, it's likely that pulling changes after that point will
  still result in merge commits rather than fast-forwards simply
  because the same set of changes were applied in a different
  order. So keeping your work in a separate branch per feature/fix
  allows the master history to be kept clean.</p>

<p>When it's time for a maintainer to merge your branch, they have a
  choice to either rebase it on top of the current master and then
  commit it, maintaining a linear history, or merge it in to master
  with a single merge commit. The latter is usually done in the case
  of longer-lived branches where you want to be able to group
  together a whole series of commits under a single feature. It's a
  bit silly/noisy to leave a merge commit lying around from merging
  a branch with only one or two commits.</p>

<h4>Cleanliness</h4>

<p>I'm a little more picky about the silly little things than most
  maintainers; I prefer my projects to be free of trailing
  whitespace and to use 80-column width, standard indentation, and
  no tabs. It's easy enough to enforce this in Emacs:</p>

<pre class="code">(setq whitespace-style '(trailing lines space-before-tab
                          indentation space-after-tab)
      whitespace-line-column 80)

  <span class="comment-delimiter">;; </span><span class="comment">add hooks for every major mode you use
</span>(add-hook 'clojure-mode-hook (<span class="keyword">lambda</span> () (whitespace-mode 1)))</pre>

<p>In an ideal world, projects would have great test coverage and
  bugfix patches would always include first a test that fails in
  order to highlight the problem the patch addresses, then the
  implementation that causes the test to pass. Many of my projects
  unfortunately fall into the tricky-to-test zone either by way of
  complex asynchronous I/O or UI-heavy pieces of code, making this
  ideal difficult to achieve. In any case, it gives maintainers much
  more confidence when applying a patch if they can use tests to
  verify it's behaving as intended. It just takes a big burden off
  the person performing the merge if they only have to manually
  verify that the test passes and makes sense rather than checking
  by hand that the implementation is behaving as expected.</p>

<p>I've found that in Clojure it's good to aim for function bodies
  of twenty lines or less, modulo exception handling and
  logging. Naturally there will be places where this isn't
  practical, but it's good to keep this in mind and carefully
  examine longer functions to see if there would be a cleaner way to
  break things up. It should go without saying that using pure
  functions as much as possible and consolidating all I/O and
  mutation into a few places will also help a great deal to make
  things easier to read.</p>

<h4>Sending it off</h4>

<p>Personally I find it easiest to work with changes that are
  published to a remote git repository. Generally this means people
  create forks on Github, but there's no reason other options
  like <a href="http://gitorious.org">Gitorious</a> or even a
  self-hosted git repo wouldn't work. Github pull requests work
  well, although please do <em>not</em> send them without a message
  explaining what the changes do. Github has a "feature" whereby you
  can send pull requests to everyone with a fork of a project; this
  is a terrible, terrible thing that you should never use. Most of
  the people on that list forked the project months and months ago
  and forgot about it, so please don't spam them.</p>

<p>Some people prefer to just mail patches or attach patches to bug
  tracker tickets. It's easy to generate these patches by
  running <kbd>git format-patch master</kbd> from your topic
  branch.</p>

<p>And it's an unfortunate fact of life that some projects require
  copyright assignment before they can accept nontrivial patches, so
  check for that first. In some cases a paper form is even required,
  which can bring a further unexpected delay into the picture.</p>

<h4>Commit Access</h4>

<p>In some cases I know I'm just not able to give a project the
  attention it deserves and I volunteer certain contributors for the
  post of maintainer. Sometimes this is because I just can't give a
  project the attention it needs to keep up with incoming patches,
  and sometimes (as with Hugo Duncan and his excellent work
  on <a href="http://github.com/technomancy/swank-clojure/tree/swank-break">swank-clojure
  break</a>) it's because I just don't want to be a bottleneck
  keeping their awesome work from getting in.</p>

<p><strike>In these cases I like to ask that changes don't get
  merged to master until they've been reviewed by at least one
  person other than the author. If you're a committer that's
  applying patches someone else sent in, then you're doing the
  review, otherwise just try to get some help from IRC or the
  project's mailing list to review your patch before it makes it to
  master.</strike><b>Update</b>: I've backed out of this policy as
  it really isn't necessary. Committers should just use their
  discretion when deciding whether to push to master or a branch.</p>

<p>All that said, keep the patches coming! I love getting them.</p>
include(footer.html)
