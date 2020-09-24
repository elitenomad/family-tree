module Family
  module Tree
    class Person
      attr_reader :name, :gender, :parent, :is_child

      def initialize(name:, gender:, is_child: false, parent: nil)
        @name = name
        @gender = gender
        @is_child = is_child
        @parent = parent
      end

      def male?
        gender == "Male"
      end

      def female?
        gender == "Female"
      end
    end
  end
end
