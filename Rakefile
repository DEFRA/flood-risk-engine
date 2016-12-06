begin
  require "bundler/setup"
rescue LoadError
  puts "You must `gem install bundler` and `bundle install` to run rake tasks"
end

require "rdoc/task"

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = "rdoc"
  rdoc.title    = "FloodRiskEngine"
  rdoc.options << "--line-numbers"
  rdoc.rdoc_files.include("README.rdoc")
  rdoc.rdoc_files.include("lib/**/*.rb")
end

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load "rails/tasks/engine.rake"
load "rails/tasks/statistics.rake"
load "lib/tasks/factorygirl.rake"

# Supressing exceptions breaks rubocop but at this time we're unsure why we
# supressed this in the first place. So for now we're disabling that rubocop
# check for this bit of code
# rubocop:disable Lint/HandleExceptions
begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end
# rubocop:enable Lint/HandleExceptions

task test: :spec

task :rubocop do
  sh "bundle exec rubocop"
end

task default: [:rubocop, :test]

Bundler::GemHelper.install_tasks
