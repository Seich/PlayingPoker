require_relative '../deck'

describe Deck do
    describe "#new" do

        context "Given a valid type" do
            it "has 52 cards when omaha" do
                oDeck = Deck.new :omaha
                expect(oDeck.count).to eq(52)
            end

            it "has 52 cards when holdem" do
                hDeck = Deck.new :holdem
                expect(hDeck.count).to eq(52)
            end

            it "has 20 cards when it's type of royal" do
                rDeck = Deck.new :royal
                expect(rDeck.count).to eq(20)
            end
        end

        context "Not given a valid type" do
            it "should raise an error" do
                expect { deck = Deck.new :test }.to raise_error
            end
        end
    end

    describe "#deal_card" do
        before :each do
            @deck = Deck.new :royal
        end

        context "When a card is dealt" do
            it "returns a card from the deck"  do
                expect(@deck.deal_card).to be_an_instance_of Struct::Card
            end

            it "should remove the card" do
                count = @deck.count
                @deck.deal_card
                expect(@deck.count).to eq(count - 1)
            end

            it "should return false if there are no cards left" do
                20.times { @deck.deal_card }

                expect(@deck.deal_card).to be_false
            end
        end
    end

    describe "#variation" do
        it "should return the deck's variation" do
            deck = Deck.new :royal
            expect(deck.to_s).to eq("royal")
        end
    end

end
