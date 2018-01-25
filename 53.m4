<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, 2006-07-19T20:33:13Z)dnl
define(__title, `exception im notifier')dnl
define(__id, 53)dnl
include(header.html)
<p>Well,  it looks like I spoke too soon about not having anything
  interesting going on.</p>

<blockquote> The <a
href="http://dev.technomancy.us/phil/wiki/ExceptionIM">Exception IM
Notifier plugin</a> is just like the regular Exception Notifier by
Jamis Buck except that it uses <a
href="http://trypticon.org/software/actionmessenger/">ActionMessenger</a>
to send instant messages rather than using ActionMailer to send
email.</blockquote>

<p>Just do your usual <kbd>script/plugin install -x
    svn://technomancy.us/exception-im</kbd> and follow the directions
    there.</p>

<p>Note that you'll only get notification in production mode for
  obvious reasons. If you'd like to try it in development just to
  confirm that it's working,  replace "rescue_action_in_public" on line
  70 of exception_notifiable.rb with "rescue_action".</p>

<p>Anyway,  give it a go. Plans for future improvement include AIM
  integration (so far it's just Jabber) and the ability to fall back
  on email notification if the user is not online.</p>

<p>Oh,  also I found out that <a
href="http://dev.technomancy.us/phil/wiki/ebby">Ebby</a> got mentioned
in <a
href="http://applications.linux.com/article.pl?sid=06/06/27/1837234&tid=47&tid=13&tid=100">a
Linux.com article</a>. It was a pretty insignificant blurb,  but it
still seems cool by my low standards. (I've never had any high-profile
mention but for a quick link on RedHanded.)</p>

include(footer.html)
