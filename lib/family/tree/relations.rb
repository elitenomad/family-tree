module Family
  module Tree
    class Relations
      attr_accessor :tree

      def initialize
        load_family_tree
      end

      # Attaches child to right parents in family `tree`
      #
      # == Parameters:
      # mother:: string e.g Flora
      # child:: string e.g Harry
      # gender:: string e.g Male | Female
      #
      # == Raises:
      # An error if mother passed does not exist in family tree
      # An error if mother passed has gender 'Male'
      #
      # == Returns:
      # A 'CHILD_ADDED' message if tree is updated
      # Successfully.
      #
      def add_child(mother, child, gender)
        person = find_person(mother)

        raise Family::Tree::PersonNotFoundError if person.nil?
        raise Family::Tree::ChildAdditionFailedError if person.male?

        new_child = Family::Tree::Person.new(
          name: child,
          gender: gender,
          is_child: true,
          parent: person.is_child ? person.name : find_spouse(mother)&.name,
        )
        cohort = Family::Tree::Cohort.new([new_child, nil])

        traverse(mother) { |c| c.children << cohort }
        # pp tree
        return Family::Tree::CHILD_ADDED_SUCCESS_MESSAGE
      end

      # Traverses family `tree` and returns
      # person's children
      #
      # == Parameters:
      # person:: string e.g Bill
      #
      # == Raises:
      # An error if person passed donot
      # exist in family tree
      #
      # == Returns:
      # [] if input is nil or
      # An array of Children ([] of Family::Tree:Cohort)
      #
      def find_children(person)
        return [] if person.nil?
        raise Family::Tree::PersonNotFoundError if find_person(person).nil?

        cohort = traverse(person)
        cohort&.children || []
      end

      # Traverses family `tree` and returns
      # person's parent
      #
      # == Parameters:
      # person:: string e.g Bill
      #
      # == Returns:
      # nil or a string
      #
      def find_parent(person)
        cohort = traverse(person)

        cohort&.
          generation&.
          find { |elem| elem&.name == person }&.
          parent
      end

      # Traverses family `tree` and returns
      # person's spouse
      #
      # == Parameters:
      # person:: string e.g Bill
      #
      # == Returns:
      # nil or a person(spouse) object
      #
      def find_spouse(person)
        cohort = traverse(person)

        cohort&.
          generation&.
          find { |elem| elem&.name != person }
      end

      # Traverses family `tree` and returns
      # person's spouse
      #
      # == Parameters:
      # person:: string e.g Bill
      #
      # == Returns:
      # nil or a person object
      #
      def find_person(person)
        cohort = traverse(person)

        cohort&.
          generation&.
          find { |elem| elem&.name == person }
      end

      # Traverses family `tree` and returns
      # person's sons
      #
      # == Parameters:
      # person:: string e.g Bill
      #
      # == Raises:
      # An error if person passed donot
      # exist in family tree
      #
      # == Returns:
      # [] if input is nil or
      # An array of person's Son names
      # e.g ['Bill','Charlie']
      #
      def find_sons(person)
        find_children(person)
          .map(&:male_child)
          .compact
          .map(&:name)
      end

      # Traverses family `tree` and returns
      # person's daughters
      #
      # == Parameters:
      # person:: string e.g Bill
      #
      # == Raises:
      # An error if person passed donot
      # exist in family tree
      #
      # == Returns:
      # [] if input is nil or
      # An array of person's daughter names
      # e.g ['Lucy']
      #
      def find_daughters(person)
        find_children(person)
          .map(&:female_child)
          .compact
          .map(&:name)
      end

      # Traverses family `tree` and returns
      # person's siblings
      #
      # == Parameters:
      # person:: string e.g Bill
      #
      # == Raises:
      # An error if person passed donot
      # exist in family tree
      #
      # == Returns:
      # [] if input is nil or
      # An array of person's Siblings
      # e.g ['Lily','Charlie']
      #
      def find_siblings(person)
        parent = find_parent(person)
        find_children(parent)
          .map(&:child)
          .map(&:name)
          .reject { |child| child == person }
      end

      # Traverses family `tree` and returns
      # person's siblings who are brothers
      #
      # == Parameters:
      # person:: string e.g Bill
      #
      # == Raises:
      # An error if person passed donot
      # exist in family tree
      #
      # == Returns:
      # [] if input is nil or
      # An array of person's Brothers
      # e.g ['Charlie']
      #
      def find_sibling_brothers(person)
        parent = find_parent(person)
        find_children(parent)
          .map(&:male_child)
          .compact
          .map(&:name)
          .reject { |child| child == person }
      end

      # Traverses family `tree` and returns
      # person's siblings who are sisters
      #
      # == Parameters:
      # person:: string e.g Bill
      #
      # == Raises:
      # An error if person passed donot
      # exist in family tree
      #
      # == Returns:
      # [] if input is nil or
      # An array of person's Sisters
      # e.g ['Lily']
      #
      def find_sibling_sisters(person)
        parent = find_parent(person)
        find_children(parent)
          .map(&:female_child)
          .compact
          .map(&:name)
          .reject { |child| child == person }
      end

      # Traverses family `tree` and returns
      # person's uncles
      #
      # == Parameters:
      # person:: string e.g Remus
      #
      # == Raises:
      # An error if person passed donot
      # exist in family tree
      #
      # == Returns:
      # [] if input is nil or
      # An array of person's Uncles
      # e.g ['Bill','Charlie']
      #
      def find_uncle(person)
        parent = find_parent(person)

        find_sibling_brothers(parent)
          .reject { |sibling| sibling == parent }
      end

      # Traverses family `tree` and returns
      # person's aunts
      #
      # == Parameters:
      # person:: string e.g Remus
      #
      # == Raises:
      # An error if person passed donot
      # exist in family tree
      #
      # == Returns:
      # [] if input is nil or
      # An array of person's Aunts
      # e.g ['Ginerva','FLora']
      #
      def find_aunt(person)
        parent = find_parent(person)

        find_sibling_sisters(parent)
          .reject { |sibling| sibling == parent }
      end

      # Traverses family `tree` and returns
      # person's brothers in law
      #
      # == Parameters:
      # person:: string e.g Remus
      #
      # == Raises:
      # An error if person passed donot
      # exist in family tree
      #
      # == Returns:
      # Spouse's Brothers + Husbands of Siblings
      #
      # [] if input is nil or
      # An array of person's brothers in law
      # e.g ['Charlie','Bill']
      #
      def find_brothers_in_law(person)
        spouse = find_spouse(person)
        spouses_brothers = find_sibling_brothers(spouse&.name)

        siblings = find_sibling_sisters(person)
        husbands_of_siblings = siblings.map { |sibling| find_spouse(sibling)&.name }

        spouses_brothers + husbands_of_siblings
      end

      # Traverses family `tree` and returns
      # person's sisters in law
      #
      # == Parameters:
      # person:: string e.g Remus
      #
      # == Raises:
      # An error if person passed donot
      # exist in family tree
      #
      # == Returns:
      #  Spouse's sisters + Wives of Siblings
      #
      # [] if input is nil or
      # An array of person's sisters in law
      # e.g ['Ginerva','FLora']
      #
      def find_sisters_in_law(person)
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

      # Traverses family `tree` and using
      # breadth first algo
      #
      # == Parameters:
      # person:: string e.g Bill
      #
      # == Returns:
      # current cohort object person belongs to
      # or yield `current` cohort given a block of code
      #
      def traverse(person)
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
    end
  end
end
