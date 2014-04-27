class Table
	attr_reader :type

    def initialize(type, variation, betting_type)
    	@variations = [:omaha, :holdem, :royal]
		@types = [:mtt, :ring]
		@betting_types = [:nl, :pl, :fl]

    	unless @variations.include? variation
          fail "Deck variation doesn't exist. Valid types: #{@variations.join ', '}"
        end

        unless @types.include? type
          fail "Table type doesn't exist. Valid types: #{@types.join ', '}"
        end

        unless @betting_types.include? betting_type
        	fail "Betting type doesn't exist. Valid types: #{@betting_types.join ', '}"
        end

        @type = type
        @deck = Deck.new variation
        @betting_type = betting_type
    end

    def deal_hole_card
    	
    end

    def deal_board_card
    	
    end

    def deck
    	@deck.to_s
    end

    def to_s
        '%s %s %s Table' % [@betting_type.upcase, @deck.variation.capitalize, @type.capitalize]
    end
end
