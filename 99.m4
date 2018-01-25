<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Mon Dec 17 00:52:14 -0800 2007)dnl
define(__title, `another one rides the bus')dnl
define(__id, 99)dnl
include(header.html)
    <p>Well,  Bus Scheme has matured just a bit. It's gotten to the point where the gaps in functionality are a bit less crippling. But the more interesting bit is that it's hosted at a publicly accessible repository now,  so you can grab it if you're interested.</p>
<pre class='code'> $ git clone git://git.caboo.se/bus_scheme.git </pre>
<p>I've submitted a <a href='http://bus-scheme.rubyforge.org'>rubyforge project</a>,  and it should get approved soon so I can upload to it. At that point gem installation should be possible with an ordinary,  everyday <kbd>sudo gem install bus-scheme</kbd>.</p>
<p>At this point there are still some pretty hairy problems with scope; the implementation is as na&iuml;eve as possible. Lexically scoped it is not,  and closures are a ways off still. Basic &lambda; functionality is a go. You can peek at <a href='http://git.caboo.se/?p=bus_scheme.git;a=blob;f=test/test_eval.rb;hb=7cd761db8b353e2a556d3c182d78b40c1a6e2164'>some</a> <a href='http://git.caboo.se/?p=bus_scheme.git;a=blob;f=test/test_parser.rb;hb=7cd761db8b353e2a556d3c182d78b40c1a6e2164'>tests</a> to see how far along it is. Everything uncommented should pass; commented tests mean "to do" items.</p>
<p>Also,  I've tested it out and it works in Ruby 1.8,  Ruby 1.9,  and Rubinius. A few folks on the Rubinius team have expressed interest in getting it to compile down to Rubinius bytecode,  which would be pretty exciting.</p>
<p><b>Much thanks</b> go to <a href='http://blog.caboo.se'>Courtenay</a> and <a href='http://scie.nti.st'>Garry</a> for helping get the repository public.</p>
<p>REPL it up!</p> <p><b>Update</b>: It's now <a href='http://github.com/technomancy/bus-scheme'>on Github</a>.
include(footer.html)
