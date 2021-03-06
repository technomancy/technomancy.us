dnl -*- html -*-
define(__timestamp, 2007-10-13T07:00:01Z)dnl
define(__title, `hardware hacks')dnl
define(__id, 70)dnl
include(header.html)
<p><a
      href='http://dev.technomancy.us/phil/wiki/NorbertRobot'>Norbert</a>
      is my latest project:  a robot that I plan on building up and
      programming.</p>

<img src='/i/die_roboter.jpg' 
     alt='die roboter' title='die roboter' class='right' />


<p>I've got the motor hooked up and running,  "mocking out" the control
  logic to a pair of switches. The plan is to get my laptop on board
  and control the motors through the serial port. Apparently the
  circuitry for such a task involves using a UART chip to convert the
  serial signals into something usable,  which is going to be a bit of
  a challenge for me; I haven't worked with ICs before.</p>

<p>Currently Norbert is capable of backward and forward motion as well
  as turning,  though the limitation of using switches on the chassis
  makes control somewhat impractical.</p>

<p>The plan is all laid out in terms of what revisions will include
  what features: </p>

<ol>
  <li>Simple motion (done)</li>
  <li>Turning capability through switches (done)</li>
  <li>Platform on which to mount laptop (done)</li>
  <li>Laptop controls forward motion</li>
  <li>Laptop controls turning</li>
  <li>Laptop controls forward/reverse</li>
  <li>Autonomy (laptop can be provided with a predetermined path to
    follow rather than requiring input each step of the way)</li>
  <li>Bump sensors so that it will stop rather than keep pushing into an
    unyielding object </li>
  <li>... and more brainstorming
  on <a href='http://dev.technomancy.us/phil/wiki/NorbertRobot'>the
  wiki page</a>.</li>
</ol>

<img src='/i/norbert.jpg' alt='norbert'
     title="lil' norbert" />

<p>I drummed up a bit of code for the controller before I had really
  decided on parallel vs serial. (I had an old laptop I was
  considering using that had an easier-to-interface-with parallel
  port,  but it was lacking a battery.) Hopefully it shouldn't be too difficult
  to modify it to use the <a href='http://ruby-serialport.rubyforge.org'>
    ruby-serialport</a> library.</p>

    <pre class='code'>
<span class="keyword">class</span> <span class="type">Robot</span>
  <span class="type">COMMAND_BITS</span> = [<span class="constant">: right_motor_forward</span>,  <span class="constant">: right_motor_backward</span>, 
    <span class="constant">: left_motor_forward</span>,  <span class="constant">: left_motor_backward</span>]

  <span class="keyword">def</span> <span class="function-name">go_forward</span>
    write_byte aggregate_commands(<span class="constant">: right_motor_forward</span>,  <span class="constant">: left_motor_forward</span>)
  <span class="keyword">end</span>

  <span class="comment-delimiter"># </span><span class="comment">[go_backward and other commands...]
</span>  
  <span class="keyword">def</span> <span class="function-name">aggregate_commands</span>(*commands)
    commands.inject(0) <span class="keyword">do</span> |aggregate,  command|
      aggregate | bit_place(<span class="type">COMMAND_BITS</span>.index (command))
    <span class="keyword">end</span>
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">bit_place</span>(place)
    (2 ** place)
  <span class="keyword">end</span>

  <span class="keyword">def</span> <span class="function-name">write_byte</span>(byte)
    <span class="comment-delimiter"># </span><span class="comment">http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/24605
</span>    p = open(<span class="string">'/dev/port'</span>,  <span class="string">'w'</span>)  <span class="comment-delimiter"># </span><span class="comment">open /dev/port in write mode
</span>    p.sync = <span class="variable-name">true</span>               <span class="comment-delimiter"># </span><span class="comment">turn buffering off,  write to the
</span>                                <span class="comment-delimiter"># </span><span class="comment">port as soon as it is requested
</span>    p.seek(0x378,  <span class="type">IO</span>: : <span class="type">SEEK_SET</span>) <span class="comment-delimiter"># </span><span class="comment">move writing cursor to the parallel
</span>                                <span class="comment-delimiter"># </span><span class="comment">port address
</span>    p.putc(byte)                <span class="comment-delimiter"># </span><span class="comment">write byte to it and activate
</span>                                <span class="comment-delimiter"># </span><span class="comment">whatever on your I/O board is 
</span>                                <span class="comment-delimiter"># </span><span class="comment">attached to the D0 pin
  <span class="keyword">end</span>
<span class="keyword">end</span>
</pre>

include(footer.html)
