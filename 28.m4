dnl -*- html -*-
define(__timestamp, 2006-02-05T15:39:44Z)dnl
define(__title, `rav')dnl
define(__id, 28)dnl
include(header.html)
<img src='/i/rav.png' align='left' /> <p>Don't let's get too excited now. This is just a first draft:  something <a href='http://blog.vemod.net'>Qerub</a> and I cooked up. It doesn't do everything. But for those of you working in Rails,  if you're tired of penciling out your diagrams... tired of creating new ones when you change the name of a field... Try this instead: </p> <p class='code'>$ script/plugin install svn://rubyforge.org/var/svn/rav/trunk</p> <p class='code'>$ rake visualize</p> <p>Poof,  you've got your funny little <kbd>diagram.png</kbd>. Or if you'd rather,  pass it <code>FILENAME=diagram.svg</code> if you'd like something scalable. It's all good.</p> <p>I should have a Rubyforge page up soon,  but 'till then be nice to my poor server and DSL line. BTW,  this requires graphviz to run properly. More details are in the <a href='http://dev.technomancy.us/phil/browser/rav/README'>README</a>. Mad props to Qerub for doing most of the coding; I've mostly just been cheerleading,  packaging,  and documenting.</p> <p>Happy hacking!</p> <p><b>Update: </b> <a href='http://rav.rubyforge.org'>Rubyforge project page</a> is up!</p>
include(footer.html)
