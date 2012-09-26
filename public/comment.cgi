#!/usr/bin/env ruby

require 'cgi'
require 'yaml'

cgi = CGI.new

raise "Spammers suck" if cgi.params['post_id'].first.to_i < 151

new_comment = { 'timestamp' => Time.now.to_s }
['author', 'uri', 'content', 'human'].each do |param|
  new_comment[param] = CGI.escapeHTML(cgi.params[param].to_s)
end

new_comment['content'].gsub!("\r?\n", "<br />") # newlines

raise "You suuuuuuuuuuuuuuuuuuuuuuuuuuck" if new_comment['uri'] =~ /bestfinance/
raise "You suuuuuuuuuuuuuuuuuuuuuuuuuuck" if new_comment['uri'] =~ /goodfinance/
raise "You suuuuuuuuuuuuuuuuuuuuuuuuuuck" if new_comment['uri'] =~ /^(http|$)/

if(cgi.params['evil'].to_s =~ /y/i and
   cgi.params['post_id'].to_s != '')
  filename = File.expand_path "../comments/#{cgi.params['post_id']}.yml"
else
  filename = '/dev/null'
end

comments = YAML.load(File.read(filename)) || [] rescue []
comments << new_comment

File.open(filename, 'w') { |f| f.puts comments.to_yaml }

cgi.out("status" => "301 Moved",
        "Location" =>
        "http://technomancy.us/#{cgi.params['post_id']}#c") { comments.to_yaml }

# system "cd #{File.dirname(__FILE__)} && rake post POST=#{cgi.params['post_id']} force=y"
