dnl -*- html -*-
define(__timestamp, Sat Oct 13 00: 00: 01 -0700 2007)dnl
define(__title, `proto-typed')dnl
define(__id, 85)dnl
include(header.html)
<p>So at <a href='http://bostonsteamer.livejournal.com/876269.html'>Dave Thomas's closing RailsConf</a> keynote,  he talked about the dangers of <a href='http://en.wikipedia.org/wiki/Cargo_cult'>cargo culting</a> and how we need to be aware of how those kinds of things affect our thinking. This made me feel somewhat vindicated considering I was committing what amounts to serious heterodoxy in the Rails community:  playing with <a href='http://helma.org'>software written in Java</a>.</p>

<img src='/i/rats-close.jpg' alt='JAVASCRIPT OBJECT PLZ' />

<p>Anyone who listened to me rant during that weekend probably heard me talk about <a href='http://helma.org'>Helma</a>. Most people gave me funny looks,  which made me feel all the better about PragDave's keynote. ("Cargo-culters!") Helma is a web development framework I discovered during <a href='/80'>my time in Indonesia</a>. The bulk of it's written in Java,  but the apps you write with it are written in Javascript. I had seen it mentioned before and simply disregarded it,  but now that <a href='http://www.sun.com/2006-1113/feature/'>Java is Free Software</a> I figured it was worth a second look.</p>

<p>So I did what any curious web developer will do when confronted with a new tool:  I wrote a blog app. I actually just ported this blog over to it. (This brings the count to three <a href='/1'>systems</a> that have powered it; four if you count a short-lived attempt at <a href='http://www.hobix.com'>Hobix</a>.) The port didn't take long at all since I'm fairly familiar with JS already,  though there were a few disorienting moments.</p>

<p>Anyway,  I think it compares pretty favourably to Rails in several aspects. Obviously it doesn't have the benefit of thousands and thousands of contributors,  and it shows in places. But in other places I think it has a few core ideas that make it stand out and are arguably superior. So without further ado:  my (mostly uninformed and surface-level) thoughts.</p>

<ul>

<li><b>Coolness</b>:  database access layer. Helma's system of HopObjects is pretty nice. It doesn't seem as easy as in ActiveRecord to drop into SQL or use fancy finders,  but it does a great job of abstracting things into a strictly object-oriented interface. But one of the most striking features is the built-in schemaless XML database. If you don't specify that an object should be stored with the ORM in a relational database,  it will automatically be saved in the internal XML database. This means you can hack away on the initial versions of your app without worrying about schema changes. I don't think it would be suitable for heavy production use what with all that XML parsing,  but I would kill to be able to change the attributes of my objects effortlessly on the fly this way in Rails. It's the glue that sets when you need it to.</li>

<li><b>Uncoolness</b>:  the lack of built-in testing. There is a <a href='https: //opensvn.csie.org/traccgi/jala/wiki/JalaUtil/Test'>unit testing framework</a> for Helma,  but it's not included in the standard library and doesn't seem nearly as comprehensive or convenient as Test/Unit. It also doesn't seem to be embedded in the culture in the same way,  which is a shame.</li>

<li><b>Coolness</b>:  how the applications are laid out. It's very REST-friendly. Each kind of object has its own directory,  and every action in that directory is a different .js file. But the URL scheme is what's really interesting&mdash;it actually mirrors your object hierarchy. So you have a Root object,  and it has child objects and collections of children that map directly onto the URL space. This seems like a tight constraint when you're used to dealing with pages-long routing files in Rails,  but I think it's an instance of constraints being liberating. When you're following good REST in Rails your routes tend to be really predictable anyway,  and the way that Helma handles nested routes is far more trouble-free. It works for 95% of the cases with zero configuration.</li>

<li><b>Coolness?</b>:  the prototype-oriented aspect of Helma. It takes a bit of getting used to,  but I think it comes out as a strength in the end. It's very flexible but still allows for a system similar to Ruby's classes if you want to treat it that way. I think this is also related to having a schemaless database:  each object is not constrained to follow a certain pattern.</li>

<li><b>Uncoolness?</b>:  there really doesn't seem to be the level of polish on the HTML-generating functions as you see in Rails. They <i>did</i> just add in support for form fields getting parsed into nested objects (with form names like <code>foo[bar]</code>) automatically,  but it's a fairly recent addition. It also came as a bit of a shock to me that the templating language is extremely limited. You can't actually embed arbitrary Javascript in the HTML; you just embed calls to "macros" (analogous to Rails' helpers) which are defined elsewhere. This turns out not to be such a bad thing after all since it forces you to keep your views strictly focused on presentation. Still,  it's a bit disorienting.</li>

<li><b>Coolness</b>:  it's fast. Very much so.</li>

<li><b>Uncoolness</b>:  deployment on shared hosting. I had trouble with this because I was using Dreamhost,  and they don't allow long-lived server processes that aren't FastCGI. If you're hosting yourself or on a VPS,  it's very easy to get started,  but on a shared host this could be harder than Rails. I ended up having to reverse-proxy off a friend's box to my server running on port 8080 off a restricted home cable connection,  but I'll have a better setup once I get settled at my new apartment.</li>

<li><b>Coolness</b>:  little bonuses:  Helma runs on <a href='http://www.mozilla.org/rhino/'>Rhino 1.6</a>,  so <a href='http://en.wikipedia.org/wiki/E4X'>E4X</a> is available. In my opinion E4X is the best way in any language to deal with XML,  so it's quite appreciated. You don't have access to the many plugins and gems you have with Rails,  but you have access to tons of Java libraries. Of course,  to use them you need to leave the comfort of JS and write some Java,  so it's a trade-off; as always.</li>

</ul>

<img src='/i/rats-cup.jpg' alt='KTHXBAI' class='right' />

<p>So I'd love to dig into the meat of Helma,  but I'll have to wait until I can find a new project that would be suitable for it. It seems that due to its flexibility it would allow you to put together the initial stages of a project very quickly,  but I suppose the jury is still out on keeping the project maintainable. It is more ad-hoc and allows for more deviation from convention,  so that might cause maintainability to suffer. Still,  I'm looking forward to being able to give it a shot.</p>
include(footer.html)
