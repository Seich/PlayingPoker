class Table
	attr_reader :type

    def initialize(type, game_variation, betting_type)
        @type = type
        @deck = Deck.new game_variation.to_sym
        @betting_type = betting_type
    end

    def deal_hole_card
    	
    end

    def deal_board_card
    	
    end

    def deck
    	@deck
    end

    def to_s
        "#{@betting_type} #{@deck.to_s.capitalize} Table"
    end
end
