dnl -*- html -*-
define(__timestamp, 2005-12-05T09:28:35Z)dnl
define(__title, `there aught to be a law against you coming around')dnl
define(__id, 20)dnl
include(header.html)
<div class="ruby"><pre class='code'>        <span class="comment"># failed login</span>
 <span class="ident">flash</span><span class="punct">.</span><span class="ident">now</span><span class="punct">[</span><span class="symbol">: attempts</span><span class="punct">]</span> <span class="punct">=</span> <span class="attribute">@params</span><span class="punct">[</span><span class="symbol">: attempts</span><span class="punct">].</span><span class="ident">to_i</span> <span class="punct">+</span> <span class="number">1</span>

 <span class="keyword">if</span> <span class="ident">flash</span><span class="punct">[</span><span class="symbol">: attempts</span><span class="punct">]</span> <span class="punct">&gt;</span> <span class="number">3</span>
 <span class="ident">flash</span><span class="punct">.</span><span class="ident">now</span><span class="punct">[</span><span class="symbol">: error</span><span class="punct">]</span> <span class="punct">=</span> <span class="punct">'</span><span class="string">You seem to be having trouble logging in. If you want
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; your password reset,  simply try to log in with the password </span><span class="punct">"</span><span class="ident">forgot</span><span class="punct">'</span><span class="string"></span><span class="punct">"</span>
 <span class="keyword">elsif</span> <span class="attribute">@params</span><span class="punct">[</span><span class="symbol">: user</span><span class="punct">][</span><span class="symbol">: password</span><span class="punct">].</span><span class="ident">include?</span><span class="punct">('</span><span class="string">forgot</span><span class="punct">')</span>
 <span class="constant">User</span><span class="punct">.</span><span class="ident">find_by_email</span><span class="punct">(</span><span class="attribute">@params</span><span class="punct">[</span><span class="symbol">: email</span><span class="punct">]).</span><span class="ident">reset_password</span>
 <span class="ident">flash</span><span class="punct">.</span><span class="ident">now</span><span class="punct">[</span><span class="symbol">: notice</span><span class="punct">]</span> <span class="punct">=</span> <span class="punct">'</span><span class="string">Your password has been reset an emailed to you.</span><span class="punct">'</span>
 <span class="keyword">else</span>
 <span class="ident">flash</span><span class="punct">.</span><span class="ident">now</span><span class="punct">[</span><span class="symbol">: error</span><span class="punct">]</span> <span class="punct">=</span> <span class="punct">'</span><span class="string">You provided an incorrect email and password combination.</span><span class="punct">'</span>
 <span class="keyword">end</span></pre></div> <p>More people should do this. It one thing I haven't seen anywhere else and one thing that is more rare than it should be. First of all,  it will reset your password and email it to you if you enter 'forgot' in the password box. Secondly,  it suggests that you get your password reset if you try to log in with the wrong password too many times. Simple things,  but they're worth paying attention to.</p>
include(footer.html)
