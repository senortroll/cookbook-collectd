#!/usr/bin/env rake
require 'rake'
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'

cookbook_dir = File.expand_path File.dirname(__FILE__)
ENV['BERKSHELF_PATH'] = cookbook_dir + '/.berkshelf'
ENV['CI_REPORTS'] =  cookbook_dir + '/reports'

task default: 'quick'

desc 'Run all of the quick tests.'
task :quick do
  Rake::Task['rubocop'].invoke
  Rake::Task['foodcritic'].invoke
  Rake::Task['spec'].invoke
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new do |task|
    task.fail_on_error = true
  end
rescue LoadError
  warn 'Rubocop gem is not installed, now the code will look like a crap!'
end

begin
  require 'foodcritic'

  task default: [:foodcritic]
  FoodCritic::Rake::LintTask.new do |t|
    t.options = { fail_tags: %w/correctness services libraries deprecated/ }
  end
rescue LoadError
  warn 'Foodcritic gem is not installed, now the cookbook will look like a crap'
end

RSpec::Core::RakeTask.new(:spec => ["ci:setup:rspec"])

begin
  require 'kitchen/rake_tasks'
  Kitchen::RakeTasks.new
rescue LoadError
  puts '>>>>> Kitchen gem not loaded, omitting tasks' unless ENV['CI']
rescue Kitchen::UserError => e
  puts "Warn: #{e}"
end

desc 'Run _all_ the tests. Go get a coffee.'
task :complete do
  Rake::Task['quick'].invoke
  Rake::Task['kitchen:all'].invoke
end

desc 'Run CI tests'
task :ci do
  Rake::Task['test:complete'].invoke
end
