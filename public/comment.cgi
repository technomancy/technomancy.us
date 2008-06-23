#!/usr/bin/env ruby

require 'cgi'
require 'yaml'

cgi = CGI.new

new_comment = { 'timestamp' => Time.now.to_s }
['author', 'uri', 'content'].each { |param| new_comment[param] = CGI.escapeHTML(cgi.params[param].to_s) }
new_comment['content'].gsub!("\n", "<br />") # newlines

filename = File.expand_path "../comments/#{cgi.params['post_id']}.yml"

comments = YAML.load(File.read(filename)) rescue []

comments << new_comment

if cgi.params['spammers'].to_s != 'suck'
  File.open(filename, 'w') { |f| f.puts comments.to_yaml }
end

cgi.out("status" => "301 Moved",
        "Location" => "http://technomancy.us/#{cgi.params['post_id']}#c") { comments.to_yaml }

system "cd .. && rake render_post POST=#{cgi.params['post_id']} force=y"
