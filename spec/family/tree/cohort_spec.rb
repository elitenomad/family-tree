module Family
  module Tree
    RSpec.describe Cohort do
      let(:decendant_male) { Family::Tree::Person.new(name: "Test", gender: "Male", is_child: true) }
      let(:dm_spouse) { Family::Tree::Person.new(name: "Test_2", gender: "Female") }

      let(:decendant_female) { Family::Tree::Person.new(name: "Test", gender: "Female", is_child: true) }
      let(:df_spouse) { Family::Tree::Person.new(name: "Test_2", gender: "Male") }

      let(:decendant_unmarried) { Family::Tree::Person.new(name: "Test", gender: "Male", is_child: true) }

      let(:couple_one) { [decendant_male, dm_spouse] }
      let(:couple_two) { [decendant_female, df_spouse] }
      let(:single) { [decendant_unmarried, nil] }

      subject { Family::Tree::Cohort.new(couple_one) }

      it { is_expected.to respond_to(:generation) }
      it { is_expected.to respond_to(:children) }

      context "when initialized" do
        it "is expected to have empty children" do
          expect(subject.children).to eq([])
        end
      end

      context "when decendant is male" do
        describe "#child" do
          it "is expected to return p1" do
            expect(subject.child).to eq(decendant_male)
          end
        end

        describe "#male_child" do
          it "is expected to return p1" do
            expect(subject.male_child).to eq(decendant_male)
          end
        end

        describe "#female_child" do
          it "is expected to return nil" do
            expect(subject.female_child).to be_nil
          end
        end
      end

      context "when decendant is female" do
        subject { Family::Tree::Cohort.new(couple_two) }

        describe "#child" do
          it "is expected to return p1" do
            expect(subject.child).to eq(decendant_female)
          end
        end

        describe "#male_child" do
          it "is expected to return p1" do
            expect(subject.male_child).to be_nil
          end
        end

        describe "#female_child" do
          it "is expected to return nil" do
            expect(subject.female_child).to eq(decendant_female)
          end
        end
      end

      context "when decendant is single" do
        subject { Family::Tree::Cohort.new(single) }

        describe "#child" do
          it "is expected to return p1" do
            expect(subject.child).to eq(decendant_unmarried)
          end
        end

        describe "#male_child" do
          it "is expected to return p1" do
            expect(subject.male_child).to eq(decendant_unmarried)
          end
        end

        describe "#female_child" do
          it "is expected to return nil" do
            expect(subject.female_child).to be_nil
          end
        end

        describe "generation second element" do
          it "is expected to return nil" do
            expect(subject.generation[1]).to be_nil
          end
        end
      end
    end
  end
end
