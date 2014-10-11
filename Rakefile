require 'erb'
require 'time'
require 'uri'
require 'yaml'

task :deploy do
  FileUtils.cd(File.dirname(__FILE__))
  system "rsync -azP --exclude=.git* . technomancy.us:technomancy.us"
end

def parse(filename)
  YAML.load(File.read(filename)) rescue {}
end

class Time
  def to_s
    utc.strftime("%Y-%m-%dT%H:%M:%SZ")
  end

  def self.stamp(time)
    if time.is_a? Time
      time.to_s
    else
      Time.parse(time).to_s
    end
  end
end

def up_to_date?(file, template, rendered_filename)
  return false if ENV['force']
  File.exist?(rendered_filename) and
    (File.mtime(rendered_filename) > File.mtime(file)) and
    (File.mtime(rendered_filename) > File.mtime(template))
end

def render_files_with_template(glob, template_file)
  template = ERB.new(File.read(template_file))
  Dir.glob(glob).each do |file|
    page = parse(file)
    puts "Rendering #{file}."
    rendered_filename = yield(page)
    next if up_to_date? file, template_file, rendered_filename and !ENV['force']
    File.open(rendered_filename, 'w') { |f| f.puts template.result(binding) }
  end
end

def render_file_with_template(page, template_file, rendered_filename)
  template = ERB.new(File.read(template_file))
  File.open(rendered_filename, 'w') { |f| f.puts template.result(binding) }
  puts "Rendered #{rendered_filename}."
end

def including(template, locals = {})
  ERB.new(File.read(File.dirname(__FILE__) +
                    "/templates/#{template}.html.erb")).result(binding)
end

desc "Render posts to static files"
task :posts do
  render_files_with_template('posts/*.yml',
                             'templates/post.html.erb') { |page| "public/#{page['id']}.html" }
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
  render_file_with_template(pages, 'templates/atom.erb', 'public/feed/atom.xml')
end

desc "Render list of posts"
task :list do
  posts = Dir.glob('posts/*.yml').sort_by{ |f| f.match(/(\d+)/)[1].to_i }.map{ |f| parse(f) }.reverse
  render_file_with_template(posts, 'templates/list.html.erb', "public/list.html")
  FileUtils.cp("public/#{posts.first['id']}.html", 'public/index.html')
end

task(:other) do
  ['projects', 'colophon', 'resume', 'books'].each { |s| render_file_with_template s, "templates/#{s}.html.erb", "public/#{s}.html" }
end

task(:server) { system "cd public; python -m SimpleHTTPServer 3001" }

task :default => [:posts, :list, :feed, :other]
