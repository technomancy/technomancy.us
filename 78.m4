<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Sat Oct 13 00: 00: 01 -0700 2007)dnl
define(__title, `mail jig')dnl
define(__id, 78)dnl
include(header.html)
<p>In the same vein as <a
href="http://blog.zenspider.com/archives/2007/03/that_stupid_thing_i_wrote_the_other_day_part_1.html">That
Stupid Thing I Wrote The Other Day</a> series; maybe this will be useful to someone: </p>

    <pre class="code">
<span class="comment-delimiter">#</span><span class="comment">!/bin/sh</span><span class="comment">
</span>
<span class="comment-delimiter"># </span><span class="comment">On my desktop,  I only want mail to be checked if I'm using the
</span><span class="comment-delimiter"># </span><span class="comment">machine. Otherwise I want it to leave the mail on the server so my
</span><span class="comment-delimiter"># </span><span class="comment">laptop can fetch it.
</span>
<span class="comment-delimiter"># </span><span class="comment">idletime gets touched every three minutes while idle
</span>xautolock -time 3 -locker <span class="string">"touch ~/.idle"</span> &amp;

<span class="comment-delimiter"># </span><span class="comment">keep the mail on the server if i'm on my laptop
</span><span class="keyword">if</span> [ <span class="string">`hostname`</span> = <span class="string">"vannevar"</span> ] ; <span class="keyword">then</span>
    <span class="variable-name">KEEP</span>=<span class="string">'-k'</span>
<span class="keyword">fi</span>

<span class="keyword">while</span> [ 1 ]
<span class="keyword">do</span>
    touch ~/.three.minutes.old
    sleep 3m

    <span class="keyword">if</span> [ ~/.idle -ot ~/.three.minutes.old ]; <span class="keyword">then</span>
        <span class="comment-delimiter"># </span><span class="comment">not idle!
</span>        fetchmail -k &gt;/dev/null 2&gt;&amp;1

        <span class="keyword">if</span> [ <span class="string">"$?"</span> = <span class="string">"0"</span> ]; <span class="keyword">then</span>
            notify-send -u low <span class="string">"New mail"</span>
        <span class="keyword">fi</span>
    <span class="keyword">fi</span>
<span class="keyword">done</span>

</pre>

<p>I've got a laptop and a desktop. I want to check mail on the
desktop and have that act as the definitive copy. So when the desktop
pulls in mail,  it deletes it off the server. I want to use the laptop
to pull in mail,  but only when I'm not at my desktop. It keeps a
non-authoritative copy that may have vast holes in its archives; no
big deal.</p>

<p>The problem is,  I don't want mail to get checked when I'm away from
my desktop. I could just manually start and stop the fetchmail d&aelig;mon, 
but that's tacky. This script uses xautolock to determine the idle
time of X. If it's been active in the last three minutes,  it should
pull in the mail; otherwise leave it alone. If it's on my laptop
(vannevar) then keep mail on the server for my desktop to consume.</p>

<p>As you can see,  I'm no shell wizard. Using hidden files is slightly
tacky,  but it gets the job done.</p>
include(footer.html)
