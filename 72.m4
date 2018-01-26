dnl -*- html -*-
define(__timestamp, 2007-10-13T07:00:01Z)dnl
define(__title, `darjeeling - a roundabout route')dnl
define(__id, 72)dnl
include(header.html)
<p>Well by now if you follow Ruby much you've probably noticed the
  whole <a
  href="http://on-ruby.blogspot.com/2007/01/will-rubinius-be-acceptable-lisp.html">Will Rubinius
  be an acceptable Lisp</a> ponderings or brainstormings or whatever you want to
  call it. And if you know me at all,  you'd be aware that the
  union of such concepts is exactly the kind of thing that would
  excite me.</p>

<p>So I meddled around a bit
  with <a
  href="http://parsetree.rubyforge.org">ParseTree</a>. Honestly,  it's
  ridiculous; the Ruby side of this kind of thing has been made more
  or less trivial by Ryan's great work: </p>

  <pre class='code'>
require <span class="string">'rubygems'</span>
require <span class="string">'parse_tree'</span>

<span class="keyword">class</span> <span class="type">Infuser</span>
  <span class="keyword">def</span> <span class="function-name">self.brew</span>(klass)
    lisp(<span class="type">ParseTree</span>.new.parse_tree(klass)).sub(<span class="string">/\(\(/</span>,  <span class="string">'(class Object ('</span>)
</span>  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">self.lisp</span>(leaf)
    leaf.respond_to?(<span class="constant">: map</span>) ? <span class="string">"(</span><span class="variable-name">#{leaf.map{|l| lisp(l)}</span><span class="string">.join(' ')})"</span> :  leaf
  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>

<p>Would you look at that. Like I said; pretty trivial. While we're on the subject of trivial,  consider this: </p>

  <pre class='code'>
<span class="keyword">class</span> <span class="type">Foo</span>
  <span class="keyword">def</span> <span class="function-name">bar</span>
    1 + 1
  <span class="keyword">end</span>
<span class="keyword">end</span></pre>


<p><code>Infuser.brew Foo</code> gives us this: </p>

<pre class='code'>
(<span class="keyword">class</span> <span class="type">Object</span>
       (<span class="keyword">class</span> <span class="type">Foo</span> (const <span class="type">Object</span>) 
	      (<span class="keyword">defn</span> bar 
		(<span class="keyword">scope</span>
		 (<span class="keyword">block</span> (args) 
		   (<span class="keyword">call</span> (lit 1) + (array (lit 1))))))))
</pre>

<p>At this point you may be tempted to think yourself,  "Hey,  that
  looks like lisp! Run it through the compiler and see what it does."
  Unfortunately Ruby's object model is wildly divergent from Common
  Lisp's. (Though you could say that's very fortunate depending on
  your opinion of <acronym title="Common Lisp Object System">CLOS</acronym>&mdash;I won't go there.) The point is,  running
  the above code would require getting a subset of Ruby's object model
  running in Common Lisp. Running nontrivial code would basically require
  getting it completely ported.</p>

<p>Now that sounds hugely daunting task. It probably is. But I've got
  this wild idea that you'd only have to actually implement a fairly
  small subset of this in CL itself. The rest could be translated over
  from Ruby. I'm thinking all the portions of the
  implementation currently written in C would need to be redone in CL, 
  and if the port is accurate enough then the portions of Ruby-the-implementation which are written
  in Ruby-the-language will be able to be translated through the infuser shown
  above. Now I know that the official Ruby has gobs and gobs of stuff
  implemented in C,  but it seems to be a stated goal
  of <a href="http://rubini.us/rubinius">Rubinius</a> to decrease the
  C-to-Ruby ratio. That may be something that could be leveraged
  here. (Note to self:  need to check out MetaRuby as well.)</p>

<p>There's another hiccup though&mdash;it seems there's no solid
  <acronym title="Behaviour-Driven Development">BDD</acronym>
  framework for Common Lisp. A few weeks back I started
  writing <a
  href="http://dev.technomancy.us/phil/browser/dotfiles/.emacs.d/behave">behave.el</a>
  for Emacs Lisp. The pieces are all coming together in my head,  so it
  seems the thing to do at this point would be to finish it,  port it
  to CL,  and then start porting the Rubinius specs to it.</p>
<p><b>Update</b>: this was not actually a good idea.</p>

include(footer.html)
