module Family
  module Tree

    # Goal of this class is to store family person
    # data as a nested tree structure
    #
    # attributes::
    #   generation: This attribute is array of
    #   couple in the family or child who is single.
    #   For e.g couple will be represented as [p1, p2]
    #   and single child will be represented as [p1, nil]
    #
    #   children: Nested strucure of Cohorts Object 
    #   itself which contains generation and children
    #   in a tree like structure.
    #
    # == Goal:
    # Goal of the parser is to search through
    # the structure recursively and execute input commands.
    class Cohort
      attr_accessor :generation, :children

      def initialize(generation)
        @generation = generation
        @children = []
      end

      def child
        generation.find { |person| person&.is_child }
      end

      def male_child
        generation.find { |person| person&.is_child && person&.gender == "Male" }
      end

      def female_child
        generation.find { |person| person&.is_child && person&.gender == "Female" }
      end
    end
  end
end
