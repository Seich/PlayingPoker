# This class is used to manage the deck of cards at a table.
# Mostly having to work on dealing the cards, keeping track of the current
# variation and it's respective set of cards.
class Deck
    attr_reader :cards

    # This initializer takes in the game variation to be used with the deck.
    # The available options include: :omaha, :holdem and, :royal.
    def initialize(variation)
        @variations = [:omaha, :holdem, :royal]
        unless @variations.include?(variation)
          fail "Deck variation doesn't exist. Valid types: #{@variations.join ', '}"
        end

        @variation = variation
        @cards =  generate_deck
    end

    # Deals n number of cards. 
    # It accepts a number specifying the total number of cards to draw.
    # 
    # Returns an array with the number of cards dealt.
    # 
    # For example:
    #   deal_card(num: 3) => %w(Qh 2d 4c)
    def deal_card(num: 1)
        return false if count == 0

        num ||= 1

        @cards.shuffle!
        @cards.pop(num)
    end

    # Returns the hole cards for the current game variation.
    # 
    # For example:
    #   (Variation being Omaha)
    #   deal_hole_cards => %w(As Qh 2d 4c)
    def deal_hole_cards
        if @variation == :omaha
            deal_card(num: 4)
        else
            deal_card(num: 2)
        end
    end

    # Returns the game's variation.
    def variation
        @variation.to_s
    end

    # Returns the number of cards remaining on the deck.
    def count
        @cards.count
    end

    # Returns a string representing the cards on the deck.
    def to_s
        @cards.join(' ')
    end

    private

    # Generates a deck for the current game variation.
    # A full deck for both omaha and holdem and a deck of cards 10 or above for royal.
    def generate_deck
        if @variation == :royal
            %w(Ts Td Th Tc Js Jd Jh Jc Qs Qd Qh Qc Ks Kd Kh Kc As Ad Ah Ac)
        else
            %w(2s 2d 2h 2c 3s 3d 3h 3c 4s 4d 4h 4c 5s 5d 5h 5c 6s 6d 6h 6c 7s 7d 7h 7c 8s 8d 8h 8c 9s 9d 9h 9c Ts Td Th Tc Js Jd Jh Jc Qs Qd Qh Qc Ks Kd Kh Kc As Ad Ah Ac)
        end
    end
end
