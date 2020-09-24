module Family
  module Tree
    class Command
      def self.parse(cmd)
        case cmd
        when /\AADD_CHILD ('?(?<mother>[\w+\s]+)'?) ('?(?<child>[\w+\s]+)'?) (?<gender>\w+)\Z/
          [:add_child, $~[:mother], $~[:child], $~[:gender]]
        when /\AGET_RELATIONSHIP ('?(?<name>[\w+\s]+)'?) (?<relationship>[\w-]+)\Z/
          [:get_relationship, $~[:name], $~[:relationship]]
        else
          [:invalid, cmd]
        end
      end
    end
  end
end
