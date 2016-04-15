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

require "before_commit"
spec = Gem::Specification.find_by_name "before_commit"
load "#{spec.gem_dir}/lib/tasks/before_commit.rake"

load "lib/tasks/factorygirl.rake"

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

task test: :spec

task :rubocop do
  sh "rubocop -D"
end

task default: [:rubocop, :test]

Bundler::GemHelper.install_tasks
