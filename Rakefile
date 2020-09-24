require "bundler/gem_tasks"
require "rspec/core/rake_task"

require "family/tree"
require "./simulator"

RSpec::Core::RakeTask.new(:spec)

desc "Displays the o/p for given family tree commands-I"
task :run, :path do |t, args|
    path = args[:path]
    cli = Family::Tree::CLI.new

    begin
        commands = cli.load(path)
        cli.run(commands)
    rescue => e
        puts "#{e.message}"
    end
end


desc "Displays the o/p for given family tree commands-II"
task :default do |t, args|
    simulate
end