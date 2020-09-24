require "spec_helper"

module Family
  module Tree
    RSpec.describe Executor do
      subject { Family::Tree::Executor.new }

      let!(:relations) { instance_double(Family::Tree::Relations) }

      before(:each) do
        allow(Family::Tree::Relations).to receive(:new).and_return(relations)
      end

      context "#add_child" do
        it "is expected to call relations add_child method" do
          expect(relations).to receive(:add_child).with("Generva", "John", "Male")
          subject.add_child("Generva", "John", "Male")
        end
      end

      context "#get_relationship" do
        describe "Children" do
          it "is expected to call relations find_children method" do
            expect(relations).to receive(:find_children).with("Generva").and_return([])
            subject.get_relationship("Generva", "Children")
          end
        end

        describe "Son" do
          it "is expected to call relations find_sons method" do
            expect(relations).to receive(:find_sons).with("Generva").and_return([])
            subject.get_relationship("Generva", "Son")
          end
        end

        describe "Daughter" do
          it "is expected to call relations find_daughters method" do
            expect(relations).to receive(:find_daughters).with("Generva").and_return([])
            subject.get_relationship("Generva", "Daughter")
          end
        end

        describe "Siblings" do
          it "is expected to call relations find_siblings method" do
            expect(relations).to receive(:find_siblings).with("Generva").and_return([])
            subject.get_relationship("Generva", "Siblings")
          end
        end

        describe "Brother-In-Law" do
          it "is expected to call relations find_brothers_in_law method" do
            expect(relations).to receive(:find_brothers_in_law).with("Generva").and_return([])
            subject.get_relationship("Generva", "Brother-In-Law")
          end
        end

        describe "Sister-In-Law" do
          it "is expected to call relations find_sisters_in_law method" do
            expect(relations).to receive(:find_sisters_in_law).with("Generva").and_return([])
            subject.get_relationship("Generva", "Sister-In-Law")
          end
        end

        describe "Paternal-Uncle" do
          it "is expected to call relations find_uncle method" do
            expect(relations).to receive(:find_uncle).with("Generva").and_return([])
            subject.get_relationship("Generva", "Paternal-Uncle")
          end
        end

        describe "Paternal-Aunt" do
          it "is expected to call relations find_aunt method" do
            expect(relations).to receive(:find_aunt).with("Generva").and_return([])
            subject.get_relationship("Generva", "Paternal-Aunt")
          end
        end

        describe "Maternal-Uncle" do
          it "is expected to call relations find_uncle method" do
            expect(relations).to receive(:find_uncle).with("Generva").and_return([])
            subject.get_relationship("Generva", "Maternal-Uncle")
          end
        end

        describe "Maternal-Aunt" do
          it "is expected to call relations find_aunt method" do
            expect(relations).to receive(:find_aunt).with("Generva").and_return([])
            subject.get_relationship("Generva", "Maternal-Aunt")
          end
        end
      end
    end
  end
end
