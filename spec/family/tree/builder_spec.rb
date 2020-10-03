require "spec_helper"

module Family
  module Tree
    RSpec.describe Builder do
      subject { Family::Tree::Builder.new }

      context "#run" do
        it "is expected to return instance of Family::Tree::Cohort" do
            path =  File.dirname(__FILE__)  + "/../../support/family.json"
            expect(subject.run(path)).to be_instance_of(Family::Tree::Cohort)
        end
      end

      context "#parse" do
        path =  File.dirname(__FILE__)  + "/../../support/family.json"
        json = JSON.parse(File.read(path))["family"]
        let(:result) { subject.parse(json) }

        # Based on spec/support test file (family.json)
        let(:expected_first_generation) { ['King Arthur', 'Queen Margret']}
        let(:expected_children_count) { 2 }

        let(:second_generation) { result.children.first.generation }
        let(:expected_child) { {:gender=>"Male", :is_child=>true, :level=>1, :name=>"Bill", :parent=>"King Arthur"} }
        let(:expected_spouse) { {:gender=>"Female", :is_child=>false, :level=>1, :name=>"Flora", :parent=>nil}  }

        it "is expected to fill cohort's generation" do
            expect(result.generation.map(&:name)).to eq(expected_first_generation)
        end

        it "is expected to fill cohort's children" do
            expect(result.children.count).to eq(expected_children_count)
        end

        # Add extra tests to test the attribtues of the family tree
        describe "child" do
          it "is expected to fill cohort's immediate child with person attributes" do
            expect(second_generation.first.to_h).to eq(expected_child)
          end
        end
        
        describe "Spouse" do
          it "is expected to fill cohort's immediate child spouse with person attributes" do
            expect(second_generation.last.to_h).to eq(expected_spouse)
          end
        end
      end
    end
  end
end
