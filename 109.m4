dnl -*- html -*-
define(__timestamp, 2008-05-13T23:31:01Z)dnl
define(__title, `in which light is shed upon some previously unexplored frontiers')dnl
define(__id, 109)dnl
include(header.html)
<p>So I've been working on modularizing a big project at work. The REST API for this one project needs to be used in multiple places, so
I've taken it out of the Rails app and spun it off into its own server
using <a href='http://rack.rubyforge.org'>Rack</a>. Rack is a library
that abstracts away the gory details of HTTP and gives you a nice
object-oriented wrapper for it, allowing you to plug it into multiple
different backends. It's great for accelerating development on your
simple lightweight services that wouldn't otherwise justify a Merb or
Rails application. Ezra gives <a
href='http://brainspl.at/articles/2008/02/16/so-merb-core-is-built-on-rack-you-say-why-should-i-care'>a
good explanation of why you might be interested in Rack</a>.</p>

<p>Anyhow, I was able to put this together fairly quickly by hooking
up libxml, ActiveRecord, and Rack. (If I were doing it again I'd use
<a
href='http://github.com/codahale/faster-builder/tree/master'>faster-builder</a>,
which I found out about a few hours after I started the project, but
whatever.) But this particular project must be able to support
ridiculously large XML responses that could be larger than 4GB. On a
32-bit machine this is... well... problematic. The solution, of
course, is to stream the response back to the client as it's
generated so it doesn't have to all be in memory at once.</p>

<p>Unfortunately the only Ruby support for HTTP streaming I was able
to find by searching the web is about streaming static files. I was
getting pretty discouraged until Ezra mentioned that Merb bundles a
patched version of Rack that allows streaming of programmatic
content.</p>

<p>Sure enough, Merb's changes to Rack <a
href='http://technomancy.us/code/streaming_quine.rb'>do the
trick</a>:</p>

<pre class='code'>require <span class='string'>'rubygems'</span>
require <span class='string'>'rack/response'</span>
require <span class='string'>'rack/handler/mongrel'</span>

<span class='comment-delimiter'># </span><span class='comment'>Launches an HTTP server on http://localhost:9999/N that streams its own code N times
</span><span class='type'>Rack</span>::<span class='type'>Handler</span>::<span class='type'>Mongrel</span>.run(<span class='type'>Proc</span>.new <span class='keyword'>do</span> |env|
                             [200, {}, <span class='type'>Proc</span>.new <span class='keyword'>do</span> |response|
                                response.send_status_no_connection_close(<span class='string'>''</span>)
                                response.send_header
                                env[<span class='string'>'PATH_INFO'</span>][/(\d+)/].to_i.times <span class='keyword'>do</span>
                                  response.write <span class='type'>File</span>.read(__FILE__) + <span class='string'>'\n'</span>; sleep 1
                                <span class='keyword'>end</span>
                                response.write <span class='string'>'\r\n\r\n'</span>
                              <span class='keyword'>end</span>]
                           <span class='keyword'>end</span>, :<span class='type'>Port</span> =&gt; 9999)
</pre>

<p>I check the streaming with curl; if it's properly streamed the <code>%
Received</code> will climb slowly instead of jumping at once to 100:</p>

<pre class='code'>$ curl http://localhost:9999/7 > /dev/null
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  5310    0  5310    0     0    755      0 --:--:--  0:00:07 --:--:--   796</pre>

<p>It's not clear to me why this functionality isn't in the standard
Rack distribution. Merb seems to be Rack's biggest user, so the fact
that they have to bundle their own patched version seemes quite
odd. Anyway, if you need HTTP streaming outside Merb, you can use my
<a href='http://technomancy.us/code/rack-0.3.0.gem'>version of
Rack</a>. I haven't been able to get the gem served by Github;
unreproducible remote problems in the gem build process are very
opaque and give no feedback. Will look into this later.</p>

<p>I'm going to try to get the changes into the mainline rack, but if
Merb hasn't been able to get it accepted this may not actually
happen. The meat of the patch is three lines, but I've got a bunch
of other stuff that allows the project to actually build as a gem;
the source as I found it was not in a working state. (Who knew there
were people out there who haven't yet discovered <a
href='http://blog.zenspider.com/2006/09/farmer-ted-uses-hoe-to-beat-ra.html'>hoe</a>?)</p>

<p><b>Update</b>: It sounds like the streaming stuff hasn't been
accepted upstream because it only works with Mongrel, and the whole
point of Rack is to provide a consistent interface across many
different web servers. I may try to port the streaming functionality
to other servers so it can become part of the official spec.</p>

<p>Much thanks to Ezra for the fix. I was starting to lose hope that
I'd even be able to even pull this off without resorting to
low-level Mongrel invocations. Even though the fix is available in
Merb, it's not really very clear how to use it, so I thought this
post would save other people from going through the same crazy hoops
I had to.</p>

<p><b>Update</b>: My patches have been accepted upstream, so
streaming works out of the box with Mongrel in Rack 0.9 and
higher.</p>
include(footer.html)
