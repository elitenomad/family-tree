module Family
  module Tree
    class Command
      def self.parse(cmd)
        case cmd
        when /\AADD_CHILD (?<mother>\w+) (?<child>\w+) (?<gender>\w+)\Z/
          [:add_child, $~[:mother], $~[:child], $~[:gender]]
        when /\AGET_RELATIONSHIP (?<name>\w+) (?<relationship>[\w-]+)\Z/
          [:get_relationship, $~[:name], $~[:relationship]]
        else
          [:invalid, cmd]
        end
      end
    end
  end
end
