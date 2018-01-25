<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, 2013-10-14T07:35:57Z)dnl
define(__title, `in which we return to the realm of the bactrian')dnl
define(__id, 170)dnl
include(header.html)
<p>A few years ago I <a href="/152">picked up a bit of OCaml</a> in
  order to put together a small, fast-launching GUI program. I had a
  lot of fun with that specific program, but soon afterward I
  dropped OCaml for general use because it was very awkward to pull
  in third-party code from outside the standard library. A month or
  two ago, a co-worker told me he was learning OCaml and mentioned
  that things had come a long way in the past few years. I was
  pleasantly surprised that not only had
  a <a href="https://realworldocaml.org/">creative-commons licensed
  book</a> been written, but the library situation was vastly
  improved with the introduction
  of <a href="http://opam.ocamlpro.com/">OPAM</a>, a fully
  respectable package manager.</p>

<p>In my mind OCaml is an excellent complement to Clojure by filling
  many of Clojure's weak places. Startup time, distributable/runtime
  size, type inference, and C integration are all fantastic in OCaml
  but often unsatisfactory in Clojure, while true concurrency, library
  availability, flexible/clear syntax, and size of the community are
  places Clojure has the edge and OCaml is very weak in.</p>

<img src="i/battery-gears.jpg" />

<p>When we've <a href="http://lein-survey-2013">polled Leiningen
  users</a> in the past, the top complaint has always been startup
  time. Most people just keep a running repl in their editor, but
  this makes certain workflows awkward. My latest project, called
  <a href="http://leiningen.org/grench.html">Grenchman</a>, addresses
  that problem by offering a fast-launching executable that connects
  directly to a running Clojure process and sends it code over the
  <a href="https://github.com/clojure/tools.nrepl">nREPL</a>
  protocol.</p>

<p>I was able to implement the first release of Grenchman in a few
  weeks with about 400 lines of OCaml while basically re-learning
  the language from scratch with the
  excellent <a href="https://realworldocaml.org/">Real World
  OCaml</a> book. My experience with the language has been very
  positive. Obviously the type system is the primary thing for which
  OCaml is notable, and with good reason. It's unobtrusive for the
  most part, and in my experience nearly every time the compiler
  complained, it was because of something stupid I had done. If
  you've used a static type system without inference, or even one
  that works on locals only, don't let bad experiences there put you
  off&mdash;the seamlessness of full Hindley-Milner inference is
  totally different.</p>

<p>The widespread use of the
  <a href="https://ocaml.janestreet.com/?q=node/78">Option type</a>
  (often called Maybe in other languages) stands out as a
  particularly helpful feature of the type system. Rather than
  allowing <tt>nil</tt> values to propagate through your program
  until someone tries to do something with them, any operation that
  could fail to return a sensible result requires you to deal with
  it explicitly before it will compile. It's occasionally a little
  more verbose, but it prevents all kinds of shortcuts in less
  strict languages (static and dynamic) that can obscure the root
  cause of subtle bugs. The certainty you get from consistent use
  of <tt>Option</tt> is similar to the easier-to-reason-about
  properties of referential transparency&mdash;there's a dimension
  of error-prone guesswork around failure semantics which simply
  evaporates.</p>

<img src="i/garden-of-the-gods.jpg" align="left" />

<p>That said, the type system isn't without its trade-offs. Any
  program that does communication with outside systems typically has
  "edges" where the compiler can't infer much about the data which
  originates outside those boundaries. In the case of Grenchman
  there is very little explicit mention of types, but acting on the
  Bencode-formatted messages sent from the Clojure server requires
  some explicit typing. Wrapper types are introduced in order for
  Strings and Lists and so on to be able to partake in the Bencode
  type, and these must be removed before the underlying values can
  be consumed. In more common serialization formats like JSON and
  XML, the wrapping and unwrapping code can be auto-generated from
  schemas, but Bencode is a more obscure format lacking in such
  luxuries.</p>

<p>The other place types must be made explicit is when interfacing
  with C functions. I used
  the <a href="https://github.com/ocamllabs/ocaml-ctypes/">Ctypes</a>
  library in order to make calls
  to <a href="https://www.gnu.org/software/readline/">GNU
  Readline</a>, and I greatly appreciated the ability to invoke that
  functionality directly instead of
  using <a href="http://cristal.inria.fr/~ddr/ledit/">a
  port</a>. That said, I had a difficult time getting it to work,
  partly due to the slim documentation and partly due to my own
  unfamiliarity with the calling conventions of C libraries.</p>

<p>One of the things which drew me to OCaml initially was the
  ability to compile small, easily-distributable native
  executables. This ended up turning out a little differently from
  my expectations for a few reasons. Firstly the use of Ctypes meant
  that I couldn't statically link everything&mdash;Ctypes is built
  upon <a href="https://sourceware.org/libffi/">libffi</a> and
  dynamically loads libreadline, making cross-distribution
  compatibility <a href="http://lists.ocaml.org/pipermail/ctypes/2013-October/000013.html">much
  more complicated</a>. But most OCaml programs won't run into that
  problem unless they need access to C code.</p>

<p>However, Grenchman is built on
  the <a href="http://janestreet.github.io/">Core and Async</a>
  libraries from <a href="https://ocaml.janestreet.com/">Jane
  Street</a>, one of the largest industrial users of OCaml. Async
  allows for monadic faux-concurrency that avoids a lot of the
  callback headaches of other event-driven tools, but it is fairly
  monolithic. This affects the size of the binaries emitted from
  OCaml's native compiler; even after running <tt>strip(1)</tt> on
  them they were still between 8.5 and 11MB. The book I was using
  cheats a bit and treats Jane Street Core as OCaml's standard
  library, which is nice because it results in code that's a lot
  more consistent and clean than it would be with OCaml's actual
  standard library, but the associated size trade-offs are
  unfortunate, and I wish they had been stated up-front.</p>

<p>While OPAM is fairly impressive and a huge improvement over the
  state of things two years ago, a couple things about it still
  bother me. One annoyance is that it's entirely source-based, so
  installing new packages can take a very long time. One impressive
  feature of OPAM is that it can handle installation and compilation
  of the OCaml compiler itself (and switching between separate
  versions), but this means pulling in a full dev stack for a given
  project can take as much as an hour. This isn't a huge deal
  though, and if I had to pick one I'd rather have a source-only
  package manager than the other way around. Creating a system that
  reliably deals in both source and binaries is very difficult. More
  worrying is the fact that it seems to encourage a "yeah, just get
  me the latest version of that" approach to versioning rather than
  defaulting to declaring explicit dependency versions. (It's
  possible to pin to specific versions, but this was only mentioned
  in passing, tucked away on the "Advanced" section of the docs, so
  I assume its use is rare.) This pattern is unrealistically
  optimistic in practice and caused lots of headaches in
  Rubygems. It was eventually be abandoned in favour of Bundler, but
  only after a very long and awkward transition phase. Hopefully the
  OCaml community can make this shift more gracefully than the
  Rubyists did by learning from their mistakes.</p>

<p>I can't say I've written lots of code in OCaml yet, but I've
  really enjoyed it so far. The extra help the compiler gives you
  allowed me to make some fairly major changes in Grenchman with a
  high degree of confidence, and being able to read type signatures
  in the libraries I was using usually made up for a general lack of
  documentation. If you've been thinking about picking up a new
  language, now is a great time to start with OCaml given the book
  and package manager.</p>
include(footer.html)
