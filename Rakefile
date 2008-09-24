require 'erb'
require 'time'
require 'cgi'
require 'uri'
require 'yaml'

begin
  require 'vlad'
  set :domain, 'technomancy.us'
  set :rsync_flags, ['-azP', "--exclude=.git*"]

  def reverse_rsync local, remote
    cmd = [rsync_cmd, rsync_flags, "#{domain}:#{remote}", local].flatten.compact

    system(*cmd) or
      raise Vlad::CommandFailedError, "execution failed: #{cmd.join ' '}"
  end

  desc "Deploy blog files to remote server"
  remote_task :deploy => :default do
    begin
      # TODO: teach rsync to ignore cache
      FileUtils.cd(File.dirname(__FILE__))
      FileUtils.mv 'planet/cache', 'tmp/planet-cache' rescue nil
      rsync '.', domain
    ensure
      FileUtils.mv 'tmp/planet-cache', 'planet/cache' rescue nil
    end
  end

  remote_task :publish => :deploy

  desc "Copy comments from remote host to local copy of blog"
  remote_task(:comments) { reverse_rsync '.', "#{domain}/comments" }
rescue LoadError
  task(:comments) { "dummy task to satisfy deps when vlad is not present" }
end

def parse(filename)
  YAML.load(File.read(filename)) rescue {}
end

class Time
  def to_s
    strftime("%Y-%m-%dT%H:%M:%SZ")
  end

  def self.stamp(time)
    Time.parse(time).to_s
  end
end

def up_to_date?(file, template, rendered_filename)
  File.exist?(rendered_filename) and
    (File.mtime(rendered_filename) > File.mtime(file)) and
    (File.mtime(rendered_filename) > File.mtime(template))
end

def render_files_with_template(glob, template_file)
  template = ERB.new(File.read(template_file))
  Dir.glob(glob).each do |file|
    page = parse(file)
    rendered_filename = yield(page)
    next if up_to_date? file, template_file, rendered_filename and ENV['force'].nil?
    File.open(rendered_filename, 'w') { |f| f.puts template.result(binding) }
    puts "Rendered #{rendered_filename}."
  end
end

def render_file_with_template(page, template_file, rendered_filename)
  template = ERB.new(File.read(template_file))
  File.open(rendered_filename, 'w') { |f| f.puts template.result(binding) }
  puts "Rendered #{rendered_filename}."
end

def including(template, locals = {})
  ERB.new(File.read(File.dirname(__FILE__) + "/templates/#{template}.html.erb")).result(binding)
end

desc "Render posts to static files"
task :posts do
  render_files_with_template('posts/*.yml', 'templates/post.html.erb') { |page| "public/#{page['id']}.html" }
end

desc "Render a single post"
task :post do
  page = parse("posts/#{ENV['POST']}.yml")
  render_file_with_template(page, 'templates/post.html.erb',
                            "public/#{page['id']}.html")
end

desc "Render Atom feed"
task :feed do
  pages = Dir.glob('posts/*.yml').sort_by{ |f| f.match(/(\d+)/)[1].to_i }[-16 .. -1].reverse.map{ |f| parse(f) }
  render_file_with_template(pages, 'templates/atom.erb',
                            'public/feed/atom.xml')
end

desc "Render list of posts"
task :list do
  posts = Dir.glob('posts/*.yml').sort_by{ |f| f.match(/(\d+)/)[1].to_i }.map{ |f| parse(f) }.reverse
  render_file_with_template(posts, 'templates/list.html.erb', "public/list.html")
  FileUtils.cp("public/#{posts.first['id']}.html", 'public/index.html')
end

task(:other) do
  ['projects', 'colophon'].each { |s| render_file_with_template s, "templates/#{s}.html.erb", "public/#{s}.html" }
end

task(:planet) { system "mars planet/config.yml" }

task :default => [:posts, :list, :feed, :other]

task(:stats) { puts File.read(__FILE__).split("\n").reject{ |l| l =~ /^\s*$/ or l =~ /^\s*#/ }.size }

# TODO:
# Favicon
# Footer that lists "around" posts
# whitespace in code snippets
# Restore old timestamps, then list posts by month
# Make index page stand out a bit
# add /blog/post/$ID redirect
# drop caps?
# fix the JS on post 66
# retire dev.technomancy.us; move content here
# convert resume into LaTeX
