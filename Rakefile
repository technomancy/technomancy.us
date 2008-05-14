require 'rubygems'
require 'erb'
require 'time'
require 'cgi'
require 'uri'
require 'yaml'

begin
  require 'vlad'
  set :domain, 'technomancy.us'
  set :rsync_flags, ['-azP', '--exclude=.git*']

  def reverse_rsync local, remote
    cmd = [rsync_cmd, rsync_flags, "#{domain}:#{remote}", local].flatten.compact
    success = system(*cmd)

    unless success then
      raise Vlad::CommandFailedError, "execution failed: #{cmd.join ' '}"
    end
  end

  desc "Deploy blog files to remote server"
  remote_task :deploy => :default do
    rsync '.', domain
  end

  remote_task :publish => :deploy
  
  desc "Copy comments from remote host to local copy of blog"
  remote_task :sync_comments do
    reverse_rsync '.', "#{domain}/comments"
  end
rescue LoadError
  task(:sync_comments) { "dummy task to satisfy deps when vlad is not present"}
end

PAGE_SIZE = 10

class Time
  def to_s
    strftime("%Y-%m-%dT%H:%M:%SZ")
  end
end

def parse(filename)
  YAML.load(File.read(filename))
end

def template(name)
  ERB.new(File.read("templates/#{name}.erb")).result(binding)
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
    next if up_to_date? file, template_file, rendered_filename
    File.open(rendered_filename, 'w') { |f| f.puts template.result(binding) }
    puts "Rendered #{rendered_filename}."
  end
end

def render_file_with_template(page, template_file, rendered_filename,
                              page_num = nil, page_count = nil)
  # TODO: check for up_to_date?
  template = ERB.new(File.read(template_file))
  File.open(rendered_filename, 'w') { |f| f.puts template.result(binding) }
  puts "Rendered #{rendered_filename}."
end

desc "Render posts to static files"
task :render_posts => :sync_comments do
  render_files_with_template('posts/*.yml', 'templates/post.erb') { |page| "public/#{page['id']}.html" }
end

desc "Render a single post"
task :render_post do
  page = parse("posts/#{ENV['POST']}.yml")
  render_file_with_template(page, 'templates/post.erb',
                            "public/#{page['id']}.html")
end

desc "Render static pages"
task :render_static do
  render_files_with_template('static/*.yml', 'templates/static.erb') { |page| "public/#{page['title'].downcase}.html" }
end

desc "Render Atom feed"
task :render_feed do
  pages = Dir.glob('posts/*.yml').sort_by{ |f| f.match(/(\d+)/)[1].to_i }[-16 .. -1].reverse.map{ |f| parse(f) }
  render_file_with_template(pages, 'templates/atom.erb',
                            'public/feed/atom.xml')
end

desc "Render pages of posts"
task :render_pages do
  all_pages = Dir.glob('posts/*.yml').sort_by{ |f| f.match(/(\d+)/)[1].to_i }.map{ |f| parse(f) }
  page_count = (all_pages.size.to_f / PAGE_SIZE).ceil

  # save the initial index first
  render_file_with_template(all_pages[-11 .. -1].reverse, 'templates/pages.erb', 'public/index.html', 1, page_count)

  page_num = 1

  until all_pages.empty? do
    pages = []
    PAGE_SIZE.times { pages << all_pages.pop } rescue nil
    render_file_with_template(pages.compact, 'templates/pages.erb',
                              "public/page/#{page_num}.html", page_num, page_count)
    page_num += 1
  end
end

task :render_all => [:render_posts, :render_pages, :render_feed, :render_static]

task :default => [:render_posts, :render_feed, :render_pages]
