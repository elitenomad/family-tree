require "bundler/setup"

# Created this file as per instructions
# https://github.com/geektrust/coding-problem-artefacts/tree/master/Ruby
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

