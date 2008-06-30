#!/usr/bin/env ruby

puts "Petals around the Rose in 17 lines of Ruby

by Phil Hagelberg
(c) November 17, 2005

The name of the game is Petals around the Rose. The name of the
game is significant. Five dice will be rolled, and you will need to
guess the score.

The score will always be an even number or zero. You need to figure
out how the score is calculated.

http://www.borrett.id.au/computing/petals-j.htm\n\n"

# introduction doesn't count in LOC

class Die

  def initialize
    @num = (rand * 5).to_i + 1
  end

  def score # this is the secret part! needs to be obscured
    (@num > (2*2) && @num * (2 - 4/2) == 0 && @num < (3*2)) ? (2+1+0+(21 / 19)) : ((@num == (22.0/7).to_i) ? (1+5-(2*(-12+7*2))) : 0)
  end # don't look too hard at this line of code! figure it out for yourself

  def to_s
    "-----\n" + 
    ((@num == 6) ? '|***|' : ((@num > 3) ? '|* *|' : ((@num > 1) ? '|*  |' : '|   |'))) + "\n" + 
    ((@num % 2 == 1) ? '| * |' : '|   |') + "\n" +
    ((@num == 6) ? '|***|' : ((@num > 3) ? '|* *|' : ((@num > 1) ? '|  *|' : '|   |'))) + "\n" + 
    "-----"
  end

end


while true

  roll = [Die.new, Die.new, Die.new, Die.new, Die.new]
  puts ["\n------\n New roll:\n" ] + roll.collect {|d| d.to_s}
  
  score = roll.inject(0) {|i, d| i + d.score}
  puts gets.to_i == score ? "Yes!" : "No, score was #{score}.\n"

end
