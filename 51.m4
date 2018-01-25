<!DOCTYPE html> <!-*- html -*-->
define(__timestamp, 2006-06-29T16:22:41Z)dnl
define(__title, `level up')dnl
define(__id, 51)dnl
include(header.html)
<p>Ok,  so i've got this theory which I'm sure totally oversimplifies
things,  but it may be a good way of thinking about
programming. Basically as I see it there are three different levels
you can achieve concerning your ability to write really good code.</p>

<ol>
  <li>At the first stage you have someone who has learned to write
    code that
    doesn't <a href='http://technomancy.us/36'>smell
    bad</a>. He's got the idea--separate your business logic from your
    display logic and avoid tight coupling. He may have a lot of old
    spaghetti code around somewhere which embarrasses him,  but he's
    learned his lesson. The project he's working on now is going to be
    done <i>right</i>,  darn it. It's going to be done in a clean
    fashion,  and its intent is going to be clear from glancing over
    the code. He can write beautiful code.</li>

  <li>The next stage is the kind of hacker who can not only build the
    type of system described above,  but can actually maintain and keep
    it maintainable it over time. Note that these are <i>not</i> the
    same thing! It's possible to write an app that satisfies the above
    without knowing anything about refactoring or testing,  but over time
    the clarity and clean structure of the project are going to
    degrade. Someone at this level can write code that stays beautiful.
  </li>

  <li>Finally we have a truly rare breed of programmer. Someone at
    this level is not only capable of writing beautiful,  maintainable
    code,  he's capable of writing beautiful code <i>that works with
    hideously ugly systems</i>. Sadly,  I'm not yet at this level,  and
    it shows. It's one thing to be able to keep things from getting
    out of hand when you're working with a system you have control
    over or a system which is reasonably well-designed. It is quite
    another to be able to masterfully hide ugliness and poor
    structure,  keeping your project flexible and clean. This is what a
    master hacker is capable of.</li>

  <li>...There may be more beyond this; I wouldn't know since I'm
  somewhere in between levels two and three.</li>
</ol>

<p>I believe it's difficult to progress to the next stage on your own
  without first working on a project that fails miserably at it. It's
  only when you really feel the pain of the limitations of your
  current style that you get yourself to progress. This has been my
  experience coding solo. I'm sure a mentorship type of situation
  could help things,  but I suspect most programmers follow a
  progression like this. </p>

include(footer.html)
