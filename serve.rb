#!/usr/bin/env ruby

require 'rubygems'
require 'mongrel'

config = Mongrel::Configurator.new :host => "127.0.0.1" do
  listener :port => 3000 do
    uri "/", :handler => Mongrel::DirHandler.new("public")
    # TODO: content-negotiate to transform "contact" into "contact.html"
  end
  run
end

puts "Serving on port 3000..."
config.join
