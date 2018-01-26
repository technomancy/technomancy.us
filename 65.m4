dnl -*- html -*-
define(__timestamp, 2006-11-10T23:12:36Z)dnl
define(__title, `quaker terms')dnl
define(__id, 65)dnl
include(header.html)
<p>A few months ago there was a bit of a fuss about a
  so-called <a href="http://docs.blacktree.com/visor/visor">Quake-style
  terminal emulator</a> for OS X. There's
  a <a href="http://yakuake.uv.ro/">Free alternative</a> if you're
  into KDE and that jazz,  but if you're not it's ridiculously simple
  to hack something up with existing terminal emulators in X. You just
  need to install the <kbd>wmctrl</kbd> utility: </p>

<pre class="code">
screenid=<span class="string">&#96;wmctrl -l | grep screen | cut -f 1 -d " "&#96;</span>.chomp.hex

<span class="keyword">if</span> screenid != 0
  puts focused=<span class="string">&#96;xdpyinfo | grep focus | cut -c 16-24&#96;</span>.chomp.hex
  <span class="keyword">if</span> screenid == focused
    <span class="string">&#96;wmctrl -i -r </span><span class="variable-name">#{screenid}</span><span class="string"> -t 9&#96;</span>
  <span class="keyword">else</span>
    <span class="string">&#96;wmctrl -i -R </span><span class="variable-name">#{screenid}</span><span class="string">&#96;</span>
  <span class="keyword">end</span>
<span class="keyword">else</span>
  <span class="string">&#96;urxvt +sb -fn terminus-16 -bg white -e screen -A -h 10000 -xRR &amp;&#96;</span>
  <span class="comment-delimiter"># </span><span class="comment">replace "-bg white" with "-tr -sh 90 -tint white" for transparency
</span><span class="keyword">end</span>
</pre>

<p>I bind this to <kbd>M-&#96;</kbd> in Sawfish and have some
  window-matching rules that govern the sizing and placement of the
  terminal window as it appears. I'm sure similar results could be
  achieved in other decently flexible window managers.</p>

<pre class="code">
<span class="paren">(</span>custom-set-typed-variable <span class="paren">(</span>quote match-window-profile<span class="paren">)</span> 
                           <span class="paren">(</span>quote <span class="paren">((((</span>WM_NAME . <span class="string">"^screen$"</span><span class="paren">))</span> 
                                    <span class="paren">(</span>position 20 . 0<span class="paren">)</span> 
                                    <span class="paren">(</span>maximized . horizontal<span class="paren">)</span> 
                                    <span class="paren">(</span>frame-type . none<span class="paren">))))</span> 
                           <span class="paren">(</span>quote match-window<span class="paren">)</span> 
			   <span class="paren">(</span>quote sawfish.wm.ext.match-window<span class="paren">))</span></pre>
<p>It's not rocket science or anything,  but I find it comes in handy
  for all kinds of stuff. The wmctrl is a really nice utility if
  you're into optimizing your workflow with automation,  which you
  should be.</p>

include(footer.html)
