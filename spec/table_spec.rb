require_relative '../deck'
require_relative '../table'

describe Table do
    describe '#new'  do
        context 'when give valid types' do
            it 'should create a no limit holdem ring table' do
                table = Table.new(betting_type: :nl, type: :ring, variation: :holdem)
                expect(table.to_s).to eq('NL Holdem Ring Table')
            end

            it 'should create a fixed limit omaha mtt table' do
                table = Table.new(betting_type: :fl, type: :mtt, variation: :omaha)
                expect(table.to_s).to eq('FL Omaha Mtt Table')
            end

            it 'should create a pot limit royal ring table' do
                table = Table.new(betting_type: :pl, type: :ring, variation: :royal)
                expect(table.to_s).to eq('PL Royal Ring Table')
            end
        end

        context 'when given invalid types' do
            it 'should fail when given invalid type' do
                expect { Table.new(betting_type: :nl, type: :invalid, variation: :holdem) }.to raise_error
            end

            it 'should fail when given invalid variation' do
                expect { Table.new(betting_type: :nl, type: :ring, variation: :invlid) }.to raise_error
            end

            it 'should fail when given invalid betting type' do
                expect { Table.new(betting_type: :invalid, type: :ring, variation: :holdem) }.to raise_error
            end
        end
    end

    describe '#deck' do
        it 'should return the deck' do
            table = Table.new(betting_type: :nl, type: :ring, variation: :holdem)
            expect(table.deck).to eq("2s 2d 2h 2c 3s 3d 3h 3c 4s 4d 4h 4c 5s 5d 5h 5c 6s 6d 6h 6c 7s 7d 7h 7c 8s 8d 8h 8c 9s 9d 9h 9c Ts Td Th Tc Js Jd Jh Jc Qs Qd Qh Qc Ks Kd Kh Kc As Ad Ah Ac")
        end
    end

    describe '#type' do
        context 'asking for the type' do
            it 'should return ring' do
                table = Table.new(betting_type: :nl, type: :ring, variation: :holdem)
                expect(table.type).to eq(:ring)
            end

            it "should return mtt" do
               table = Table.new(betting_type: :nl, type: :mtt, variation: :holdem)
                expect(table.type).to eq(:mtt) 
            end
        end
    end
end