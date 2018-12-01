# frozen_string_literal: true

require 'bundler/setup'
require 'bundler/gem_tasks'

desc 'Run Cucumber'
require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |task|
  # Any valid command line option can go here.
  task.cucumber_opts = '--format progress --tags "not @wip"'
end
Cucumber::Rake::Task.new(:wip) do |task|
  # Any valid command line option can go here.
  task.cucumber_opts = '--format pretty --tags @wip --wip'
end

desc 'Run RuboCop'
require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.options << '--display-cop-names'
end

desc 'Run RSpec'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task default: %i[rubocop features wip spec]
