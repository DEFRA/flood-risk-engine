# frozen_string_literal: true

begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

APP_RAKEFILE = File.expand_path("spec/dummy/Rakefile", __dir__)
load "rails/tasks/engine.rake"
load "rails/tasks/statistics.rake"

Dir[File.join(File.dirname(__FILE__), "lib/tasks/**/*.rake")].each { |f| load f }

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)

desc "test task"
task test: :spec

task default: [:test]

Bundler::GemHelper.install_tasks
