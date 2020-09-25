module Family
  module Tree
    class Executor
      attr_reader :relations

      def initialize
        initialize_relations
      end

      def add_child(mother, child, gender)
        @relations.add_child(mother, child, gender)
      end

      def get_relationship(person, relation)
        relatives = case relation
          when "Children"
            @relations.find_children(person)
          when "Son"
            @relations.find_sons(person)
          when "Daughter"
            @relations.find_daughters(person)
          when "Siblings"
            @relations.find_siblings(person)
          when "Brother-In-Law"
            @relations.find_brothers_in_law(person)
          when "Sister-In-Law"
            @relations.find_sisters_in_law(person)
          when "Paternal-Uncle"
            @relations.find_paternal_uncle(person)
          when "Paternal-Aunt"
            @relations.find_paternal_aunt(person)
          when "Maternal-Uncle"
            @relations.find_maternal_uncle(person)
          when "Maternal-Aunt"
            @relations.find_maternal_aunt(person)
          else
            ["COMMAND_NOT_SUPPORTED"]
          end

        (relatives.empty? ? "NONE" : relatives.join(" "))
      end

      private

      def initialize_relations
        @relations ||= Family::Tree::Relations.new
      end
    end
  end
end
