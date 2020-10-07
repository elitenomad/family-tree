require "json"

module Family
  module Tree
    class Builder
      def run(path)
        parse(JSON.parse(File.read(path))["family"])
      end

      def parse(family, parent = nil, level = 0)
        generation = [child(family, parent, level), spouse(family, level)]
        cohorts = Family::Tree::Cohort.new(generation)

        (family["children"] || []).each do |child|
          cohorts.children << parse(child, generation.first.name, level + 1)
        end

        cohorts
      end

      private

      def child(family, parent = nil, level)
        Family::Tree::Person.new(
          name: family["name"],
          gender: family["gender"],
          parent: parent,
          is_child: true,
          level: level
        )
      end

      def spouse(family, level)
        return nil if family["spouse"].empty?

        Family::Tree::Person.new(
          name: family["spouse"],
          gender: family["gender"] == "Male" ? "Female" : "Male",
          parent: nil,
          level: level
        )
      end
    end
  end
end
