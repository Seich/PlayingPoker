# This class is used to create a poker table.
# At this point, the table is used to manage the board and hole cards
# and keeps track of the minimum and maximum raise limits and the pot.
class Table
	attr_reader :type	
	attr_reader :min_raise
	attr_reader :betting_limit
    attr_reader :pot

    # Initializes the table. The options available are:
    # - type: This type refers to the type of table this is. At this moment
    #         can either be :mtt or :ring.
    # - betting_type: This defines the betting type at the table. The available
    #                 options are :nl (No Limit), :pl (Pot Limit) and, :fl (Fixed Limit).
    # - variation: This defines the game variation. The available options are:
    #              :holdem, :omaha and, :royal.
    # - betting_limit: This option is only required if the betting type is fixed otherwise, 
    #                  it'll be ignored.
    # - pot: This sets the table's initial pot. It is optional.
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

    # Returns the current maximum raise based on the betting type.
    # 
    # Returns the betting limit for the fixed limit, 
    # the current pot for the pot limit and  a symbol, stating :no_limit whenever
    # the betting type is no limit.
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

    # Places a new bet on the table. Making the appropriate changes to the minimum
    # raise.
    # 
    # Returns the placed bet.
    # 
    # For example:
    #   place_bet(of: 100) => 100
    def place_bet(of: nil)
        if of.nil? && @betting_type == :fl
            of = @betting_limit
        end

    	fail 'The bet has to be over the minimum raise.' if of < @min_raise

    	@min_raise = of
    end

    # Returns n number of hole cards for the current game variation.
    def deal_hole_cards
    	@deck.deal_hole_cards
    end

    # Returns 5 cards to serve as board cards.
    def deal_board_cards
    	@deck.deal_card(num: 5)
    end

    # Returns the current deck of cards.
    def deck
    	@deck.cards
    end

    # Returns a string describing the current table configuration.
    def to_s
        '%s %s %s Table' % [@betting_type.upcase, 
                            @deck.variation.capitalize, 
                            @type.capitalize]
    end
end
