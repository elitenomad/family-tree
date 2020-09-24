require 'spec_helper'

module Family
    module Tree
        RSpec.describe Command do
            let(:command) { Family::Tree::Command.new }
          
            context 'ADD_CHILD' do
                describe 'when format is valid' do
                    it 'processes a command' do
                        command, *args = Family::Tree::Command.parse("ADD_CHILD Generva John Male")
                        expect(command).to eq(:add_child)
                        expect(args).to eq(["Generva", "John", "Male"])
                    end
                end
             
                describe 'when format is invalid' do
                    it "returns :invalid" do
                        command = Family::Tree::Command.parse("ADD_CHILD Generva, John, Male")
                        expect(command).to eq([:invalid, "ADD_CHILD Generva, John, Male"])
                    end
                end
            end
          
            context 'GET_RELATIONSHIP' do
                describe 'when format is valid' do
                    it 'processes a command' do
                        command, *args = Family::Tree::Command.parse("GET_RELATIONSHIP Bill Son")
                        expect(command).to eq(:get_relationship)
                        expect(args).to eq(["Bill", "Son"])
                    end
                end
             
                describe 'when format is invalid' do
                    it "returns :invalid" do
                        command = Family::Tree::Command.parse("GET_RELATIONSHIP Bill, Son")
                        expect(command).to eq([:invalid, "GET_RELATIONSHIP Bill, Son"])
                    end
                end
            end
        end
    end
end

