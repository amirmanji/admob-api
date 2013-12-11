require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |spec|
  spec.pattern    = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['-c', '-fs']
end

task :default => :spec
