require "./config/env"
require 'cucumber/rake/task'

namespace :cuke do
  Cucumber::Rake::Task.new("client") do |t|
    t.cucumber_opts = %w{--format pretty features/client}
  end

  Cucumber::Rake::Task.new("server") do |t|
    t.cucumber_opts = %w{--format pretty features/server}
  end
end
