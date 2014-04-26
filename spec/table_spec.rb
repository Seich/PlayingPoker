require_relative '../deck'
require_relative '../table'

describe Table do
    describe "#new"  do
        it "should create table with the given options" do
            table = Table.new :ring, :holdem, :no_limit
            expect(table.to_s).to eq("no_limit Holdem Table")
        end
    end

    describe "#deck" do
    	it "should return the deck" do
    		table = Table.new :ring, :holdem, :no_limit
    		expect(table.deck).to be_an_instance_of Deck
    	end
    end


end
