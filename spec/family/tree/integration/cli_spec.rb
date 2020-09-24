require "spec_helper"

module Family
  module Tree
    RSpec.describe 'Family::Tree::CLI Integration Spec' do
      subject { Family::Tree::CLI.new }

      context "Run commands from usecase-1.txt" do
        it "is expected forward and match the output to terminal" do
          path = File.dirname(__FILE__) + "/../../../support/usecase-1.txt"
          commands = subject.load(path)
          expected_display = <<~EOF
            CHILD_ADDED
            James John
            Albus John
          EOF

          expect{ 
              subject.run(commands)
          }.to output(expected_display).to_stdout
        end
      end

      context "Run commands from usecase-2.txt" do
        it "is expected forward and match the output to terminal" do
          path = File.dirname(__FILE__) + "/../../../support/usecase-2.txt"
          commands = subject.load(path)
          expected_display = <<~EOF
            Lily
            NONE
            PERSON_NOT_FOUND
          EOF

          expect{ 
              subject.run(commands)
          }.to output(expected_display).to_stdout
        end
      end

      context "Run commands from usecase-3.txt" do
        it "is expected forward and match the output to terminal" do
          path = File.dirname(__FILE__) + "/../../../support/usecase-3.txt"
          commands = subject.load(path)
          expected_display = <<~EOF
            CHILD_ADDED
            CHILD_ADDITION_FAILED
            Bill Charlie Percy Ronald Pranava
            Ginerva
            Bill Charlie Percy Ronald Ginerva
          EOF

          expect{ 
              subject.run(commands)
          }.to output(expected_display).to_stdout
        end
      end
    end
  end
end
