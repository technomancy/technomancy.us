dnl -*- html -*-
define(__timestamp, 2006-03-08T17:01:07Z)dnl
define(__title, `brain breaks')dnl
define(__id, 39)dnl
include(header.html)
<p>What will this code produce?</p>  <pre class="code"><span class="keyword">class </span>Confusion<br /> <span class="keyword">def</span> <span class="keyword">self</span>.confuse<br /> &nbsp; &nbsp; never_defined = <span class="literal">'defined'</span> <span class="keyword">if</span> <span class="keyword">false</span><br /> &nbsp; &nbsp; never_defined<br /> <span class="keyword">end</span><br /> <br /> <span class="keyword">def</span> method_missing(m,  *args)<br /> &nbsp; &nbsp; <span class="literal">'Will you see this?'</span><br /> <span class="keyword">end</span><br /> <span class="keyword">end</span><br /> <br /> puts Confusion.confuse</pre> <p><b>Update: </b> KirinDave has <a href='http://blog.caboo.se/articles/2006/03/08/your-ruby-gotcha-of-the-day#comments'>a more informative explanation</a> on the caboose blog.</p> 
include(footer.html)
