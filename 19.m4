dnl -*- html -*-
define(__timestamp, 2005-11-23T11:48:19Z)dnl
define(__title, `music dilemma')dnl
define(__id, 19)dnl
include(header.html)
<p> If you're anything like me,  you've got about a million music files that aren't tagged properly. Specifically,  they are missing their track number tags. (They have the track number as part of their file name though,  such as "06-the_curse_of_feanor.ogg") This isn't a big deal if you use players like <a href='http://xmms.org'>XMMS</a>,  which are capable of ordering files in alphabetical order by filename. Unfortunately,  a recent trend in audio players has been to leave that capability out. (I'm looking at <i>you</i>,  iTunes. But there are many guilty parties.) </p> <p>Here's a script that will fix your dilemma. I wanted to do it all in Ruby,  but I found that the <a href='http://www.hakubi.us/ruby-taglib/'>Ruby TagLib</a> library was simply too crappy to do so. So this script requires that <a href='http://linuxcommand.org/man_pages/vorbiscomment1.html'>vorbiscomment</a> be installed. (It's in the <code>vorbis-tools</code> package on Ubuntu.) Save what's below as <code>allofogg.rb</code></p> <pre class='code'> #/usr/bin/env ruby
 require 'find'
 Find.find(ARGV[0]) do |f|
 next unless f.include? ARGV[1] || '.ogg'
 next unless f.include?('/') && (tracknum = f[f.rindex('/')+1 .. 
 f.rindex('/') + 2].to_i) > 0
 sanitized = f.gsub('(',  '\(').gsub(')',  '\)')

 &#96;vorbiscomment -a #{sanitized} -t "tracknumber=#{tracknum}"&#96;
 end </pre> <p>Syntax:  allofogg.rb FILES [EXTENSION]</p>
include(footer.html)
