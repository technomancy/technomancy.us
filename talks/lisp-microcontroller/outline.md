# Interactive Lisp on a Microcontroller

## Introduction; who am I

https://technomancy.us/talks/lisp-microcontroller
* Phil Hagelberg
 * Creator of Leiningen
 * Designer and producer of the Atreus keyboard
 * One of the lead developers of Fennel
 * work for CircleCI

## Introduction: why do you care?

https://www.hackrva.org/blog/wp-content/uploads/2015/12/ThoseMicrocontrollers.jpg
* Microcontrollers
 * small computers
 * you'd think the word for small computers would be "microcomputers"
https://p.hagelb.org/commodore-pet.jpg
 * but that actually means a kind of big computer
  * english is weird?
https://p.hagelb.org/microcontrollers.jpg
 * becoming...
  * cheaper
  * faster
  * more _connected_

* that's great
 * there's a lot of cool things you can do with that
* but also can be problematic
 * the more you know about software
  * the more nervous you are about being surrounded by it
   * every waking moment
https://biggaybunny.tumblr.com/post/166787080920/tech-enthusiasts-everything-in-my-house-is-wired
 * "the only connected device I have is a printer
    and I keep a loaded gun next to it in case it makes any funny noises"
* you think you bought a "smart device" but you didn't!
 * the device is a dumb endpoint
 * all the smarts are on the server
 * data centers cost a _lot_ to keep running!
 * how long is that data center going to stay up?
 * you're using an ongoing service but in many cases only paying up front
  * this is dishonest and misleading
  * it's unsustainable
  * cost to keep it running will quickly outpace benefit of providing service
https://www.phoronix.com/scan.php?page=news_item&px=Linux-4.14-Code-Size
* complexity
 * most of these devices are running Linux
 * 23 million LOC!
 * patching security vulnerabilities only happens if you're lucky
  * even then it's very short-term
* a lot of these devices are gathering a lot of your data
 * what's happening with it?
 * no transparency
https://www.nytimes.com/2017/07/25/technology/roomba-irobot-data-privacy.html
 * Roomba is planning on selling maps of your living room
 * forget about being able to export your data
 * to the company, your data is an asset to exploit
* we can do better than this!
 * free software hackers have a history of building systems that put the user first
 * the need to grow a company is in direct opposition to the need to respect users
 * freed from the market, free software solutions can take a sustainable approach

but how?

## Arduino vs Raspberry Pi (5 minute mark)

* historically two main approaches
 * speaking in VERY broad strokes

https://www.arduino.cc/
* Arduinos: 
 * simple (no OS)
 * lots of pins
 * basically only runs C or C++ (not strictly true but close enough)
 * low specs (single-digit kb of ram is typical, single-digit MHz CPUs)
 * difficult networking
 * however, they make an effort to be approachable to newbies
  * ESPECIALLY compared to what came before them
https://www.raspberrypi.org/
* Raspberry Pi
 * powerful (GB of RAM, GHz CPU)
 * runs any linux software
 * super complex OS
 * wifi/ethernet is easy
 * usually overkill
 * historically expensive, Pi Zero changes that

* What the Pi doesn't have is comprehensibility, Arduino has it
* For every module, you can understand what it does and why
 * maybe you haven't read all the code
  * but you COULD if you really wanted to
  * you could never read thru all the code in Linux

* Comprehensibility is a big part of the appeal of retrocomputing
 * getting nostalgic about 8-bit micros
 * a lot of this is rose-colored-glasses nostalgia
 * you wouldn't actually WANT to go back to using a C64 every day
  * primitive, brutal lifestyle
https://p.hagelb.org/dysentery.jpg
  * BUT you could understand it! every part.
  * there's a leg imitate appeal there that we've lost
  * we've traded it for fast networks and incredible connectedness
  * and that's a big step forward

* What if you could have something in between?

## ESP8266 and ESP32 (10 minute mark)

http://esp8266.net/
* originally designed to add wifi to a board like Arduino over UART
* Hayes AT command set
* basically no english documentation early on
* astonishingly cheap
* english speaking community discovered it was a general-purpose CPU

* esp8266
 * 80kb of ram
 * 80MHz
 * wifi
 * $1 module/$3 dev board
https://en.wikipedia.org/wiki/ESP32
* esp32
 * 520kb of ram
 * 2 240MHz CPUs
 * wifi/bluetooth
 * hardware-accelerated crypto
 * $3 module/$8 dev board

* you could just port the Arduino toolchain to this (and people have)
 * Arduino is two things: family of boards and a software toolchain
* but you can do so much more!

## interactive development!

https://p.hagelb.org/repl.jpg
* centers around the REPL: read eval print loop

* talk to lisp programmers and they often get very passionate about the repl
* so why is the repl such a big deal?
* I think it's valuable for all kinds of programming...
 * BUT traditional microcontroller development has *miserable* feedback loops
 * edit, recompile, upload, restart device, run, stare at it
 * often with arduinos, your only hint as to the state of the chip is LEDs
 * deciphering different patterns of blinking
* the tighter your feedback loop, the faster you can fix problems
 * when you do this right, you achieve a state of flow
 * dialed in to the problem and the code
 * TODO: more material on the state of flow? faulhauber's talk?
* not only can you tell what's going on, you can call functions directly
* or redefine functions without restarting
* on a non-networked chip, this isn't too bad; there's very little state
 * how much state can you fit in 2.5kb anyway?
 * restart, re-establish your state, easy
 * throw networking in and it gets more complicated; lots of state!
 * you can change code *without* closing a socket
 * fix a bug, try out a new feature: seamlessly

* it feels like interacting with something that's alive
* otherwise you're shooting it dead and examining the corpse

## Why Lua?

https://www.lua.org/
* Normally picking a language means picking an ecosystem with a lot of
  good libraries

* Microcontroller work is qualitatively different
* All the rubygems or python libs in the world isn't going to help
* You want code for I2C, neopixels, ADC, etc
* Simplicity is always important, but here it's even more so
 * memory usage and storage is part of it
 * but also: you haven't lost the battle against incomprehensibility yet
 * by choosing carefully you can preserve that valuable property

* famously small, embeddable language
* reference implementation (VM, compiler, repl, standard library) is 247kb
* oh, and it's fast
 * luajit in particular is record-breaking fast
 * but it's not as small; we care about size more than speed here
* relentlessly simple semantics
 * if you know any other imperative lang w closures you can learn in an afternoon
 * the hardest part is unlearning your OOP habits

## But it's not perfect (20 minutes)

Lua has a few small annoyances:

* easy to accidentally set a global
* easy to accidentally reference a global
* easy to call a function with the wrong number of arguments
* stock repl is not very good
 * prints data structures opaquely
 * would only accept statements (fixed in latest version)
* statements vs expressions
> example and/or chain
 * and/or chains instead of if expressions
 
It's is a very nice language. it's simple and well-understood.
It's small, so its flaws are small too.

## Fennel

https://fennel-lang.org

* but ... I like lisps!
 * no statement/expression distinction
 * predictable, regular syntax (code is data)
 * macro system
 * no accidental globals

* Fennel is a language and a compiler
 * the compiler takes this language as input and outputs regular lua
 * core tenet: no runtime overhead

* what is the cost of a compiler?
 * depends on the semantic distance between the two languages
 * with no semantic distance, the mental overhead is negligible
  * it can prevent certain Lua patterns from being used (accidental globals)
  * but other than that it maps 1:1 with Lua
 * change syntax all you want!
 * even the line numbers match up
  * no need for sourcemap-style extensions

https://p.hagelb.org/irc.html

* also has these bonuses
 * pattern matching/destructuring
 * clearer difference between sequential vs k/v tables
  * lua uses curly brackets for all
  * fennel looks more like json with square brackets for sequential
 * locals default to immutability
 * optional arity checks

* fennel is simple (2kloc) but powerful
 * used in the last 3 lisp game jams by the winning entry

(28 minutes)

## demo?

* serial terminal to a lua repl
* takver or jeejah

## lua-rtos

https://whitecatboard.org/software/lua-rtos/
* A port of Lua to the ESP32 platform
* it sits on top of FreeRTOS
https://freertos.org/
* what even is an operating system?
 * exposing capabilities of the underlying hardware to application code
 * on most systems this means display, disks, keyboards, mouse
 * on ESP32 this means GPIO, UART, I2C, flash
 
* but also: a shell (!)
* and ... a text editor (!!!)

* mdns!
 * traditional IOT means no control without Internet
 * when your home's ISP goes down, you still have LAN!
 * it shouldn't take your local devices down
 * no middleman

## "serverless"

https://blog.codinghorror.com/content/images/2019/02/there-is-no-cloud.png

* I got excited when I heard that serverless software is the next hip thing
 * very disappointed to find out that it was just a different kind of server
 * because actually-serverless software is way more interesting!
  * decentralization has the potential to put power back in the hands of users
* actually-serverless software won't come from a typical startup
* software developed by companies tends towards centralization
 * monetization as it is practiced in SV requires centralization

## coda

I'm giving a keynote, so...
time for something more personal, but also bigger picture

* I used to be a True Believer in open source
 * capital T; capital B
* I read the GNU Manifesto when I was in school
 * drawn in by the ideas of sharing with others; building a community
 * then I read about "open source" and figured it was the same thing
  * which is a REALLY COMMON mistake

* contributing to open source feels Pretty Good, right?
* you're giving a gift to humanity, right?
* or at least, giving a gift to other computer users
* or at least, giving a gift to other programmers
* or at least, giving a gift to people who employ programmers

* open source is often considered a gift economy
 * free software IS a gift economy
 * but understood correctly, open source is transactional

* let me unpack that a bit:
 * free software is a political movement to empower users
  * by public collaboration to produce software in a way that can't be subverted
 * open source is a methodology to use that same public collaboration
  * to produce software for any purpose, regardless of effect on end-users
 * you can see how there's confusion; they overlap
  * but their goals are completely different

* transactional open source:
 * you contribute code -> you gain reputation -> you have access to better jobs
* open source has treated me well
* but when YOU think of it as a gift economy
 * they're going to think of it as a way to exploit
  * um, I mean to BENEFIT FROM unpaid labor to pursue their business goals

* it took me a long time to realize this dynamic
 * largely because open source HAS succeeded at co-opting the goodwill of free software
  * stripping away the political aspects which empower the user
  * but somehow keeping the fuzzy feel-good vibes

* when I did realize it, I became a lot less inclined to do oss in my free time
* but I still wanted to write code and make things
 * that's just part of who I am
* I began to work on writing games and programming microcontrollers
 * making things for humans to enjoy
 * not libraries for web services or distributed systems

* don't ignore open source or shun it
 * it's not going away
 * understand it for what it is
 * but it makes a terrible Cause
  * you don't want to be a True Believer

* my hope is you would take this technology and build something for humans
* you don't need to reach for the tools you use at your day job to do that
 * those tools make assumptions about centralization, and hence scalability
  * those assumptions over-complicate things terribly
   * and tear away at the foundation of comprehensibility
  * but you become blind to them
  * "this is just how serious software is done"
 * you can do something dramatically simpler
  * and produce something that's useful for a human
  * even if it's not something that would fly at work

http://www.lord-enki.net/medium-backup/2018-12-21_Free-software-and-the-revolt-against-transactionality-3a44a1b7f96d.html

> Software intended for businesses has a need that software intended
> for individuals does not: scalability. Software intended for
> individuals can be unstandardized, ad-hoc, quirky, and
> personal. ‘Enterprise’ software must pretend to scale (even if it
> cannot), & the centralization necessary for any business to make a
> profit increases the load on the software that inhabits that
> bottleneck.
>
> For twenty years, we’ve been making corporations rich by buying into
> standardization and scale — making it feasible for them to funnel us
> into silos. We can stop this process, and perhaps even reverse it,
> by refusing to make un-frivolous software. Personal software should
> be personal: it should not scale or conform; it should chafe at
> strictures the same way you do, and burst out of any box that dare
> enclose it.

If you're fortunate enough to work in software but still feel the need
to code in your free time, I hope that's something you can aspire to.

whether that's thru microcontrollers, interactive development, or some
other way, more power to you.

happy hacking



ht tps://boingboing.net/2018/06/21/digital-enclosure.html

* during development, you want modules exposed as globals
* tension between lexical scope and reloadability
