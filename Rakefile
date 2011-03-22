PROJECT_ROOT = File.expand_path(File.dirname(__FILE__))
PROJECT_CEEDLING_ROOT = "#{PROJECT_ROOT}/vendor/ceedling"

require "cucumber/rake/task"
require "#{PROJECT_ROOT}/config/env"
load "#{PROJECT_CEEDLING_ROOT}/lib/rakefile.rb"

task :default => [:clobber, "test:all", :release]

namespace :cuke do
  Cucumber::Rake::Task.new("client") do |t|
    t.cucumber_opts = %w{--format pretty features/client}
  end

  Cucumber::Rake::Task.new("server") do |t|
    t.cucumber_opts = %w{--format pretty features/server}
  end

  task :all => %w[ client server ]

  cuke_task_builder = lambda do |subdir|
    Dir["#{PROJECT_ROOT}/features/#{subdir}/*.feature"].each do |file|
      file = File.basename(file, ".feature")
      task(file, :line) do |t, args|
        command = "ruby bin/cucumber --format pretty features/#{subdir}/#{file}.feature"
        command += ":#{args[:line]}" if args[:line]
        puts `#{command}`
      end
    end
  end

  namespace :client do
    cuke_task_builder.call("client")
  end

  namespace :server do
    cuke_task_builder.call("server")
  end
end
