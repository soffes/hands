#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = ['--color']
end

task :default => :spec

task :coverage do
  `open coverage/index.html`
end

task :doc do
  puts `bundle exec yard`
end

namespace :doc do
  task :server do
    `bundle exec yard server --reload`
  end
end
