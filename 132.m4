<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, Tue 22 Dec 2009 03:14:16 PM PST)dnl
define(__title, `in which persistence proves a propitious property')dnl
define(__id, 132)dnl
include(header.html)
<p>When you read about functional languages, one of the things that
  frequently comes up is the value of persistent data structures. If
  you come from an OOP background where persistent means "it gets
  saved to disk", this is a little confusing until you do a little
  digging to find out it's a different meaning of the word
  persistent; you discover that it just means the data structures
  are immutable. This is technically true; all persistent data
  structures are immutable. But this understanding is a little bit
  lacking&mdash;it doesn't really get at the meaning of
  persistent.</p>

<p>The point of persistence in this case is that future versions of
  the object in question can be created without changing either the
  value <b>or</b> the performance characteristics of the existing
  instance. So when you've got a vector that you want to work with,
  you can create another vector based on the original, but with a
  few new items added to it. In languages that provide persistent
  data structures this is done without copying; internally the
  portions of the vector that are the same use a shared
  structure. But there are some pseudo-persistent implementations
  that cheat; as you create more and more versions based on the
  original vector, the performance of the original degrades even
  though the value is preserved. This is avoided in true persistent
  implementations such as Clojure's.</p>

<p>The other important thing about understanding persistence is
  understanding what it's not. A new feature in Clojure 1.1 is the
  addition of <a href="http://clojure.org/transients">transient</a>
  data structures. Transients provide speed boosts in cases where
  you decide performance is more important than persistence by using
  mutable data structures in a controlled, thread-safe way. If you
  don't understand what persistence means then you might see the
  fact that they are mutable and use them as you would in an
  imperative language&mdash;but that's not what they're meant for!
  The key to understanding transients is not that they're mutable
  but that they're <i>not persistent</i>. The fact that they are
  mutable is an implementation detail; you should treat them like
  regular immutable data structures, you just shouldn't rely on
  their persistent qualities.</p>

<p>Focusing on immutability is focusing on the negative: what
  you <i>can't</i> do. Thinking in terms of persistence is focusing
  on the positive: there are a certain set of guarantees that we may
  rely on. If you decide in some cases to give up those guarantees
  for speed benefits, transients allow you to do that, but you
  shouldn't think of them as your old imperative friends you can
  alter as you wish.</p>
include(footer.html)
