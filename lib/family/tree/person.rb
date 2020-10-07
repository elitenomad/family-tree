module Family
  module Tree
    class Person
      attr_reader :name, :gender, :parent, :is_child, :level

      def initialize(name:, gender:, is_child: false, parent: nil, level: 0)
        @name = name
        @gender = gender
        @is_child = is_child
        @parent = parent
        @level = level
      end

      def male?
        gender == "Male"
      end

      def female?
        gender == "Female"
      end

      # Testing purposes when building cohorts object
      def to_h
        {
          name: name,
          gender: gender,
          parent: parent,
          is_child: is_child,
          level: level
        }
      end
    end
  end
end
