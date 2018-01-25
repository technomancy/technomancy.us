<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Sat Oct 13 00: 00: 01 -0700 2007)dnl
define(__title, `post-railsconf 07')dnl
define(__id, 82)dnl
include(header.html)
<p>RailsConf just ended. I've got a big refactoring
of <a href='http://rav.rubyforge.org'>RAV</a> in the works,  but until
I wrap that up I'll post this to hold things over: </p>

<img src='/i/mongrel_panel.png' alt='mongrel panel screenshot' />

<p>It may be hypocritical of me to keep harping on how it's best to avoid reliance on the mouse as much as you can,  but  I grudgingly admit that sometimes it <i>is</i> handy to be able to launch mongrel quickly with it. Below is the code for <code>mongrel_panel.rb</code>: </p>

<pre class='code' style='font-size:  90%;'>
<span class="comment-delimiter">#</span><span class="comment">!/usr/bin/env ruby
</span>
<span class="comment-delimiter"># </span><span class="comment">Mongrel Panel
</span><span class="comment-delimiter"># </span><span class="comment">Copyright (C) 2007 Phil Hagelberg
</span>
require <span class="string">'gtk2'</span>
require <span class="string">'gtktrayicon'</span>

<span class="type">RAILS_ROOT</span> = <span class="type">ENV</span>[<span class="string">'RAILS_ROOT'</span>] || <span class="string">'.'</span>

mongrel = <span class="type">Gtk</span>: : <span class="type">TrayIcon</span>.new(<span class="string">"mongrel"</span>)

<span class="variable-name">$started</span> = <span class="type">File</span>.exist? <span class="type">RAILS_ROOT</span> + <span class="string">'/log/mongrel.pid'</span>
button = <span class="type">Gtk</span>: : <span class="type">Button</span>.new(<span class="string">""</span>,  <span class="variable-name">true</span>)
button.image = <span class="type">Gtk</span>: : <span class="type">Image</span>.new(<span class="string">"</span><span class="variable-name">#{File.dirname(__FILE__)}</span><span class="string">/mong</span><span class="variable-name">#{ \
    '_mono' unless $started}</span><span class="string">.png"</span>)
button.relief = <span class="type">Gtk</span>: : <span class="type">RELIEF_NONE</span>

button.signal_connect(<span class="string">'clicked'</span>) <span class="keyword">do</span>
  <span class="keyword">if</span> <span class="variable-name">$started</span>
    button.image = <span class="type">Gtk</span>: : <span class="type">Image</span>.new(<span class="string">"</span><span class="variable-name">#{File.dirname(__FILE__)}</span><span class="string">/mong_mono.png"</span>)
    <span class="string">&#96;mongrel_rails stop -c </span><span class="variable-name">#{RAILS_ROOT}</span><span class="string">&#96;</span>
    <span class="variable-name">$started</span> = <span class="variable-name">false</span>
  <span class="keyword">else</span>
    button.image = <span class="type">Gtk</span>: : <span class="type">Image</span>.new(<span class="string">"</span><span class="variable-name">#{File.dirname(__FILE__)}</span><span class="string">/mong.png"</span>)
    <span class="string">&#96;mongrel_rails start -c </span><span class="variable-name">#{RAILS_ROOT}</span><span class="string"> -d&:96;</span>
    <span class="variable-name">$started</span> = <span class="variable-name">true</span>
  <span class="keyword">end</span>
<span class="keyword">end</span>

mongrel.add(button)
mongrel.show_all
<span class="type">Gtk</span>.main
</pre>

<p>I feel like I keep harping on this,  but man... GUI code is <i>weird</i> and unintuitive for me. Probably just a matter of familiarizing myself with the conventions,  but still. On Ubuntu/Debian:  <kbd>sudo apt-get install libgnome2-ruby libgtk-trayicon-ruby1.8</kbd> then <a href='/code/mongrel_panel.tar.gz'>grab it</a>.</p>

<p>Usage:  <kbd>RAILS_ROOT=~/projects/foo mongrel_panel.rb &</kbd> or run it from your rails root.</p>

<p>This is nothing really,  but it might be a nice base to adapt for other similar d&aelig;mons,  I suppose. Let me know if you find it useful.</p>
include(footer.html)
