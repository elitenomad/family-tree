module Family
  module Tree
    class Command
      def self.parse(cmd)
        case cmd
        when /\AADD_CHILD ('?(?<mother>[\w+\s]+)'?) ('?(?<child>[\w+\s]+)'?) (?<gender>\w+)\Z/
          [:add_child, $~[:mother], $~[:child], $~[:gender]]
        when /\AGET_RELATIONSHIP ('?(?<name>[\w+\s]+)'?) (?<relationship>[\w-]+)\Z/
          [:get_relationship, $~[:name], $~[:relationship]]
        when /\AFIND_OLDER ('?(?<member_1>[\w+\s]+)'?) ('?(?<member_2>[\w+\s]+)'?)\Z/
          [:find_older, $~[:member_1], $~[:member_2]]
        else
          [:invalid, cmd]
        end
      end
    end
  end
end
