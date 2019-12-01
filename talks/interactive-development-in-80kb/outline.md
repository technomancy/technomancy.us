# Lisp on NodeMCU talk outline

## Intro

* Going to be speaking about these lil devices and how they make uc
  dev much more pleasant.
* Microcontrollers are everywhere!
* historically 2 approaches: Arduino and Raspberry Pi (broadly speaking)
* Arduinos: 
 * simple (no OS)
 * basically only runs C or C++ (not strictly true but close enough)
 * low specs (single-digit kb of ram is typical, single-digit MHz CPUs)
 * difficult networking
 * lots of pins
* Raspberry Pi
 * powerful (GB of RAM, GHz CPU)
 * runs any linux software
 * super complex OS
 * wifi/ethernet is easy
 * usually overkill
 * historically expensive, Pi Zero changes that

* Arduino: you can understand everything that's happening on your device
 * but it can't be online
* Pi you can go online and do basically anything
 * at the expense of comprehensibility

* What if you could have something in between?

## ESP8266

* main feature is wifi
* originally designed to add wifi to a board like Arduino over UART
* Hayes AT command set
* basically no english documentation?
* astonishingly cheap
* english speaking community discovered it was a general-purpose CPU

### Specs

Point out the difference between the module and the dev board

* 32-bit 80MHz RISC Xtensa chip
* 80kb user RAM
* SPI, I2C, UART
* Varying amounts of flash storage; usually at least 4MB
* around $1 for the module
* cannot be programmed by a conventional PC

### dev boards

* dev board mounts the module into a breadboard-friendly form factor
* 16 gpio pins
* USB micro
* reset button
* there are actually several of these, some of them don't even have USB
* when you plug it in, you get a lua repl over the "serial port" (actually USB)

## wifi changes everything

* mainstream IOT means "tiny device on your network, the rest in our data center"
* even if you own the device it doesn't mean anything; it's useless on its own
* importance of owning your own data
* subscription model is great for companies
 * but leaves you with a useless brick when your subscription ends
 * whether you ended it by choice or not
* unfortunately NAT ruins everything

### Lua

* so you've got all that flash and more ram than most arduinos
* you could just port the arduino toolchain to it, and that's been done
* but with that much memory, you can do a lot better!
* 80kb isn't enough to run most programming languages, but it can run Lua!

* famously small, embeddable language
* reference implementation (VM, compiler, repl, standard library) is 180kb
* oh, and it's fast
* relentlessly simple semantics
 * if you know any other imperative lang w closures you can learn in an afternoon
 * the hardest part is unlearning your OOP habits
* very small standard library
 * filesystem functions have no concept of directories
 * sounds crazy but it's actually OK because neither does C99 or the esp8266!
* "embeddable" has two meanings
 * usually means "embedded in a larger C program"
 * but here it means "runs in very limited resources"

### least-favorite things about Lua

Lua has a few small annoyances; most of these have workarounds:

* easy to accidentally set a global
* easy to accidentally attempt to read a global
* easy to call a function with the wrong number of arguments
* statements vs expressions

## Fennel

* So Lua is a very nice language. it's simple and well-understood.
 * it's small, so its flaws are small too.
* but ... I like lisps!
 * no statement/expression distinction
  * if expression, not and/or chain
 * predictable, regular syntax (code is data)
 * macro system
 * no accidental globals

* what is the cost of a compiler?
 * depends on the semantic distance between the two languages
 * with no semantic distance, the mental overhead is negligible
 * change syntax all you want!

* also has these bonuses
 * pattern matching/destructuring
 * clearer difference between sequential vs k/v tables
  * lua uses curly brackets for all
  * fennel looks more like json with square brackets for sequential
 * locals default to immutability
 * optional arity checks

## interactive development!

* so why is the repl such a big deal?
* traditional microcontroller development has *miserable* feedback loops
 * edit, recompile, upload, run, stare at it
 * often with arduinos, your only hint as to the state of the chip is LEDs
 * deciphering different patterns of blinking
* the tighter your feedback loop, the faster you can fix problems
 * achieve a state of flow
* not only can you tell what's going on, you can call functions directly
* or redefine functions without restarting
* on a non-networked chip, this isn't too bad; there's very little state
 * how much state can you fit in 2.5kb anyway?
 * restart, re-establish your state, easy
 * throw networking in and it gets more complicated; lots of state!
 * you can change code *without* closing a socket
* gold standard here is Erlang
 * hello, mike. hello, joe.

* during development, you want modules exposed as globals
* tension between lexical scope and reloadability

## nodemcu

* one firmware option available for esp8266
 * a port of Lua to this platform
 * plus APIs exposing the available hardware
 * without getting TOO philosophical, is this an operating system?
 * based on eLua, a fork of 5.1 optimized for limited resources
* nodemcu itself typically consumes 35kb (early versions it was 65kb!)

### differences from standard lua

* certain modules are omitted: io, os, debug, math (yes math)
* other HW-specific things added in: tmr, wifi, net, i2c, etc
* plus some higher-level things: mdns, http (client and server), mqtt, sjson
* built-in modules are read-only tables so they can be stored in flash, not RAM
* no execution can take over 15 ms, or your wifi connection can be interrupted
* errors or exhausting memory typically results in reboot
* callbacks, callbacks everywhere

### tasks

* all lua execution happens inside a task
* tasks get queued up with three different priority orders
 * high priority: hardware stuff (typically not your code)
 * medium priority: timer/event/io
 * low priority: everything else
* coroutine resuming cannot cross task boundaries?
* if you suspend the wifi, the strict time limits don't apply

* typically init.lua attempts to connect to wifi, then loads app code
* but you can also act as a wifi base station
* or be a base station just in order to get creds for a real connection

### onboard compiler

* attempted to load the compiler onto the device
* failed to load; too many locals (50 limit vs 200)
* can bump the limit when compiling by hand
* got the compiler uploaded but ran out of RAM when loading it
* stripped out all the macro features, it loaded but left under 20kb free

### takver repl

* two operational modes of fennel: immediate vs aot
* when you're not developing, you do aot compilation and ship the compiled output
* when you're in development, you've always got a Real Computer at hand
* run the compiler on the PC, evaluate it on the device
* requires a change to the Fennel compiler (allow evaluation to be overridden)

### micropeng: case study

* an IRC bot
* IRC is a lovely simple protocol
* raw sockets, plain text
* IRC library is 58 lines
* coding against both luasocket (for the PC) and the nodemcu net module
* the eval command is gone, but the gpio command is new
* possible expansions:
 * sense when a door is opened/closed
 * heat regulator

### Building

* Because storage space is extremely limited, not all modules can be included
* adding modules costs flash AND ram space, so don't do it unless needed
* you can omit floating point to save ram
* cloud builder lets you avoid installing the toolchain locally
 * (but the toolchain isn't really that bad)
* flashing requires a program called esptool
 * but you don't need to flash unless you're changing the modules

* save memory with LSF
 * remember what I said about read-only tables in flash?
 * you can do that for your own code too!
 * only do it once you've worked the bugs out of a given module

## DEMO TIME

* M-x serial-term /dev/TTYUSB0
* takver repl
* connect to the wifi
 * init.lua shim waits for wifi to connect
 * beware the reboot loop
 * you're also going to want mdns in most cases
 * pick a unique name
