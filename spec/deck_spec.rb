require_relative '../deck'

describe Deck do
    describe "#new" do
        it "has 52 cards when it's type is omaha or hold'em" do
            oDeck = Deck.new :omaha
            oDeck.count.should eq(52)

            hDeck = Deck.new :holdem
            hDeck.count.should eq(52)
        end

        it "has 20 cards when it's type of royal" do
            rDeck = Deck.new :royal
            rDeck.count.should eq(20)
        end

        it "should raise an exception if type not of three valid ones." do
            expect { deck = Deck.new :test }.to raise_error
        end
    end

    describe "#get_card" do
        before :each do
            @deck = Deck.new :royal
        end

        it "returns a card from the deck"  do
            @deck.get_card.class.name.should eq("Struct::Card")
        end

        it "should remove the card form the deck" do
            count = @deck.count
            @deck.get_card
            @deck.count.should eq(count - 1)
        end

        it "should return false if there are no cards left" do
            20.times  do
                @deck.get_card.class
            end
            
            @deck.get_card.class.name.should eq("FalseClass")
        end
    end
end
