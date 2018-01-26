dnl -*- html -*-
define(__timestamp, 2007-10-13T07:10:01Z)dnl
define(__title, `cleaning up ecmascript')dnl
define(__id, 95)dnl
include(header.html)
<p>OK,  so I'm writing Javascript at work. It's not too shabby; the nonsensical requirement of an explicit return is starting to drive me a bit batty,  but other quirks can be dealt with. For example,  let's do something about the ridiculous proliferation of the <code>function</code> keyword. Let's damp the syntactic noise required to use closures: </p>
<pre class="code"><span class="paren">(</span><span class="keyword">defun</span> <span class="function-name">js-lambda</span> <span class="paren">()</span> <span class="paren">(</span>interactive<span class="paren">)</span> <span class="paren">(</span>insert <span class="string">"function () {
 };"</span><span class="paren">)</span>
 <span class="paren">(</span>backward-char 6<span class="paren">))</span>
 
 <span class="paren">(</span><span class="keyword">defun</span> <span class="function-name">js-pretty-lambdas</span> <span class="paren">()</span>
 <span class="paren">(</span>font-lock-add-keywords
 nil `<span class="paren">((</span><span class="string">"</span><span class="string"><span class="regexp-grouping-backslash">\\</span></span><span class="string"><span class="regexp-grouping-construct">(</span></span><span class="string">function *</span><span class="string"><span class="regexp-grouping-backslash">\\</span></span><span class="string"><span class="regexp-grouping-construct">)</span></span><span class="string">("</span>
 <span class="paren">(</span>0 <span class="paren">(</span><span class="keyword">progn</span> <span class="paren">(</span>compose-region <span class="paren">(</span>match-beginning 1<span class="paren">)</span> <span class="paren">(</span>match-end 1<span class="paren">)</span>
 , <span class="paren">(</span>make-char 'greek-iso8859-7 107<span class="paren">))</span>
 nil<span class="paren">))))))</span>
 
 <span class="paren">(</span>add-hook 'js-mode-hook 'js-pretty-lambdas<span class="paren">)</span>
 <span class="paren">(</span>define-key js-mode-map <span class="paren">(</span>kbd <span class="string">"C-c l"</span><span class="paren">)</span> 'js-lambda<span class="paren">)</span></pre>
<p>That means instead of the unsightly <code>function () {};</code> you get the more subtle <code>&lambda; () { }</code>&mdash;much easier on the eyes. Plus you get the <kbd>C-c l</kbd> binding to make up for the shortsightedness of keyboard manufacturers in neglecting to include a &lambda; key on their products. Drop this in your <code>.emacs</code> file to let them know who's boss.</p>
include(footer.html)
