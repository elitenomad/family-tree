require "json"

module Family
  module Tree
    class Builder
      
      def run(path)
        parse(JSON.parse(File.read(path))["family"])
      end

      def parse(family, parent = nil)
        generation = [child(family, parent), spouse(family)]
        cohorts = Family::Tree::Cohort.new(generation)

        (family["children"] || []).each do |child|
          cohorts.children << parse(child, generation.first.name)
        end

        cohorts
      end


      private

      def child(family, parent = nil)
        Family::Tree::Person.new(
          name: family["name"],
          gender: family["gender"],
          parent: parent,
          is_child: true,
        )
      end

      def spouse(family)
        return nil if family["spouse"].empty?

        Family::Tree::Person.new(
          name: family["spouse"],
          gender: family["gender"] == "Male" ? "Female" : "Male",
          parent: nil,
        )
      end
    end
  end
end
