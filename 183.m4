<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, 2017-05-14T21:01:31Z)dnl
define(__title, `in which actors simulate a protocol')dnl
define(__id, 183)dnl
include(header.html)
<p>I've been on a bit of a yak shave recently
  on <a href="">Bussard</a>, my spaceflight programming adventure
  game. The game relies pretty heavily on simulating various
  computer systems, from your own craft to space stations, portals,
  rovers, and other craft. It naturally needs to simulate
  communications between all these.</p>

<p>I started with a pretty simple method of having each connection
  spin up its own coroutine running its own sandboxed session. Space
  station sessions
  run <a href="https://gitlab.com/technomancy/bussard/blob/threads/os/orb/resources/smash">smash</a>,
  a vaguely bash-like shell in a faux-unix, while connecting to a
  portal
  triggers <a href="https://gitlab.com/technomancy/bussard/blob/beta-2/os/lisp/resources/portal.lsp">a
  small lisp script to check for clearance and gradually activate
  the gateway sequence</a>. The main loop would allow each session's
  coroutine a slice of time for each update tick, but a
  badly-behaved script could make the frame rate
  suffer. (Coroutines, you will remember, are a form
  of <a href="https://en.wikipedia.org/wiki/Cooperative_multitasking">cooperative
  multitasking</a>; not only do they not allow more than one thing to
  literally be running at the same time, but handing control off
  must be done explicitly.) Also input and output was
  handled in a pretty ad-hoc method where Lua tables were used as
  channels to send strings to and from these session coroutines. But
  most problematic of all was the fact that there wasn't any
  uniformity or regularity in the implementations of the various
  sessions.</p>

<img src="/i/bussard-rpc.png" alt="Bussard shell session">

<p>The next big feature I wanted to add was the ability to deploy
  rovers from your ship and SSH into them to control their
  movements or reprogram them. But I really didn't want to add a
  third half-baked session type; I needed all the different implementations
  to conform to a single interface. This required some rethinking.</p>

<p>The codebase is written primarily in Lua, but not just any
  Lua&mdash;it uses the <a href="https://love2d.org">LÖVE</a>
  framework. While Lua's concurrency options are very limited,
  LÖVE offers <a href="https://love2d.org/wiki/love.thread">true
  OS threads</a> which run independently of each other. Now of
  course LÖVE can't magically change the semantics of
  Lua&mdash;these threads are technically in the same process but
  cannot communicate directly. All communication happens
  over <a href="https://love2d.org/wiki/Channel">channels</a> (aka queues)
  which allow <em>copies</em> of data to be shared, but not actual
  state.</p>

<p>While these limitations could be annoying in some cases, they
  turn out to be a perfect fit for simulating communications
  between separate computer systems. Moving to threads allows for
  much more complex programs to run on stations, portals, rovers,
  etc without adversely affecting performance of the game.</p>

<p>Each world
  has <a href="https://gitlab.com/technomancy/bussard/blob/threads/os/server.lua">a
  server thread</a> with a pair of input/output channels that gets
  started when you enter that world's star system. Upon a
  successful login, a thread is created for that specific session, which
  also gets its own <tt>stdin</tt> channel. Input from the main
  thread's SSH client gets routed from the server thread to
  the <tt>stdin</tt> channel of each specific session. Each OS
  implementation can provide its own implementation of what
  a <a href="https://gitlab.com/technomancy/bussard/blob/threads/os/orb/session.lua">session
  thread</a> looks like, but they all exchange stdin and stdout
  messages over channels. Interactive sessions will typically run
  a shell like <tt>smash</tt> or a repl, and their thread parks
  on <tt><a href="https://love2d.org/wiki/Channel:demand">stdin:demand()</a></tt>, waiting until the main thread
  has some input to send along.</p>

<p>This works great for regular input and output, but sometimes it's
  necessary for the OS thread to make state changes to tables in the
  main thread, such as
  the <a href="https://gitlab.com/technomancy/bussard/blob/threads/os/orb/resources/cargo">cargo</a>
  script for buying and selling. Time to build an RPC mechanism! I
  created <a href="https://gitlab.com/technomancy/bussard/blob/threads/rpcs.lua">a
  whitelist table of all functions which should be exposed</a> to
  code running in a session thread over RPC. Each of these is
  exposed as a shim function in the session's sandbox:</p>

  <pre class="code"><span class="keyword"><span class="region">local</span></span><span class="region"> </span><span class="function-name"><span class="region">add_rpc</span></span><span class="region"> = </span><span class="keyword"><span class="region">function</span></span><span class="region">(sandbox, name)
   sandbox[name] = </span><span class="keyword"><span class="region">function</span></span><span class="region">(...)
      </span><span class="keyword"><span class="region">local</span></span><span class="region"> </span><span class="variable-name"><span class="region">chan</span></span><span class="region"> = love.thread.newChannel()
      output:push({op=</span><span class="string"><span class="region">"rpc"</span></span><span class="region">, fn=name, args={...}, chan=chan})
      </span><span class="keyword"><span class="region">local</span></span><span class="region"> </span><span class="variable-name"><span class="region">response</span></span><span class="region"> = chan:demand()
      </span><span class="keyword"><span class="region">if</span></span><span class="region">(response[1] == </span><span class="string"><span class="region">"_error"</span></span><span class="region">) </span><span class="keyword"><span class="region">then</span></span><span class="region">
         </span><span class="builtin"><span class="region">table</span></span><span class="region">.</span><span class="builtin"><span class="region">remove</span></span><span class="region">(response, 1)
         </span><span class="builtin"><span class="region">error</span></span><span class="region">(</span><span class="builtin"><span class="region">unpack</span></span><span class="region">(response))
      </span><span class="keyword"><span class="region">else</span></span><span class="region">
         </span><span class="keyword"><span class="region">return</span></span><span class="region"> </span><span class="builtin"><span class="region">unpack</span></span><span class="region">(response)
      </span><span class="keyword"><span class="region">end</span></span><span class="region">
   </span><span class="keyword"><span class="region">end</span></span><span class="region">
</span><span class="keyword"><span class="region">end</span></span><span class="region"></span></pre>

<p>When the shim function is called it sends an <tt>op="rpc"</tt>
  table with a new throwaway channel (used only for communicating
  the return value), and sends it back over the output channel. The
  main thread picks this up, looks up the function in
  the <tt>rpcs</tt> table, and sends a message back over the
  response channel with the return value. This same RPC mechanism
  works equally well for scripts on space stations as it does for
  the portal control script, and a similar variation (but going the
  other direction) allows the SSH client to implement tab completion
  by making an RPC call to get completion targets.</p>

<p>They're not perfect, but the mechanisms LÖVE offers for
  concurrency have been a great fit in this particular case.</p>
include(footer.html)
