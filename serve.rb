#!/usr/bin/env ruby1.8

require 'rubygems'
require 'mongrel'

config = Mongrel::Configurator.new :host => "127.0.0.1" do
  listener :port => 3001 do
    uri "/", :handler => Mongrel::DirHandler.new("public")
  end
  run
end

puts "Serving on port 3001..."
config.join
