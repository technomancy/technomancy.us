dnl -*- html -*-
define(__timestamp, 2008-02-18T10:36:59Z)dnl
define(__title, `in which you may get started with bus scheme')dnl
define(__id, 104)dnl
include(header.html)
<p>So a number of folks have asked me how they should get started
 with Bus Scheme.[<a href='#fn1'>1</a>]. I've mostly just said silly
 things like, "Umm... good question. Maybe
 read/watch <a href='http://mitpress.mit.edu/sicp/'>SICP</a>?", which
 is silly because it doesn't have much to do with the <i>Bus</i> part
 of Bus Scheme, not because <i>The Structure and Interpretation of
 Computer Programs</i> is silly.</p>

 <p>There's a poster in <a href='http://www.powells.com/'>my favourite
 bookstore</a> that has Dante's <i>Comedy</i>, the <i>Iliad</i>, and a
 few other classics captioned with something like "Might as well start
 them now; you're going to have to read them eventually anyway." I
 hold the same notion regarding SICP and perhaps <i>The Little
 Schemer</i>, but I could see how it'd be helpful to have an
 introduction to Scheme from a Rubyist's perspective since reading a
 book like that can be large-ish mental investment.</p>

<p>Scheme is a programming language directly descended from Lisp. It's
most often compared to Common Lisp, which is in some senses its big
brother. Scheme is usually considered less "kitchen-sink"-ish than
Common Lisp in that it only defines an extremely clean small core
language and allows developers to extend it seamlessly to do what they
need. In the words of the creators of Scheme:</p>

<blockquote> Programming languages should be designed not by piling
 feature on top of feature, but by removing the weaknesses and
 restrictions that make additional features appear
 necessary.</blockquote>

<p>(As a potential student of Scheme, you should be encouraged by this
notion as it directly translates into fewer concepts to learn.)</p>

<p>Ruby draws a lot of its heritage from Scheme, though Matz does not
share the idea that a language should be limited to a very small
number of core axioms from which everything else can be
defined. [<a href='#fn2'>2</a>] Destructive method names ending in "!"
and predicates ending in "?" were inspired by Scheme. Matz himself has
even lightheartedly referred to Ruby as "MatzLisp". So this is a
language that at the core should not feel too foreign to a Rubyist,
even if the syntax looks quite different.</p>

<p>Let's dive in. <kbd>sudo gem install bus-scheme</kbd> if you
haven't got it installed. Go ahead and launch Bus Scheme with
the <kbd>bus</kbd> executable. Like <kbd>irb</kbd>, it drops you into
a REPL, or Read-Eval-Print Loop. Scheme programs are made up
of <b>expressions</b>. When you enter expressions into the REPL, they
get evaluated and their value is shown. There are only a few simple
rules for how expressions get evaluated that we'll address below. Feel
free to experiment with entering expressions and seeing what gets
returned.</p>

<p>The simplest expressions are just <b>atoms</b>, which are simple
"indivisible" values, like symbols, numeric values, and strings. Some
atoms evaluate to themselves just like in Ruby, so
entering <kbd>12</kbd> into the REPL returns (and echoes)
12. <kbd>"foo"</kbd> works the same way. Symbols are a little
different. Ruby uses a colon before the symbol's name, but in Scheme
you refer to a symbol just using its name. So <kbd>baz</kbd> refers to
the symbol with the name "baz". But if you enter <kbd>baz</kbd> into
the REPL, Bus Scheme complains:</p>

<pre class='code'>&gt; baz<br />Error: Undefined symbol:
baz</pre> <p>This is because symbols aren't
considered <b>literals</b>; that is, they don't evaluate to themselves
like they do in Ruby. When Bus Scheme encounters a symbol in this
context, it treats it as a variable and tries to return the value
that's bound to it, which doesn't work when it's not bound. So let's
see what happens with a symbol that already has a value bound to
it:</p>
<pre class='code'>&gt; +<br />
#&lt;Proc:0xb7c4b2a8@./bin/../lib/primitives.rb:16&gt;</pre> <p>This
is the way Bus Scheme represents a built-in
(primitive) <b>function</b>. In Scheme, functions are first-class
values, so you can bind them to variables, like you can with
the <code>lambda</code> keyword in Ruby. But in Scheme this the
primary way you refer to functions when you want to call them or pass
them to other functions.</p>

<p>Speaking of calling functions, it works something like this:</p>

<pre class='code'>&gt; (+ 3 4)<br /> 7</pre>
<p>This is a <b>list</b>, which is Scheme's compound expression. This
list is made up of three elements, in this case all atoms: the
symbol <kbd>+</kbd>, the number 3, and the number 4. In normal
contexts, when Scheme sees a list it treats it as a function
call. First the first item in the list is evaluated, which evaluates
to a Ruby Proc object. Then each of the remaining list elements are
evaluated. Since they're all literals here, they evaluate to
themselves. Then the arguments get passed to the function. Behind the
scenes, this translates rougly into <code>Proc.new{|*args|
args.sum}.call(3, 4)</code>. Let's see something a bit more
complicated:</p>

<pre class='code'>&gt; (+ (+ 1 2) (+ 3 4))<br /> 10</pre>

<p>In this case, the first <code>+</code> gets evaluated, and Bus
Scheme sees that it's a function. So it looks at its
arguments: <code>(+ 1 2)</code> gets evaluated to 3, and <code>(+ 3
4)</code> gets evaluated to 7. Then those two arguments get passed
to <code>+</code> and the result becomes the value of the whole
expression. </p>

<p>That's the basics of how program execution happens, but you won't
get far without having a few more functions under your belt. Here are
a some to get you rolling:</p>

<dl>
  <dt>+, -, *, and /</dt>
  <dd>You've been introduced to + above, but I'm sure you recognize
  your other old friends from grade-school days. + and * support any
  number of arguments, but - and / take two. In regular Scheme these
  all only work for numerical types, but Bus Scheme borrows Ruby's
    methods and lets you pass strings and other objects to + and *.</dd>

  <dt>&lt;, &gt;, and =</dt>
  <dd>These are comparison functions. They work like they do in any
  language, but in Scheme you invoke them as <code>(&gt; 3 7)</code>
  etc. Again, Bus Scheme uses Ruby's underlying methods, so you can
    pass strings and other objects in, unlike in regular Scheme.</dd>

  <dt>list</dt>
  <dd>If you want a list of numbers, you may think you get this by
  entering <code>(1 2 3)</code>. The problem with this is that in
  normal contexts it gets treated like a function call, and it will
  complain that 1 is not a function. What you can do instead
  is <code>(list 1 2 3)</code>, which evaluates to (1 2 3).</dd>

  <dt>map</dt>
  <dd>This works like Ruby's map, but it's a free-standing function
  instead of a method. So instead of <code>[1, 2, 3].map {|x| x +
  3}</code> you would do <code>(map (lambda (x) (+ x 3)) (list 1 2
      3)</code>, which would return <code>(4 5 6)</code>.</dd>

  <dt>substring</dt>
  <dd>Bus Scheme's <code>(substring "foobar" 3 5)</code> translates
    into <code>"foobar"[3 .. 5]</code> in Ruby.</dd>

  <dt>if</dt>
  <dd>The most basic conditional is <code>if</code>. Use it like
  this: <code>(if x "x is true" "x is false")</code>. <code>if</code>
  evaluates its first argument, which in this case is x. If it
  evaluates to a true value [<a href='#fn3'>3</a>] then its second
  argument gets evaluated and returned. If it's false then the
  remaining arguments (if any) are evaluated and the last one is
    returned.[<a href='#fn4'>4</a>]</dd>
</dl>

<p>Well, that's enough for now. You may not know enough to be
dangerous, but I hope you know enough to explore. Tune in next time
when I uncover the true Secrets of Lisp&trade; by
explaining <code>cons</code>, <code>lambda</code>, and special
forms.</p>

<hr>
<div class="footnotes">
<p><a name='fn1'>1</a> - I didn't say it was a large number.</p>
<p><a name='fn2'>2</a> - I imagine this causes <a href='http://blog.fallingsnow.net'>Evan</a> and <a href='http://headius.blogspot.com/'>Charles</a> some varying amounts of distress.</p>
<p><a name='fn3'>3</a> - In Scheme every value is true except <code>#f</code>, which is equivalent to Ruby's <code>false</code>.</p>
<p><a name='fn4'>4</a> - Observant readers will note that this does not follow the evaluation rule for functions given above which states that every argument is evaluated before the function is called. This is because <code>if</code> is not technically a function, but rather a <b>special form</b>, and different rules apply for the evaluation of a special form's arguments. There's more to this than I can cover in this article, but these rules allow for great syntactic flexibility.</p>
</div>

include(footer.html)
