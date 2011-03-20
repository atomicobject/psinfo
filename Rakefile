require "./config/env"
require 'cucumber/rake/task'

here = File.expand_path(File.dirname(__FILE__))
PROJECT_CEEDLING_ROOT = "#{here}/vendor/ceedling"
load "#{PROJECT_CEEDLING_ROOT}/lib/rakefile.rb"

task :default => [:clobber, 'test:all', :release]

namespace :cuke do
  Cucumber::Rake::Task.new("client") do |t|
    t.cucumber_opts = %w{--format pretty features/client}
  end

  Cucumber::Rake::Task.new("server") do |t|
    t.cucumber_opts = %w{--format pretty features/server}
  end

  task :all => %w[ client server ]
end
