dnl -*- html -*-
define(__timestamp, Sat Oct 13 00: 00: 01 -0700 2007)dnl
define(__title, `inte-gray-shun')dnl
define(__id, 83)dnl
include(header.html)
<p>So I've been playing around with some more of this new-fangled "desktop integration" stuff. Pretty crazy.</p>

<img src='/i/portland_street.jpg' alt='portland street' />

<p>Recently the ever-useful gaim project was <a href='http://pidgin.im'>renamed to pidgin</a>. The new release is quite nice,  but several plugins haven't really been ported over yet. On top of that,  the notification plugin has some <a href='https: //bugs.launchpad.net/ubuntu/+source/gaim/+bug/93638'>serious problems</a> on 64-bit machines. How troublesome! Of course,  you can always scratch your itches by writing plugins in Python or C,  but then you have to use Python or C.</p>

<p>Well it turns out if you take advantage of <a href='http://dbus.freedesktop.org'>dbus</a>,  the whole plugin architecture with its limited language support becomes a bit of a non-issue. The <a href='https: //trac.luon.net/ruby-dbus/'>ruby-dbus</a> project helps out here admirably. I should note that there's a proliferation of projects purporting to allow dbus usage from within Ruby,  but this one seemed the most mature and active. I was also very impressed by the quick response on the mailing list I got from the developers when I found a problem.</p>

<pre class='code'>
  <span class="keyword">def</span> <span class="function-name">watch_status</span>
    <span class="variable-name">@purple</span>.on_signal(<span class="string">"AccountStatusChanged"</span>) <span class="keyword">do</span> |account,  old,  new|
      <span class="keyword">begin</span>
        <span class="type">TwitterClient</span>.update(current_message) <span class="keyword">unless</span> current_message == <span class="string">''</span>
      <span class="keyword">rescue</span> <span class="type">Twitter</span>: : <span class="type">RESTError</span> =&gt; re
        puts re
      <span class="keyword">end</span>
    <span class="keyword">end</span>
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">notify_messages</span>
    <span class="variable-name">@purple</span>.on_signal(<span class="string">"ReceivedImMsg"</span>) <span class="keyword">do</span> |account,  user,  message|
      message.gsub!(<span class="string">/\&lt;[^\&gt;]*\&gt;/</span>,  <span class="string">''</span>) <span class="comment-delimiter"># </span><span class="comment">jabber messages have unnecessary XML
</span>      user = user.split(<span class="string">/\//</span>).first <span class="comment-delimiter"># </span><span class="comment">get rid of jabber resource part
</span>      <span class="type">Notify</span>.send(<span class="constant">: message</span> =&gt; message,  <span class="constant">: title</span> =&gt; <span class="string">"</span><span class="variable-name">#{user}</span><span class="string"> says: "</span>, 
                  <span class="constant">: seconds</span> =&gt; 5, 
                  <span class="constant">: icon</span> =&gt; (<span class="type">File</span>.expand_path(<span class="string">"~/.purple/icons/"</span>) + <span class="string">'/'</span>
                            + <span class="variable-name">@buddy_icons</span>[user] <span class="keyword">if</span> <span class="variable-name">@buddy_icons</span>[user]))
      <span class="type">ThinkLight</span>.flash
      sleep 0.2
      <span class="type">ThinkLight</span>.flash
    <span class="keyword">end</span>
  <span class="keyword">end</span></pre>

<p>So far it does a few things: </p>
<ul>
<li>listens for changes in my IM status and posts them to <a href='http://twitter.com/technomancy'>Twitter</a></li>
<li>pops up a notification bubble on incoming messages (with buddy icons)</li>
<li>flashes the light on my laptop when a message is received</li>
</ul>

<p>Not what you'd call exciting,  but the point is it's written in Ruby and thus easily extensible by myself. Instant messaging has been the lone holdout in terms of the daily tasks that I was unable to automate and tie into programmatically,  so it's good to see that taken care of.</p>

<p>Code is <a href='http://dev.technomancy.us/browser/dotfiles/bin/pidgin-tools.rb'>in Trac</a> as usual.</p>
include(footer.html)
