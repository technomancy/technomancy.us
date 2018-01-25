<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Tue 19 May 2009 05:20:29 PM PDT)dnl
define(__title, `in which a tool helps with relaxation')dnl
define(__id, 125)dnl
include(header.html)
<p>I've been experimenting a bit with <a href='http://couchdb.apache.org'>CouchDB</a> recently. I've been really impressed with how quickly it lets you get started; interacting with it always feels <i>obvious</i>. I've spent enough time doing web apps to get tired of how everyone always jumps straight to the unholy combination of a relational database system and object-relational mapper whenever they need any persistence. (When all you have is a hammer...) So using CouchDB with a functional language is a breath of fresh air.</p>
<img src='/i/relax.png' alt='relax.el' class='right' />
<p>Putting together a CouchDB adapter in Clojure is really a matter of no more than a page worth of code once you've got an <a href='http://github.com/technomancy/clojure-http-client'>HTTP client</a>, so it's left as an exercise to the reader. Since functional languages encourage working closer to your core data types (which have clear mappings to JSON) there's very little cognitive overhead when it comes to using Couch for persistence.</p>
<p>Last week while I was in Portland I put together a client written in Elisp <a href='http://github.com/technomancy/relax.el'>called relax.el</a>. This lets you browse Couch databases from the comfort of Emacs. It also lets you edit documents straight from an Emacs buffer, which is much more convenient than using the browser's text tools from Futon.</p>
<p>There are a few quirks with regard to pagination, (just press <kbd>g</kbd> if it gets messed up) but it's pretty useful as it is. It should be in <a href='http://tromey.com/elpa'>ELPA</a> soon, so <kbd>M-x knock-yourself-out</kbd>.</p>
include(footer.html)
