<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Sat Oct 13 00:00:01 -0700 2007)dnl
define(__title, `fletter')dnl
define(__id, 94)dnl
include(header.html)
<p> One of the handy things about Lisp that I've gotten attached to is the <code>flet</code> function. Using it you can temporarily redefine a function but have its definition revert back to the original when its body exits. This is analagous to the way a block in Ruby can have some specific behaviour that goes away when it exits,  but <code>flet</code> doesn't seem to have a Ruby equivalent. (The best my searches found was pstickne enlightening folks in #ruby-lang about this lisptastic functionality.) Anyway,  I just figured out an implementation. </p>
<pre class="code"> <span class="keyword">def</span> <span class="function-name">Object.flet</span>(bindings,  &amp;block)
 old_methods = {}

bindings.each <span class="keyword">do</span> |the_method,  body|
 old_methods[the_method] = method(the_method)
 define_method(the_method,  body)
 <span class="keyword">end</span>
 
 <span class="keyword">begin</span>
 block.call
 <span class="keyword">ensure</span>
 bindings.each <span class="keyword">do</span> |the_method,  body|
 define_method(the_method) { |*args| old_methods[the_method].call(*args) }
 <span class="keyword">end</span>
 <span class="keyword">end</span>
 <span class="keyword">end</span>
 </pre>
<p>This lets you do stuff like: </p>
<pre class="code"> puts <span class="string">"foo"</span>
 
 <span class="type">Object</span>.flet(<span class="constant">: puts</span> =&gt; &lambda; { |str| print <span class="string">"</span><span class="variable-name">#{str.reverse}</span><span class="string">
 "</span> }) <span class="keyword">do</span>
 puts <span class="string">"foo"</span>
 <span class="keyword">end</span>
 
 puts <span class="string">"foo"</span>
 </pre>
<p>... which will output: </p>
<pre class="code">foo
 oof
 foo
</pre>
<p>Pretty cool,  huh? I haven't done much funky metaprogramming in Ruby,  so it's quite possible my attempts to Lispify it here are dangerous and/or misguided. (That's what comments are for,  BTW.) But it's coming in pretty handy for me so far.</p>
<p><b>Update</b>:  <a href='http://blog.hasmanythrough.com'>Josh</a> points out that this is not thread-safe and thoroughly violates encapsulation in a way that should earn me a severe thrashing (dare I say&mdash;flogging?) were I to use it in production in anything but the simplest of circumstances. In my mind it's kind of like using <code>eval</code>:  all advice concerning actually using it goes along the lines of "never do this". Only once you learn when it's OK to ignore such strong warnings can you be trusted to posess the necessary discretion to use it in practice.</p>
<p>The context here is that I want to run a bunch of tests and gather failure data within my library. But when I require <code>test/unit</code>,  it sets up an <a href="http://www.ruby-doc.org/core/classes/Kernel.html#M005957">at_exit</a> block that actually initiates the running of the tests as a final act before the execution finishes. This is redundant since I already initiated them myself in the library. But once you've created an <code>at_exit</code>,  there's no mechanism for disabling it. I could just redefine <code>at_exit</code> permanently,  but it's quite possible I'd want to use it elsewhere. <code>flet</code> allows me to limit the scope of this change. But it's only forgivable because I'm not really working with an object-oriented phenomenon here; I'm working with a lower-level feature of Ruby.</p>
<pre class="code"> <span class="type">Object</span>.flet(<span class="constant">: at_exit</span> =&gt; lambda {}) <span class="keyword">do</span>
 <span class="comment-delimiter"># </span><span class="comment">keep test/unit's at_exit block from running</span>
 require <span class="string">'test/unit'</span>
 <span class="keyword">end</span>
 </pre>
<p>And as Josh notes,  Rubinius will make stuff like this much easier. I imagine I wouldn't even have to resort to <code>flet</code> to get around my <code>at_exit</code> problem.</p>
include(footer.html)
