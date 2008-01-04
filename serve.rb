#!/usr/bin/env ruby

require 'rubygems'
require 'mongrel'

config = Mongrel::Configurator.new :host => "127.0.0.1" do
  listener :port => 3000 do
    uri "/", :handler => Mongrel::DirHandler.new("public")
  end
  run
end

config.join
