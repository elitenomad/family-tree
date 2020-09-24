require "spec_helper"

module Family
  module Tree
    RSpec.describe Relations do
      subject { Family::Tree::Relations.new }

      let(:expected_bills_children) { ["Victoire", "Dominique", "Louis"] }
      let(:expected_bills_sons) { ["Louis"] }
      let(:expected_bills_daughters) { ["Victoire", "Dominique"] }
      let(:expected_bills_parent) { "King Arthur" }
      let(:expected_bills_spouse) { "Flora" }
      let(:expected_bills_siblings) { ["Charlie", "Percy", "Ronald", "Ginerva"] }
      let(:expected_bills_sibling_brothers) { ["Charlie", "Percy", "Ronald"] }
      let(:expected_bills_sibling_sisters) { ["Ginerva"] }

      let(:expected_remus_aunts) { ["Dominique"] }
      let(:expected_ginny_uncles) { ["James"] }
      let(:expected_darcy_sister_in_laws) { ["Lily"] }
      let(:expected_darcy_brother_in_laws) { ["Albus"] }

      context "tree" do
        it "is expected not to be empty" do
          expect(subject.tree).not_to be_nil
        end
      end

      context "#add_child" do
        describe "when mother is not found in the family tree" do
          it "is expected to return PERSON_NOT_FOUND" do
            expect(
              subject.add_child("Genervaxyz", "John", "Male")
            ).to eq("PERSON_NOT_FOUND")
          end
        end

        describe "when person passed is a Male" do
          it "is expected return CHILD_ADDITION_FAILED" do
            expect(
              subject.add_child("Bill", "John", "Male")
            ).to eq("CHILD_ADDITION_FAILED")
          end
        end

        describe "when mother is not found in the family tree" do
          it "is expected to return CHILD_ADDED" do
            expect(
              subject.add_child("Ginerva", "John", "Male")
            ).to eq("CHILD_ADDED")
          end
        end
      end

      context "#find_children" do
        describe "when person passed has children" do
          it "is expected return list of children" do
            expect(
              subject.find_children("Bill")
                .map(&:child)
                .map(&:name)
            ).to eq(expected_bills_children)
          end
        end

        describe "when person passed has no children" do
          it "is expected return an empty list" do
            expect(
              subject.find_children("Charlie")
            ).to eq([])
          end
        end

        describe "when person passed is nil" do
          it "is expected return an empty list" do
            expect(
              subject.find_children(nil)
            ).to eq([])
          end
        end
      end

      context "#find_parent" do
        describe "when person passed has a parent" do
          it "is expected returns name of the parent" do
            expect(
              subject.find_parent("Bill")
            ).to eq(expected_bills_parent)
          end
        end

        describe "when person passed is nil" do
          it "is expected return an empty list" do
            expect(
              subject.find_children(nil)
            ).to eq([])
          end
        end
      end

      context "#find_spouse" do
        describe "when person passed has a spouse" do
          it "is expected returns name of the spouse" do
            expect(
              subject.find_spouse("Bill").name
            ).to eq(expected_bills_spouse)
          end
        end

        describe "when person passed is nil" do
          it "is expected return an empty list" do
            expect(
              subject.find_spouse(nil)
            ).to eq(nil)
          end
        end
      end

      context "#find_person" do
        describe "when person passed is in the family tree" do
          it "is expected not to be nil" do
            expect(
              subject.find_person("Bill")
            ).not_to be_nil
          end
        end

        describe "when person passed is not in the family tree" do
          it "is expected to return nil" do
            expect(
              subject.find_person("Billsy")
            ).to be_nil
          end
        end

        describe "when person passed is nil" do
          it "is expected return nil" do
            expect(
              subject.find_person(nil)
            ).to eq(nil)
          end
        end
      end

      context "#find_sons" do
        describe "when person passed has sons" do
          it "is expected return list of sons" do
            expect(
              subject.find_sons("Bill")
            ).to eq(expected_bills_sons)
          end
        end

        describe "when person passed has no sons" do
          it "is expected return an empty list" do
            expect(
              subject.find_sons("Charlie")
            ).to eq([])
          end
        end

        describe "when person passed is nil" do
          it "is expected return an empty list" do
            expect(
              subject.find_sons(nil)
            ).to eq([])
          end
        end
      end

      context "#find_daughters" do
        describe "when person passed has daughters" do
          it "is expected return list of daughters" do
            expect(
              subject.find_daughters("Bill")
            ).to eq(expected_bills_daughters)
          end
        end

        describe "when person passed has no daughters" do
          it "is expected return an empty list" do
            expect(
              subject.find_daughters("James")
            ).to eq([])
          end
        end

        describe "when person passed is nil" do
          it "is expected return an empty list" do
            expect(
              subject.find_daughters(nil)
            ).to eq([])
          end
        end
      end

      context "#find_siblings" do
        describe "when person passed has siblings" do
          it "is expected return list of siblings" do
            expect(
              subject.find_siblings("Bill")
            ).to eql(expected_bills_siblings)
          end
        end

        describe "when person passed has no siblings" do
          it "is expected return an empty list" do
            expect(
              subject.find_siblings("William")
            ).to eq([])
          end
        end

        describe "when person passed is nil" do
          it "is expected return an empty list" do
            expect(
              subject.find_siblings(nil)
            ).to eq([])
          end
        end
      end

      context "#find_sibling_brothers" do
        describe "when person passed has siblings" do
          it "is expected return list of sibling brothers" do
            expect(
              subject.find_sibling_brothers("Bill")
            ).to eql(expected_bills_sibling_brothers)
          end
        end

        describe "when person passed has no siblings" do
          it "is expected return an empty list" do
            expect(
              subject.find_sibling_brothers("William")
            ).to eq([])
          end
        end

        describe "when person passed is nil" do
          it "is expected return an empty list" do
            expect(
              subject.find_sibling_brothers(nil)
            ).to eq([])
          end
        end
      end

      context "#find_sibling_sisters" do
        describe "when person passed has siblings" do
          it "is expected return list of sibling sisters" do
            expect(
              subject.find_sibling_sisters("Bill")
            ).to eql(expected_bills_sibling_sisters)
          end
        end

        describe "when person passed has no siblings" do
          it "is expected return an empty list" do
            expect(
              subject.find_sibling_sisters("William")
            ).to eq([])
          end
        end

        describe "when person passed is nil" do
          it "is expected return an empty list" do
            expect(
              subject.find_sibling_sisters(nil)
            ).to eq([])
          end
        end
      end

      context "#find_uncle" do
        describe "when person passed has uncles" do
          it "is expected return list uncle" do
            expect(
              subject.find_uncle("Ginny")
            ).to eql(expected_ginny_uncles)
          end
        end

        describe "when person passed has no uncle" do
          it "is expected return an empty list" do
            expect(
              subject.find_uncle("Bill")
            ).to eq([])
          end
        end

        describe "when person passed is nil" do
          it "is expected return an empty list" do
            expect(
              subject.find_uncle(nil)
            ).to eq([])
          end
        end
      end

      context "#find_aunt" do
        describe "when person passed has aunts" do
          it "is expected return list of aunts" do
            expect(
              subject.find_aunt("Remus")
            ).to eql(expected_remus_aunts)
          end
        end

        describe "when person passed has no aunts" do
          it "is expected return an empty list" do
            expect(
              subject.find_aunt("Bill")
            ).to eq([])
          end
        end

        describe "when person passed is nil" do
          it "is expected return an empty list" do
            expect(
              subject.find_aunt(nil)
            ).to eq([])
          end
        end
      end

      context "#find_brothers_in_law" do
        describe "when person passed has brother in laws" do
          it "is expected return list" do
            expect(
              subject.find_brothers_in_law("Darcy")
            ).to eql(expected_darcy_brother_in_laws)
          end
        end

        describe "when person passed is nil" do
          it "is expected return an empty list" do
            expect(
              subject.find_brothers_in_law(nil)
            ).to eq([])
          end
        end
      end

      context "#find_sisters_in_law" do
        describe "when person passed has sister in laws" do
          it "is expected return list" do
            expect(
              subject.find_sisters_in_law("Darcy")
            ).to eql(expected_darcy_sister_in_laws)
          end
        end

        describe "when person passed is nil" do
          it "is expected return an empty list" do
            expect(
              subject.find_sisters_in_law(nil)
            ).to eq([])
          end
        end
      end
    end
  end
end
