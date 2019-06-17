# Lisp on a Microcontroller

## Introduction; who am I

https://technomancy.us/talks/lisp-microcontroller

Thanks to the organizers of BuzzConf for inviting me and making me feel so welcome.

* Phil Hagelberg aka technomancy

https://leiningen.org

 * Creator of Leiningen

https://atreus.technomancy.us

 * Designer and producer of the Atreus keyboard

https://fennel-lang.org

 * One of the lead developers of Fennel

https://circleci.com

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
* a lot of these devices are gathering a lot of your data
 * what's happening with it?
 * no transparency

https://www.theverge.com/2017/7/24/16021610/irobot-roomba-homa-map-data-sale

 * Roomba is planning on selling maps of your living room
 * forget about being able to export your data
 * to the company, your data is an asset to exploit
* we can do better than this!
 * free software hackers have a history of building systems that put the user first
 * the #1 requirement of a VC-backed tech startup is growth
  * growth is in direct opposition to the need to respect users
 * free software alternatives can be decoupled from market
  * "growth above all else" doesn't need to win
  * possible to take a sustainable approach

but how?

## Arduino vs Raspberry Pi (5 minute mark)

* historically two main approaches
 * speaking in VERY broad strokes

https://www.arduino.cc/

* Arduinos: 
 * simple (no OS)
  * your code is the only thing running on the device
  * I'll come back to that more, but that's a big deal
 * lots of pins
 * basically only runs C or C++
  * (not strictly true but close enough)
 * low specs
  * (single-digit kb of ram is typical, single-digit MHz CPUs)
 * difficult networking
 * however, they make an effort to be approachable to newbies
  * ESPECIALLY compared to what came before them
* Arduino is two things
 * a family of hardware devices
 * a software toolchain; compiler/ide/libraries, etc

https://www.raspberrypi.org/

* Raspberry Pi
 * powerful (GB of RAM, GHz CPU)
 * historically expensive, Pi Zero changes that
 * wifi/ethernet is easy
 * runs any linux software
  * flip side: super complex OS

* What the Pi doesn't have is comprehensibility, Arduino has it
* For every module, you can understand what it does and why
 * maybe you haven't read all the code
  * but you COULD if you really wanted to
  * you could never read thru all the code in Linux

http://www.retroarchive.org/

* Comprehensibility is a big part of the appeal of retrocomputing
 * getting nostalgic about 8-bit micros
 * a lot of this is rose-colored-glasses nostalgia
 * you wouldn't actually WANT to go back to using a C64 every day
  * primitive, brutal lifestyle

https://p.hagelb.org/dysentery.jpg

  * BUT you could understand it! every part.
  * there's a legitimate appeal there that we've lost
  * we've traded it for fast networks
   * incredible connectedness
   * software that can spring up quickly
  * and that's a big step forward

* What if you could have something in between?

## ESP8266 and ESP32 (10 minute mark)

https://www.espruino.com/ESP8266

* originally designed to add wifi to a board like Arduino over UART
* Hayes AT command set
* basically no english documentation early on
* astonishingly cheap
* english speaking community discovered it was a general-purpose CPU

* esp8266
 * 80kb of ram
 * 32-bit RISC CPU at 80MHz
 * wifi
 * $1 module
 * for prototyping/hobbyists: $3 dev board

https://en.wikipedia.org/wiki/ESP32

* esp32
 * 520kb of ram
 * 2 240MHz CPUs
 * wifi/bluetooth
 * hardware-accelerated crypto
 * $3 module/$8 dev board

* one of the first things people did was port Arduino
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
 * everything else fades away in the background
 * hyperfocus
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

My weapon of choice to achieve this development style on a microcontroller is the Lua runtime.

## Why Lua?

https://www.lua.org/

* Normally picking a language means picking an ecosystem with a lot of good libraries

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
 * regular lua is fast too
 * language simplicity allows for optimizations
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
 * and/or chains instead of if expressions
 
It's is a very nice language. it's simple and well-understood.
It's small, so its flaws are small too.

## Fennel

https://fennel-lang.org

* but ... I like lisps!
 * no statement/expression distinction
 * predictable, regular syntax (code is data)
 * macro system
  * user can extend it as if they were the lang designer
 * no accidental globals

* Fennel is a language and a compiler
 * the compiler takes this language as input and outputs regular lua
 * core goal: no runtime overhead
  * no standard library, standalone files

* what is the cost of a compiler?
 * depends on the semantic distance between the two languages
 * with no semantic distance, the mental overhead is negligible
  * a different notation for expressing the same ideas
  * Fennel maps 1:1 with Lua
 * change syntax all you want!
 * even the line numbers match up
  * no need for sourcemap-style extensions

https://p.hagelb.org/irc.html

* also has these bonuses
 * pattern matching/destructuring
 * locals default to immutability
 * optional arity checks

* fennel is simple (2kloc) but powerful
* Lua is ubiquitous

(28 minutes)

## lua-rtos

https://whitecatboard.org/software/lua-rtos/

* A port of Lua to the ESP32 platform
 * provides Lua runtime
 * it sits on top of FreeRTOS

https://freertos.org/

* it's not much like Linux or Windows
* what even is an operating system?
 * exposing capabilities of the underlying hardware to application code
 * on most systems this means display, disks, keyboards, mouse
 * on ESP32 this means GPIO, UART, I2C, flash
 
* but also: a shell (!)
* and ... a text editor (!!!)
 * completely unheard of on non-Pi microcontrollers

* mdns/zeroconf!
 * a device can publish its IP address on the LAN
  * using a .local hostname
 * traditional IOT means no control without Internet
 * when your home's ISP goes down, you still have LAN!
 * it shouldn't take your local devices down
 * no middleman

## "serverless"

https://blog.codinghorror.com/content/images/2019/02/there-is-no-cloud.png

* I got excited when I heard that serverless software is the next hip thing
 * very disappointed to find out that it was just a different kind of server
 * because actually-serverless software is way more interesting than some cloud provider's API of the week!
  * decentralization has the potential to put power back in the hands of users
* actually-serverless software won't come from a typical VC-backed tech startup
* software developed by those companies tends towards centralization
 * monetization as it is practiced in SV requires centralization
 * when push comes to shove, monetization always wins

## coda

I'm giving a keynote, so...
time for something more personal, but also bigger picture

* I used to be a True Believer in open source
 * capital T; capital B
* I read the GNU Manifesto when I was in school
 * drawn in by the ideas of sharing with others
   * building a community around software
 * then I read about "open source" and figured it was the same thing
  * which is a REALLY COMMON mistake

* contributing to open source feels Pretty Good, right?
* you're giving a gift to humanity, right?
* or at least, giving a gift to other computer users
* or at least, giving a gift to other programmers
* or at least, giving a gift to people who employ programmers

* open source is often considered a gift economy
 * that is a misconception
 * free software IS a gift economy
 * but understood correctly, open source is transactional

* let me unpack that a bit:
 * free software is a political movement to empower users
  * by public collaboration to produce software in a way that hopefully can't be subverted
 * open source is a methodology to use that same public collaboration
  * to produce software for any purpose, regardless of effect on end-users
 * you can see how there's confusion; they overlap
  * but their goals are completely different

* transactional open source:
 * you contribute code -> you gain reputation -> you have access to better jobs
* open source has treated me well
 * I have no grounds for complaint
 * as long as people see it for what it is
* but when YOU think of it as a gift economy
 * they're going to think of it as a way to benefit from unpaid labor to pursue their business goals

* it took me a long time to recognize this dynamic
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
 * but it makes a terrible religious Cause
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

If you're fortunate enough to work in software but still feel the drive
to code in your free time, I hope that's something you can aspire to.

whether that's thru microcontrollers, interactive development, or some
other way, more power to you.

happy hacking

from the questions:

http://www.lambdadays.org/lambdadays2018/heather-miller

Heather Miller at LambdaDays 2018: We're building on Hollow Foundations
