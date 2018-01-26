dnl -*- html -*-
define(__title, `R&eacute;sum&eacute;')dnl
include(header.html)

<div id='resume'>
  <div style='text-align: center;'>
    <a name='top'></a><h2>Philip N. Hagelberg</h2>
    <address>phi<span style='display: none;'>¡no spam thank you!</span>l@hagelb.org</address>
  </div>

  <div>
    <a name='skills'></a><h3>Skills</h3>
    <dl>
      <dt>Languages</dt>
      <dd>Proficient in
        <a href='http://clojure.org'>Clojure</a>,
        <a href='https://www.gnu.org/software/emacs/'>Emacs Lisp</a>, and
        <a href='http://lua.org'>Lua</a>.
        Experience with
        <a href='http://erlang.org'>Erlang</a>,
        <a href='http://racket-lang.org'>Racket</a>,
        <a href='http://caml.inria.fr/'>OCaml</a>,
        <a href='https://github.com/technomancy/orestes'>Forth</a>,
        <a href='http://www.mirah.org'>Mirah</a>, and
        <a href='http://bus-scheme.rubyforge.org'>Scheme</a>.

        <!-- 1995 - QBasic
             2002 - C++ (mercifully long since forgotten)
             2003 - SQL
             2004 - PHP
             2005 - Ruby
             2006 - Emacs Lisp
             2007 - Javascript
             2008 - Scheme
             2009 - Clojure, Processing
             2010 - Duby
             2011 - Mirah, OCaml
             2012 - Nix, Scratch
             2013 - Racket, OCaml
             2014 - Erlang, Forth, C
             2015 - Lua
             2016 - l2l Lisp
             2017 - smolforth
             2018 - m4
             ???? - Factor, Datalog, Logo, Elixir, J, Self, Haskell, Julia
          -->
      </dd>

      <dt>Tools</dt>
      <dd>Knowledgeable concerning
        <a href='http://www.gnu.org/software/emacs/emacs.html' title='Oops, this belongs in Operating Systems.'>GNU Emacs</a>,
        <a href='http://gnupg.org'>GPG</a>,
        <a href='https://github.com/technomancy/leiningen'>Leiningen</a>,
        <a href='http://www.debian.org/distrib/packages'>Debian packaging</a>,
        <a href='http://nixos.org/nix'>Nix</a>,
        <a href='http://kicad-pcb.org'>KiCAD</a>,
        <a href='https://love2d.org'>LÖVE</a>, and more.</dd>
    </dl>
  </div>

  <div id='contributions'>
    <a name='contributions'></a><h3>Free Software Contributions</h3>

    <dl>
      <dt>Contributed to:</dt>
      <dd>
        <a href='http://gnu.org/software/emacs'>GNU Emacs</a>,
        <a href='http://clojure.org'>Clojure</a>,
        <a href='http://ruby-lang.org'>Ruby</a>,
        <a href='http://rubini.us'>Rubinius</a>,
        <a href='http://jruby.org'>JRuby</a>,
        <a href='http://rubyonrails.org'>Rails</a>,
        <a href='http://conkeror.org'>Conkeror</a>,
        <a href='http://rubyforge.org/projects/rubygems'>RubyGems</a>,
        <a href='http://rubyforge.org/projects/rack'>Rack</a>,
        <a href='http://sonic-pi.org'>Sonic Pi</a>,
        <a href="http://microscheme.org/">Microscheme</a>,
        <a href='http://github.com/whymirror/hpricot'>Hpricot</a>,
        <a href='http://www.mirah.org'>Mirah</a>,
        <a href="https://tic.computer">TIC-80</a>,
        <a href='https://github.com/technomancy/magit'>Magit</a>, and more
      </dd>

      <dt>Took over Maintenance of:</dt>
      <dd>
        <a href='https://github.com/heroku/logplex'>Logplex</a>,
        <a href='http://github.com/technomancy/swank-clojure'>Swank Clojure</a>,
        <a href='http://github.com/technomancy/clojure-mode'>Clojure Mode</a>,
        <a href='http://clojars.org'>Clojars</a>,
        <a href='http://tromey.com/elpa'>package.el</a>, and
        <a href='http://rubyforge.org/projects/gitjour'>Gitjour</a>
      </dd>

      <dt>Created:</dt>
      <dd>
        <a href='http://github.com/technomancy/leiningen'>Leiningen</a>,
        <a href='http://github.com/technomancy/emacs-starter-kit'>Emacs
        Starter Kit</a>,
        <a href='https://github.com/technomancy/atreus'>Atreus</a>,
        <a href="https://gitlab.com/technomancy/bussard">Bussard</a>,
        <a href='https://github.com/technomancy/grenchman'>Grenchman</a>,
        <a href='http://rinari.rubyforge.org'>Rinari</a>,
        <a href='http://github.com/technomancy/slamhound'>Slamhound</a>,
        <a href='https://syme.herokuapp.com'>Syme</a>,
        <a href='http://bus-scheme.rubyforge.org'>Bus Scheme</a>,
        and more
      </dd>
    </dl>

    <!-- Suggested the new name "Jenkins" for the Hudson project. -->

    <p style='clear: both'><a href='/projects'>Details</a></p>
  </div>

  <div>
    <a name='work'></a><h3>Work Experience</h3>

    <p><a href="https://circleci.com">CircleCI</a>, San Francisco, CA [December 2016 - present]</p>
    <ul>
      <li>Staff Engineer</li>
    </ul>

    <p><a href="https://atreus.technomancy.us">Atreus Keyboards</a>, Mae Sot, Thailand [December 2014 - present]</p>
    <ul>
        <li>Created and <a href="https://github.com/technomancy/atreus/blob/master/assembly/assembly.tex">documented</a> a design for a small keyboard to be constructed from readily-available DIY parts.</li>
        <li>Wrote a <a href="https://github.com/technomancy/atreus-firmware">USB keyboard firmware</a> from scratch for the ATMega32u4 chip.</li>
        <!-- actually more like two or three firmwares now that I think of it -->
        <li>Started and ran a small business selling and supporting kits and fully-assembled keyboards to a worldwide customer base.</li>
    </ul>

    <p><a href='http://heroku.com'>Heroku</a>, San Francisco, CA [October 2011 - December 2014]</p>
    <ul>
      <li>Maintained the <a href="https://github.com/heroku/logplex">log pipeline infrastructure</a> in Erlang for routing app output.</i>
      <li>Handled the <a href="https://github.com/heroku/heroku-buildpack-clojure">adapter for building Clojure applications</a> on the Heroku platform.</li>
      <li>Maintained <a href="https://devcenter.heroku.com/articles/git">git-based deployment pipeline</a> for applications running on Heroku.</li>
    </ul>

    <p><a href='http://sonian.net'>Sonian</a>, Newton, MA [April 2009 - September 2011]</p>
    <ul>
      <li>Helped design and implement a document parsing, indexing, and archival pipeline in Clojure which functioned at petabyte level.</li>
      <li>Developed <a href="https://leiningen.org">Leiningen</a> project automation tool originally for our in-house needs, which got
        turned into a public project with many thousands of users and hundreds of contributors.</li>
    </ul>

    <!--
    <p><a href='http://www.evri.com'>Evri</a>, Seattle, WA [August 2007 - March 2009]</p>
    <ul>
      <li>Wrote a system to gather documents from feed subscriptions
        and web crawling for an NLP indexing system which scaled out
        to many distributed nodes and millions of documents.</li>
      <li>Helped build a web application allowing people to see at a
        glance how entites are connected to other things in the
        news.</li>
    </ul>

    <p><a href='http://i5labs.com'>i5 Labs</a>, San Francisco, CA [December 2006 - August 2007]</p>
    <ul>
      <li>Built a social networking site in Rails with a small team.</li>
      <li>Used test-driven techniques to ensure stability and quality.</li>
    </ul>

    <p>Paxtel, Yakima, WA [August 2005 - October 2006]</p>
    <ul>
      <li>Created a web application to view diagnostics and map location of fleets of vehicles.</li>
      <li>Connected the application to a nationwide RF network by handling a custom vehicle communications protocol.</li>
    </ul> -->
  </div>

  <div>
    <a name='other'></a> <h3>Other</h3>

    <p>Voraciously <a href='http://technomancy.us/books'>self-taught</a>.</p>

    <p>Founded <a href='http://seajure.github.com'>Seajure</a>,
      the Seattle Clojure group and led meetings from 2010-2014.</p>

    <p>Native English speaker, conversant in Indonesian/Malaysian. Beginner-level Thai.</p>

    <p>Graduate of the <a href='http://www.biola.edu/academics/torrey'>Torrey
      Honors Institute</a>.</p>

    <p><a href='http://www.biola.edu'>Bachelor of Science degree</a>
      in Computer Science, Magna Cum Laude.</p>

    <p>Will not relocate to San Francisco.</p>
  </div>

  <!-- Thanks for taking time to read the source.-->
</div>

include(footer.html)
