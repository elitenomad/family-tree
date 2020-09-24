require "spec_helper"

module Family
  module Tree
    RSpec.describe CLI do
      subject { Family::Tree::CLI.new }

      context "#load" do
        it "is expected to match expected_commands from test file" do
          path = File.dirname(__FILE__) + "/../../support/usecase-1.txt"
          commands = subject.load(path)
          expected_commands = [
            [:add_child, "Ginerva", "John", "Male"],
            [:get_relationship, "Ginny", "Paternal-Uncle"],
            [:get_relationship, "Darcy", "Brother-In-Law"]
          ]

          expect(commands).to eq(expected_commands)
        end

        context "when file is not present" do
          it "is expected to raise no such file or directory error" do
            path = File.dirname(__FILE__) + "/../../support/test.txt"
            expect { subject.load(path) }.to raise_error(Errno::ENOENT)
          end
        end

        context "when file format is not supported" do
          it "is expected to raise file not supported error" do
            path = File.dirname(__FILE__) + "/../../support/test.csv"
            expect { subject.load(path) }.to raise_error(Family::Tree::FileFormatNotSupportedError)
          end
        end
      end

      context "#add_child" do
        let(:executor) { instance_double(Family::Tree::Executor) }

        before(:each) do
          allow(subject).to receive(:executor) { executor }
        end

        context "add_child command" do
          it "passes add_child command to executor" do
            expect(executor).to receive(:add_child).with("Generva", "John", "Male")
            subject.run([[:add_child, "Generva", "John", "Male"]])
          end
        end

        context "get_relationship command" do
          it "passes get_relationship command to executor" do
            expect(executor).to receive(:get_relationship).with("Bill", "Son")
            subject.run([[:get_relationship, "Bill", "Son"]])
          end
        end
      end
    end
  end
end
