module Family
  module Tree
    RSpec.describe Person do
      subject {
        Family::Tree::Person.new(
          name: "Test",
          gender: "Male",
          is_child: true,
        )
      }

      it { is_expected.to respond_to(:name) }
      it { is_expected.to respond_to(:gender) }
      it { is_expected.to respond_to(:parent) }
      it { is_expected.to respond_to(:is_child) }
      it { is_expected.to respond_to(:level)}

      describe "#male?" do
        context "when gender is Male" do
          it "is expected to return true" do
            expect(subject.male?).to be_truthy
          end
        end
      end

      describe "#female?" do
        subject {
          Family::Tree::Person.new(
            name: "Test",
            gender: "Female",
            is_child: true,
          )
        }

        context "when gender is Female" do
          it "is expected to return true" do
            expect(subject.female?).to be_truthy
          end
        end
      end

      describe "when initialized" do
        subject {
          Family::Tree::Person.new(
            name: "Test",
            gender: "Female",
          )
        }

        context "defaults of parent and is_child" do
          it "is expected to be nil and false" do
            expect(subject.parent).to be_nil
            expect(subject.is_child).to be_falsey
            expect(subject.level).to eq(0)
          end
        end
      end
    end
  end
end
