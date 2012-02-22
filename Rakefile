# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "lumos_take_home"
  gem.homepage = "http://github.com/rjspotter/lumos_take_home"
  gem.license = "MIT"
  gem.summary = %Q{lumos programming quiz}
  gem.description = %Q{solve for cheapest restaurant}
  gem.email = "rjspotter@gmail.com"
  gem.authors = ["R. Potter"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new

namespace :metrics do
  desc "shows flog complexity metric"
  task :flog do
    puts `find lib -name \*.rb -printf "%p " | xargs flog -a`
  end

  desc "show flay duplication (copy/paste) metric"
  task :flay do
    puts "Flay " + `find lib -name \*.rb -printf "%p " | xargs flay`
  end

  desc "show reek smells"
  task :reek do
    puts `find lib -name \*.rb -printf "%p " | xargs reek`
  end

  desc "run flay and flog"
  task :all => [:flay, :flog, :reek] 

end