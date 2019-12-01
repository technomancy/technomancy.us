# In Production: Creating Physical Objects with Racket

who am I, etc: Leiningen, Fennel, Atreus

my secret: I'm not a seasoned Racketeer

but! 

> the spirit of Racket is about modifying your environment to
> better fit the problem at hand and moving beyond outdated assumptions.

this talk should be relevant to that spirit:

## History

much like with mainstream programming languages, status quo for
keyboards is very poor for historical reasons

> typewriter

* outdated assumptions: typewriter staggering is so 1800s
  * each key press made a striking arm come hit the paper
  * aligning them would have left no room for multiple rows arms to come
  * computer keyboards don't jam
  * look at your fingers!
  * they go up and down, not side to side.
  * space bar doesn't need to be huge
  * shift key is on the pinky
  * not even going to talk about how bad QWERTY is
    * basically everyone already knows this

> qmk configurator

* programmable environment
  * every keyboard has a microcontroller now
  * keyboard firmware can do so much more
  * layout should not be static
  * you should be able to change it to fit your needs

(about 4.5m)

## my design

> nx-01

* In 2014 I took a shot at improving on the status quo
  * thought experiment: how much can you remove and still have it usable?
  * shrink the space bar down
  * opens up room for shift, ctrl, alt to use the thumbs
    * emacs user here, hi
  * layers, fn key being on the thumb means it doesn't suck
* Designed a case in Inkscape
* Took it to the laser cutter at the local makerspace

> hand-wired matrix
* First prototype using hand-wired matrix
  * published schematics, BOM, instructions
  * a couple intrepid folks did full DIY
    * including one who contributed a case improvement
* friends asked me to build them one
  * friend of a friend
  * friend of a friend of a friend ...
  * too many to build myself; start selling kits
* hand-wiring is not for the faint of heart

(7 minutes)

## PCB to the rescue!

> PCB
* what even is a PCB?
  * it's just taking all those wires and ... formalizing them
  * "fewer moving parts"
  * makes the construction process much quicker and more reliable
* electrically very simple: no analog signals, just binary HIGH/LOW
* keyboard matrix
  * columns and rows for each pin creating a grid
  * one row is read at a time; loops thru scanning each row quickly
  * gives the illusion of instantaneous reads
  * same principle as an LED matrix sign, but that's output

> kicad
* kicad!
  * laid out all the switches
  * but you can't rotate a group as a single unit, just individually!
  * thought about doing the calculations by hand but ... ugh!
  * huzzah: kicad file format is s-expressions!
  * symbols have leading digits: can't use Clojure
  * why not Racket?

(11 minutes)

> pcb source
* atreus.rkt
  * takes column/row count, spacing, and angle parameters
  * define offsets for each column
  * uses trigonometry to determine positioning of switch+diode pair

* impractical to fabricate at low volumes
* sent seeed studio

* first prototype run had a couple issues
  * only ordered 10 because I wasn't sure it would work
  * mistake: no room for USB port
  * alterations done with a hacksaw on the first ten
  * second run was perfect
* racket let me do the calculations I needed to produce this file
  * I could play with the design and adjust the parameters

## Needs a case!

> acrylic case
* laser cutting
  * not as hyped as 3D printing but better in many ways
  * looks better
  * cuts faster
  * much stronger
  * also: did I mention they use lasers and lasers are cool?
* but obviously limited to stacked 2D shapes

> inkscape screenshot
* Prototype: drawn in Inkscape
  * not even 100% symmetrical
* Kits: OpenSCAD
  * Remarkable technology!
  * Programmable design compiled from input parameters
  * Very disagreeable programming language
  * Much more powerful than necessary; I'm only making cuts in 2D

> case source
* Atreus 2: Racket!
  * racket/draw library with SVG output?
    * well... no
    * circles were elliptical somehow
    * ellipses placed based on the top left corner of their bounding box?!?
  * luckily SVG itself is actually pretty easy!
    * just write out XML.
> atreus 2
  * this case is much smaller!
  * snugly hugs the circuit board

> glowforge
* Racket was a great fit for programmatically generating shapes
* I have my own laser
* But depending on where you live, you might be able to buy time on one
  * Makerspaces are the first place to look
  * but independent laser operators exist too

(18m)

## Firmware

> instead of slides, show the codebases?

* prototype: atreus-firmware codebase in C (200 lines)
  * my first C in over a decade
  * layer switching bug! ugh.
  * not very featureful
* orestes: argh but I hate C
  * but nothing else will run on microcontrollers
  * unless... what if forth?!
  * turns out: no. 2.5kb is not enough RAM
  * I dropped into the #forth IRC channel and asked if it's reasonable
    * basically: no, maybe for a super-forth-genius
  * ported to ARM-based prototype
  * actually works; my dad uses it
  * but the chip costs 2x as much; not worth it
  * surprise twist, 4 years later: you actually CAN forth in 2.5kb if clever
    * http://michaelalynmiller.com/blog/2017/10/04/enforth/
* the recommended firmware is QMK, a community project (but the code is gnarly!)

> microscheme web site
* microscheme!
  * very arduino-ish
  * my firmware: started in 2015
  * but testing it is sooooo tedious
  * I finished basic matrix scan without layering
  * in preparation for this talk I took another look at it
  * realized microscheme is a subset of racket
  * used racket to write a test harness to develop without uploading
  * in 2 days I had gotten further than I had previously, around 150 lines
  * it works nicely!

## Conclusion

* that's my story

> the spirit of Racket is about modifying your environment to
> better fit the problem at hand and moving beyond outdated assumptions.

* I'd encourage you to find ways to challenge outdated assumptions and
  find ways to improve on the status quo
