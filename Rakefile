require 'rubygems'
require 'rake/gempackagetask'

require 'merb-core'
require 'merb-core/tasks/merb'

dependency 'dm-core'
dependency 'merb_datamapper'

# Load the basic runtime dependencies; this will include 
# any plugins and therefore plugin rake tasks.
init_env = ENV['MERB_ENV'] || 'development'
Merb.load_dependencies(:environment => init_env)

# Get Merb plugins and dependencies
Merb::Plugins.rakefiles.each { |r| require r }


GEM_NAME = "merb_latest_rss_items_slice"
AUTHOR = "Matt Aimonetti"
EMAIL = "mattaimonetti@gmail.com"
HOMEPAGE = "http://merbist.com/"
SUMMARY = "Merb Slice that provides RSS links display"
GEM_VERSION = "0.0.1"

spec = Gem::Specification.new do |s|
  s.rubyforge_project = 'merb_latest_rss_items_slice'
  s.name = GEM_NAME
  s.version = GEM_VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.add_dependency('merb-slices', '>= 0.9.10')
  s.add_dependency('feedtools', '>= 0.2.29')
  s.require_path = 'lib'
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{lib,spec,app,public,stubs}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Install the gem"
task :install do
  Merb::RakeHelper.install(GEM_NAME, :version => GEM_VERSION)
end

desc "Uninstall the gem"
task :uninstall do
  Merb::RakeHelper.uninstall(GEM_NAME, :version => GEM_VERSION)
end

desc "Create a gemspec file"
task :gemspec do
  File.open("#{GEM_NAME}.gemspec", "w") do |file|
    file.puts spec.to_ruby
  end
end

require 'spec/rake/spectask'
require 'merb-core/test/tasks/spectasks'
desc 'Default: run spec examples'
task :default => 'spec'
