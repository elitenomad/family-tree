module Family
  module Tree
    class Relations
      attr_accessor :tree

      def initialize
        load_family_tree
      end

      def parse(person)
        loop = false
        queue = []
        queue << tree

        until loop || queue.size <= 0
          current = queue.pop()
          found = current.generation.compact.map(&:name).include?(person)

          if found
            loop = true
            return current unless block_given?

            yield(current)
          else
            children = current.children
            (children || []).each do |child|
              queue << child
            end
          end
        end
      end

      def add_child(mother, child, gender)
        person = find_person(mother)

        return "PERSON_NOT_FOUND" if person.nil?
        return "CHILD_ADDITION_FAILED" if person.male?

        new_child = Family::Tree::Person.new(
          name: child,
          gender: gender, 
          is_child: true, 
          parent: person.is_child ? person.name : find_spouse(mother)&.name
        )
        cohort = Family::Tree::Cohort.new([new_child, nil])

        parse(mother) { |c| c.children << cohort }

        return "CHILD_ADDED"
      end

      def find_children(person)
        return [] if person.nil?

        cohort = parse(person)
        cohort&.children || []
      end

      def find_parent(person)
        cohort = parse(person)

        cohort&.
          generation&.
          find { |elem| elem&.name == person }&.
          parent
      end

      def find_spouse(person)
        cohort = parse(person)

        cohort&.
          generation&.
          find { |elem| elem&.name != person }
      end

      def find_person(person)
        cohort = parse(person)

        cohort&.
          generation&.
          find { |elem| elem&.name == person }
      end

      def find_sons(person)
        return [] if person.nil?

        find_children(person)
          .map(&:male_child)
          .compact
          .map(&:name)
      end

      def find_daughters(person)
        return [] if person.nil?

        find_children(person)
          .map(&:female_child)
          .compact
          .map(&:name)
      end

      def find_siblings(person)
        return [] if person.nil?

        parent = find_parent(person)
        find_children(parent)
          .map(&:child)
          .map(&:name)
          .reject { |child| child == person }
      end

      def find_sibling_brothers(person)
        return [] if person.nil?

        parent = find_parent(person)
        find_children(parent)
          .map(&:male_child)
          .compact
          .map(&:name)
          .reject { |child| child == person }
      end

      def find_sibling_sisters(person)
        return [] if person.nil?

        parent = find_parent(person)
        find_children(parent)
          .map(&:female_child)
          .compact
          .map(&:name)
          .reject { |child| child == person }
      end

      def find_uncle(person)
        parent = find_parent(person)

        find_sibling_brothers(parent)
          .reject { |sibling| sibling == parent }
      end

      def find_aunt(person)
        parent = find_parent(person)

        find_sibling_sisters(parent)
          .reject { |sibling| sibling == parent }
      end

      def find_brothers_in_law(person)
        # Spouse's Brothers
        # Husbands of Siblings
        spouse = find_spouse(person)
        spouses_brothers = find_sibling_brothers(spouse&.name)

        siblings = find_sibling_sisters(person)
        husbands_of_siblings = siblings.map { |sibling| find_spouse(sibling)&.name }

        spouses_brothers + husbands_of_siblings
      end

      def find_sisters_in_law(person)
        # Spouse's sisters
        # Wives of Siblings
        spouse = find_spouse(person)
        spouses_sisters = find_sibling_sisters(spouse&.name)

        siblings = find_sibling_brothers(person)
        wives_of_siblings = siblings.map { |sibling| find_spouse(sibling)&.name }.compact

        spouses_sisters + wives_of_siblings
      end

      private

      def load_family_tree
        @tree ||= Family::Tree::Builder.new.run("data/family.json")
      end
    end
  end
end
