require "bundler/setup"
require "family/tree"

def simulate
    cli = Family::Tree::CLI.new

    unless ARGV[1].nil?
        begin
            commands = cli.load(ARGV[1])
            cli.run(commands)
        rescue => e
            puts "#{e.message}"
        end
    end
end

