require 'rubygems'
gem 'technomancy-rack'
require 'rack/response'
require 'rack/handler/mongrel'

# Launches an HTTP server on http://localhost:9999/N that outputs its own code N times
Rack::Handler::Mongrel.run(Proc.new do |env|
                             [200, {}, Proc.new do |response|
                                response.send_status_no_connection_close('')
                                response.send_header
                                env['PATH_INFO'][/(\d+)/].to_i.times do
                                  response.write File.read(__FILE__) + "\n"; sleep 1
                                end
                                response.write "\r\n\r\n"
                              end]
                           end, :Port => 9999)
