dnl -*- html -*-
define(__timestamp, 2008-09-23T10:07:01Z)dnl
define(__title, `in which an opportunity for exceptional confusion presents itself')dnl
define(__id, 114)dnl
include(header.html)
<p>So I've noticed there seems to be a fair amount of confusion in
the Ruby world about exception hierarchies. A number of libraries I
use happen to use them in ways that cause problems&mdash;usually in
ways that surface at the worst possible times near the end of long
batch operations. So here's a little primer to refresh your memory
and hopefully save some of <i>my</i> sanity if I ever use one of
your gems.</p>

<p><code>Exception</code> is the root class for the whole exception
  hierarchy. I see a lot of code that subclasses <code>Exception</code>
  for regular non-fatal exceptions. It's not obvious, but this is
  really not how it's meant to be used. Imagine you are building a
  restful interface. The following code will bring down the
  application:</p>

<pre class='code'>
<span class='comment-delimiter'># </span><span class='comment'>This is wrong! Inherit from StandardError.</span>
<span class='keyword'>class</span> <span class='type'>GetSomeRest</span> &lt; <span class='type'>Exception</span>; <span class='keyword'>end</span>

<span class='keyword'>begin</span>
  <span class='keyword'>if</span> (7 .. 11).include? <span class='type'>Time</span>.now.hour
    perform_restful_operation
  <span class='keyword'>else</span>
    <span class='keyword'>raise</span> <span class='type'>GetSomeRest</span>
  <span class='keyword'>end</span>
<span class='keyword'>rescue</span>
  puts <span class='string'>'You really should not stay up so late.'</span>
<span class='keyword'>end</span>
</pre>

<p>This is because <code>rescue</code> will only capture errors that
  descend from <code>StandardError</code> by default. We should be
  subclassing <code>StandardError</code> here, as well as for anything
  else that's non-fatal. Save <code>Exception</code> subclasses for very
  serious things. Running out of memory should raise an
  <code>Exception</code>. When a user presses control-c, it raises
  <code>Interrupt</code>, which is descended directly from
  <code>Exception</code> rather than <code>StandardError</code>. Sending a
  Unix kill signal to a process does the same thing. If you rescue
  <code>Exception</code> or <code>Interrupt</code>, then you have to resort
  to <code>kill -9</code> to stop your application externally, leaving
  it with no chance to clean up after yourself.</p>

<p>Unfortunately, we live in an imperfect world, and we have to deal
with libraries that misuse the exception hierarchy. The first thing
you should do when you encounter one of these misuses is submit a
patch to the offending library. (You could even include a link to
this post.) But it's not always possible to get it fixed, so here's
the workaround I've been using:</p>

<pre class='code'>
<span class='keyword'>begin</span>
  perform_possibly_problematic_process
<span class='keyword'>rescue</span> <span class='type'>Exception</span> =&gt; e
  <span class='keyword'>raise</span> e <span class='keyword'>unless</span> e.is_a? <span class='type'>StandardError</span> <span class='keyword'>or</span> e.is_a? <span class='type'>GetSomeRest</span>
  <span class='variable-name'>@log</span>.warn e.message <span class='comment-delimiter'># </span><span class='comment'>or whatever
</span><span class='keyword'>end</span>
</pre>

<p>If you're not sure of all the problematic <code>Exception</code>s a
piece of code could raise, you could just rescue <code>Exception</code>
and re-raise <code>e</code> if it's an <code>Interrupt</code>, but this
might swallow some other legitimate serious problems, so it's best
to be specific.</p>

<p>Tell your friends to use Ruby's exception hierarchy as it was
intended! <b>Update</b>: Don't feel bad if you didn't know this,
apparently even the Lucky Stiff himself has <a href='http://github.com/why/hpricot/commit/3f14969ccc862fde26e7fcdc072b01f4fc4b9146'>fallen into this trap</a>.</p>
include(footer.html)
