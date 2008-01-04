require 'rubygems'
require 'erb'
require 'json'

def render_files_with_template(glob, template_file, filename_generator)
  template = ERB.new(File.read(template_file))
  Dir.glob(glob).each do |file|
    page = JSON.parse(File.read(file))
    rendered_filename = filename_generator.call(page)
    File.open(rendered_filename, 'w') { |f| f.puts template.result(binding) }
    puts "Rendered post #{rendered_filename}."
  end
end

desc "Render posts to static files"
task :render_posts do
  render_files_with_template('posts/*.json', 'templates/post.erb',
                             lambda { |page| "public/#{page['id']}.html" })
end

desc "Render static pages"
task :render_static do
  render_files_with_template('static/*.json', 'templates/static.erb',
                             lambda { |page| "public/#{page['name']}.html" })
end

desc "Render Atom feed"
task :render_feed do
  render_files_with_template('posts/*.json', 'templates/atom.erb',
                             lambda { 'public/feed/atom.xml'} )
end

desc "Render pages of posts"
task :render_pages do
end

task :render => [:render_posts, :render_pages, :render_feed, :render_static]

task :default => [:render_posts, :render_feed, :render_pages]
