require "bundler/gem_tasks"
require "rspec/core/rake_task"

require "family/tree"

RSpec::Core::RakeTask.new(:spec)

desc "Produces the output for given input commands through file."
task :default, :path do |t, args|
    path = args[:path]
    cli = Family::Tree::CLI.new

    begin
        commands = cli.load(path)
        cli.run(commands)
    rescue => e
        puts "#{e.message}"
    end
end
