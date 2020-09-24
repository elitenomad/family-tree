module Family
  module Tree
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
