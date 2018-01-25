<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, 2006-03-08T12:00:19Z)dnl
define(__title, `orientation')dnl
define(__id, 38)dnl
include(header.html)
<p>The other day I was thinking to myself,  "You know,  I'm glad I don't have a widescreen display,  because I already waste a lot of horizontal space. Vertical space is much more valuable." A few pokes to my <kbd>xorg.conf</kbd> produced this: </p>
<img src='/i/multihead-rotate.jpg' alt='sideways' />
<p>If you're using X,  the trick is to add the line <code>Option "Rotate" "CW"</code> to the relevant device section. Not sure about other OSes; I've heard you can do it in Windows if you buy a special Samsung monitor. Thanks to AaronP from #xorg on freenode for pointing me in the right direction.</p> 
include(footer.html)
