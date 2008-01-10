#!/usr/bin/env ruby

require 'cgi'

class CGI
  def redirect(where)
    print self.header( { 'Status' => '302 Moved', 'location' => '#{where}' } )
  end

  def parse_param(param_name)
    CGI.escapeHTML self.params[param_name]
  end
end

def to_json(hash)
  "{\"timestamp\":  \"#{hash['timestamp']}\",  \"uri\":  \"#{hash['uri']}\",  \"author\":  \"#{hash['author']}\",  \"content\":  \"#{hash['content']}\"}"
end

cgi = CGI.new

new_comment = { 'timestamp' => Time.now.to_s }
['author', 'uri', 'content'].each { |param| new_comment[param] = cgi.parse_param(param) }

filename = "../comments/#{cgi.params['post_id']}.json"
comments = YAML.load(File.read(filename))
comments << new_comment

File.open(filename, ,'w') { |f| f.puts '[' + comments.map{ |c| to_json(c) }.join(',') + ']' }

cgi.redirect "http://technomancy.us/#{cgi.params['post_id']}"
