<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, 2006-07-28T23:12:21Z)dnl
define(__title, `the afternoon&apos;s hack')dnl
define(__id, 55)dnl
include(header.html)
<p>Last February,  I started a project
  called <a
  href='http://dev.technomancy.us/phil/wiki/RuseMail'>RuseMail</a> and
  promptly forgot about it since I couldn't get the bindings compiled
  properly. This afternoon,  I finished it.</p>

<p>The formula behind RuseMail is really really simple:  FUSE + IMAP =
  RuseMail. (The code is not <i>too</i> much longer than that
  formula.) FUSE is a Linux tool that allows you to create filesystems
  in userspace,  and IMAP is a mail protocol that (while internally
  being hideously ugly to behold) allows a mailbox to be treated like
  a file system. Sort of. (So far it's a read-only filesystem.)</p>

<p>Anyway,  the code isn't much,  but once again it's the idea that
  counts. Right? Give it a go if you're interested,  but note that
  you'll need to
  install <a
  href='http://rubyforge.org/frs/?group_id=948&release_id=3876'>FuseFS</a>
  (the Ruby FUSE bindings) for it to work.</p>

include(footer.html)
