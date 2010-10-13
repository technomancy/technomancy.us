#!/usr/bin/env ruby

require 'cgi'
require 'yaml'

cgi = CGI.new

new_comment = { 'timestamp' => Time.now.to_s }
['author', 'uri', 'content'].each do |param|
  new_comment[param] = CGI.escapeHTML(cgi.params[param].to_s)
end

new_comment['content'].gsub!("\r?\n", "<br />") # newlines

if cgi.params['human'].to_s != '1' or cgi.params['post_id'].to_s == ''
  filename = '/dev/null'
  new_comment['post_id'] = cgi.params['post_id']
else
  filename = File.expand_path "../comments/#{cgi.params['post_id']}.yml"
end

comments = YAML.load(File.read(filename)) || [] rescue []
comments << new_comment

File.open(filename, 'w') { |f| f.puts comments.to_yaml }

cgi.out("status" => "301 Moved",
        "Location" =>
        "http://technomancy.us/#{cgi.params['post_id']}#c") { comments.to_yaml }

# system "cd #{File.dirname(__FILE__)} && rake post POST=#{cgi.params['post_id']} force=y"
