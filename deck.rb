class Deck
    attr_reader :cards

    def initialize(variation)
        @variations = [:omaha, :holdem, :royal]
        unless @variations.include?(variation)
          fail "Deck variation doesn't exist. Valid types: #{@variations.join ', '}"
        end

        @variation = variation
        @cards =  generate_deck
    end

    def deal_card(num: 1)
        return false if count == 0

        num ||= 1

        @cards.shuffle!
        @cards.pop(num)
    end

    def deal_hole_cards
        if @variation == :omaha
            deal_card(num: 4)
        else
            deal_card(num: 2)
        end
    end

    def variation
        @variation.to_s
    end

    def count
        @cards.count
    end

    def to_s
        @cards.join(' ')
    end

    private

    def generate_deck
        if @variation == :royal
            %w(Ts Td Th Tc Js Jd Jh Jc Qs Qd Qh Qc Ks Kd Kh Kc As Ad Ah Ac)
        else
            %w(2s 2d 2h 2c 3s 3d 3h 3c 4s 4d 4h 4c 5s 5d 5h 5c 6s 6d 6h 6c 7s 7d 7h 7c 8s 8d 8h 8c 9s 9d 9h 9c Ts Td Th Tc Js Jd Jh Jc Qs Qd Qh Qc Ks Kd Kh Kc As Ad Ah Ac)
        end
    end
end
