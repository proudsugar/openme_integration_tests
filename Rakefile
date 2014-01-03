#
# Copyright (C) 2014 Proudsugar.com
# Author Luis Merino <luis@proudsugar.com>
#

ENV['CIRCLE_ARTIFACTS'] ||= File.expand_path("./metrics")

FEATURE_FILES = Dir.glob(Dir.pwd + "/features/*.feature")

require 'bundler'
Bundler.setup(:test)

require 'cucumber'
require 'cucumber/rake/task'

task default: :features

$tasks = []

namespace :cucumber do
  FEATURE_FILES.each do |feature_path|
    task_name = File.basename(feature_path).gsub(/\.feature/, '')
    $tasks << "cucumber:#{task_name}"
    Cucumber::Rake::Task.new(task_name.to_sym) do |task|
      #task.cucumber_opts = "--format html --out=#{ENV['CIRCLE_ARTIFACTS']}/#{task_name}.html"
      task.cucumber_opts = feature_path
    end
  end
end

FileUtils.mkdir_p("#{ENV['CIRCLE_ARTIFACTS']}")
task :features => $tasks
