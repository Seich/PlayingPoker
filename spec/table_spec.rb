require_relative '../deck'
require_relative '../table'

describe Table do
    describe '#new'  do
        context 'when give valid types' do
            it 'should create a no limit holdem ring table' do
                table = Table.new(betting_type: :nl, 
                                  type: :ring, 
                                  variation: :holdem)

                expect(table.to_s).to eq('NL Holdem Ring Table')
            end

            it 'should create a fixed limit omaha mtt table' do
                table = Table.new(betting_type: :fl, 
                                  type: :mtt, 
                                  variation: :omaha,
                                  betting_limit: 100)

                expect(table.to_s).to eq('FL Omaha Mtt Table')
            end

            it 'should create a pot limit royal ring table' do
                table = Table.new(betting_type: :pl, 
                                  type: :ring, 
                                  variation: :royal)

                expect(table.to_s).to eq('PL Royal Ring Table')
            end
        end

        context 'when given invalid types' do
            it 'should fail when given invalid type' do
                expect { 
                    Table.new(betting_type: :nl, 
                              type: :invalid, 
                              variation: :holdem) 
                }.to raise_error
            end

            it 'should fail when given invalid variation' do
                expect { 
                    Table.new(betting_type: :nl, 
                              type: :ring, 
                              variation: :invlid) 
                }.to raise_error
            end

            it 'should fail when given invalid betting type' do
                expect { 
                    Table.new(betting_type: :invalid, 
                              type: :ring, 
                              variation: :holdem) 
                }.to raise_error
            end
        end
    end

    describe '#deck' do
        it 'should return the deck' do
            table = Table.new(betting_type: :nl, 
                              type: :ring, 
                              variation: :holdem)

            expect(table.deck).to be_an_instance_of Array
        end
    end

    describe '#type' do
        context 'asking for the type' do
            it 'should return ring' do
                table = Table.new(betting_type: :nl, 
                                  type: :ring, 
                                  variation: :holdem)

                expect(table.type).to eq(:ring)
            end

            it 'should return mtt' do
               table = Table.new(betting_type: :nl, 
                                 type: :mtt, 
                                 variation: :holdem)

                expect(table.type).to eq(:mtt) 
            end
        end
    end

    describe "#deal_hole_cards" do
        context 'Holdem being the variation' do
            it 'should return 2 cards' do
                table = Table.new(betting_type: :nl,
                                 type: :ring,
                                 variation: :holdem)

                expect(table.deal_hole_cards).to have(2).cards
            end
        end

        context 'Royal being the variation' do
            it 'should return 2 cards' do
                table = Table.new(betting_type: :nl,
                                 type: :ring,
                                 variation: :royal)

                expect(table.deal_hole_cards).to have(2).cards
            end
        end

        context 'Omaha being the variation' do
            it 'should return 4 cards' do
                table = Table.new(betting_type: :nl,
                                 type: :ring,
                                 variation: :omaha)

                expect(table.deal_hole_cards).to have(4).cards
            end
        end
    end

    describe '#deal_board_cards' do
        it 'should return 5 cards' do
            table = Table.new(betting_type: :nl,
                             type: :ring,
                             variation: :omaha)

            expect(table.deal_board_cards).to have(5).cards
        end
    end

    describe '#min_raise' do
        context 'when betting type is no limit' do
            it 'should return the minimum bet' do
                 table = Table.new(betting_type: :nl,
                                   type: :ring,
                                   variation: :royal)

                 expect(table.min_raise).to eq(0)
             end 
        end

        context 'when betting type is pot limit' do
            it 'should return the current pot' do
                table = Table.new(betting_type: :nl,
                                   type: :ring,
                                   variation: :royal)

                expect(table.min_raise).to eq(table.pot) 
            end
        end

        context 'when betting type is fixed limit' do
            it 'should return the betting limit' do
                table = Table.new(betting_type: :fl,
                                  type: :ring,
                                  variation: :royal,
                                  betting_limit: 100)

                expect(table.min_raise).to eq(table.betting_limit)
            end
        end
    end

    describe '#max_raise' do
        context 'when betting type is no limit' do
            it 'should indicate that there\'s no limit' do
                table = Table.new(betting_type: :nl,
                                  type: :ring,
                                  variation: :royal)

                expect(table.max_raise).to eq(:no_limit)
            end
        end

        context 'when betting type is fixed limit' do
            it 'should return the betting limit' do
               table = Table.new(betting_type: :fl,
                                 type: :ring,
                                 variation: :royal,
                                 betting_limit: 150)

                expect(table.max_raise).to eq(150) 
            end
        end

        context 'when betting type is pot limit' do
            it 'should return the current pot' do
                table = Table.new(betting_type: :pl,
                                  type: :ring,
                                  variation: :royal,
                                  pot: 150)

                expect(table.max_raise).to eq(150)
            end
        end
    end

    describe '#place_bet' do
        context 'when betting type is no limit' do
            before(:each) do
                @table = Table.new(betting_type: :nl,
                                type: :ring, 
                                variation: :royal)

                @table.place_bet(of: 15)
            end

            it 'should raise the min_raise' do
                expect(@table.min_raise).to eq(15)
            end

            it 'should match the min_raise' do
                @table.place_bet(of: 15)
                expect(@table.min_raise).to eq(15)
            end

            it 'shouldn\'t allow lower bets than the min_raise' do
                expect { @table.place_bet(10) }.to raise_error
            end
        end

        context 'when betting type is fixed limit' do
            it 'should automatically bet the limit' do
                table = Table.new(betting_type: :fl,
                                   type: :ring, 
                                   variation: :royal,
                                   betting_limit: 100)

                expect(table.place_bet).to eq(table.betting_limit)
            end
        end
        
    end
end