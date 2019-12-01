dnl -*- html -*-
define(__timestamp, 2019-11-24T14:42:41Z)dnl
define(__title, `in which we get socially rendered')dnl
define(__id, 191) define(__last) dnl
include(header.html)

<p>I joined <a href="https://en.wikipedia.org/wiki/Fediverse">the
    fediverse</a> in early 2017. If you haven't heard of it, it's a
    distributed network providing social media type features without
    any one centralized authority. Users are in control of their data,
    and anyone can run their own servers with their own rules,
    including the ability to block all traffic from other servers if
    they tolerate abusive behavior, etc.</p>

<img src="i/icosahedron.png" alt="my profile" class="right">

<p>It took me a while to get to the point where I was comfortable on
  the Fediverse. I
  created <a href="https://icosahedron.website/@technomancy">an
    account</a> on the
  oddly-named <a href="https://icosahedron,website">icosahedron.website</a>
  in April, but it didn't stick immediately. It didn't feel like there
  was much going on because I hadn't found that many users to
  follow. After a few months of poking my head around, clicking around
  a bit, and then forgetting about it for another few weeks, I finally
  got enough momentum for it to be a compelling place for me, and by
  November I stopped using my Twitter account altogether. I had felt
  since the 2016 US election that Twitter had spiraled into a worse
  and worse condition; the site felt engineered to drive more and
  more "engagement" at the expense of human misery. So making a clean
  break dramatically improved my mental well-being.</p>

<p>Even tho it makes a few things more complicated (like finding new
  users to follow[<a href="#fn1">1</a>]), I deeply appreciate the emphasis on user
  empowerment that's inherent in the design of the fediverse. One of the
  cornerstones of this empowerment is the ability to run your own
  fediverse server, or instance. The most common fediverse server software
  is <a href="https://joinmastodon.org">Mastodon</a>, which could be
  considered the flagship of the fediverse. While it's very slick and
  full-featured, a big downside of Mastodon is that it's difficult to
  run your own server. Administering it requires running a Ruby on
  Rails application with Node.js, Postgres, Redis, Nginx,
  ElasticSearch, and more. For servers which serve a medium-to-large
  community, this overhead can be justifiable, but it requires a lot
  of mental energy to get started. There are a lot of places where
  things could go wrong.</p>

<p>The <a href="https://pleroma.social">Pleroma</a> project aims to
  reduce this by creating a dramatically simpler fediverse
  server. Running a Pleroma server requires just an Elixir
  application, a Postgres database, and Nginx to handle TLS. Since
  Elixir is a lot more efficient than Ruby, it's even possible to run
  it on a low-powered machine like a Raspberry
  Pi[<a href="#fn2">2</a>]. I set up my own Pleroma server a few weeks
  ago at <a href="https://hi.technomancy.us">hi.technomancy.us</a>.
  It's running on the Pi in the photo.</p>

<img src="i/pi-pleroma.jpg" alt="a raspberry pi and hard drive">

<p>One downside of Pleroma being simpler is that it's really just an
  API server. All your interaction in the browser goes thru a separate
  Javascript application
  called <a href="https://git.pleroma.social/pleroma/pleroma-fe">pleroma-fe</a>,
  and mobile clients like <a href="https://tusky.app/">Tusky</a> just
  hit the JSON API. The API-first design makes sense when you're using
  the application to browse, post, search, etc, but a big downside is that
  when you want to share a post with someone else, they have to load
  all of pleroma-fe just to see it. If you share it with someone who
  has scripting turned off, then they'll just see a blank white page,
  which is very unfriendly[<a href="#fn3">3</a>].</p>

<p>I wanted to start using Pleroma, but I wasn't comfortable with this
  unfriendly behavior. I wanted it so that if I sent a link to a post
  to a friend, the server would send them the HTML of
  the post![<a href="#fn4">4</a>] So I took a course of action I never could have
  taken with a centralized, commercial social network: I fixed it
  myself. I found that there had
  been <a href="https://git.pleroma.social/pleroma/pleroma/merge_requests/882">an
    attempt to start this 8 months ago</a> which had more or less been
  forgotten, so I used that as my starting point.</p>

<p>Pleroma is written in <a href="https://elixir-lang.org">Elixir</a>,
  which I had never used before, but I had learned Erlang a few years
  ago, and many of the core concepts are the same. Since I
  based <a href="https://git.pleroma.social/pleroma/pleroma/merge_requests/1917">my
    work</a> on the old initial sketch, I was able to make quick
  progress and add several features, like threading, media, content
  warnings, and more. I got some really helpful review about how to
  improve it and test it, and it got merged a couple weeks ago. So now you
  can <a href="https://hi.technomancy.us/notice/9otSYoQwZAyokRBXcm">see
    it in action</a>. I'm thankful to the Pleroma developers for
  their helpful and welcoming attitude.</p>

<img src="/i/pleroma-screenshot.png" alt="pleroma screenshot" class="left">

<p>One of the reasons this is important to me is that I normally use
  <a href="/gear">a laptop that's a bit old</a>. But I think it's
  important for software developers to keep some empathy for users who
  don't have the latest and greatest hardware. On my laptop, using the
  pleroma-fe Javascript application to view a post takes eight
  seconds[<a href="#fn5">5</a>] if you haven't already loaded
  pleroma-fe (which is the main use case for when you're sharing a
  link with a friend). If you have it loaded already, it's still 2-3
  seconds to load in pleroma-fe. When you have the server generate the
  HTML, it takes between 200 and 500 milliseconds. But 500ms is nearly
  a worst-case scenario since it's running on a tiny Raspberry Pi
  server; on a high-end server it would likely be several times
  faster.</p>

<p>Running your own fediverse server is still much harder than it
  should be. I've glossed over the annoyances of Dynamic DNS, port
  forwarding, and TLS certificates. There's still a lot of opportunity
  for this to become better. I have a vision of a system where you
  could sign up for a fediverse server and it would pre-generate an SD
  card image with Pleroma, Postgres, and Nginx preinstalled and
  configured with the domain name of your choice, but right now
  shortcomings in typical consumer-grade routers and consumer ISPs
  make this impractical. But it's come a long way, and I think it's
  only going to get better going forward.</p>

<p>If you're interested in running your own fediverse server, you
  might find <a href="https://runyourown.social/">runyourown.social</a>
  helpful, tho it focuses on Mastodon instead of Pleroma. If you're
  not interested in running your own server, check
  out <a href="https://instances.social">instances.social</a> for a
  listing of servers with open registration. There's never been a
  better time to ditch corporate social media and join the fediverse!</p>

<hr>

<div class="footnotes">

  <p>[<a name="fn1">1</a>] When people get started on the Fediverse,
    the first question is just "which server should I choose?" As
    someone who's been around a while, it's tempting for me to say "it
    doesn't matter as long as you pick a place with a code of conduct
    that disallows abusive behavior; all the servers talk to each
    other, so you can follow any user from any server that hasn't
    de-federated yours." The problem is this isn't quite true due to
    the bootstrapping problem; when you're trying to find interesting
    people to follow, you'll have an easier time if you land on a
    server where people have interests that overlap with yours.</p>

  <p>In a distributed system, one server can't know about every single
    user in the entire network; it's just too big. So server A only
    knows about users on server B if someone from server A has already
    made a connection with a user on server B. Once you choose an
    server, your view of the network will be determined by the sum total
    of those followed by your server-mates.</p>

  <p>[<a name="fn2">2</a>] Just don't make the same mistake I did and
    try to run Postgres on an SD card! I tried this initially, and after
    a few days I started seeing unexplained segmentation fault loops
    from Postgres. Apparently this is common behavior when a disk
    failure corrupts the DB's files. Moving everything over to an
    external USB drive made the problem go away, but it was certainly
    a surprise. Everything else can run on the SD card but the database.</p>

  <p>[<a name="fn3">3</a>] Note that this problem also occurs with
    Twitter. Mastodon is slightly better, but it still refuses to show
    you images or content-warnings without scripting.</p>

  <p>[<a name="fn4">4</a>] You used to be able to take this very basic
    behavior for granted, but since the arrival of the "single-page
    app", it has become some kind of ancient forgotten wisdom.</p>

  <p>[<a name="fn5">5</a>] Eight seconds sounds like a very slow
    application (and it is!) but it's hardly the worst offender for
    single-page applications. Trello takes 10 seconds, Jira takes 16
    seconds, and Slack takes 18 seconds.</p>

</div>

include(footer.html)
