class Table
	attr_reader :type	
	attr_reader :min_raise
	attr_reader :betting_limit
    attr_reader :pot

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

        @max_raise = 0
        @min_raise = 0
        @pot = options[:pot] || 0

        if @betting_type == :fl && options[:betting_limit].nil?
        	raise 'You need to provide a betting_limit when the betting_type is fixed limit.'
        else
        	@betting_limit = options[:betting_limit] || 0
        	@min_raise = @betting_limit
        end

        if @betting_type == :nl
            @max_raise = :no_limit
        end
    end

    def max_raise
        case @betting_type
        when :fl
            @betting_limit
        when :pl
            @pot
        when :nl
            :no_limit
        end
    end

    def place_bet(of: nil)
        if of.nil? && @betting_type == :fl
            of = @betting_limit
        end

    	fail 'The bet has to be over the minimum raise.' if of < @min_raise

    	@min_raise = of
    end

    def deal_hole_cards
    	@deck.deal_hole_cards
    end

    def deal_board_cards
    	@deck.deal_card(num: 5)
    end

    def deck
    	@deck.cards
    end

    def to_s
        '%s %s %s Table' % [@betting_type.upcase, @deck.variation.capitalize, @type.capitalize]
    end
end
