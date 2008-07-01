#!/usr/bin/env ruby1.8

require 'rubygems'
require 'mongrel'

class Mongrel::Error404Handler
  def process(request, response)
    if request.params['REQUEST_PATH'] =~ /\.html$/
      response.socket.write(@response)
    else
      new_url = request.params['REQUEST_PATH'] + '.html'
      response.socket.write(Mongrel::Const::REDIRECT % new_url)
    end
  end
end

config = Mongrel::Configurator.new :host => "0.0.0.0" do
  listener :port => 3001 do
    uri "/", :handler => Mongrel::DirHandler.new("public")
    uri "/", :handler => Mongrel::Error404Handler.new('')
  end
  run
end

puts "Serving on port 3001..."
config.join
