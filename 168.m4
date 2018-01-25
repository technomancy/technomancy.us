<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, 2013-06-29T14:04:08Z)dnl
define(__title, `in which metaprogramming crosses several runtime boundaries')dnl
define(__id, 168)dnl
include(header.html)
<p>Since the <a href="/163">deprecation of swank-clojure</a> I've
been a happy user of <a href="https://github.com/kingtim/nrepl.el">nrepl.el</a>
for connecting to Clojure from Emacs. I had a lot easier time adding
features than when doing so in swank-clojure.</p>

<p>But the other day I was thinking about using
the <a href="https://github.com/clojure/tools.trace">tools.trace</a>
library, and realized it was a bit of a drag that you have to
remember to load the code up front and then remember the exact
invocation to enter in the repl to enable tracing on a given
defn. It's not much, but if there's friction in between being in the
zone and enabling a tool like that, you're likely to just fall back
to printlns. I was looking through what it would take to toggle the
tracing directly from Emacs, but at the time I wasn't really in the
mood for writing a bunch of elisp, especially not if it had to be
repeated for every command you'd want to add support for in
nrepl.el. The worst part was that if the elisp needed to invoke any
server-side code, it had to be embedded in the elisp code, usually
as strings.</p>

<p>This got me thinking about whether we could come up with a way to
make commands self-describing in such a way that the editor (whether
Emacs or another) could construct the appropriate commands
automatically. I ended up putting together a
<a href="https://github.com/technomancy/nrepl-discover">proof-of-concept</a>
which annotated tools.trace such that it could be invoked directly
from Emacs via <kbd>M-x nrepl-toggle-trace</kbd> or bound to a key
combination by the user. When I found that posed little difficulty I
went on to extend it to add a command to run tests from clojure.test
as well in a way that could mostly deprecate
<a href="https://github.com/technomancy/clojure-mode/blob/master/clojure-test-mode.el">clojure-test-mode</a>.</p>

<img src="/i/fish.jpg" alt="fish from discovery park" />

<p>The way it works is that on the server side vars are annotated
with <tt>:nrepl/op</tt> metadata that describes the command's name,
documentation, and arguments. Then an initial discovery endpoint is
provided which can tell the client about all known ops. In my
proof-of-concept, Emacs uses this data to construct
elisp <tt>defun</tt>s which prompt the user for the arguments, often
in ways involving fancy completion schemes. The results can be
displayed either as a simple message or as a number of other richer
formats. I've described the mechanism
in <a href="https://github.com/technomancy/nrepl-discover/blob/master/Proposal.md">a
slightly more formal proposal</a> here, which I hope could be useful
to others wanting to annotate their own development tools or by
maintainers of the Clojure tooling for Vim, Eclipse, etc.</p>

<p>If you've got some piece of functionality you'd like to expose to
users directly in their editor, please give it a shot. There's
probably more discussion that needs to happen around the fancier
response types as well as providing implementations for other
clients. There's <a href="https://groups.google.com/group/clojure-tools/browse_thread/thread/c08b628a9af8346d">some
discussion on the clojure-tools</a> mailing list where you can chime
up with suggestions or notes on how it's worked for you.</p>
include(footer.html)
