require './deck'
require './table'

puts 'MTT PL Royal Table'
t = Table.new(type: :mtt,
			  variation: :royal,
			  betting_type: :pl,
			  pot: 60)

puts "type: #{t.type}"
puts "deck: #{t.deck}"
puts "deal_hole_cards: #{t.deal_hole_cards}"
puts "deal_board_cards: #{t.deal_board_cards}"
puts "min_raise: #{t.min_raise}"
puts "max_raise: #{t.max_raise}"

puts "\n\n"

puts 'Ring FL Omaha Table'
t = Table.new(type: :ring,
			  variation: :omaha,
			  betting_type: :fl,
			  betting_limit: 200)

puts "type: #{t.type}"
puts "deck: #{t.deck}"
puts "deal_hole_cards: #{t.deal_hole_cards}"
puts "deal_board_cards: #{t.deal_board_cards}"
puts "min_raise: #{t.min_raise}"
puts "max_raise: #{t.max_raise}"