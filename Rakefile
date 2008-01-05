require 'rubygems'
require 'erb'
require 'time'
require 'cgi' # for HTML escaping
require 'uri'
begin
  require 'vlad'
rescue LoadError
end

begin
  require 'json'
  def parse(filename)
    JSON.parse(File.read(filename).gsub("\n", ''))
  end
rescue LoadError
  require 'yaml'
  def parse(filename)
    YAML.parse(File.read(filename).gsub("\n", ''))
  end
end

set :domain, 'technomancy.us'
PAGE_SIZE = 10

class Time
  def to_s
    strftime("%Y-%m-%dT%H:%M:%SZ")
  end
end

def render_files_with_template(glob, template_file, filename_generator)
  template = ERB.new(File.read(template_file))
  Dir.glob(glob).each do |file|
    page = parse(file)
    rendered_filename = filename_generator.call(page)
    File.open(rendered_filename, 'w') { |f| f.puts template.result(binding) }
    puts "Rendered #{rendered_filename}."
  end
end

def render_file_with_template(page, template_file, rendered_filename, page_num = nil, page_count = nil)
  template = ERB.new(File.read(template_file))
  File.open(rendered_filename, 'w') { |f| f.puts template.result(binding) }
  puts "Rendered #{rendered_filename}."
end

desc "Render posts to static files"
task :render_posts do
  render_files_with_template('posts/*.json', 'templates/post.erb',
                             lambda { |page| "public/#{page['id']}.html" })
end

desc "Render a single post"
task :render_post do
  page = parse("posts/#{ENV['POST']}.json")
  render_file_with_template(page, 'templates/post.erb',
                            "public/#{page['id']}.html")
end

desc "Render static pages"
task :render_static do
  render_files_with_template('static/*.json', 'templates/static.erb',
                             lambda { |page| "public/#{page['title'].downcase}.html" })
end

desc "Render Atom feed"
task :render_feed do
  pages = Dir.glob('posts/*.json').sort_by{ |f| f.match(/(\d+)/)[1].to_i }[-16 .. -1].reverse.map{ |f| parse(f) }
  render_file_with_template(pages, 'templates/atom.erb',
                            'public/feed/atom.xml')
end

desc "Render pages of posts"
task :render_pages do
  all_pages = Dir.glob('posts/*.json').sort_by{ |f| f.match(/(\d+)/)[1].to_i }.map{ |f| parse(f) }
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

# Can't deploy with Rake 0.8!
desc "Deploy blog files to remote server"
remote_task :deploy do
  rsync '.', 'technomancy.us'
end
