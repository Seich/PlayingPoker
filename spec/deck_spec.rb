require_relative '../deck'

describe Deck do
    describe '#new' do

        context 'Given a valid type' do
            it 'has 52 cards when omaha' do
                oDeck = Deck.new(:omaha)
                expect(oDeck.count).to eq(52)
            end

            it 'has 52 cards when holdem' do
                hDeck = Deck.new(:holdem)
                expect(hDeck.count).to eq(52)
            end

            it 'has 20 cards when it\'s type of royal' do
                rDeck = Deck.new(:royal)
                expect(rDeck.count).to eq(20)
            end
        end

        context 'Not given a valid type' do
            it 'should raise an error' do
                expect { Deck.new(:test) }.to raise_error
            end
        end
    end

    describe '#deal_card' do
        it 'should return an array' do
            deck = Deck.new(:royal)
            expect(deck.deal_card).to be_an_instance_of Array
        end

        context 'When a single card is dealt' do
            before(:each) do
                @deck = Deck.new(:royal)
                @card = @deck.deal_card.first
            end

            it 'returns a card from the deck'  do
                expect(@card).to be_an_instance_of(String)
            end

            it 'the card should be 2 characters long' do
                expect(@card).to have(2).characters
            end

            it 'should remove the card' do
                expect(@deck.count).to eq(19)
            end

            it 'should return false if there are no cards left' do
                19.times { @deck.deal_card }

                expect(@deck.deal_card).to be_false
            end
        end

        context 'When more than a card is dealt' do
            before(:each) do
                @deck = Deck.new(:royal)
            end

            it 'returns the number of card passed to the function ' do
                cards = @deck.deal_card(num: 2)
                expect(cards).to have(2).cards
            end
        end
    end

    describe '#deal_hole_cards' do
        context 'when variation is omaha' do
            it 'should return 4 cards' do
                deck = Deck.new(:omaha)
                expect(deck.deal_hole_cards).to have(4).cards
            end
        end

        context 'when variation is royal' do
            it 'should return 2 cards' do
                deck = Deck.new(:royal)
                expect(deck.deal_hole_cards).to have(2).cards
            end
        end

        context 'when variation is holdem' do
            it 'should return 2 cards' do
                deck = Deck.new(:holdem)
                expect(deck.deal_hole_cards).to have(2).cards
            end
        end
    end

    describe '#variation' do
        it 'should return the deck\'s variation' do
            deck = Deck.new :royal
            expect(deck.variation).to eq('royal')
        end
    end

    describe '#to_s' do
        it 'being of type omaha should list 52 cards' do
            deck = Deck.new :omaha
            expect(deck.to_s).to eq('2s 2d 2h 2c 3s 3d 3h 3c 4s 4d 4h 4c 5s 5d 5h 5c 6s 6d 6h 6c 7s 7d 7h 7c 8s 8d 8h 8c 9s 9d 9h 9c Ts Td Th Tc Js Jd Jh Jc Qs Qd Qh Qc Ks Kd Kh Kc As Ad Ah Ac')
        end

        it 'being of type holdem should list 52 cards' do
           deck = Deck.new :holdem
            expect(deck.to_s).to eq('2s 2d 2h 2c 3s 3d 3h 3c 4s 4d 4h 4c 5s 5d 5h 5c 6s 6d 6h 6c 7s 7d 7h 7c 8s 8d 8h 8c 9s 9d 9h 9c Ts Td Th Tc Js Jd Jh Jc Qs Qd Qh Qc Ks Kd Kh Kc As Ad Ah Ac') 
        end

        it 'should list available cards' do
            deck = Deck.new :royal
            expect(deck.to_s).to eq('Ts Td Th Tc Js Jd Jh Jc Qs Qd Qh Qc Ks Kd Kh Kc As Ad Ah Ac')
        end
    end

end
