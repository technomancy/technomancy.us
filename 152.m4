<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Sun 14 Aug 2011 09:37:00 PM EDT)dnl
define(__title, `in which static types are friends, not foes')dnl
define(__id, 152)dnl
include(header.html)
<p>I'm a big fan of composability in user interfaces. Unix has
  traditionally been strong in this area with its culture of pipes
  and standard in/out, making it easy to chain together small tools
  with orthogonal purposes. Unfortunately this usually does not
  extend to GUI tools which often tend towards monolithic
  globs of functionality. There are a few exceptions, my favourites
  including <a href="http://www.nongnu.org/xbindkeys/xbindkeys.html">xbindkeys</a>
  and <a href="http://musicpd.org/">mpd</a>.</p>

<p>The most versatile of these I've found has
  been <a href="http://tools.suckless.org/dmenu">dmenu</a>, a
  graphical option chooser in the style of Emacs' <tt>ido-mode</tt>:
  it presents a list of options, and as you type it narrows to just
  the options which match the input that's been entered so far. I've
  built a number of tools on top of this including
  a <a href="https://github.com/technomancy/dotfiles/blob/43e98156961a7592a1b809740d0af4f04d4835db/bin/music-choose">music
  frontend to mpd</a>
  and <a href="https://github.com/technomancy/dotfiles/blob/master/bin/skyyy">a
    script that allows me to perform a number of Skype actions from
    the keyboard</a>.</p>

<p>The problem is that dmenu is pretty minimalistic compared to
  ido. The main annoyance to me is that it doesn't support flex
  matching&mdash;in other words, only exact matches are shown. In Emacs,
  <tt>ido</tt> lets me match a few characters against the front of
  the string and a few against the tail. Any input is accepted as
  long as it uniquely identifies one of the choices. Since dmenu is
  written in C I didn't exactly relish the idea of picking up skills
  in that language to add this functionality, so I wrote a
  replacement in OCaml instead:</p>

<pre class="code"><span class="tuareg-font-lock-governing">let</span> <span class="tuareg-font-lock-governing">rec</span> <span class="function-name">read_lines</span><span class="variable-name"> lines </span><span class="tuareg-font-lock-operator">=</span>
  <span class="keyword">try</span> read_lines <span class="tuareg-font-lock-operator">(</span>read_line <span class="tuareg-font-lock-operator">()</span> <span class="tuareg-font-lock-operator">::</span> lines<span class="tuareg-font-lock-operator">)</span>
  <span class="keyword">with</span> End_of_file <span class="tuareg-font-lock-operator">-&gt;</span> lines

<span class="tuareg-font-lock-governing">let</span> <span class="variable-name">lines </span><span class="tuareg-font-lock-operator">=</span> read_lines <span class="tuareg-font-lock-operator">[]</span>

<span class="tuareg-font-lock-governing">let</span> <span class="function-name">lines_matching</span><span class="variable-name"> pattern matched line </span><span class="tuareg-font-lock-operator">=</span>
  <span class="keyword">try</span> <span class="tuareg-font-lock-governing">let</span> <span class="variable-name">_ </span><span class="tuareg-font-lock-operator">=</span> <span class="type">Str</span>.search_forward pattern line 0 <span class="tuareg-font-lock-governing">in</span> 
      line <span class="tuareg-font-lock-operator">::</span> matched
    <span class="keyword">with</span> Not_found <span class="tuareg-font-lock-operator">-&gt;</span> matched

<span class="tuareg-font-lock-governing">let</span> <span class="function-name">escape</span><span class="variable-name"> </span><span class="tuareg-font-lock-operator">=</span> <span class="keyword">function</span>
 <span class="variable-name"> </span><span class="tuareg-font-lock-operator">|</span> <span class="string">' '</span> <span class="tuareg-font-lock-operator">-&gt;</span> <span class="string">".*"</span>
  <span class="tuareg-font-lock-operator">|</span> c <span class="tuareg-font-lock-operator">-&gt;</span> <span class="type">Char</span>.escaped c

<span class="tuareg-font-lock-governing">let</span> <span class="function-name">pattern</span><span class="variable-name"> input </span><span class="tuareg-font-lock-operator">=</span>
  <span class="type">Str</span>.regexp <span class="tuareg-font-lock-operator">(</span><span class="type">String</span>.concat <span class="string">""</span> <span class="tuareg-font-lock-operator">(</span><span class="type">List</span>.map escape input<span class="tuareg-font-lock-operator">))</span>

<span class="tuareg-font-lock-governing">let</span> <span class="function-name">matched</span><span class="variable-name"> input lines </span><span class="tuareg-font-lock-operator">=</span>
  <span class="type">List</span>.fold_left <span class="tuareg-font-lock-operator">(</span>lines_matching <span class="tuareg-font-lock-operator">(</span>pattern input<span class="tuareg-font-lock-operator">))</span> <span class="tuareg-font-lock-operator">[]</span> lines

<span class="tuareg-font-lock-governing">let</span> <span class="tuareg-font-lock-governing">rec</span> <span class="function-name">draw_matches</span><span class="variable-name"> matches </span><span class="tuareg-font-lock-operator">=</span>
  <span class="type">Graphics</span>.open_graph <span class="string">" 1440x15"</span><span class="tuareg-font-lock-operator">;</span>
  <span class="type">Graphics</span>.set_window_title <span class="string">"erythrina"</span><span class="tuareg-font-lock-operator">;</span>
  <span class="type">Graphics</span>.draw_string <span class="tuareg-font-lock-operator">(</span><span class="type">String</span>.concat <span class="string">" | "</span> matches<span class="tuareg-font-lock-operator">)</span>

<span class="tuareg-font-lock-governing">let</span> <span class="function-name">finish</span><span class="variable-name"> input lines </span><span class="tuareg-font-lock-operator">=</span>
  <span class="type">Graphics</span>.close_graph <span class="tuareg-font-lock-operator">();</span>
  <span class="keyword">match</span> matched input lines <span class="keyword">with</span>
    <span class="tuareg-font-lock-operator">|</span> f <span class="tuareg-font-lock-operator">::</span> _ <span class="tuareg-font-lock-operator">-&gt;</span> print_string f
    <span class="tuareg-font-lock-operator">|</span> <span class="tuareg-font-lock-operator">[]</span> <span class="tuareg-font-lock-operator">-&gt;</span> <span class="tuareg-font-lock-operator">()</span>

<span class="tuareg-font-lock-governing">let</span> <span class="function-name">butlast</span><span class="variable-name"> input </span><span class="tuareg-font-lock-operator">=</span>
  <span class="keyword">match</span> <span class="type">List</span>.rev input <span class="keyword">with</span>
    <span class="tuareg-font-lock-operator">|</span> <span class="tuareg-font-lock-operator">[]</span> <span class="tuareg-font-lock-operator">-&gt;</span> <span class="tuareg-font-lock-operator">[]</span>
    <span class="tuareg-font-lock-operator">|</span> _ <span class="tuareg-font-lock-operator">::</span> rest <span class="tuareg-font-lock-operator">-&gt;</span> <span class="type">List</span>.rev rest

<span class="tuareg-font-lock-governing">let</span> <span class="tuareg-font-lock-governing">rec</span> <span class="function-name">main</span><span class="variable-name"> input </span><span class="tuareg-font-lock-operator">=</span>
  draw_matches <span class="tuareg-font-lock-operator">(</span>matched input lines<span class="tuareg-font-lock-operator">);</span>
  <span class="keyword">match</span> <span class="type">Graphics</span>.read_key <span class="tuareg-font-lock-operator">()</span>  <span class="keyword">with</span>
    <span class="tuareg-font-lock-operator">|</span> <span class="comment-delimiter">(* </span><span class="comment">enter </span><span class="comment-delimiter">*)</span> <span class="string">'\r'</span> <span class="tuareg-font-lock-operator">-&gt;</span> finish input lines
    <span class="tuareg-font-lock-operator">|</span> <span class="comment-delimiter">(* </span><span class="comment">escape </span><span class="comment-delimiter">*)</span> <span class="string">'\027'</span> <span class="tuareg-font-lock-operator">-&gt;</span> <span class="type">Graphics</span>.close_graph <span class="tuareg-font-lock-operator">()</span>
    <span class="tuareg-font-lock-operator">|</span> <span class="comment-delimiter">(* </span><span class="comment">backspace </span><span class="comment-delimiter">*)</span> <span class="string">'\b'</span> <span class="tuareg-font-lock-operator">-&gt;</span> main <span class="tuareg-font-lock-operator">(</span>butlast input<span class="tuareg-font-lock-operator">)</span>
    <span class="tuareg-font-lock-operator">|</span> <span class="comment-delimiter">(* </span><span class="comment">any other </span><span class="comment-delimiter">*)</span> c <span class="tuareg-font-lock-operator">-&gt;</span> main <span class="tuareg-font-lock-operator">(</span><span class="type">List</span>.append input <span class="tuareg-font-lock-operator">[</span>c<span class="tuareg-font-lock-operator">])</span>

<span class="tuareg-font-lock-governing">let</span> <span class="variable-name">_ </span><span class="tuareg-font-lock-operator">=</span> main <span class="tuareg-font-lock-operator">[]</span></pre>

<p>In 39 lines of OCaml I've achieved near feature-parity to the
  700 lines of C that make up dmenu. The only missing features are
  tab-completion and font/color customization, though I have added
  the flex-matching feature mentioned above that dmenu lacks, which
  makes tab completion less important.</p>

<p>This is my second foray back into the land of static typing since
  university. (Supposedly I learned C++ in school, but I've long
  since mercifully forgotten it all.) I picked
  up <a href="http://mirah.org">Mirah</a> last year
  and <a href="/145">spent a little more time hacking in it earlier
  this year for an Android app</a>. While Mirah is a huge
  improvement over Java, its type inference unfortunately only
  extends to locals, (a common shortcoming of most JVM-hosted type
  systems from what I gather) meaning if you tend to write small
  methods you end up specifying all your types anyway. OCaml on the
  other hand infers all types
  using <a href="http://en.wikipedia.org/wiki/Type_inference#Hindley.E2.80.93Milner_type_inference_algorithm">Hindley
  Milner inference</a>, allowing the types to be effectively
  invisible.</p>

<p>I've only spent a few days writing OCaml, but I've got to say I'm
  impressed. The type system stayed out of the way, only making a
  fuss when I'd clearly made an error. Pattern matching is a dream:
  you'll notice that all the conditionals in the code above come
  from <tt>match</tt> rather than <tt>if</tt>. It's fast, it's
  pleasantly interactive, (especially
  via <a href="http://marmalade-repo.org/packages/tuareg">tuareg</a>
  and Emacs) and the executables produced by the compiler are tiny
  and quick to start, which is valuable for anyone who spends a lot
  of time on the JVM and is looking for something to fill those
  pesky gaps for which the JVM is admittedly lousy.</p>

<p>My only real complaints surround the fact that the standard
  library is slim and quirky. It throws exceptions in places you
  wouldn't expect, like hitting the end of the file while reading or
  searching for a regex when the text contains no match. The regex
  support is a bit odd, but that's not too surprising considering
  how old the language is.</p>

<p>Of course the standard library is augmented by a number of
  third-party libraries. It seems like up until recently it's been
  assumed that you'll use either <tt>apt-get</tt> as the main way to
  pull these in or run <tt>make install</tt> from source. As
  I've <a href="/152">blogged about recently</a>, <tt>apt-get</tt>
  is a bit of a drag for libraries that are obscure or change
  frequently. It looks
  like <a href="http://oasis.forge.ocamlcore.org/documentation.html">Oasis</a>
  is making it easier to build projects
  while <a href="http://oasis.ocamlcore.org/dev/browse">ODB</a> is
  the beginning of a rich library dependency system, though it's
  still got a long way to go. My needs have been simple enough that
  I've been able to stick with the standard library for my current
  project, but it's great to see progress in this direction.</p>

<p>Anyway, it's always a bit disorienting to toss yourself into a
  new environment like this. But OCaml has proven to be quite a
  treat. I recommend starting
  with <a href="http://mirror.ocamlcore.org/ocaml-tutorial.org/">this
  OCaml Tutorial</a> which also links off to many other helpful
  resources. Have fun!</p>

<p><b>Update</b>: As of version 4.5, dmenu has implemented fuzzy
  matching, making erythrina interesting mostly for educational
  purposes.</p>

<p><b>Update</b>: I've posted <a href="/170">further reflections on
  OCaml and how the ecosystem has changed in the time since this was
  written.</a></p>
include(footer.html)
