dnl -*- html -*-
define(__timestamp, Sat Oct 13 00:00:01 -0700 2007)dnl
define(__title, `messages instantly')dnl
define(__id, 91)dnl
include(header.html)
<p>So I've updated my <a href='/83'>Pidgin</a> script fairly significantly. The goal here is to be able to be as keyboard-driven as possible. It's always bugged me how you need to find the pidgin window,  scroll down to find the buddy you want,  and double-click to start talking. So much excess motion. We can improve on this. I've discovered a <a href='http://www.suckless.org/wiki/tools/xlib'>nifty tool called dmenu</a> that provides super-lightweight  menus. (If you've used <a href='http://eigenclass.org/hiki.rb?wmii+ruby'>wmii</a> or dwm you'll recognize it.) Basically you send it a list of options,  and it provides you with an autocompleting choice of what has been piped in. It emits the one you chose as output,  making it very convenient for inclusion in scripts.</p>
<p>I've tied this in with Pidgin using some ruby-dbus glue. When you want to talk to someone,  you invoke the launch script and it will give you an autocompleting choice between all your buddies currently online. When you choose one,  a conversation will be opened with them. </p>
<p>Invocation is handled by the <kbd>pidgin-do.rb</kbd> script. Bind a key to <kbd>pidgin-do.rb launch</kbd> for maximal convenience.</p>
<p>Added bonus:  If you don't like keeping your buddy list visible at all times,  you can use the <kbd>list</kbd> command to get a transient notification window with the currently online buddies:  <kbd>pidgin-do.rb list</kbd></p>
<p>The only issue is that when you launch a conversation and the window is not visible,  it won't bring it front-and-center. Not sure why&mdash;this seems like it's obviously the more useful behaviour. A minor point that I intend to address soon. The <a href='https://trac.luon.net/ruby-dbus/'>ruby-dbus library</a> is still needed,  but you don't need to use the trunk version any more.</p>
<p><a href='http://dev.technomancy.us/browser/dotfiles/bin/pidgin-tools.rb'>Grab it</a> while it's hot.</p>
<p><b>Update: </b> created a <a href='http://dev.technomancy.us/wiki/PidginTools'>wiki entry</a>.</p>
include(footer.html)
