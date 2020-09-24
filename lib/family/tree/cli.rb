module Family
  module Tree
    class CLI
      attr_reader :executor

      def initialize
        @executor = Family::Tree::Executor.new
      end

      def load(file)
        if !Family::Tree::ACCEPTED_FORMATS.include?(File.extname(file))
          raise Family::Tree::FileFormatNotSupportedError.new
        end

        File.readlines(file).map do |line|
          Family::Tree::Command.parse(line)
        end
      end

      def run(commands)
        commands.each do |command, *args|
          begin
            puts executor.send(command, *args) unless command == :invalid
          rescue => e
            puts "#{e.message}"
            next
          end
        end
      end
    end
  end
end
