Struct.new('Card', :rank, :suit)

class Deck
    def initialize(type)
        unless [:omaha, :holdem, :royal].include? type
          fail "Deck type doesn't exist."
        end

        @type = type
        @deck =  []

        fill_deck
    end

    def deal_card
        return false if count == 0

        @deck.shuffle!
        @deck.pop
    end

    def count
        @deck.count
    end

    def to_s
        @type.to_s
    end

    private

    def fill_deck
        range = (2..14)
        range = (10..14) if @type == :royal

        %w(d s h c).each do |suit|
            range.each do |rank|
                @deck << Struct::Card.new(rank, suit)
            end
        end
    end
end
