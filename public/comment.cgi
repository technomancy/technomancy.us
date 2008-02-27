#!/usr/bin/env ruby

require 'cgi'
require 'yaml'

def to_json(hash)
  "{\"timestamp\":  \"#{hash['timestamp']}\",  \"uri\":  \"#{hash['uri']}\",  \"author\":  \"#{hash['author']}\",  \"content\":  \"#{hash['content']}\"}"
end

cgi = CGI.new

new_comment = { 'timestamp' => Time.now.to_s }
['author', 'uri', 'content'].each { |param| new_comment[param] = CGI.escapeHTML(cgi.params[param].to_s) }
filename = File.expand_path "../comments/#{cgi.params['post_id']}.json"

begin
  comments = YAML.load(File.read(filename))
rescue
  comments = []
end

comments << new_comment
json = '[' + comments.map{ |c| to_json(c) }.join(', ') + ']'

if not spammer = cgi.params['spammers'].to_s != 'suck'
  File.open(filename, 'w') { |f| f.puts json }
end

cgi.out("status" => "301 Moved", "X-Spammer" => spammer,
        "Location" => "http://technomancy.us/#{cgi.params['post_id']}#c") { json }

`touch #{File.dirname(__FILE__)}/../posts/#{cgi.params['post_id']}.json`
`cd #{File.dirname(__FILE__)}/.. rake render_post POST=#{cgi.params['post_id']}`
