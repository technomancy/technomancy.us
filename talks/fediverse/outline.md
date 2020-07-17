# What is the Fediverse?

What if it's possible to have a social network that's decentralized
rather than controlled by a big tech company? What if you could take
control, own your data, and escape from the surveillance capitalism
hellscape? We'll explore how software like Mastodon, Pleroma, and
others work together to make that happen.

https://technomancy.us/talks/fediverse

## the problems

Social media in 2020 is part of nearly everyone's life.

Ask (show of hands) how many people have an account on Twitter, on Facebook

"If you're not paying, you're not the customer, you're the product"

Almost trite nowadays, but still very true.

In an attention economy, these systems feed on eyeballs.
The algorithms behind these systems decide what you see.
these algorithms are designed to maximize engagement.
feedback loop measures what is most effective at engaging, and increases that.

Have you ever gone on a youtube binge to follow the trail of recommendations?

ever noticed how the further you go on that, the more outrageous your
recommendations become?

youtube's machine learning systems understand that outrage is "sticky"
clickbait rules everything

recommendation engines don't work in your best interest
it's not what you'd be most interested in or benefit most from
they serve the platform and only care about optimizing platform numbers

but clickbait is only half the story; we also have to talk about data collection

Facebook is all about building up a detailed profile of who you are as
a person; what interests do you have, how do you identify, what do you click?

they sell this data to advertisers (hopefully this isn't news to anyone)

but advertising is essentially an attempt to change the way you think
sometimes that's trying to convince you to choose one brand over another
sometimes that's undermining the foundation of democracy
and everything in between

https://www.forbes.com/sites/kashmirhill/2014/06/28/facebook-manipulated-689003-users-emotions-for-science/

that control over what you're exposed to impacts how you think and act

no one would spend money on ads if they thought they couldn't
influence peoples behavior

up until a few months ago, facebook had a policy that banned ads which
made false claims. they recently changed this to exempt political ads.

https://www.theguardian.com/technology/2019/oct/04/facebook-exempts-political-ads-ban-making-false-claims

of all the cases where it's important to ban false claims, this is the
most important of all, and they just stopped doing it.

do you think they have your best interest in mind?

## so what can you do about it?

social networks don't have to be under the control of tech companies.
we had people socializing on the internet before internet megacorps existed.
and people will keep networking long after Facebook is history.

https://fediverse.party

but the one I want to talk about today is called the Fediverse:

A network of servers running a variety of different software to allow
interoperability and sharing data.

the Fediverse is like the web in a lot of ways:

* defined based on protocols that anyone is free to implement
* anyone can put up a server, no gatekeeping
* no one can say exactly how big it is
* no company controls its development direction

incomplete stats place the number of users at around 4.5 million.

the fediverse attracts people who like decentralization, free software
and tinkering with technology. it also has seen a lot of growth from
people fleeing twitter when they've failed to enforce anti-harassment
policies, particularly lgbt+ folk.

## the servers

http://joinmastodon.org/

the fediverse existed before Mastodon, but Mastodon put it on the map;
it was the first to have the user interface really nailed.

https://pleroma.social/

Pleroma is another newer project that's a little less polished but
much easier to set up and administer.

Mastodon and Pleroma give you a twitter-like experience, but there's
nothing inherent in the Fediverse that says it has to be that way.

other servers include:

https://joinpeertube.org/

https://funkwhale.audio/

https://pixelfed.social/

https://writefreely.org/

... and a bunch more less-established ones

## how do I use it?

If you want an account, you can find a server and sign up.

How do you decide on a server?

don't just sign up for mastodon.social! (no one goes there; it's too crowded)

some servers are themed
some have different rules; no nazis, anti-harassment policies, etc

https://instances.social/
can help you pick one

## demo

A lot is the same as twitter:

* post, fave, boost, attach images
* polls, lists

### pick a client

* default UI for mastodon can switch to multi-column, can work on mobile
* mobile: tusky is great on android, mast/amaroq for ios?
* pinafore.social is my favorite
* brutaldon is neat (pure HTML, no JS; works in lynx)
* CLI clients

### what's different?

* home vs local timeline vs federated
* content warnings: not always NSFW
    * uspol
    * mh
    * punchlines
    * events (wwdc/e3)
    * spoilers
* sensitive media (orthogonal to CW)
* privacy settings
* post length limits are determined by server (at least 500)

### it can be hard to find people to follow. 

* find a few people who look interesting and see who they're talking to.
* check out the local timeline, if your server is medium/big

in the long run, which server you pick will matter very little other
unless you land somewhere that's very unstable or has bad moderation
policies. but when you're first getting started, it's easier to build
a follow list on a bigger server, or one that has more overlap with
your interests!

it took me about six months of logging in every so often, poking
around, and not seeing enough to make it stick before I finally
gathered enough follows to make my usage interesting. (but that was
years ago)

### account migration

if you end up picking a server that isn't a great fit, that's OK!

* you can export your posts and follow lists
* you can set up a redirect so your followers will get sent to the new account
f
this is relatively new! some straggler followers might not get the message
but it's a huge improvement over how it was

## how does it work?

ActivityPub is the protocol that ties everything together.

https://activitypub.rocks

The spec is a little dry and hard to read; this guide is helpful

https://tinysubversions.com/notes/reading-activitypub/

essentially it defines a vocabulary for actors with inboxes and outboxes
that can publish and subscribe to each other

But the ActivityPub standard is only used to communicate between servers.

Clients almost all use Mastodon's own client/server API; standard
OAuth/JSON deal.

The Masto API is pretty approachable; I built a bot in about 50 lines:

https://git.sr.ht/~technomancy/pengbot/tree/master/fediverse.fnl

## running a server

https://runyourown.social

https://masto.host/

https://fediverse.network/hi.technomancy.us

I started my own a few months ago, running Pleroma on a Raspberry Pi.

it works great, as long as you don't try to run postgres on an sd card.

## static-fe

I started playing with my Pleroma instance and noticed that you
couldn't view permalinks without loading up the whole pleroma-fe JS app

this takes like 8 seconds! and it's dumb.

so I put together a patch to generate HTML for it server-side

[basically just say the stuff from my blog post]

https://technomancy.us/191

## problems

### nothing is private from your instance admin

* if you need end-to-end encryption, use Signal or Wire
* you have to trust your admin (which should be a lot easier than
  trusting twitter!)

### instances can disappear

* sometimes admins get burned out

### some instances harbor hate speech

* gab, spinster
* usually people who were so bad twitter actually kicked them off
* it takes a lot to get twitter to kick you off for white supremacy

### self-hosting is kinda tricky

* NAT is THE WORST
* Dynamic DNS is a pain
* be sure to install fail2ban and stuff

### notice

* all these problems are problems we already have with social media
* but at least now we have a shot at fixing them
