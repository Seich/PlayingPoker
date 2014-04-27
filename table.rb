class Table
	attr_reader :type
    def initialize(options = {})
		@types = [:mtt, :ring]
		@betting_types = [:nl, :pl, :fl]
    	

        unless @types.include? options[:type]
          fail "Table type doesn't exist. Valid types: #{@types.join ', '}"
        end

        unless @betting_types.include? options[:betting_type]
        	fail "Betting type doesn't exist. Valid types: #{@betting_types.join ', '}"
        end

        @type = options[:type]
        @deck = Deck.new options[:variation]
        @betting_type = options[:betting_type]
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
